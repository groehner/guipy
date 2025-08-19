{-------------------------------------------------------------------------------
 Unit:     UQtFrameBased
 Author:   Gerhard Röhner
 Date:     July 2022
 Purpose:  PyQt frame based widgets
-------------------------------------------------------------------------------}
unit UQtFrameBased;

{ classes
    TQtFrame
      TQtLabel
        TQtCanvas
      TQtLine
      TQtToolBox
      TQtStackedWidget
      TQtLCDNumber
}

interface

uses
  Windows, Graphics, Classes, UBaseQtWidgets;

type
  TFrameShape = (NoFrame, Box, Panel, WinPanel, HLine, VLine, StyledPanel);

  TFrameShadow = (Plain, Raised, Sunken);

  TTextFormat =  (PlainText, RichText, AutoText, MarkdownText);

  TMode = (_MO_Hex, _MO_Dec, _MO_Oct, _MO_Bin); // dec conflicts with dec for decrement

  TSegmentStyle = (Outline, Filled, Flat);

  TQtFrame = class(TBaseQtWidget)
  private
    FFrameShape: TFrameShape;
    FFrameShadow: TFrameShadow;
    FLineWidth: Integer;
    FMidLineWidth: Integer;
    procedure SetFrameShape(Value: TFrameShape);
    procedure SetFrameShadow(Value: TFrameShadow);
    procedure SetLineWidth(Value: Integer);
    procedure SetMidLineWidth(Value: Integer);
    procedure PaintBorder(ARect: TRect; Color1, Color2: TColor; LWidth: Integer = -1);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
    function InnerRect: TRect; override;
  published
    property FrameShape: TFrameShape read FFrameShape write SetFrameShape;
    property FrameShadow: TFrameShadow read FFrameShadow write SetFrameShadow;
    property LineWidth: Integer read FLineWidth write SetLineWidth;
    property MidLineWidth: Integer read FMidLineWidth write SetMidLineWidth;
  end;

  TQtLabel = class(TQtFrame)
  private
    FAlignmentHorizontal: TAlignmentHorizontal;
    FAlignmentVertical: TAlignmentVertical;
    FText: string;
    FTextFormat: TTextFormat;
    FPixmap: string;
    FScaledContents: Boolean;
    FWordWrap: Boolean;
    FMargin: Integer;
    FIndent: Integer;
    FOpenExternalLinks: Boolean;
    // FTextInteractionFlags: TTextInteractionFlags;
    FBuddy: string;
    FLinkActivated: string;
    FLinkHovered: string;
    procedure SetAlignmentHorizontal(Value: TAlignmentHorizontal);
    procedure SetAlignmentVertical(Value: TAlignmentVertical);
    procedure SetText(const Value: string);
    procedure SetPixmap(const Value: string);
    procedure SetWordWrap(Value: Boolean);
    procedure SetIndent(Value: Integer);
    procedure SetMargin(Value: Integer);
    procedure SetScaledContents(Value: Boolean);
    procedure MakePixmap(const Value: string);
    procedure MakeAlignment(const Attr, Value: string);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure SizeToText; override;
    procedure Paint; override;
  published
    property AlignmentHorizontal: TAlignmentHorizontal read FAlignmentHorizontal write SetAlignmentHorizontal;
    property AlignmentVertical: TAlignmentVertical read FAlignmentVertical write SetAlignmentVertical;
    property Text: string read FText write SetText;
    property TextFormat: TTextFormat read FTextFormat write FTextFormat;
    property Pixmap: string read FPixmap write SetPixmap;
    property ScaledContents: Boolean read FScaledContents write SetScaledContents;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property Margin: Integer read FMargin write SetMargin;
    property Indent: Integer read FIndent write SetIndent;
    property OpenExternalLinks: Boolean read FOpenExternalLinks write FOpenExternalLinks;
    property Buddy: string read FBuddy write FBuddy;
    //signals
    property linkActivated: string read FLinkActivated write FLinkActivated;
    property linkHovered: string read FLinkHovered write FLinkHovered;
  end;

  TQtCanvas = class(TQtLabel)
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  end;

  TQtLine = class(TQtFrame)
  private
    FOrientation: TOrientation;
    procedure SetOrientation(Value: TOrientation);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property Orientation: TOrientation read FOrientation write SetOrientation;
  end;

  TQtToolBox = class(TQtFrame)
  private
    FCurrentIndex: Integer;
    FTabSpacing: Integer;
    FPages: TStrings;
    FCurrentChanged: string;
    procedure SetPages(Value: TStrings);
    procedure SetCurrentIndex(Value: Integer);
    procedure SetTabSpacing(Value: Integer);
    procedure MakePages;
    procedure MakeTabSpacing(const Value: string);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteWidget; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property CurrentIndex: Integer read FCurrentIndex write SetCurrentIndex;
    property TabSpacing: Integer read FTabSpacing write SetTabSpacing;
    property Pages: TStrings read FPages write SetPages;
    // signals
    property currentChanged: string read FCurrentChanged write FCurrentChanged;
  end;

  TQtStackedWidget = class(TQtFrame)
  private
    FCurrentIndex: Integer;
    FCurrentPageName: string;
    FCurrentChanged: string;
    FWidgetRemoved: string;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
  published
    property CurrentIndex: Integer read FCurrentIndex write FCurrentIndex;
    property CurrentPageName: string read FCurrentPageName write FCurrentPageName;
    property CurrentChanged: string read FCurrentChanged write FCurrentChanged;
    property WidgetRemoved: string read FWidgetRemoved write FWidgetRemoved;
  end;

  TQtLCDNumber = class(TQtFrame)
  private
    FSmallDecimalPoint: Boolean;
    FDigitCount: Integer;
    FMode: TMode;
    FSegmentStyle: TSegmentStyle;
    FValue: Double;
    FIntValue: Integer;
    FOverflow: string;
    procedure SetSegmentStyle(Value: TSegmentStyle);
    procedure SetValue(Value: Double);
    procedure SetIntValue(Value: Integer);
    procedure SetDigitCount(Value: Integer);
    procedure SetSmallDecimalPoint(Value: Boolean);
    procedure SetMode(Value: TMode);
    procedure MakeValue(const Value: string);
    procedure MakeIntValue(const Value: string);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure GetSlots(const Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property SmallDecimalPoint: Boolean read FSmallDecimalPoint write SetSmallDecimalPoint;
    property DigitCount: Integer read FDigitCount write SetDigitCount;
    property Mode: TMode read FMode write SetMode;
    property SegmentStyle: TSegmentStyle read FSegmentStyle write SetSegmentStyle;
    property Value: Double read FValue write SetValue;
    property IntValue: Integer read FIntValue write SetIntValue;
    // signals
    property overflow: string read FOverflow write FOverflow;
  end;

implementation

uses
  Controls,
  SysUtils,
  Math,
  Types,
  UUtils,
  UGUIDesigner;

{--- TQtFrame -----------------------------------------------------------------}

constructor TQtFrame.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 82;
  Width:= 120;
  Height:= 80;
  FLineWidth:= 1;
  FFrameShape:= StyledPanel;
  FFrameShadow:= Raised;
  ControlStyle := [csAcceptsControls];
end;

function TQtFrame.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '';
  if ClassName = 'TQtFrame' then
    Result:= '|FrameShape|FrameShadow|LineWidth|MidLineWidth'
  else if ShowAttributes >= 2 then
    Result:= '|FrameShape|FrameShadow|LineWidth|MidLineWidth';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtFrame.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'FrameShape' then
    MakeAttribut(Attr, 'QFrame.Shape.' + Value)
  else if Attr = 'FrameShadow' then
    MakeAttribut(Attr, 'QFrame.Shadow.' + Value)
  else
    inherited;
end;

procedure TQtFrame.NewWidget(const Widget: string = '');
begin
  if Widget = ''
    then inherited NewWidget('QFrame')
    else inherited NewWidget(Widget);
end;

procedure TQtFrame.Paint;
  const Grey = $A0A0A0;
begin
  inherited;
  if FFrameShadow = Plain
    then Canvas.Pen.Color:= clBlack
    else Canvas.Pen.Color:= $908782;
  Canvas.Brush.Color:= $F0F0F0;
  case FFrameShape of
    NoFrame:
      Canvas.FillRect(ClientRect);
    Box:
      case FFrameShadow of
        Plain : PaintBorder(ClientRect, clBlack, clBlack);
        Raised: begin
           var ARect:= ClientRect;
           PaintBorder(ARect, clWhite, Grey);
           ARect.Inflate(-LineWidth, -LineWidth);
           PaintBorder(ARect, Grey, clWhite);
        end;
        Sunken: begin
           var ARect:= ClientRect;
           PaintBorder(ARect, Grey, clWhite);
           ARect.Inflate(-LineWidth, -LineWidth);
           PaintBorder(ARect, clWhite, Grey);
        end;
      end;
    Panel:
      case FFrameShadow of
        Plain : PaintBorder(ClientRect, clBlack, clBlack);
        Raised: PaintBorder(ClientRect, clWhite, Grey);
        Sunken: PaintBorder(ClientRect, Grey, clWhite);
      end;
    WinPanel: begin
      case FFrameShadow of
        Plain: begin
          Canvas.Brush.Color:= clBlack;
          var ARect:= ClientRect;
          Canvas.FrameRect(ARect);
          ARect.Inflate(-1, -1);
          Canvas.FrameRect(ARect);
        end;
        Raised: PaintBorder(ClientRect, clWhite, Grey, 2);
        Sunken: PaintBorder(ClientRect, Grey, clWhite, 2);
      end;
    end;
    HLine: begin
      Canvas.MoveTo(0, Height div 2);
      case FFrameShadow of
        Plain:  Canvas.Pen.Color:= clBlack;
        Raised: Canvas.Pen.Color:= Grey;
        Sunken: Canvas.Pen.Color:= Grey;
      end;
      Canvas.LineTo(Width, Height div 2);
    end;
    VLine: begin
      Canvas.MoveTo(Width div 2, 0);
      case FFrameShadow of
        Plain:  Canvas.Pen.Color:= clBlack;
        Raised: Canvas.Pen.Color:= Grey;
        Sunken: Canvas.Pen.Color:= Grey;
      end;
      Canvas.LineTo(Width div 2, Height);
    end;
    StyledPanel: begin
      Canvas.Pen.Color:= Grey;
      case FFrameShadow of
        Plain:  Canvas.Rectangle(ClientRect);
        Raised: Canvas.FillRect(ClientRect);
        Sunken: Canvas.Rectangle(ClientRect);
      end;
    end;
  end;
end;

function TQtFrame.InnerRect: TRect;
  var ARect, Rect1: TRect;
begin
  ARect:= ClientRect;
  Rect1:= ClientRect;
  Rect1.Inflate(-FLineWidth, -FLineWidth);
  case FFrameShape of
    NoFrame: ;
    Box:
      case FFrameShadow of
        Plain:  ARect:= Rect1;
        Raised,
        Sunken: ARect.Inflate(-2*FLineWidth, -2*FLineWidth);
      end;
    Panel: ARect:= Rect1;
    WinPanel:
      case FFrameShadow of
        Plain:  ARect.Inflate(-1, -1);
        Raised: ARect:= Rect1;
        Sunken: ARect:= Rect1;
      end;
    StyledPanel: ARect.Inflate(-1, -1);
  end;
  Result:= ARect;
end;

procedure TQtFrame.PaintBorder(ARect: TRect; Color1, Color2: TColor; LWidth: Integer = -1);

  procedure PaintTopLeft;
  begin
    Canvas.Pen.Color:= Color1;
    for var I:= 0 to LWidth - 1 do begin
      Canvas.MoveTo(ARect.Left + I, ARect.Bottom - I - 1);
      Canvas.LineTo(ARect.Left + I, ARect.Top + I);
      Canvas.LineTo(ARect.Right - I, ARect.Top + I);
    end;
  end;

  procedure PaintBottomRight;
  begin
    Canvas.Pen.Color:= Color2;
    for var I:= 1 to LWidth do begin
      Canvas.MoveTo(ARect.Left + I, ARect.Bottom - I);
      Canvas.LineTo(ARect.Right - I, ARect.Bottom - I);
      Canvas.LineTo(ARect.Right - I, ARect.Top + I - 1);
    end;
  end;

begin
  if LWidth = -1 then
    LWidth:= FLineWidth;
  Canvas.Pen.Width:= 1;
  if LineWidth > 0 then
    case FFrameShadow of
      Plain: begin
         PaintTopLeft;
         PaintBottomRight;
      end;
      Raised: begin
         PaintTopLeft;
         PaintBottomRight;
       end;
      Sunken: begin
         PaintTopLeft;
         PaintBottomRight;
       end;
    end;
end;

procedure TQtFrame.SetFrameShape(Value: TFrameShape);
begin
  if Value <> FFrameShape then begin
    FFrameShape:= Value;
    Invalidate;
  end;
end;

procedure TQtFrame.SetFrameShadow(Value: TFrameShadow);
begin
  if Value <> FFrameShadow then begin
    FFrameShadow:= Value;
    Invalidate;
  end;
end;

procedure TQtFrame.SetLineWidth(Value: Integer);
begin
  if Value <> FLineWidth then begin
    FLineWidth:= Value;
    Invalidate;
  end;
end;

procedure TQtFrame.SetMidLineWidth(Value: Integer);
begin
  if Value <> FMidLineWidth then begin
    FMidLineWidth:= Value;
    Invalidate;
  end;
end;

{--- TQtLabel -----------------------------------------------------------------}

constructor TQtLabel.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 71;
  Height:= 24; // synchron to buttons
  Width:= 80;
  FAlignmentVertical:= AlignVCenter;
  FFrameShape:= NoFrame;
  FFrameShadow:= Plain;
  FTextFormat:= AutoText;
  FIndent:= -1;
  FText:= 'TextLabel';
  ControlStyle := [];
end;

function TQtLabel.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Text|Pixmap|Buddy|Font';
  if ShowAttributes >= 2 then
    Result:= Result + '|TextFormat|WordWrap|Margin|Indent';
  if ShowAttributes = 3 then
    Result:= Result + '|AlignmentHorizontal|AlignmentVertical|ScaledContents|OpenExternalLinks';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtLabel.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'TextFormat'  then
    MakeAttribut(Attr, 'Qt.TextFormat.' + Value)
  else if Attr = 'Pixmap'  then
    MakePixmap(Value)
  else if Pos('Alignment', Attr) = 1 then
    MakeAlignment(Attr, Value)
  else
    inherited;
end;

const LabelEvents = '|linkActivated|linkHovered';

function TQtLabel.GetEvents(ShowEvents: Integer): string;
begin
  Result:= LabelEvents + inherited GetEvents(ShowEvents);
end;

function TQtLabel.HandlerInfo(const Event: string): string;
begin
  if Pos(Event, LabelEvents) > 0 then
    Result:= 'QString;link'
  else
    Result:= inherited;
end;

procedure TQtLabel.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
    Slots.Add(Name + '.clear')
  else if Parametertypes = 'QMovie' then
    Slots.Add(Name + '.setMovie')
  else if (Parametertypes = 'double') or (Parametertypes = 'int') then
    Slots.Add(Name + '.setNum')
  else if Parametertypes = 'QPicture' then
    Slots.Add(Name + '.setPicture')
  else if Parametertypes = 'QPixmap' then
    Slots.Add(Name + '.setPixmap')
  else if Parametertypes = 'QString' then
    Slots.Add(Name + '.setText');
  inherited;
end;

procedure TQtLabel.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QLabel');
  if Widget = '' then
    SetAttribute('Text', 'TextLabel', 'Text');
end;

procedure TQtLabel.SizeToText;
begin
  var Delta:= Canvas.TextWidth(Text + 'x') - Width;
  if Delta > 0 then Width:= Width + Delta;
  Delta:= Canvas.TextHeight(Text)+ 4 - Height;
  if Delta > 0 then Height:= Height + Delta;
end;

procedure TQtLabel.Paint;
  var AWidth, AHeight, Format, Indent, Taw: Integer; Pathname: string;
      StringList: TStringList; ARect: TRect; Bmp: TBitmap;
begin
  inherited;
  ARect:= ClientRect;
  if FMargin > 0 then
    ARect.Inflate(-FMargin, -FMargin);
  Pathname:= FGUIDesigner.getPath + 'images\' + Copy(FPixmap, 8, Length(FPixmap));
  if FileExists(Pathname) then begin
    Bmp:= BitmapFromRelativePath(FPixmap);
    if FScaledContents
      then Canvas.StretchDraw(ARect, Bmp)
      else Canvas.Draw(0, (Height - Bmp.Height) div 2, Bmp);
    FreeAndNil(Bmp);
  end else begin
    if FIndent <= 0
      then Indent:= HalfX
      else Indent:= FIndent;
    ARect.Inflate(-Indent, 0);
    StringList:= TStringList.Create;
    Taw:= ARect.Right - ARect.Left;
    if FWordWrap
      then WrapText(FText, Taw, AWidth, AHeight, StringList)
      else CalculateText(FText, AWidth, AHeight, StringList);

    case FAlignmentHorizontal of
      AlignLeft:    Format:= DT_LEFT;
      AlignRight:   Format:= DT_RIGHT;
      AlignHCenter: begin
                      ARect.Left:= (Taw - AWidth) div 2;
                      Format:= DT_CENTER;
                    end;
      else          Format:= DT_LEFT;
    end;
    case FAlignmentVertical of
      AlignTop:      ;
      AlignBottom:   ARect.Top:= ARect.Bottom - AHeight;
      AlignVCenter:  ARect.Top:= (Height - AHeight) div 2;
      AlignBaseline: ;
    end;
    if FWordWrap then
      Format:= Format + DT_WORDBREAK;
    if StringList.Text <> CrLf then
      DrawText(Canvas.Handle, PChar(StringList.Text), Length(StringList.Text), ARect, Format);
    FreeAndNil(StringList);
  end;
end;

procedure TQtLabel.MakePixmap(const Value: string);
  var Str, Key, Dest, Filename, Path: string;
begin
  // ToDo use PIL if png-file selected
  Key:= 'self.' + Name + '.setPixmap';
  if Value = '(Image)' then begin
    Partner.DeleteAttribute(Key);
    Partner.DeleteAttribute(Key + 'Size');
  end else begin
    Filename:= ExtractFileName(Value);
    if Pos('images/', Filename) = 1 then
      System.Delete(Filename, 1, 7);
    Path:= ExtractFilePath(Partner.Pathname);
    Dest:= Path + 'images\' + Filename;
    ForceDirectories(Path + 'images\');
    if not FileExists(Dest) then
      CopyFile(PChar(Value), PChar(Dest), True);
    FPixmap:= 'images/' + Filename;
    Str:= Key + '(QPixmap(' + AsString(FPixmap) + '))';
    SetAttributValue(Key, Str);
    UpdateObjectInspector;
  end;
end;

procedure TQtLabel.MakeAlignment(const Attr, Value: string);
  var Key: string;
begin
  Key:= 'self.' + Name + '.setAlignment';
  if Attr = 'AlignmentHorizontal'
    then SetAttributValue(Key, Key + '(Qt.AlignmentFlag.' + Value +
           ' | Qt.AlignmentFlag.' + EnumToString(FAlignmentVertical) + ')')
    else SetAttributValue(Key, Key + '(Qt.AlignmentFlag.' +
           EnumToString(FAlignmentHorizontal) + ' | Qt.AlignmentFlag.' + Value + ')');
end;

procedure TQtLabel.SetText(const Value: string);
begin
  if Value <> FText then begin
    FText:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.SetPixmap(const Value: string);
begin
  if Value <> FPixmap then begin
    FPixmap:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.SetWordWrap(Value: Boolean);
begin
  if Value <> FWordWrap then begin
    FWordWrap:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.SetIndent(Value: Integer);
begin
  if Value <> FIndent then begin
    FIndent:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.SetMargin(Value: Integer);
begin
  if Value <> FMargin then begin
    FMargin:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.SetScaledContents(Value: Boolean);
begin
  if Value <> FScaledContents then begin
    FScaledContents:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.SetAlignmentHorizontal(Value: TAlignmentHorizontal);
begin
  if Value <> FAlignmentHorizontal then begin
    FAlignmentHorizontal:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.SetAlignmentVertical(Value: TAlignmentVertical);
begin
  if Value <> FAlignmentVertical then begin
    FAlignmentVertical:= Value;
    Invalidate;
  end;
end;

{--- TQtCanvas ----------------------------------------------------------------}

constructor TQtCanvas.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 81;
  Height:= 80;
  Width:= 120;
  ControlStyle := [];
end;

function TQtCanvas.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= Result + inherited GetAttributes(ShowAttributes);
  var Posi:= Pos('|Text|Pixmap|Buddy', Result);
  Delete(Result, Posi, Posi + 17);
end;

procedure TQtCanvas.NewWidget(const Widget: string = '');
  var Str: string;
begin
  inherited NewWidget('QLabel');
  Text:= '';
  Str:= Surround('self.' + Name + 'Pixmap = QPixmap(self.' + Name + '.size())');
  Str:= Str + Surround('self.' + Name + 'Pixmap.fill()');
  Str:= Str + Surround('self.' + Name + 'Painter = QPainter(self.' + Name + 'Pixmap' + ') # draw with Painter');
  Str:= Str + Surround('self.' + Name + '.setPixmap(self.' + Name + 'Pixmap) # show the drawing');
  InsertValue(Str);
end;

procedure TQtCanvas.DeleteWidget;
begin
  inherited;
  Partner.DeleteAttributeValues('self.' + Name + 'Pixmap');
  Partner.DeleteAttribute('self.' + Name + 'Painter');
end;

procedure TQtCanvas.Paint;
begin
  inherited;
  Canvas.Brush.Color:= clWhite;
  Canvas.FillRect(ClientRect);
end;

{--- TQtLine ------------------------------------------------------------------}

constructor TQtLine.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 112;
  Width:= 120;
  Height:= 3;
  FOrientation:= Horizontal;
  FrameShape:= HLine;
  FrameShadow:= Sunken;
  ControlStyle := [];
end;

function TQtLine.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Orientation';
  Result:= Result + inherited GetAttributes(ShowAttributes);
  var Posi:= Pos('|FrameShape', Result);
  if Posi > 0 then
    Delete(Result, Posi, 11);
end;

procedure TQtLine.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Orientation'  then begin
    if Value = 'Horizontal'
      then SetAttribute('FrameShape', 'HLine', '')
      else SetAttribute('FrameShape', 'VLine', '');
  end else
    inherited;
end;

procedure TQtLine.NewWidget(const Widget: string = '');
begin
  inherited NewWidget(Widget);
  SetAttribute('FrameShape', 'HLine', '');
  SetAttribute('FrameShadow', 'Sunken', '');
end;

procedure TQtLine.SetOrientation(Value: TOrientation);
begin
  if Value <> FOrientation then begin
    FOrientation:= Value;
    if not (csLoading in ComponentState) then begin
      var Tmp:= Width; Width:= Height; Height:= Tmp;
      SetPositionAndSize;
    end;
    if Value = Horizontal
      then FrameShape:= HLine
      else FrameShape:= VLine;
    Invalidate;
  end;
end;

{--- TQtToolBox ---------------------------------------------------------------}

constructor TQtToolBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 114;
  Width:= 176;
  Height:= 120;
  FrameShape:= NoFrame;
  FrameShadow:= Plain;
  FTabSpacing:= 6;
  FPages:= TStringList.Create;
  FPages.Text:= 'Page 1'#13#10'Page 2'#13#10'Page 3'#13#10;
  ControlStyle := [];
end;

destructor TQtToolBox.Destroy;
begin
  FreeAndNil(FPages);
  inherited;
end;

procedure TQtToolBox.DeleteWidget;
begin
  inherited;
  Partner.DeleteItems(Name, 'Page');
end;

function TQtToolBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|CurrentIndex|Pages|TabSpacing';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtToolBox.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Pages' then
    MakePages
  else if Attr = 'TabSpacing' then
    MakeTabSpacing(Value)
  else
    inherited;
end;

function TQtToolBox.GetEvents(ShowEvents: Integer): string;
begin
  Result:= '|currentChanged';
  Result:= Result + inherited GetEvents(ShowEvents);
end;

function TQtToolBox.HandlerInfo(const Event: string): string;
begin
  if Event = 'currentChanged' then
    Result:= 'int;index'
  else
    Result:= inherited;
end;

procedure TQtToolBox.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then
    Slots.Add(Name + '.setCurrentIndex')
  else if Parametertypes = 'QWidget' then
    Slots.Add(Name + '.setCurrentWidget');
  inherited;
end;

procedure TQtToolBox.MakePages;
  var Pagename, Str: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteAttributeValues('self.' + Name + '.addItem');
  Partner.DeleteItems(Name, 'Page');
  Str:= '';
  for var I:= 1 to FPages.Count do begin
    Pagename:= 'self.' + Name + 'Page' + IntToStr(I);
    Str:= Str + Surround(Pagename + ' = QLabel()');
    Str:= Str + Surround(Pagename + '.setText(' + AsString('Add widgets to this page') + ')');
    Str:= Str + Surround('self.' + Name + '.addItem(' + Pagename + ', ' + AsString(FPages[I-1]) + ')');
  end;
  InsertValue(Str);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtToolBox.MakeTabSpacing(const Value: string);
begin
  var Str:= 'self.' + Name  + '.layout' ;
  SetAttributValue(Str, Str + '().setSpacing(' + Value + ')');
end;

procedure TQtToolBox.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QToolBox');
  MakePages;
end;

procedure TQtToolBox.Paint;
  var ARect, Rect2: TRect; RowHeight, AvailableHeight: Integer;
      Str: string;

  procedure PaintPage(ARect: TRect; Str: string);
  begin
    Canvas.Brush.Color:= $F0F0F0;
    Canvas.Pen.Color:= clWhite;
    Canvas.Rectangle(ARect);
    Canvas.Pen.Color:= $A0A0A0;
    Canvas.MoveTo(ARect.Left, ARect.Bottom);
    Canvas.LineTo(ARect.Right-1, ARect.Bottom);
    Canvas.LineTo(ARect.Right-1, ARect.Top);
    ARect.Inflate(-HalfX, -HalfX);
    DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, DT_LEFT);
  end;

begin
  inherited;
  ARect:= ClientRect;
  RowHeight:= Canvas.TextHeight('A') + 2*HalfX;
  AvailableHeight:= (Height - FPages.Count * FTabSpacing) div (FPages.Count + 1);
  RowHeight:= Min(RowHeight, AvailableHeight);

  ARect.Bottom:= ARect.Top + RowHeight;
  for var I:= 0 to FPages.Count - 1 do begin
    PaintPage(ARect, FPages[I]);
    if I = FCurrentIndex then begin
      Rect2:= ARect;
      Rect2.Top:= ARect.Bottom;
      Rect2.Bottom:= Height - ((FPages.Count - 2 - I) * (RowHeight + FTabSpacing) + RowHeight) - 1;
      Str:= 'Replace QLabel with any widget';
      DrawText(Canvas.Handle, PChar(Str), Length(Str), Rect2, DT_CENTER+DT_VCENTER+DT_SINGLELINE);
      ARect.Offset(0, Rect2.Bottom - ARect.Bottom + RowHeight);
    end else
      ARect.Offset(0, RowHeight + FTabSpacing);
  end;
end;

procedure TQtToolBox.SetPages(Value: TStrings);
begin
  if Value <> FPages then begin
    FPages.Assign(Value);
    Invalidate;
  end;
end;

procedure TQtToolBox.SetCurrentIndex(Value: Integer);
begin
  if Value <> FCurrentIndex then begin
    FCurrentIndex:= Value;
    Invalidate;
  end;
end;

procedure TQtToolBox.SetTabSpacing(Value: Integer);
begin
  if Value <> FTabSpacing then begin
    FTabSpacing:= Value;
    Invalidate;
  end;
end;

{--- TQtStackedWidget ---------------------------------------------------------}

constructor TQtStackedWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 115;
  Height:= 80;
  Width:= 120;
  FrameShape:= NoFrame;
  FrameShadow:= Plain;
  ControlStyle := [];
end;

function TQtStackedWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|CurrentIndex|CurrentPageName';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

const StackEvents = '|currentChanged|widgetRemoved';

function TQtStackedWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result:= StackEvents + inherited GetEvents(ShowEvents);
end;

function TQtStackedWidget.HandlerInfo(const Event: string): string;
begin
  if Pos(Event, StackEvents) > 0 then
    Result:= 'int;index'
  else
    Result:= inherited;
end;

procedure TQtStackedWidget.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then
    Slots.Add(Name + '.setCurrentIndex')
  else if Parametertypes = 'QWidget' then
    Slots.Add(Name + '.setCurrentWidget');
  inherited;
end;

procedure TQtStackedWidget.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QStackedWidget');
end;

{--- TQtLCDNumber -------------------------------------------------------------}

constructor TQtLCDNumber.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag:= 107;
  Width:= 80;
  Height:= 24;
  FrameShape:= Box;
  FrameShadow:= Raised;
  FDigitCount:= 5;
  FSegmentStyle:= Filled;
  FMode:= _MO_Dec;
  ControlStyle := [];
end;

function TQtLCDNumber.GetAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|SmallDecimalPoint|DigitCount|Mode|SegmentStyle|Value|IntValue';
  Result:= Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtLCDNumber.SetAttribute(const Attr, Value, Typ: string);
begin
  if (Attr = 'Mode') or (Attr = 'SegmentStyle') then
    MakeAttribut(Attr, 'QLCDNumber.' + Attr + '.' + Value)
  else if Attr = 'Value' then
    MakeValue(Value)
  else if Attr = 'IntValue' then
    MakeIntValue(Value)
  else
    inherited;
end;

function TQtLCDNumber.GetEvents(ShowEvents: Integer): string;
begin
  Result:= '|overflow';
  Result:= Result + inherited GetEvents(ShowEvents);
end;

procedure TQtLCDNumber.GetSlots(const Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.setBinMode');
    Slots.Add(Name + '.setDecMode');
    Slots.Add(Name + '.setHexMode');
    Slots.Add(Name + '.setOctMode');
  end else if Parametertypes = 'bool' then
    Slots.Add(Name + '.setSmallDecimalPoint')
  else if Parametertypes = 'QString' then
    Slots.Add(Name + '.display')
  else if (Parametertypes = 'double') or (Parametertypes = 'int') then
    Slots.Add(Name + '.display');
  inherited;
end;

procedure TQtLCDNumber.MakeValue(const Value: string);
begin
  var Str:= 'self.' + Name + '.setProperty("Value';
  SetAttributValue(Str, Str + '", ' + Value + ')');
  Str:= 'self.' + Name + '.setProperty("intValue';
  Partner.DeleteAttribute(Str);
end;

procedure TQtLCDNumber.MakeIntValue(const Value: string);
begin
  var Str:= 'self.' + Name + '.setProperty("intValue';
  SetAttributValue(Str, Str + '", ' + Value + ')');
  Str:= 'self.' + Name + '.setProperty("Value';
  Partner.DeleteAttribute(Str);
end;

procedure TQtLCDNumber.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('QLCDNumber');
end;

procedure TQtLCDNumber.Paint;
  const
   Digits: array[0..17, 0..6] of Integer =
    ((1,1,1,1,1,1,0), // 0
     (0,1,1,0,0,0,0), // 1
     (1,1,0,1,1,0,1), // 2
     (1,1,1,1,0,0,1), // 3
     (0,1,1,0,0,1,1), // 4
     (1,0,1,1,0,1,1), // 5
     (1,0,1,1,1,1,1), // 6
     (1,1,1,0,0,0,0), // 7
     (1,1,1,1,1,1,1), // 8
     (1,1,1,1,0,1,1), // 9
     (1,1,1,0,1,1,1), // A
     (0,0,1,1,1,1,1), // B
     (1,0,0,1,1,1,0), // C
     (0,1,1,1,1,0,1), // D
     (1,0,0,1,1,1,1), // E
     (1,0,0,0,1,1,1), // F
     (0,0,0,1,0,0,0), // .
     (0,0,0,0,0,0,1)  // -
     );

   Stretch = 107/52;

  type TPointArray = array of TPoint;

  var RightSpace, TopSpace, Base: Integer;
      X1Pos, Y1Pos, YHeight, YWidth, Padding, Xhw, DeltaX, DeltaY: Double;
      ValueInBase: string;
      TopSegment, RightTopSegment, RightBottomSegment, BottomSegment,
      LeftBottomSegment, LeftTopSegment, MiddleSegment, PointSegment,
      Segment: TPointArray;

  procedure ShowDigit(CDigit: Char; XPos, YPos: Double);
    var Digit: Integer;
  begin
    if CDigit <= '9' then
      Digit:= Ord(CDigit) - Ord('0')
    else
      Digit:= Ord(CDigit) - 55; // Ascii(A) = 65
    if CDigit = '.' then
      Digit:= 16;
    if CDigit = '-' then
      Digit:= 17;

    for var I:= 0 to 6 do
      if Digits[Digit][I] = 1 then begin
        case I of
          0: Segment:= Copy(TopSegment);
          1: Segment:= Copy(RightTopSegment);
          2: Segment:= Copy(RightBottomSegment);
          3: if Digit = 16
               then Segment:= Copy(PointSegment)
               else Segment:= Copy(BottomSegment);
          4: Segment:= Copy(LeftBottomSegment);
          5: Segment:= Copy(LeftTopSegment);
          6: Segment:= Copy(MiddleSegment);
        end;
        for var J:= 0 to Length(Segment) - 1 do begin
          Segment[J].X:= Round(Segment[J].X * DeltaX + XPos);
          Segment[J].Y:= Round(Segment[J].Y * DeltaY + YPos);
        end;
        Canvas.Polygon(Segment);
      end;
  end;

begin
  inherited;
  // SegmentStyle
  Canvas.Pen.Color:= $7A7A7A;
  Canvas.Brush.Color:= clBtnFace;
  Canvas.Rectangle(ClientRect);
  case FSegmentStyle of
    Flat: begin
            Canvas.Pen.Color:= clLtGray;
            Canvas.Brush.Color:= clBlack;
          end;
    Filled: begin
            Canvas.Pen.Color:= clWhite;
            Canvas.Brush.Color:= clBlack;
          end;
    Outline: begin
            Canvas.Pen.Color:= clLtGray;
            Canvas.Brush.Color:= clBtnFace;
          end;
  end;
  // Segments
  TopSegment:= [Point(0, 0), Point(10,0), Point(9,2), Point(2,2)];
  RightTopSegment:= [Point(10, 0), Point(10,10), Point(8,9), Point(8,2)];
  RightBottomSegment:= [Point(10, 10), Point(10,20), Point(8,18), Point(8,11)];
  BottomSegment:= [Point(0, 20), Point(10,20), Point(8,18), Point(2,18)];
  LeftBottomSegment:= [Point(0, 10), Point(0,20), Point(2,18), Point(2,11)];
  LeftTopSegment:= [Point(0, 0), Point(0,10), Point(2,9), Point(2,2)];
  MiddleSegment:= [Point(0, 10), Point(2,9), Point(8,9),
                   Point(10,10), Point(8, 11), Point(2,11)];
  PointSegment:= [Point(5, 20), Point(7, 20), Point(7,18), Point(5, 18)];

  // layout of segments
  YHeight:= Height/(5*Stretch + 2.0);
  YWidth:= Width/(6*FDigitCount + 1.0);
  if YHeight < YWidth
    then Padding:= YHeight // Padding = distance digit to border
    else Padding:= YWidth;
  Xhw:= 5*Padding;   // Xhw = width of a digit
  if YHeight < YWidth then begin
    RightSpace:= Round((Width - FDigitCount*Xhw - (FDigitCount+1)*Padding)/2);
    TopSpace:= 0;
  end else begin
    TopSpace:= Round((Height - Xhw*Stretch - 2*Padding)/2);
    RightSpace:= 0;
  end;
  DeltaX:= Xhw/10;
  DeltaY:= DeltaX*Stretch/2;

  // Mode
  case FMode of
    _MO_Hex: Base:= 16;
    _MO_Dec: Base:= 10;
    _MO_Oct: Base:= 8;
    else     Base:= 2;
  end;

  ValueInBase:= DecToBase(Base, FValue);
  if Length(ValueInBase) > FDigitCount then
    ValueInBase:= DecToBase(Base, 0);
  ValueInBase:= StringOfChar(' ', FDigitCount - Length(ValueInBase)) + ValueInBase;

  // Digits
  for var I:= FDigitCount downto 1 do begin
    X1Pos:= RightSpace + (I-1)*Xhw + I*Padding;
    Y1Pos:= TopSpace + Padding;
    if ValueInBase[I] <> ' ' then
      ShowDigit(ValueInBase[I], X1Pos, Y1Pos);
  end;
end;

procedure TQtLCDNumber.SetSegmentStyle(Value: TSegmentStyle);
begin
  if Value <> FSegmentStyle then begin
    FSegmentStyle:= Value;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.SetValue(Value: Double);
begin
  if Value <> FValue then begin
    FValue:= Value;
    FIntValue:= Round(FValue);
    Invalidate;
  end;
end;

procedure TQtLCDNumber.SetIntValue(Value: Integer);
begin
  if Value <> FIntValue then begin
    FIntValue:= Value;
    FValue:= FIntValue;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.SetDigitCount(Value: Integer);
begin
  if Value <> FDigitCount then begin
    FDigitCount:= Value;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.SetSmallDecimalPoint(Value: Boolean);
begin
  if Value <> FSmallDecimalPoint then begin
    FSmallDecimalPoint:= Value;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.SetMode(Value: TMode);
begin
  if Value <> FMode then begin
    FMode:= Value;
    Invalidate;
  end;
end;

end.





