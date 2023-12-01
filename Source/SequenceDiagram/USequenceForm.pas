{-------------------------------------------------------------------------------
 Unit:     USequenceForm
 Author:   Gerhard Röhner
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
  SpTBXItem, Vcl.Menus;

type
  TFSequenceForm = class(TFileForm)
    SequenceScrollbox: TScrollBox;
    PToolbar: TPanel;
    SequenceToolbar: TToolBar;
    TBClose: TToolButton;
    TBLifeLine: TToolButton;
    TBZoomOut: TToolButton;
    TBZoomIn: TToolButton;
    TBActor: TToolButton;
    TBNewLayout: TToolButton;
    TBRefresh: TToolButton;
    EMessage: TEdit;
    ILSequencediagram: TImageList;
    ILSequencediagramDark: TImageList;
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
  private
    EditMemo: TMemo;
    LifeLines: TList;
    EditMemoElement: TLifeLine;
    EditConnection: TConnection;
    LifeLinesTop: integer;
    PopupAtYPos: integer;
    PopupAtLifeLine: TLifeLine;
    DistY: integer;
    ActivationWidth: integer;
    minWidth: integer;
    minHeight: integer;
    minDist: integer;
    MaxHeadHeight: integer;
    aMessage: string;
    MethodArrowStyle: TArrowStyle;
    procedure DoEdit(LifeLine: TLifeLine);
    procedure DoEditMessage(Conn: TConnection);
    procedure setLeftBorderForEditMemo;
    procedure CloseEdit(b: boolean);
    function getLifeLine(const Participant: String): TLifeLine;
    procedure OnBackgroundDblClick(Sender: TObject; Conn: TConnection);
    procedure onCreatedChanged(Sender: TObject);
    function getParticipantName: string;
    function getActorName: string;
  private
    SequencePanel: TSequencePanel;
    OnCloseNotify: TNotifyEvent; // future use for CreateSequencediagram
    procedure AddLifeline(const Participant: String);
    procedure AddConnection(const Connection: String);
    procedure setPanelFont(aFont: TFont);
    procedure TranslateDiagram;
    procedure CalculateXPositions;
    procedure CalculateDiagram;
    procedure SortLifeLines;
    procedure prepareMethod(const aMethod: String);
    function prepareParticipant(const participant: String): String;
    function getBitmap: TBitmap;
    procedure ChangeStyle;
    function getMaxLifelineHeight: integer;
    function getMinLifelineTop: integer;
    function getMinLifelineLeft: integer;
  protected
    procedure SetModified(Value: boolean); override;
    function LoadFromFile(const FileName: string): boolean; override;
    procedure SetFont(aFont: TFont); override;
    function CanCopy: boolean; override;
    procedure CopyToClipboard; override;
    procedure SetFontSize(Delta: integer); override;
    procedure DoActivateFile(Primary: boolean = True); override;
    procedure WMSpSkinChange(var Message: TMessage); message WM_SPSKINCHANGE;
  public
    // debugger related
    FromParticipant: string;
    ToParticipant: string;
    aResult: string;
    procedure MethodEntered(const aMethod: String);
    procedure MethodExited(aMethod: String);
    procedure addParameter(const parameter: string);
    procedure changeParameter(Parameter: TStringList);
    procedure changeLifeLineName(const value, aName: string);
    procedure makeFromParticipant(const participant: String);
    procedure makeToParticipant(const participant: String);
    procedure makeConnection;

    // UML-diagram related
    procedure ObjectDelete;

    procedure Print; override;
    function getAsStringList: TStringList; override;
    procedure DoExport; override;
    procedure SetOptions; override;
  end;

implementation

{$R *.dfm}

uses SysUtils, Printers, IniFiles, Math, Clipbrd, Themes, Dialogs,
     UITypes, uCommonFunctions, UImages, UConfiguration, UUtils,
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
  EditMemo.Visible:= false;
  EditMemo.WordWrap:= false;
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
 if assigned(OnCloseNotify) then
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

function TFSequenceForm.LoadFromFile(const FileName: string): boolean;
  var i: integer;
     Ini: TMemIniFile;
     SL: TStringList;
begin
  Result:= false;
  SL:= TStringList.Create;
  SequencePanel.isLocked:= true;
  Ini:= TMemIniFile.Create(Filename, TEncoding.UTF8);
  try
    try
      LifeLinesTop:= PPIScale(min(Ini.ReadInteger('Diagram', 'Top', 30), 500));
      Ini.ReadSectionValues('Participants', SL);
      for i := 0 to SL.Count - 1 do
        AddLifeLine(UnhideCrLf(SL[i]));
      Ini.ReadSectionValues('Messages', SL);
      for i := 0 to SL.Count - 1 do
        AddConnection(SL[i]);
      Font.Name:= Ini.ReadString('Diagram', 'FontName', 'Segoe UI');
      Font.Size:= Ini.ReadInteger('Diagram', 'FontSize', 12);
      setFont(Font);
      Result:= true;
    except on e: exception do
      ErrorMsg(e.Message);
    end;
  finally
    FreeAndNil(SL);
    FreeAndNil(Ini);
    SequencePanel.isLocked:= false;
  end;
end;

function TFSequenceForm.getAsStringList: TStringList;
var
  aLifeLine: TLifeline;
  i: integer;
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
  SL.add('FontSize=' + IntToStr(Font.Size));
  Result:= SL;
end;

procedure TFSequenceForm.ConnectLifeLines(Sender: TObject);
  var Src, Dest: TControl;
begin
  Src:= SequencePanel.GetFirstSelected;
  Dest:= TControl(LifeLines.Items[(Sender as TSpTBXItem).Tag]);
  SequencePanel.FindManagedControl(Dest).Selected:= true;
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
  var i, j, yPos, theWidth, NewWidth, NewHeight: integer;
      Conn, Conn1: TConnection; ConnList: TList;
      LifeLine, LifeLine1, LifeLine2: TLifeLine;
      Activations: array of integer;
begin
  if SequencePanel.isLocked then exit;

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
        then dec(LifeLine.Activation)
        else inc(LifeLine.Activation);
      Conn.ToActivation:= LifeLine.Activation;
    end else begin
      LifeLine1:= Conn.FFrom as TLifeLine;
      LifeLine2:= Conn.FTo as TLifeLine;
      if Conn.ArrowStyle = casReturn then begin
        Conn.FromActivation:= LifeLine1.Activation;
        Conn.ToActivation:= LifeLine2.Activation;
        dec(LifeLine1.Activation);
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
    theWidth:= max(theWidth, LifeLine.Left + LifeLine.Width);
    if LifeLine.Created then begin
      for j:= 0 to ConnList.Count - 1 do begin
        Conn1:= TConnection(ConnList.Items[j]);
        if (Conn1.ArrowStyle = casNew) and (Conn1.FTo = LifeLine) then begin
          LifeLine.Top:= Conn1.YPos - LifeLine.Headheight div 2;
          break;
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
          break;
        end;
      end;
    end;
  end;

  NewWidth:= max(SequenceScrollbox.Width, theWidth + 30);
  NewHeight:= max(SequenceScrollbox.Height, yPos + 30);
  if (NewWidth > SequenceScrollbox.Width) or (NewHeight > SequenceScrollbox.Height) then
    SequenceScrollbox.SetBounds(0, 0, NewWidth, NewHeight);

  if (NewWidth > SequencePanel.Width) or (NewHeight > SequencePanel.Height) or
     (SequencePanel.Left <> 0) or (SequencePanel.Top <> 0) then
    SequencePanel.SetBounds(0, 0, NewWidth, NewHeight);
  FreeAndNil(ConnList);
end;

procedure TFSequenceForm.DoActivateFile(Primary: boolean = True);
begin
  inherited;
  SequencePanel.SetFocus;
end;

procedure TFSequenceForm.MIPopupAsTextClick(Sender: TObject);
begin
  DoSave;
  PyIDEMainForm.DoOpenFile(Pathname, '', 1, true);
end;

procedure TFSequenceForm.MIPopupConfigurationClick(Sender: TObject);
begin
  FConfiguration.OpenAndShowPage('Sequence diagram');
end;

procedure TFSequenceForm.MIPopupCreateObjectClick(Sender: TObject);
  var LifeLine1, LifeLine2: TLifeLine; Attributes: TConnectionAttributes;
      Connections: TList; Conn: TConnection;
      i, Pos: integer;
begin
  if LifeLines.Count > 0 then begin
    LifeLine1:= TLifeLine(SequencePanel.GetFirstSelected);
    AddLifeLine(getParticipantName);
    LifeLine2:= TLifeLine(LifeLines.Items[LifeLines.Count-1]);
    LifeLine2.Created:= true;
    if LifeLine1 =  TLifeLine(LifeLines.Items[LifeLines.Count-2]) then
      LifeLine2.Left:= LifeLine2.Left - minDist + Canvas.TextWidth(GuiPyLanguageOptions.SDNew);
    if assigned(LifeLine1) and assigned(LifeLine2) then begin
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
          inc(i);
        end;
        SequencePanel.ConnectObjectsAt(LifeLine1, LifeLine2, Attributes, Pos);
        Modified:= true;
        CalculateDiagram;
      finally
        FreeAndNil(Attributes);
        FreeAndNil(Connections);
      end;
    end;
  end;
end;

procedure TFSequenceForm.MIPopupDeleteLifeLineClick(Sender: TObject);
  var LifeLine: TLifeLine; i: integer;
begin
  LifeLine:= TLifeLine(SequencePanel.GetFirstSelected);
  if assigned(LifeLine) then begin
    i:= 0;
    while i < LifeLines.Count do begin
      if TLifeLine(LifeLines.Items[i]) = LifeLine then begin
        LifeLines.Delete(i);
        i:= LifeLines.Count;
      end;
      inc(i);
    end;
  end;
  SequencePanel.DeleteSelectedControls;
end;

procedure TFSequenceForm.MIPopupRefreshClick(Sender: TObject);
begin
  SequencePanel.isLocked:= true;
  DoSave;
  SequencePanel.ClearManagedObjects;
  LifeLines.Clear;
  LoadFromFile(Pathname);
  SequencePanel.isLocked:= false;
  CalculateDiagram;
  SequencePanel.Clear;
  SequencePanel.ShowAll;
  //Invalidate;
  Modified:= true;
end;

procedure TFSequenceForm.PopupMenuConnectionPopup(Sender: TObject);
  var Pt: TPoint;
begin
  inherited;
  Pt:= SequencePanel.ScreenToClient(Mouse.CursorPos);
  PopupAtYPos:= Pt.Y;
end;

procedure TFSequenceForm.OnLifeLineSequencePanel(Sender: TObject);
  var Pt: TPoint;
begin
  Pt:= SequencePanel.ScreenToClient(Mouse.CursorPos);
  PopupAtYPos:= Pt.Y;
  if assigned(Sender) and (Sender is TLifeLine)
    then PopupAtLifeLine:= (Sender as TLifeLine)
    else PopupAtLifeLine:= nil;
end;

procedure TFSequenceForm.PopupMenuLifeLineAndSequencePanelPopup(Sender: TObject);
  var aMenuItem: TSpTBXItem;
      i, p: integer; s: string;
begin
  for i:= MIPopupConnectWith.Count - 1 downto 0 do
    FreeAndNil(MIPopupConnectWith.Items[i]);

  if assigned(PopupAtLifeLine) then begin
    MIPopupConnectWith.Visible:= true;
    MIPopupDeleteLifeLine.Visible:= true;
    MIPopupCreateObject.Visible:= true;
    for i:= 0 to LifeLines.Count - 1 do begin
      s:= TLifeLine(LifeLines.Items[i]).Participant;
      p:= Pos(#13#10, s); if p > 0 then delete(s, p, length(s));
      aMenuItem:= TSpTBXItem.Create(PopupMenuLifeLineAndSequencePanel);
      aMenuItem.Caption:= s;
      aMenuItem.OnClick:= ConnectLifeLines;
      aMenuItem.ImageIndex:= 16;
      aMenuItem.Tag:= i;
      MIPopupConnectWith.Add(aMenuItem);
    end;
  end else begin
    MIPopupConnectWith.Visible:= false;
    MIPopupDeleteLifeLine.Visible:= false;
    MIPopupCreateObject.Visible:= false;
  end;
end;

function TFSequenceForm.getBitmap: TBitmap;
  var aBitmap: TBitmap;
      w, h: integer;
begin
  SequencePanel.GetDiagramSize(w, h);
  aBitmap:= TBitmap.Create;
  aBitmap.Width:= w;
  aBitmap.Height:= h;
  aBitmap.Canvas.Lock;
  try
    SequencePanel.PaintTo(aBitmap.Canvas, 0, 0);
  finally
    aBitmap.Canvas.Unlock;
  end;
  Result:= aBitmap;
end;

procedure TFSequenceForm.Print;
  var aBitmap: TBitmap;
begin
  aBitmap:= getBitmap;
  try
    PrintBitmap(aBitmap, PixelsPerInch);
  finally
    FreeAndNil(aBitmap);
  end;
end;

procedure TFSequenceForm.CopyToClipboard;
  var aBitmap: TBitmap;
begin
  aBitmap:= getBitmap;
  try
    Clipboard.Assign(aBitmap);
  finally
    FreeAndNil(aBitmap);
  end;
end;

procedure TFSequenceForm.DoExport;
  var aBitmap: TBitmap;
begin
  aBitmap:= getBitmap;
  try
    PyIDEMainForm.DoExport(Pathname, aBitmap);
  finally
    FreeAndNil(aBitmap);
    if canFocus then SetFocus;
  end;
end;

function TFSequenceForm.CanCopy: boolean;
begin
  Result:= true;
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
  DistY:= PPIScale(Round(cDistY*Font.Size/12.0));
  ActivationWidth:= PPIScale(Round(cActivationWidth*Font.Size/12.0));
  MinWidth:= PPIScale(Round(cMinWidth*Font.Size/12.0));
  MinHeight:= PPIScale(Round(cMinHeight*Font.Size/12.0));
  LifeLinesTop:= PPIScale(Round(cLifeLinesTop*Font.Size/12.0));
  minDist:= PPIScale(Round(cMinDist*Font.Size/12.0));
  Canvas.Font.Assign(aFont);

  setPanelFont(aFont);
  SortLifeLines;
  CalculateDiagram;
  GuiPyOptions.SequenceFont.Assign(aFont);
  Paint;
end;

procedure TFSequenceForm.SetFontSize(Delta: integer);
begin
  inherited;
  CalculateXPositions;
end;

procedure TFSequenceForm.CalculateXPositions;
  var i, j, w, activation, w1, w2: integer;
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
          then w:= max(w, w1 + LifeLine2.Width div 2)
          else w:= max(w, w1);
        Activation:= max(Activation, (Conn.FromActivation + Conn.ToActivation)*ActivationWidth);
      end;
      if j > 0 then begin
        ConnPrev:= TConnection(Connections[j - 1]);
        if (ConnPrev.ArrowStyle = casNew) and
           (ConnPrev.FFrom = LifeLine1) and
           (ConnPrev.FTo = LifeLine2)
        then begin
          w1:= Canvas.TextWidth(ConnPrev.aMessage) + ConnPrev.FTo.Width div 2;
          w2:= Canvas.TextWidth(Conn.aMessage) + + ConnPrev.FTo.Width div 2 - MinDist;
          w:= max(max(w, w1), w2);
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
    maxHeadHeight:= max(maxHeadHeight, TLifeLine(LifeLines.Items[i]).HeadHeight);
  end;
  SequencePanel.setFont(aFont);
end;

procedure TFSequenceForm.TBCloseClick(Sender: TObject);
begin
  (fFile as IFileCommands).ExecClose;
end;

procedure TFSequenceForm.AddLifeline(const Participant: String);
  var LifeLine: TLifeLine; i, maxx, x1, lef: integer; SL: TStringList;
begin
  if copy(Participant, 1, 1) = '#' then exit;
  SL:= Split('|', Participant);
  LifeLine:= TLifeLine.createLL(SequencePanel, trim(SL[0]), Font, TBClose);
  LifeLine.OnDblClick:= LifeLineDblClick;
  LifeLine.PopupMenu:= PopupMenuLifeLineAndSequencePanel;
  LifeLine.onCreatedChanged:= onCreatedChanged;
  if (Sl.Count > 1) and TryStrToInt(trim(SL[1]), lef) then begin
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

procedure TFSequenceForm.AddConnection(const Connection: String);
  var Participant1, Participant2, bMessage: String;
      p: integer;
      ArrowStyle: TArrowStyle;
      Attributes: TConnectionAttributes;
      Lifeline1, LifeLine2: TLifeLine;
begin
  if Copy(Connection, 1, 1) = '#' then
    exit;
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
  if p = 0 then exit;
  Participant1:= UnhideCrLf(trim(copy(Connection, 1, p-1)));
  if ArrowStyle = casSynchron
    then Participant2:= trim(copy(Connection, p + 2, length(Connection)))
    else Participant2:= trim(copy(Connection, p + 3, length(Connection)));
  p:= Pos('|', Participant2);
  if p > 0 then begin
    bMessage:= trim(copy(Participant2, p + 1, length(Participant2)));
    Participant2:= trim(copy(Participant2, 1, p-1));
  end else
    bMessage:= '';
  Participant2:= UnHideCrLf(Participant2);
  LifeLine1:= getLifeline(Participant1);
  LifeLine2:= getLifeline(Participant2);
  if assigned(LifeLine1) and assigned(LifeLine2) then begin
    Attributes:= TConnectionAttributes.Create;
    try
      Attributes.ArrowStyle:= ArrowStyle;
      Attributes.aMessage:= bMessage;
      if Attributes.ArrowStyle = casNew then
        LifeLine2.Created:= true;
      if Attributes.ArrowStyle = casClose then
        LifeLine2.Closed:= true;
      SequencePanel.ConnectObjects(LifeLine1, LifeLine2, Attributes);
    finally
      FreeAndNil(Attributes);
    end;
  end;
end;

procedure TFSequenceForm.MIPopupNewLifeLineClick(Sender: TObject);
begin
  AddLifeLine(getParticipantName);
  Modified:= true;
end;

function TFSequenceForm.getParticipantName: string;
  var i, n: integer; ok: boolean;
begin
  n:= 1;
  repeat
    ok:= true;
    Result:= GuiPyLanguageOptions.SDObject + IntToStr(n);
    for i:= 0 to LifeLines.Count - 1 do
      if Pos(Result, TLifeLine(LifeLines.Items[i]).Participant) = 1 then
        ok:= false;
    inc(n);
  until ok;
end;

procedure TFSequenceForm.MIPopupNewActorClick(Sender: TObject);
begin
  AddLifeLine(getActorName);
  Modified:= true;
end;

function TFSequenceForm.getActorName: string;
  var i, n: integer; ok: boolean;
begin
  n:= 1;
  repeat
    ok:= true;
    Result:= 'Actor' + IntToStr(n);
    for i:= 0 to LifeLines.Count - 1 do
      if Pos(Result, TLifeLine(LifeLines.Items[i]).Participant) = 1 then
        ok:= false;
    inc(n);
  until ok;
end;

procedure TFSequenceForm.TranslateDiagram;
  var i, delta: integer;
begin
  delta:= getMinLifelineLeft - minDist;
  if delta <> 0 then
    for i:= 0 to Lifelines.Count - 1 do
      TLifeline(Lifelines.items[i]).Left:=
        TLifeline(Lifelines.items[i]).Left - delta;
  delta:= getMinLifelineTop - cLifeLinesTop;
  if delta <> 0 then
    for i:= 0 to Lifelines.Count - 1 do
      TLifeline(Lifelines.items[i]).Top:=
        TLifeline(Lifelines.items[i]).Top - delta;
end;

procedure TFSequenceForm.MIPopupNewLayoutClick(Sender: TObject);
begin
  SequencePanel.isLocked:= true;
  SequencePanel.Clear;
  SortLifeLines;
  TranslateDiagram;
  SequencePanel.isLocked:= false;
  CalculateDiagram;
  SequenceScrollbox.HorzScrollBar.Position:= 0;
  SequenceScrollbox.VertScrollBar.Position:= 0;
  MIPopupRefreshClick(Self);
  Modified:= true;
end;

procedure TFSequenceForm.TBZoomInClick(Sender: TObject);
begin
  SetFontSize(+1);
  Modified:= true;
end;

procedure TFSequenceForm.TBZoomOutClick(Sender: TObject);
begin
  SetFontSize(-1);
  Modified:= true;
end;

procedure TFSequenceForm.DoEdit(LifeLine: TLifeLine);
begin
  if Assigned(LifeLine) and not ReadOnly then begin
    EditMemoElement:= LifeLine;
    EditMemo.Text:= LifeLine.Participant;
    EditMemo.SetBounds(LifeLine.Left+2, PToolbar.Height + LifeLine.Top +2, LifeLine.Width, LifeLine.HeadHeight);
    setLeftBorderForEditMemo;
    EditMemo.Visible:= true;
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
    EMessage.Visible:= true;
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
  var w, h: integer; LifeLine: TLifeLine;
begin
  LifeLine:= EditMemoElement;
  if assigned(LifeLine) then begin
    LifeLine.getWidthHeigthOfText(EditMemo.Lines.Text, w, h);
    if EditMemo.Height < h then
      EditMemo.Height:= h;
    if EditMemo.Width < w then
      EditMemo.Width:= w;
  end;
  SendMessage(EditMemo.handle, WM_VSCROLL, SB_TOP, 0);
  setLeftBorderForEditMemo;
end;

procedure TFSequenceForm.CloseEdit(b: boolean);
begin
  if EditMemo.Visible then begin
    if b and assigned(EditMemoElement) then begin
      EditMemoElement.Participant:= EditMemo.Text;
      EditMemoElement.CalcWidthHeight;
      Modified:= true;
      SequencePanel.Invalidate;
    end;
    EditMemo.Visible:= false;
    EditMemoElement:= nil;
  end;
  if EMessage.Visible then begin
    if b and assigned(EditConnection) then begin
      EditConnection.aMessage:= EMessage.Text;
      Modified:= true;
      SequencePanel.Invalidate;
    end;
    EMessage.Visible:= false;
    EditConnection:= nil;
  end;
end;

function TFSequenceForm.getLifeLine(const Participant: String): TLifeLine;
  var i: integer;
begin
  i:= 0;
  while i < LifeLines.Count do
    if (TLifeLine(LifeLines.Items[i]).Participant = Participant) or
       (TLifeLine(LifeLines.Items[i]).Internalname = Participant)
    then begin
      Result:= TLifeLine(LifeLines.Items[i]);
      exit;
    end else
      inc(i);
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
      if assigned(Connection)
        then DoEditMessage(Connection)
    end;
  end;
end;

procedure TFSequenceForm.OnBackgroundDblClick(Sender: TObject; Conn: TConnection);
begin
  if assigned(Conn) then
    DoEditMessage(Conn)
end;

procedure TFSequenceForm.OnPanelClick(Sender: TObject);
begin
  CloseEdit(true);
  PyIDEMainForm.ActiveTabControl := ParentTabControl;
end;

procedure TFSequenceForm.OnPanelModified(Sender: TObject);
begin
  Modified:= true;
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
    TLifeLine(conn.FTo).Closed:= true;
  if conn.ArrowStyle = casNew then
    TLifeLine(conn.FTo).Created:= true;
end;

procedure TFSequenceForm.OnConnectionChanged(Sender: TObject; ArrowStyleOld, ArrowStyleNew: TArrowStyle);
  var conn: TConnection; aLifeline: TLifeline; minTop, maxHeight: integer;
begin
  conn:= Sender as TConnection;
  aLifeLine:= TLifeLine(conn.FTo);
  aLifeLine.Created:= false;
  aLifeLine.Closed:= false;
  if ArrowStyleNew = casNew then
    aLifeline.Created:= true;
  if ArrowStyleNew = casClose then
    aLifeline.Closed:= true;
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
  var i, j: integer;
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

procedure TFSequenceForm.prepareMethod(const aMethod: String);
  var p: integer;
begin
  aMessage:= aMethod;
  p:= Pos('(', aMessage);
  if p > 0 then
    Delete(aMessage, p, length(aMessage));
  p:= Pos('.', aMessage);
  if p > 0 then
    Delete(aMessage, 1, p);
end;

procedure TFSequenceForm.addParameter(const parameter: string);
begin
  aMessage:= aMessage + '(' + Parameter + ')';
end;

procedure TFSequenceForm.changeParameter(Parameter: TStringList);
  var i: integer; conn: TConnection;
begin
  conn:= SequencePanel.Get2NdLastConnection;
  if assigned(conn) then
    for i:= 0 to Parameter.Count - 1 do
      if Pos(Parameter.Names[i], conn.aMessage) > 0 then
        conn.aMessage:= myStringReplace(conn.aMessage, Parameter.Names[i], Parameter.ValueFromIndex[i]);
  conn:= SequencePanel.GetLastConnection;
  if assigned(conn) then
    for i:= 0 to Parameter.Count - 1 do
      if Pos(Parameter.Names[i], conn.aMessage) > 0 then
        conn.aMessage:= myStringReplace(conn.aMessage, Parameter.Names[i], Parameter.ValueFromIndex[i]);
end;

procedure TFSequenceForm.changeLifeLineName(const value, aName: string);
  var i: integer;
begin
  for i:= 0 to LifeLines.Count - 1 do begin
    if TLifeLine(LifeLines.Items[i]).Participant <> '' then continue;
    if TLifeLine(LifeLines.Items[i]).Internalname = value then begin
      TLifeLine(LifeLines.Items[i]).RenameParticipant(aName);
      exit;
    end;
  end;
end;

procedure TFSequenceForm.MethodEntered(const aMethod: String);
begin
  prepareMethod(aMethod);
  if aMessage = '<init>' then begin
    aMessage:= GuiPyLanguageOptions.SDNew;
    MethodArrowStyle:= casNew;
  end else
    MethodArrowStyle:= casSynchron;
end;

procedure TFSequenceForm.MethodExited(aMethod: String);
  var p: integer;
begin
  p:= Pos(', ', aMethod);
  if p > 0 then begin
    aResult:= copy(aMethod, 1, p-1);
    if aResult = '<void value>' then
      aResult:= '';
    delete(aMethod, 1, p+1);
  end;
  prepareMethod(aMethod);
  MethodArrowStyle:= casReturn;
end;

procedure TFSequenceForm.ObjectDelete;
begin
  aMessage:= GuiPyLanguageOptions.SDClose;
  MethodArrowStyle:= casClose;
end;

function TFSequenceForm.prepareParticipant(const participant: String): String;
begin
  if participant = 'main'
    then Result:= 'Actor'
    else Result:= participant;
end;

procedure TFSequenceForm.makeFromParticipant(const participant: String);
begin
  FromParticipant:= prepareParticipant(participant);
end;

procedure TFSequenceForm.makeToParticipant(const participant: String);
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
    exit;
  LifeLine1:= getLifeline(FromParticipant);
  LifeLine2:= getLifeline(ToParticipant);
  if assigned(LifeLine1) and assigned(LifeLine2) then begin
    Attributes:= TConnectionAttributes.Create;
    try
      Attributes.ArrowStyle:= MethodArrowStyle;
      if Attributes.ArrowStyle = casNew then
        LifeLine2.Created:= true;
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

procedure TFSequenceForm.SetModified(Value: boolean);
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
  var Details: TThemedElementDetails; Color: TColor;
begin
  if StyleServices.IsSystemStyle then begin
    SequencePanel.Color:= clWhite;
  end else begin
    Details:= StyleServices.GetElementDetails(tbsBackground);
    StyleServices.GetElementColor(Details, ecFillColor, Color);
    SequencePanel.Color:= Color;
  end;
  if IsStyledWindowsColorDark then begin
    SequenceToolbar.Images:= DMImages.ILSequenceToolbarDark;
    PopupMenuLifeLineAndSequencePanel.Images:= DMImages.ILSequenceToolbarDark;
    PopupMenuConnection.Images:= ILSequencediagramDark;
  end else begin
    SequenceToolbar.Images:= DMImages.ILSequenceToolbar;
    PopupMenuLifeLineAndSequencePanel.Images:= DMImages.ILSequenceToolbar;
    PopupMenuConnection.Images:= ILSequencediagram;
  end;
end;

function TFSequenceForm.getMaxLifelineHeight: integer;
begin
  Result:= 0;
  for var i:= 0 to LifeLines.Count - 1 do
    Result:= max(Result, TLifeLine(LifeLines.Items[i]).Height);
end;

function TFSequenceForm.getMinLifelineTop: integer;
begin
  Result:= MaxInt;
  for var i:= 0 to LifeLines.Count - 1 do
    Result:= min(Result, TLifeLine(LifeLines.Items[i]).Top);
end;

function TFSequenceForm.getMinLifelineLeft: integer;
begin
  Result:= MaxInt;
  for var i:= 0 to LifeLines.Count - 1 do
    Result:= min(Result, TLifeLine(LifeLines.Items[i]).Left);
end;

procedure TFSequenceForm.SetOptions;
begin
  FConfiguration.setToolbarVisibility(SequenceToolbar, 5);
end;


end.
