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
    FLineWidth: integer;
    FMidLineWidth: integer;
    procedure setFrameShape(Value: TFrameShape);
    procedure setFrameShadow(Value: TFrameShadow);
    procedure setLineWidth(Value: integer);
    procedure setMidLineWidth(Value: integer);
    procedure PaintBorder(R: TRect; C1, C2: TColor; lWidth: integer = -1);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
    function InnerRect: TRect; override;
  published
    property FrameShape: TFrameShape read FFrameShape write setFrameShape;
    property FrameShadow: TFrameShadow read FFrameShadow write setFrameShadow;
    property LineWidth: integer read FLineWidth write setLineWidth;
    property MidLineWidth: integer read FMidLineWidth write setMidLineWidth;
  end;

  TQtLabel = class(TQtFrame)
  private
    FAlignmentHorizontal: TAlignmentHorizontal;
    FAlignmentVertical: TAlignmentVertical;
    FText: String;
    FTextFormat: TTextFormat;
    FPixmap: string;
    FScaledContents: boolean;
    FWordWrap: boolean;
    FMargin: integer;
    FIndent: integer;
    FOpenExternalLinks: boolean;
    // FTextInteractionFlags: TTextInteractionFlags;
    FBuddy: string;
    FLinkActivated: string;
    FLinkHovered: string;
    procedure setAlignmentHorizontal(Value: TAlignmentHorizontal);
    procedure setAlignmentVertical(Value: TAlignmentVertical);
    procedure setText(value: String);
    procedure setPixmap(value: String);
    procedure setWordWrap(value: boolean);
    procedure setIndent(Value: integer);
    procedure setMargin(Value: integer);
    procedure setScaledContents(Value: boolean);
    procedure MakePixmap(Value: string);
    procedure MakeAlignment(Attr, Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure SizeToText; override;
    procedure Paint; override;
  published
    property AlignmentHorizontal: TAlignmentHorizontal read FAlignmentHorizontal write setAlignmentHorizontal;
    property AlignmentVertical: TAlignmentVertical read FAlignmentVertical write setAlignmentVertical;
    property Text: string read FText write setText;
    property TextFormat: TTextFormat read FTextFormat write FTextFormat;
    property Pixmap: string read FPixmap write setPixmap;
    property ScaledContents: boolean read FScaledContents write setScaledContents;
    property WordWrap: boolean read FWordWrap write setWordWrap;
    property Margin: integer read FMargin write setMargin;
    property Indent: integer read FIndent write setIndent;
    property OpenExternalLinks: boolean read FOpenExternalLinks write FOpenExternalLinks;
    property Buddy: string read FBuddy write FBuddy;
    //signals
    property linkActivated: string read FLinkActivated write FLinkActivated;
    property linkHovered: string read FLinkHovered write FLinkHovered;
  end;

  TQtCanvas = class(TQtLabel)
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  end;

  TQtLine = class(TQtFrame)
  private
    FOrientation: TOrientation;
    procedure setOrientation(Value: TOrientation);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property Orientation: TOrientation read FOrientation write setOrientation;
  end;

  TQtToolBox = class(TQtFrame)
  private
    FCurrentIndex: integer;
    FTabSpacing: integer;
    FPages: TStrings;
    FCurrentChanged: string;
    procedure setPages(Value: TStrings);
    procedure setCurrentIndex(Value: integer);
    procedure setTabSpacing(Value: integer);
    procedure MakePages;
    procedure MakeTabSpacing(Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteWidget; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property CurrentIndex: integer read FCurrentIndex write setCurrentIndex;
    property TabSpacing: integer read FTabSpacing write setTabSpacing;
    property Pages: TStrings read FPages write setPages;
    // signals
    property currentChanged: string read FCurrentChanged write FCurrentChanged;
  end;

  TQtStackedWidget = class(TQtFrame)
  private
    FCurrentIndex: integer;
    FCurrentPageName: string;
    FCurrentChanged: string;
    FWidgetRemoved: string;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
  published
    property CurrentIndex: integer read FCurrentIndex write FCurrentIndex;
    property CurrentPageName: string read FCurrentPageName write FCurrentPageName;
    property CurrentChanged: string read FCurrentChanged write FCurrentChanged;
    property WidgetRemoved: string read FWidgetRemoved write FWidgetRemoved;
  end;

  TQtLCDNumber = class(TQtFrame)
  private
    FSmallDecimalPoint: boolean;
    FDigitCount: integer;
    FMode: TMode;
    FSegmentStyle: TSegmentStyle;
    FValue: double;
    FIntValue: integer;
    FOverflow: string;
    procedure setSegmentStyle(Value: TSegmentStyle);
    procedure setValue(Value: double);
    procedure setIntValue(Value: integer);
    procedure setDigitCount(Value: integer);
    procedure setSmallDecimalPoint(Value: boolean);
    procedure setMode(Value: TMode);
    procedure MakeValue(Value: string);
    procedure MakeIntValue(Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property SmallDecimalPoint: boolean read FSmallDecimalPoint write setSmallDecimalPoint;
    property DigitCount: integer read FDigitCount write setDigitCount;
    property Mode: TMode read FMode write setMode;
    property SegmentStyle: TSegmentStyle read FSegmentStyle write setSegmentStyle;
    property Value: double read FValue write setValue;
    property IntValue: integer read FIntValue write setIntValue;
    // signals
    property overflow: string read FOverflow write FOverflow;
  end;

implementation

uses  Controls, SysUtils, Math, Types,  UUtils, UGuiDesigner;

{--- TQtFrame -----------------------------------------------------------------}

constructor TQtFrame.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 83;
  Width:= 120;
  Height:= 80;
  FLineWidth:= 1;
  FFrameShape:= StyledPanel;
  FFrameShadow:= Raised;
  ControlStyle := [csAcceptsControls];
end;

function TQtFrame.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '';
  if classname = 'TQtFrame' then
    Result:= '|FrameShape|FrameShadow|LineWidth|MidLineWidth'
  else if ShowAttributes >= 2 then
    Result:= '|FrameShape|FrameShadow|LineWidth|MidLineWidth';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtFrame.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'FrameShape' then
    MakeAttribut(Attr, 'QFrame.Shape.' + Value)
  else if Attr = 'FrameShadow' then
    MakeAttribut(Attr, 'QFrame.Shadow.' + Value)
  else
    inherited;
end;

procedure TQtFrame.NewWidget(Widget: String = '');
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
           var R:= ClientRect;
           PaintBorder(R, clWhite, Grey);
           R.Inflate(-LineWidth, -LineWidth);
           PaintBorder(R, Grey, clWhite);
        end;
        Sunken: begin
           var R:= ClientRect;
           PaintBorder(R, Grey, clWhite);
           R.Inflate(-LineWidth, -LineWidth);
           PaintBorder(R, clWhite, Grey);
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
          var R:= ClientRect;
          Canvas.FrameRect(R);
          R.Inflate(-1, -1);
          Canvas.FrameRect(R);
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
  var R, R1: TRect;
begin
  R:= ClientRect;
  R1:= ClientRect;
  R1.Inflate(-FLineWidth, -FLineWidth);
  case FFrameShape of
    NoFrame: ;
    Box:
      case FFrameShadow of
        Plain:  R:= R1;
        Raised,
        Sunken: R.Inflate(-2*FLineWidth, -2*FLineWidth);
      end;
    Panel: R:= R1;
    WinPanel:
      case FFrameShadow of
        Plain:  R.Inflate(-1, -1);
        Raised: R:= R1;
        Sunken: R:= R1;
      end;
    StyledPanel: R.Inflate(-1, -1);
  end;
  Result:= R;
end;

procedure TQtFrame.PaintBorder(R: TRect; C1, C2: TColor; lWidth: integer = -1);

  procedure PaintTopLeft;
  begin
    Canvas.Pen.Color:= C1;
    for var i:= 0 to lWidth - 1 do begin
      Canvas.MoveTo(R.Left + i, R.Bottom - i - 1);
      Canvas.LineTo(R.Left + i, R.Top + i);
      Canvas.LineTo(R.Right - i, R.Top + i);
    end;
  end;

  procedure PaintBottomRight;
  begin
    Canvas.Pen.Color:= C2;
    for var i:= 1 to lWidth do begin
      Canvas.MoveTo(R.Left + i, R.Bottom - i);
      Canvas.LineTo(R.Right - i, R.Bottom - i);
      Canvas.LineTo(R.Right - i, R.Top + i - 1);
    end;
  end;

begin
  if lWidth = -1 then
    lWidth:= FLineWidth;
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

procedure TQtFrame.setFrameShape(Value: TFrameShape);
begin
  if Value <> FFrameShape then begin
    FFrameShape:= Value;
    Invalidate;
  end;
end;

procedure TQtFrame.setFrameShadow(Value: TFrameShadow);
begin
  if Value <> FFrameShadow then begin
    FFrameShadow:= Value;
    Invalidate;
  end;
end;

procedure TQtFrame.setLineWidth(Value: integer);
begin
  if Value <> FLineWidth then begin
    FLineWidth:= Value;
    Invalidate;
  end;
end;

procedure TQtFrame.setMidLineWidth(Value: integer);
begin
  if Value <> FMidLineWidth then begin
    FMidLineWidth:= Value;
    Invalidate;
  end;
end;

{--- TQtLabel -----------------------------------------------------------------}

constructor TQtLabel.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
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

function TQtLabel.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Text|Pixmap|Buddy|Font';
  if ShowAttributes >= 2 then
    Result:= Result + '|TextFormat|WordWrap|Margin|Indent';
  if ShowAttributes = 3 then
    Result:= Result + '|AlignmentHorizontal|AlignmentVertical|ScaledContents|OpenExternalLinks';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtLabel.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'TextFormat'  then
    Makeattribut(Attr, 'Qt.TextFormat.' + Value)
  else if Attr = 'Pixmap'  then
    MakePixmap(Value)
  else if Pos('Alignment', Attr) = 1 then
    MakeAlignment(Attr, Value)
  else
    inherited;
end;

Const LabelEvents = '|linkActivated|linkHovered';

function TQtLabel.getEvents(ShowEvents: integer): string;
begin
  Result:= LabelEvents + inherited getEvents(ShowEvents);
end;

function TQtLabel.HandlerInfo(const event: string): string;
begin
  if Pos(event, LabelEvents) > 0 then
    Result:= 'QString;link'
  else
    Result:= inherited;
end;

procedure TQtLabel.getSlots(Parametertypes: string; Slots: TStrings);
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

procedure TQtLabel.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QLabel');
  if Widget = '' then
    setAttribute('Text', 'TextLabel', 'Text');
end;

procedure TQtLabel.SizeToText;
begin
  var d:= Canvas.TextWidth(Text + 'x') - Width;
  if d > 0 then Width:= Width + d;
  d:= Canvas.TextHeight(Text)+ 4 - Height;
  if d > 0 then Height:= Height + d;
end;

procedure TQtLabel.Paint;
  var w, h, format, indent, taw: integer; pathname: String;
      SL: TStringList; R: TRect; bmp: TBitmap;
begin
  inherited;
  R:= ClientRect;
  if FMargin > 0 then
    R.inflate(-FMargin, -FMargin);
  pathname:= FGuiDesigner.getPath + 'images\' + copy(FPixmap, 8, length(FPixmap));
  if FileExists(pathname) then begin
    bmp:= BitmapFromRelativePath(FPixmap);
    if FScaledContents
      then Canvas.StretchDraw(R, bmp)
      else Canvas.Draw(0, (Height - bmp.Height) div 2, bmp);
    FreeAndNil(bmp);
  end else begin
    if FIndent <= 0
      then indent:= HalfX
      else indent:= FIndent;
    R.Inflate(-indent, 0);
    SL:= TStringList.Create;
    taw:= R.Right - R.Left;
    if FWordWrap
      then WrapText(FText, taw, w, h, SL)
      else CalculateText(FText, w, h, SL);

    case FAlignmentHorizontal of
      AlignLeft:    format:= DT_LEFT;
      AlignRight:   format:= DT_RIGHT;
      AlignHCenter: begin
                      R.Left:= (taw - w) div 2;
                      format:= DT_CENTER;
                    end;
      else          format:= DT_LEFT;
    end;
    case FAlignmentVertical of
      AlignTop:      ;
      AlignBottom:   R.Top:= R.Bottom - h;
      AlignVCenter:  R.Top:= (Height - h) div 2;
      AlignBaseline: ;
    end;
    if FWordWrap then
      format:= format + DT_WORDBREAK;
    if SL.Text <> CrLf then
      DrawText(Canvas.Handle, PChar(SL.Text), Length(SL.Text), R, format);
    FreeAndNil(SL);
  end;
end;

procedure TQtLabel.MakePixmap(Value: string);
  var s, key, Dest, filename, Path: string;
begin
  // ToDo use PIL if png-file selected
  key:= 'self.' + Name + '.setPixmap';
  if Value = '(Image)' then begin
    Partner.DeleteAttribute(key);
    Partner.DeleteAttribute(key + 'Size');
  end else begin
    filename:= ExtractFileName(Value);
    if Pos('images/', filename) = 1 then
      System.delete(filename, 1, 7);
    Path:= ExtractFilePath(Partner.Pathname);
    Dest:= Path + 'images\' + filename;
    ForceDirectories(Path + 'images\');
    if not FileExists(Dest) then
      copyFile(PChar(Value), PChar(Dest), true);
    FPixmap:= 'images/' + filename;
    s:= key + '(QPixmap(' + asString(FPixmap) + '))';
    setAttributValue(key, s);
    UpdateObjectInspector;
  end;
end;

procedure TQtLabel.MakeAlignment(Attr, Value: string);
  var key: string;
begin
  key:= 'self.' + Name + '.setAlignment';
  if Attr = 'AlignmentHorizontal'
    then setAttributValue(key, key + '(Qt.AlignmentFlag.' + Value +
           ' | Qt.AlignmentFlag.' + enumToString(FAlignmentVertical) + ')')
    else setAttributValue(key, key + '(Qt.AlignmentFlag.' +
           enumToString(FAlignmentHorizontal) + ' | Qt.AlignmentFlag.' + Value + ')');
end;

procedure TQtLabel.setText(Value: string);
begin
  if Value <> FText then begin
    FText:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.setPixmap(Value: string);
begin
  if Value <> FPixmap then begin
    FPixmap:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.setWordWrap(Value: boolean);
begin
  if Value <> FWordWrap then begin
    FWordWrap:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.setIndent(Value: integer);
begin
  if Value <> FIndent then begin
    FIndent:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.setMargin(Value: integer);
begin
  if Value <> FMargin then begin
    FMargin:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.setScaledContents(Value: boolean);
begin
  if Value <> FScaledContents then begin
    FScaledContents:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.setAlignmentHorizontal(Value: TAlignmentHorizontal);
begin
  if Value <> FAlignmentHorizontal then begin
    FAlignmentHorizontal:= Value;
    Invalidate;
  end;
end;

procedure TQtLabel.setAlignmentVertical(Value: TAlignmentVertical);
begin
  if Value <> FAlignmentVertical then begin
    FAlignmentVertical:= Value;
    Invalidate;
  end;
end;

{--- TQtCanvas ----------------------------------------------------------------}

constructor TQtCanvas.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 81;
  Height:= 80;
  Width:= 120;
  ControlStyle := [];
end;

function TQtCanvas.getAttributes(ShowAttributes: integer): string;
begin
  Result:= Result + inherited getAttributes(ShowAttributes);
  var p:= Pos('|Text|Pixmap|Buddy', Result);
  delete(Result, p, p + 17);
end;

procedure TQtCanvas.NewWidget(Widget: String = '');
  var s: string;
begin
  inherited NewWidget('QLabel');
  Text:= '';
  s:= surround('self.' + Name + 'Pixmap = QPixmap(self.' + Name + '.size())');
  s:= s + surround('self.' + Name + 'Pixmap.fill()');
  s:= s + surround('self.' + Name + 'Painter = QPainter(self.' + Name + 'Pixmap' + ') # draw with Painter');
  s:= s + surround('self.' + Name + '.setPixmap(self.' + Name + 'Pixmap) # show the drawing');
  InsertValue(s);
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

constructor TQtLine.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 112;
  Width:= 120;
  Height:= 3;
  FOrientation:= Horizontal;
  FrameShape:= HLine;
  FrameShadow:= Sunken;
  ControlStyle := [];
end;

function TQtLine.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Orientation';
  Result:= Result + inherited getAttributes(ShowAttributes);
  var p:= Pos('|FrameShape', Result);
  if p > 0 then
    delete(Result, p, 11);
end;

procedure TQtLine.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Orientation'  then begin
    if Value = 'Horizontal'
      then setAttribute('FrameShape', 'HLine', '')
      else setAttribute('FrameShape', 'VLine', '');
  end else
    inherited;
end;

procedure TQtLine.NewWidget(Widget: String = '');
begin
  inherited NewWidget(Widget);
  setAttribute('FrameShape', 'HLine', '');
  setAttribute('FrameShadow', 'Sunken', '');
end;

procedure TQtLine.setOrientation(Value: TOrientation);
begin
  if Value <> FOrientation then begin
    FOrientation:= Value;
    if not (csLoading in ComponentState) then begin
      var h:= Width; Width:= Height; Height:= h;
      SetPositionAndSize;
    end;
    if Value = Horizontal
      then FrameShape:= HLine
      else FrameShape:= VLine;
    Invalidate;
  end;
end;

{--- TQtToolBox ---------------------------------------------------------------}

constructor TQtToolBox.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
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

function TQtToolBox.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|CurrentIndex|Pages|TabSpacing';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtToolBox.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Pages' then
    MakePages
  else if Attr = 'TabSpacing' then
    MakeTabSpacing(Value)
  else
    inherited;
end;

function TQtToolBox.getEvents(ShowEvents: integer): string;
begin
  Result:= '|currentChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtToolBox.HandlerInfo(const event: string): string;
begin
  if event = 'currentChanged' then
    Result:= 'int;index'
  else
    Result:= inherited;
end;

procedure TQtToolBox.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then
    Slots.Add(Name + '.setCurrentIndex')
  else if Parametertypes = 'QWidget' then
    Slots.Add(Name + '.setCurrentWidget');
  inherited;
end;

procedure TQtToolBox.MakePages;
  var i: integer; pagename, s: string;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  Partner.DeleteAttributeValues('self.' + Name + '.addItem');
  Partner.DeleteItems(Name, 'Page');
  s:= '';
  for i:= 1 to FPages.Count do begin
    pagename:= 'self.' + Name + 'Page' + IntTostr(i);
    s:= s + surround(pagename + ' = QLabel()');
    s:= s + surround(pagename + '.setText(' + asString('Add widgets to this page') + ')');
    s:= s + surround('self.' + Name + '.addItem(' + pagename + ', ' + asString(FPages[i-1]) + ')');
  end;
  InsertValue(s);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TQtToolBox.MakeTabSpacing(Value: string);
begin
  var s:= 'self.' + Name  + '.layout' ;
  setAttributValue(s, s + '().setSpacing(' + Value + ')');
end;

procedure TQtToolBox.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QToolBox');
  MakePages;
end;

procedure TQtToolBox.Paint;
  var R, R2: TRect; i, RowHeight, AvailableHeight: integer;
      s: string;

  procedure PaintPage(R: TRect; s: string);
  begin
    Canvas.Brush.Color:= $F0F0F0;
    Canvas.Pen.Color:= clWhite;
    Canvas.Rectangle(R);
    Canvas.Pen.Color:= $A0A0A0;
    Canvas.MoveTo(R.Left, R.Bottom);
    Canvas.LineTo(R.Right-1, R.Bottom);
    Canvas.LineTo(R.Right-1, R.Top);
    R.Inflate(-HalfX, -HalfX);
    DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_LEFT);
  end;

begin
  inherited;
  R:= ClientRect;
  RowHeight:= Canvas.TextHeight('A') + 2*HalfX;
  AvailableHeight:= (Height - FPages.Count * FTabSpacing) div (FPages.Count + 1);
  RowHeight:= min(RowHeight, AvailableHeight);

  R.Bottom:= R.Top + RowHeight;
  for i:= 0 to FPages.Count - 1 do begin
    PaintPage(R, FPages[i]);
    if i = FCurrentIndex then begin
      R2:= R;
      R2.Top:= R.Bottom;
      R2.Bottom:= Height - ((FPages.Count - 2 - i) * (RowHeight + FTabSpacing) + RowHeight) - 1;
      s:= 'Replace QLabel with any widget';
      DrawText(Canvas.Handle, PChar(s), Length(s), R2, DT_CENTER+DT_VCENTER+DT_SINGLELINE);
      R.Offset(0, R2.Bottom - R.Bottom + RowHeight);
    end else
      R.Offset(0, RowHeight + FTabSpacing);
  end;
end;

procedure TQtToolBox.setPages(Value: TStrings);
begin
  if Value <> FPages then begin
    FPages.assign(Value);
    Invalidate;
  end;
end;

procedure TQtToolBox.setCurrentIndex(Value: integer);
begin
  if Value <> FCurrentIndex then begin
    FCurrentIndex:= Value;
    Invalidate;
  end;
end;

procedure TQtToolBox.setTabSpacing(Value: integer);
begin
  if Value <> FTabSpacing then begin
    FTabSpacing:= Value;
    Invalidate;
  end;
end;

{--- TQtStackedWidget ---------------------------------------------------------}

constructor TQtStackedWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 115;
  Height:= 80;
  Width:= 120;
  FrameShape:= NoFrame;
  FrameShadow:= Plain;
  ControlStyle := [];
end;

function TQtStackedWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|CurrentIndex|CurrentPageName';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

const StackEvents = '|currentChanged|widgetRemoved';

function TQtStackedWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= StackEvents + inherited getEvents(ShowEvents);
end;

function TQtStackedWidget.HandlerInfo(const event: string): string;
begin
  if Pos(event, StackEvents) > 0 then
    Result:= 'int;index'
  else
    Result:= inherited;
end;

procedure TQtStackedWidget.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then
    Slots.Add(Name + '.setCurrentIndex')
  else if Parametertypes = 'QWidget' then
    Slots.Add(Name + '.setCurrentWidget');
  inherited;
end;

procedure TQtStackedWidget.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QStackedWidget');
end;

{--- TQtLCDNumber -------------------------------------------------------------}

constructor TQtLCDNumber.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 107;
  Width:= 80;
  Height:= 24;
  FrameShape:= Box;
  FrameShadow:= Raised;
  FDigitCount:= 5;
  FSegmentStyle:= Filled;
  FMode:= _MO_dec;
  ControlStyle := [];
end;

function TQtLCDNumber.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|SmallDecimalPoint|DigitCount|Mode|SegmentStyle|Value|IntValue';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtLCDNumber.setAttribute(Attr, Value, Typ: string);
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

function TQtLCDNumber.getEvents(ShowEvents: integer): string;
begin
  Result:= '|overflow';
  Result:= Result + inherited getEvents(ShowEvents);
end;

procedure TQtLCDNumber.getSlots(Parametertypes: string; Slots: TStrings);
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

procedure TQtLCDNumber.MakeValue(Value: string);
begin
  var s:= 'self.' + Name + '.setProperty("value';
  setAttributValue(s, s + '", ' + Value + ')');
  s:= 'self.' + Name + '.setProperty("intValue';
  Partner.DeleteAttribute(s);
end;

procedure TQtLCDNumber.MakeIntValue(Value: string);
begin
  var s:= 'self.' + Name + '.setProperty("intValue';
  setAttributValue(s, s + '", ' + Value + ')');
  s:= 'self.' + Name + '.setProperty("value';
  Partner.DeleteAttribute(s);
end;

procedure TQtLCDNumber.NewWidget(Widget: String = '');
begin
  inherited NewWidget('QLCDNumber');
end;

procedure TQtLCDNumber.Paint;
  const
   digits: array[0..17, 0..6] of integer =
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

  var i, RightSpace, TopSpace, Base: integer;
      x1, y1, yh, yw, padding, xhw, dx, dy: double;
      ValueInBase: string;
      TopSegment, RightTopSegment, RightBottomSegment, BottomSegment,
      LeftBottomSegment, LeftTopSegment, MiddleSegment, PointSegment,
      Segment: TPointArray;

  procedure ShowDigit(cDigit: char; x, y: double);
    var i, j, digit: integer;
  begin
    if cDigit <= '9' then
      digit:= Ord(cDigit) - Ord('0')
    else
      digit:= Ord(cDigit) - 55; // Ascii(A) = 65
    if cDigit = '.' then
      digit:= 16;
    if cDigit = '-' then
      digit:= 17;

    for i:= 0 to 6 do
      if digits[digit][i] = 1 then begin
        case i of
          0: Segment:= copy(TopSegment);
          1: Segment:= copy(RightTopSegment);
          2: Segment:= copy(RightBottomSegment);
          3: if digit = 16
               then Segment:= copy(PointSegment)
               else Segment:= copy(BottomSegment);
          4: Segment:= copy(LeftBottomSegment);
          5: Segment:= copy(LeftTopSegment);
          6: Segment:= copy(MiddleSegment);
        end;
        for j:= 0 to Length(Segment) - 1 do begin
          Segment[j].x:= Round(Segment[j].x*dx + x);
          Segment[j].y:= Round(Segment[j].y*dy + y);
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
  yh:= Height/(5*Stretch + 2.0);
  yw:= Width/(6*FDigitCount + 1.0);
  if yh < yw
    then padding:= yh // padding = distance digit to border
    else padding:= yw;
  xhw:= 5*padding;   // xhw = width of a digit
  if yh < yw then begin
    RightSpace:= Round((Width - FDigitCount*xhw - (FDigitCount+1)*padding)/2);
    TopSpace:= 0;
  end else begin
    TopSpace:= Round((Height - xhw*Stretch - 2*padding)/2);
    RightSpace:= 0;
  end;
  dx:= xhw/10;
  dy:= dx*Stretch/2;

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

  // digits
  for i:= FDigitCount downto 1 do begin
    x1:= RightSpace + (i-1)*xhw + i*padding;
    y1:= TopSpace + padding;
    if ValueInBase[i] <> ' ' then
      ShowDigit(ValueInBase[i], x1, y1);
  end;
end;

procedure TQtLCDNumber.setSegmentStyle(Value: TSegmentStyle);
begin
  if Value <> FSegmentStyle then begin
    FSegmentStyle:= Value;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.setValue(Value: double);
begin
  if Value <> FValue then begin
    FValue:= Value;
    FIntValue:= Round(FValue);
    Invalidate;
  end;
end;

procedure TQtLCDNumber.setIntValue(Value: integer);
begin
  if Value <> FIntValue then begin
    FIntValue:= Value;
    FValue:= FIntValue;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.setDigitCount(Value: integer);
begin
  if Value <> FDigitCount then begin
    FDigitCount:= Value;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.setSmallDecimalPoint(Value: boolean);
begin
  if Value <> FSmallDecimalPoint then begin
    FSmallDecimalPoint:= Value;
    Invalidate;
  end;
end;

procedure TQtLCDNumber.setMode(Value: TMode);
begin
  if Value <> FMode then begin
    FMode:= Value;
    Invalidate;
  end;
end;

end.



