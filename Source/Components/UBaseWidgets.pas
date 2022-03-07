{-------------------------------------------------------------------------------
 Unit:     UBaseWidgets
 Author:   Gerhard R�hner
 Date:     May 2021
 Purpose:  base widget of Tkinter and TTKinter
-------------------------------------------------------------------------------}

unit UBaseWidgets;

interface

uses
  Windows, Messages, Controls, Graphics, Classes, ELEvents, frmEditor;

const
  TagNormal        =  0;
  TagText          =  1;
  TagAlignment     =  2;
  TagBoolean       =  3;
  TagColor         =  4;
  TagFont          =  5;
  TagNumber        =  6;
  TagChar          =  7;
  TagLines         =  8;
  TagOrientation   =  9;
  TagLayout        = 10;
  TagJAlignment    = 11;
  TagSelectionMode = 12;
  TagJOrientation  = 13;
  TagJVScrollPane  = 14;
  TagJHScrollPane  = 15;
  TagIcon          = 16;
  TagMode          = 17;
  TagSelection     = 18;
  TagOption        = 19;
  TagMessage       = 20;
  PickBoolean = 'true'#13#10'false';

  CrLf = #13#10;

type

  // Relief
  TRelief = (_TR_flat, _TR_groove, _TR_raised, _TR_ridge, _TR_solid, _TR_sunken);

  // positioning of text, used in TextWidget
  TAnchor = (_TA_nw, _TA_n, _TA_ne, _TA_w, _TA_center, _TA_e, _TA_sw, _TA_s, _TA_se);

  // used in Text and Labeled
  TJustify = (_TJ_left, _TJ_center, _TJ_right);

  TUCompound = (_TU_top, _TU_bottom, _TU_left, _TU_right, _TU_center, _TU_none,
                _TU_image, _TU_text); // united Compound

  TScrollbar = (_TB_none, _TB_horizontal, _TB_vertical, _TB_both);

  TSide = (_TS_none, _TS_left, _TS_right, _TS_bottom, _TS_top);

  TBaseWidget = class(TCustomControl)
  private
    FAnchor: TAnchor;
    FBackground: TColor;
    FForeground: TColor;
    FBorderWidth: String;
    FCommand: Boolean;
    FImage: String;
    FJustify: TJustify;
    FRelief: TRelief;
    FSizeable: boolean;
    FScrollbar: boolean;
    FScrollbars: TScrollbar;
    FTakeFocus: boolean;
    FUnderline: integer;
    FWrapLength: String;

    // events
    FActivate: TEvent;
    FButtonPress: TEvent;
    FButtonRelease: TEvent;
    FConfigure: TEvent;
    FDeactivate: TEvent;
    FEnter: TEvent;
    FFocusIn: TEvent;
    FFocusOut: TEvent;
    FKeyPress: TEvent;
    FKeyRelease: TEvent;
    FLeave: TEvent;
    FMotion: TEvent;
    FMouseWheel: TEvent;

    procedure setX(aValue: integer);
    function  getX: integer;
    procedure setY(aValue: integer);
    function  getY: integer;
    procedure setAnchor(aValue: TAnchor);
    procedure setBackground(aColor: TColor);
    procedure setForeground(aColor: TColor);
    procedure setBorderWidth(aValue: string);
    procedure setMenu(Value: string);
    procedure setImage(aValue: string);
    procedure setJustify(aValue: TJustify);
    procedure setRelief(aValue: TRelief);
    procedure setUnderline(aValue: integer);
    procedure setWrapLength(aValue: String);
    procedure MakeBoolean(Attr, Value: String);
    procedure MakeShow(Value: String);
  protected
    FNameExtension: string; // used by LabeledScale
    BorderWidthInt: integer;
    TopSpace: integer;
    LeftSpace: integer;
    RightSpace: integer;

    function getMouseEvents(ShowEvents: integer): string; virtual;
    function getKeyboardEvents(ShowEvents: integer): string; virtual;
    function getCompound: TUCompound; virtual; abstract;
    procedure setAttributValue(key, s: string);
    function getAttrAsKey(Attr: string): string;
    procedure setValue(Variable, Value: String);
    procedure Calculate3DColors(var DarkColor, LightColor: TColor; Background: TColor);
    procedure CalculatePadding(var pl, pt, pr, pb: integer); virtual; abstract;
    procedure CalculateText(var tw, th: integer; var SL: TStringList); virtual; abstract;
    procedure MakeCommand(Attr, Value: String); virtual;
    procedure AddParameter(const Value, par: String);
    procedure MakeControlVar(Variable, ControlVar: String; Value: String = '';  Typ: String = 'String');
    procedure MakeImage(const Value: string);
    procedure MakeValidateCommand(Attr, Value: string);
    procedure MakeScrollbar(Value, TkTyp: String);
    procedure MakeScrollbars(Value, TkTyp: String);
    procedure PaintAScrollbar(Value: boolean);
    procedure PaintScrollbars(Scrollbar: TScrollbar);
    procedure setScrollbar(Value: boolean);
    procedure setScrollbars(Value: TScrollbar);
    procedure ShowText(s: String; newWidth, newHeight: integer);
    procedure Paint; override;
    procedure PaintBorder(R: TRect; Relief: TRelief; BorderWidth: integer); virtual; abstract;
    procedure PaintScrollbar(R: TRect; horizontal: boolean; ttk: boolean = false);
    procedure ChangeCommand(Attr, Value: string);
    procedure InsertVariable(const Variable: string);
    function Indent1: string;
    function Indent2: string;
    function Indent3: string;
  public
    property Anchor: TAnchor read FAnchor write setAnchor default _TA_center;
    property Background: TColor read FBackground write setBackground default clBtnFace;
    property BorderWidth: String read FBorderWidth write setBorderWidth;
    property Command: Boolean read FCommand write FCommand;
    property Foreground: TColor read FForeground write setForeground default clWindowText;
    property Image: String read fImage write setImage;
    property Justify: TJustify read FJustify write setJustify default _TJ_center;
    property Relief: TRelief read FRelief write setRelief default _TR_flat;
    property Sizeable: boolean read FSizeable write FSizeable default true;
    property Scrollbars: TScrollbar read FScrollbars write setScrollbars default _TB_none;
    property Scrollbar: boolean read FScrollbar write setScrollbar default false;
    property TakeFocus: boolean read FTakeFocus write fTakeFocus default true;
    property Underline: integer read FUnderline write setUnderline default -1;
    property WrapLength: String read FWrapLength write setWrapLength;
  published
    // common attribute for tk and ttk
    property Cursor;
    property Height;
    property Width;
    property x: integer read getX write setX;
    property y: integer read getY write setY;

    // events
    {$WARNINGS OFF}
    property Activate: TEvent read Factivate write Factivate;
    property ButtonPress: TEvent read FbuttonPress write FbuttonPress;
    property ButtonRelease: TEvent read FbuttonRelease write FbuttonRelease;
    property Configure: TEvent read Fconfigure write Fconfigure;
    property Deactivate: TEvent read Fdeactivate write Fdeactivate;
    property Enter: TEvent read FEnter write FEnter;
    property FocusIn: TEvent read FfocusIn write FfocusIn;
    property FocusOut: TEvent read FfocusOut write FfocusOut;
    property KeyPress: TEvent read fkeyPress write fkeyPress;
    property KeyRelease: TEvent read fkeyRelease write fkeyRelease;
    property Leave: TEvent read fleave write fleave;
    property Motion: TEvent read fMotion write fMotion;
    property MouseWheel: TEvent read fmouseWheel write fmouseWheel;
    {$WARNINGS ON}
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); virtual;
    function getAttributes(ShowAttributes: integer): string; virtual;
    procedure setEvent(Attr: string);
    function getContainer: string;
    function getEvents(ShowEvents: integer): string; virtual; abstract;
    procedure DeleteEvents; virtual;
    procedure DeleteWidget; virtual;
    procedure DeleteEventHandler(const Event: string);
    procedure NewWidget(Widget: String = ''); virtual;
    function MakeBinding(Eventname: string): string;
    function MakeHandler(const event: string ): string;
    procedure MakeFont;
    function HandlerName(const event: string): string;
    procedure Rename(const OldName, NewName, Events: string); virtual;
    procedure Resize; override;
    procedure SetPositionAndSize; virtual;
    function ClientRectWithoutScrollbars: TRect;
    function Partner: TEditorForm;
    procedure SizeLabelToText; virtual;
    function getType: String;
    function getNameAndType: String;
    function isFontAttribute(const s: string): boolean;
    procedure UpdateObjectInspector;
  end;

implementation

uses SysUtils, TypInfo, Math, UITypes, UGuiForm, UTKMiscBase, UTTKMiscBase,
     Vcl.Imaging.GIFImg, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
     UGUIDesigner, UObjectInspector, UKoppel, UConfiguration, UUtils;

constructor TBaseWidget.create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Width:= 100;
  Height:= 100;
  FAnchor:= _TA_center;
  FBackground:= clBtnFace;     // SystemButtonFace
  FForeground:= clWindowText;  // SystemWindowText
  FBorderWidth:= '2';
  FJustify:= _TJ_CENTER;
  FNameExtension:= '';
  FRelief:= _TR_flat;
  FTakeFocus:= true;
  FUnderline:= -1;
  FWrapLength:= '0';
  Canvas.Font.PixelsPerInch:= 72;
  Font.PixelsPerInch:= 72;
  Font.Name:= 'Segoe UI';   // TkDefaultFont and TkTextFont
  Font.Size:= 9;
  Font.Style:= [];
  HelpType:= htContext;
  Sizeable:= true;

  FButtonPress:= TEvent.Create(Self);
  FButtonRelease:= TEvent.Create(Self);

  FKeyPress:= TEvent.Create(Self);
  FKeyRelease:= TEvent.Create(Self);

  FActivate:= TEvent.Create(Self);
  FConfigure:= TEvent.Create(Self);
  FDeactivate:= TEvent.Create(Self);
  FEnter:= TEvent.Create(Self);
  FFocusIn:= TEvent.Create(Self);
  FFocusOut:= TEvent.Create(Self);
  FLeave:= TEvent.Create(Self);
  FMouseWheel:= TEvent.Create(Self);
  FMotion:= TEvent.Create(Self);
end;

function TBaseWidget.Partner: TEditorForm;
begin
  Result:= (Owner as TFGuiForm).Partner as TEditorForm
end;

destructor TBaseWidget.Destroy;
begin
  FActivate.Destroy;
  FButtonPress.Destroy;
  FButtonRelease.Destroy;
  FConfigure.Destroy;
  FDeactivate.Destroy;
  FEnter.Destroy;
  FFocusIn.Destroy;
  FFocusOut.Destroy;
  FKeyPress.Destroy;
  FKeyRelease.Destroy;
  FLeave.Destroy;
  FMotion.Destroy;
  FMouseWheel.Destroy;
  inherited;
end;

function TBaseWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Name|Font';
  if ShowAttributes >= 2 then
    Result:= Result + '|BorderWidth|Relief';
  if ShowAttributes = 3 then
    Result:= Result + '|Cursor|Left|Top|Height|Width|TakeFocus';
end;

function TBaseWidget.getMouseEvents(ShowEvents: integer): string;
begin
  Result:= MouseEvents1;
  if ShowEvents >= 2 then
    Result:= MouseEvents1 + MouseEvents2;
  if ShowEvents = 3 then
    Result:= AllEvents;
  Result:= Result + '|';
end;

function TBaseWidget.getKeyboardEvents(ShowEvents: integer): string;
begin
  Result:= KeyboardEvents1;
{  if ShowEvents >= 2 then
    Result:= Result + KeyboardEvents2;}
  if ShowEvents = 3 then
    Result:= AllEvents;
  Result:= Result + '|';
end;

procedure TBaseWidget.PaintScrollbar(R: TRect; horizontal: boolean; ttk: boolean = false);
  var i, mid: integer;
begin
  Canvas.Brush.Color:= clBtnFace;
  Canvas.FillRect(R);
  Canvas.Brush.Color:= $CDCDCD;
  Canvas.Pen.Color:= clWhite;
  if horizontal then begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Right, R.Top);
    Canvas.Pen.Color:= $606060;
    mid:= (R.Top + R.Bottom) div 2;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(R.Left +  9 + i, mid - 3);
      Canvas.LineTo(R.Left +  6 + i, mid);
      Canvas.LineTo(R.Left + 10 + i, mid + 4);
    end;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(R.Right -  9 + i, mid - 3);
      Canvas.LineTo(R.Right -  6 + i, mid);
      Canvas.LineTo(R.Right - 10 + i, mid + 4);
    end;
    if ttk then begin
      R.Left:= R.Left + 18;
      R.Right:= R.Right - 18;
    end else begin
      R.Left:= R.Left + 18;
      R.Right:= R.Left + 18;
    end;
  end else begin
    Canvas.MoveTo(R.Left, R.Top);
    Canvas.LineTo(R.Left, R.Bottom);
    Canvas.Pen.Color:= $606060;
    mid:= (R.Left + r.Right) div 2;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(mid - 3, R.Top +  9 + i);
      Canvas.LineTo(mid    , R.Top +  6 + i);
      Canvas.LineTo(mid + 4, R.Top + 10 + i);
    end;
    for i:= 0 to 2 do begin
      Canvas.MoveTo(mid - 3, R.Bottom -  9 + i);
      Canvas.LineTo(mid    , R.Bottom -  6 + i);
      Canvas.LineTo(mid + 4, R.Bottom - 10 + i);
    end;
    if ttk then begin
      R.Top:= R.Top + 18;
      R.Bottom:= R.Bottom - 18;
    end else begin
      R.Top:= R.Top + 18;
      R.Bottom:= R.Top + 18;
    end;
  end;
  R.Inflate(-1, -1);
  Canvas.FillRect(R);
end;

procedure TBaseWidget.Paint;
  var tx, ty, tw, th, x, y, w, h, gw, gh, gx, gy, maxw, maxh, mgw, mtw,
      gtg, bx, by, pl, pt, pr, pb, center: integer;
      pathname, ext: string;
      png: TPngImage;
      gif: TGifImage;
      jpg: TJPEGImage;
      bmp: Graphics.TBitmap;
      SL: TStringList;
      Compound: TUCompound;

  procedure ShowText(R: TRect);
    var Format: integer; wraplen: double; s: String;
  begin
    case Justify of
      _TJ_left:   Format:= DT_LEFT;
      _TJ_center: Format:= DT_CENTER;
    else          Format:= DT_RIGHT;
    end;
    s:= SL.Text;
    if trim(s) = '' then
      exit;
    if FUnderline >= 0 then
      insert('&', s, FUnderline + 1);
    if TryStrToFloat(FWrapLength, wraplen) and (wraplen > 0) and (wraplen < tw) then begin
      Format:= Format + DT_WORDBREAK + DT_NOFULLWIDTHCHARBREAK;
      R.Left:= R.Left + tw div 2 - Round(wraplen/2);
      R.Right:= R.Left + round(wraplen);
      R.Bottom:= R.Top + round((th*tw)/wraplen);
    end;
    DrawText(Canvas.Handle, PChar(s), Length(s), R, Format);
  end;

begin
  Canvas.Font.Assign(Font);
  Canvas.Font.Size:= Font.Size + (Font.Size + 1) div 3;
  Canvas.Font.Color:= FForeground;
  Canvas.Brush.Color:= FBackground;
  if (Parent is TKPanedWindow) or (Parent is TTKPanedwindow) then
    Parent.invalidate;
  Canvas.FillRect(ClientRect);
  PaintBorder(ClientRectWithoutScrollbars, Relief, BorderWidthInt);
  h:= Height;
  w:= Width;
  CalculatePadding(pl, pt, pr, pb);
  SL:= TStringList.Create;
  try
    CalculateText(tw, th, SL);

    Compound:= getCompound;
    if Compound = _TU_image then begin
      tw:= 0;
      th:= 0;
    end;
    if LeftSpace <> 21 then
      LeftSpace:= 0;
    if RightSpace <> 21 then
      RightSpace:= 0;

    pathname:= FGuiDesigner.getPath + 'images\' + copy(Image, 8, length(Image));
    if (Image = '') or not FileExists(pathname) or (Compound = _TU_text) then begin
      // without graphic
      center:= (w - tw - LeftSpace - RightSpace) div 2 + LeftSpace;
      case FAnchor of
        _TA_NW:     begin x:= pl + LeftSpace;               y:= 1 + pt; end;
        _TA_N :     begin x:= center;                       y:= 1 + pt; end;
        _TA_NE:     begin x:= w - 3 - tw - pr - RightSpace; y:= 1 + pt; end;
        _TA_W:      begin x:= pl + LeftSpace;               y:= (h - pb - th) div 2; end;
        _TA_CENTER: begin x:= center;                       y:= (h - pb - th) div 2; end;
        _TA_E:      begin x:= w - 3 - tw - pr - RightSpace; y:= (h - pb - th) div 2; end;
        _TA_SW:     begin x:= pl + LeftSpace;               y:= h - 1 - th - pb; end;
        _TA_S:      begin x:= center;                       y:= h - 1 - th - pb; end;
        _TA_SE:     begin x:= w - 3 - tw - pr - RightSpace; y:= h - 1 - th - pb; end;
        else        begin x:= 0;                            y:= 0; end;
      end;

      ShowText(Rect(x, y, x + tw, y + th));
      LeftSpace:= x - 21;  // for use in Checkbutton and Radiobutton
      TopSpace:= y;
    end else begin
      // with graphic
      ext:= Uppercase(ExtractFileExt(Image));
      bmp:= Graphics.TBitmap.Create;
      if ext = '.PNG' then begin
        png:= TPngImage.Create;
        png.LoadFromFile(pathname);
        bmp.Assign(png);
        FreeAndNil(png);
      end else if ext = '.GIF' then begin
        gif:= TGifImage.Create;
        gif.LoadFromFile(Pathname);
        bmp.Assign(gif.Bitmap);
        FreeAndNil(gif);
      end else if (ext = '.JPG') or (ext = 'JPEG') then begin
        jpg:= TJPEGImage.Create;
        jpg.LoadFromFile(Pathname);
        bmp.Assign(jpg);
        FreeAndNil(jpg);
      end;

      gw:= bmp.Width;
      gh:= bmp.Height;
      gtg:= 4; // GraphicTextGap
      maxw:= 0;
      maxh:= 0;

      case Compound of
        _TU_top, _TU_bottom: begin
          maxw:= max(tw, gw);
          maxh:= gh + gtg + th;
        end;
        _TU_center: begin
          maxw:= max(tw, gw);
          maxh:= max(gh, th);
        end;
        _TU_none, _TU_image: begin
          maxw:= gw;
          maxh:= gh;
        end;
        _TU_left, _TU_right: begin
          maxw:= gw + gtg + tw;
          maxh:= max(th, gh);
        end;
      end;
      if maxw > w then begin
        width:= maxw;
        w:= maxw;
      end;

      // bx, by = position of compound box of graphic and text
      // maxw, maxh = size of compound box
      bx:= 0;
      by:= 0;
      case fAnchor of
        _TA_NW: begin
          bx:= pl + LeftSpace;
          by:= pt;
        end;
        _TA_N: begin
          bx:= (w - maxw - RightSpace) div 2 + LeftSpace;
          by:= pt;
        end;
        _TA_NE: begin
          bx:= w - maxw - pr - RightSpace;
          by:= pt;
        end;
        _TA_W: begin
          bx:= pl + LeftSpace;
          by:= (h - maxh) div 2;
        end;
        _TA_CENTER: begin
          bx:= (w - maxw - RightSpace) div 2 + LeftSpace;
          by:= (h - maxh) div 2;
        end;
        _TA_E: begin
          bx:= w - maxw - pr - RightSpace;
          by:= (h - maxh) div 2;
        end;
        _TA_SW: begin
          bx:= pr + LeftSpace;
          by:= h - maxh - pb;
        end;
        _TA_S: begin
          bx:= (w - maxw - RightSpace) div 2 + LeftSpace;
          by:= h - maxh - pb;
        end;
        _TA_SE: begin
          bx:= w - maxw - pr - RightSpace;
          by:= h - maxh - pb;
        end;
      end;

      mgw:= (maxw - gw) div 2;
      mtw:= (maxw - tw) div 2;
      tx:= 0;
      ty:= 0;
      gx:= 0;
      gy:= 0;

      case Compound of
        _TU_top: begin
          gx:= mgw;
          gy:= 0;
          tx:= mtw;
          ty:= gh + gtg;
        end;
        _TU_bottom: begin
          gx:= mgw;
          gy:= maxh - gh;
          tx:= mtw;
          ty:= 0;
        end;
        _TU_left: begin
          gx:= 0;
          gy:= 0;
          tx:= gw + gtg;
          ty:= (maxh - th) div 2;
        end;
        _TU_right: begin
          gx:= maxw - gw;
          gy:= 0;
          tx:= 0;
          ty:= (maxh - th) div 2;
        end;
        _TU_center: begin
          gx:= mgw;
          gy:= 0;
          tx:= mtw;
          ty:= (maxh - th) div 2;
        end;
        _TU_none: begin
          gx:= 0;
          gy:= 0;
        end;
      end;

      gx:= bx + gx;
      gy:= by + gy;
      tx:= bx + tx;
      ty:= by + ty;

      Canvas.Draw(gx, gy, bmp);
      if (Compound <> _TU_none) and (Compound <> _TU_image) and (SL.Text <> #13#10) then
        ShowText(Rect(tx, ty, tx+tw, ty+th));
      // for debugging
      // R:= rect(min(gx,tx), min(gy,ty), max(gx+gw,tx+tw), max(gy+gh, ty+th));
      // Canvas.DrawFocusRect(r);

      // for use in Checkbutton and Radiobutton
      LeftSpace:= bx - 21;
      TopSpace:= by + maxh div 2 - 10;
      FreeAndNil(bmp);
    end;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TBaseWidget.SetPositionAndSize;
  var key: String; R: TRect;
begin
  R:= ClientRectWithoutScrollbars;
  if not (Parent is TKPanedWindow) then
    setAttributValue('self.' + Name + '.place',
      'self.' + Name +
      '.place(x=' + IntToStr(Left) + ', y=' + IntToStr(Top) +
      ', width=' + IntToStr(R.Right) + ', height=' + IntToStr(R.Bottom) +')');
  if Scrollbars in [_TB_both, _TB_vertical] then begin
    key:= 'self.' + Name + 'ScrollbarV.place';
    setAttributValue(key,
      key + '(x=' + IntToStr(x + R.Right - 2) + ', y=' + IntToStr(y) +
            ', width=20, height='+ IntToStr(R.Bottom) + ')');
  end;
  if (Scrollbars in [_TB_both, _TB_horizontal]) or Scrollbar then begin
    key:= 'self.' + Name + 'ScrollbarH.place';
    setAttributValue(key,
      key + '(x=' + IntToStr(x) + ', y=' + IntToStr(y + R.Bottom - 2) +
            ', width=' + IntToStr(R.Right) + ', height=20)');
  end;
end;

function TBaseWidget.ClientRectWithoutScrollbars: TRect;
begin
  Result:= ClientRect;
  if Scrollbars in [_TB_vertical, _TB_both]
    then Result.Right:= Result.Right - 20;
  if (Scrollbars in [_TB_horizontal, _TB_both]) or Scrollbar
    then Result.Bottom:= Result.Bottom - 20;
end;

procedure TBaseWidget.Resize;
begin
  inherited;
  if Parent is TKPanedWindow then
    (Parent as TKPanedWindow).Resize
  else if Self is TKPanedWindow then
    (Self as TKPanedWindow).Resize
  else if Parent is TTKPanedwindow then
    (Parent as TTKPanedwindow).Resize
  else if Self is TTKPanedwindow then
    (Self as TTKPanedwindow).Resize;
end;

procedure TBaseWidget.setAttributValue(key, s: string);
begin
  if Pos(Indent2, s) = 0 then
    s:= Indent2 + s;
  Partner.setAttributValue(Name, key, s, 1);
end;

function TBaseWidget.getAttrAsKey(Attr: string): string;
begin
  Result:= 'self.' + Name + FNameExtension + '[''' + Lowercase(Attr) + ''']';
end;

procedure TBaseWidget.setAttribute(Attr, Value, Typ: string);
  var s1: string;
begin
  s1:= getAttrAsKey(Attr);
  if isFontAttribute(Attr)then
    MakeFont
  else if Attr = 'TakeFocus' then
    MakeBoolean(Attr, Value)
  else if Attr = 'Menu' then
    setMenu(Value)
  else if Attr = 'Show' then
    MakeShow(Value)
  else if Right(Attr, -7) = 'Command' then
    ChangeCommand(Attr, Value)
  else if Typ = 'Source' then
    if Value = ''
      then Partner.DeleteAttribute(s1)
      else setAttributValue(s1, s1 + ' = ' + Value)
  else if Typ = 'TCursor' then
    if Value = 'default'
      then Partner.DeleteAttribute(s1)
      else setAttributValue(s1, s1 + ' = ' + asString(Value))
  else if Typ = 'Boolean' then
    MakeBoolean(Attr, Value)
  else if (Typ = 'string') or (Typ[1] = 'T') then  // enum type, TColor
    if Value = ''
      then Partner.DeleteAttribute(s1)  // borderwidth, padx, ...
      else setAttributValue(s1, s1 + ' = ' + asString(Value))
  else begin
    if Value = ''                                  // Typ real
      then Partner.DeleteAttribute(s1)
      else setAttributValue(s1, s1 + ' = ' + Value);
  end;
end;

procedure TBaseWidget.setEvent(Attr: string);
begin
  if not Partner.hasText('def ' + HandlerName(Attr) + '(self, event):') then
    Partner.InsertProcedure(CrLf + MakeHandler(Attr));
  Partner.InsertBinding(Name, Attr, MakeBinding(Attr));
end;

function TBaseWidget.isFontAttribute(const s: string): boolean;
begin
  Result:= Pos(s, ' Font Name Size Bold Italic') > 0;
end;

procedure TBaseWidget.MakeFont;
  var s1, s2: string;
begin
  s1:= 'self.' + Name + '[''font'']';
  s2:= ' = (' + asString(Font.Name) + ', ' + IntToStr(Font.Size);
  if fsBold   in Font.Style then s2:= s2 + ', ' + asString('bold');
  if fsItalic in Font.Style then s2:= s2 + ', ' + asString('italic');
  if fsStrikeout in Font.Style then s2:= s2 + ', ' + asString('overstrike');
  if fsUnderline in Font.Style then s2:= s2 + ', ' + asString('underline');
  s2:= s2 + ')';
  setAttributValue(s1, s1 + s2);
  Invalidate;
end;

procedure TBaseWidget.MakeBoolean(Attr, Value: String);
  var s1, s2: string;
begin
  s1:= getAttrAsKey(Attr);
  if Value = 'True'
    then s2:= s1 + ' = 1'
    else s2:= s1 + ' = 0';
  setAttributValue(s1, s2)
end;

procedure TBaseWidget.MakeShow(Value: String);
  var s: string;
begin
  s:= 'self.' + Name  + '[''show'']';
  if Value = 'True'
    then Partner.DeleteAttribute(s)
    else setAttributValue(s, s + ' = ''*''');
end;

procedure TBaseWidget.setValue(Variable, Value: String);
  var s: String;
begin
  if Variable <> '' then begin
    s:= 'self.' + Variable + '.set';
    setAttributValue(s, s + '(' + Value + ')');
  end;
end;

procedure TBaseWidget.AddParameter(const Value, par: string);
  var old, new: String;
begin
  old:= 'def ' + Value + '(self):';
  new:= 'def ' + Value + '(self, ' + par + '):';
  Partner.ReplaceWord(old, new, false);
end;

procedure TBaseWidget.MakeControlVar(Variable, ControlVar: String; Value: String = ''; Typ: String = 'String');
begin
  InsertVariable('self.' + ControlVar + ' = tk.' + Typ + 'Var()');
  if Typ = 'String'
    then InsertVariable('self.' + ControlVar + '.set(' + asString(Value) + ')')
    else InsertVariable('self.' + ControlVar + '.set(' + Value + ')');
  InsertVariable('self.' + Name + '[' + asString(Variable) + '] = self.' + ControlVar);
end;

procedure TBaseWidget.setMenu(Value: string);
  var s1, s2: string;
begin
  if Value = '' then begin
    Partner.DeleteAttribute('self.' + Name + '[''menu'']');
    s1:= 'self.' + LOldValue + ' = tk.Menu';
    s2:= s1 + '(tearoff=0)';
  end else begin
    s1:= 'self.' + Name + '[''menu'']';
    setAttributValue(s1, s1 + ' = self.' + Value);
    s1:= 'self.' + Value + ' = tk.Menu';
    s2:= s1 + '(self.' + Name + ', tearoff=0)';
  end;
  setAttributValue(s1, s2);
end;

procedure TBaseWidget.ChangeCommand(Attr, Value: string);
  var nam, key: string;
begin
  nam:= Name + '_' + Attr;
  key:= 'self.' + Name + FNameExtension + '[' + asString(lowercase(Attr)) + ']';
  if Value = 'False' then begin
    Partner.DeleteAttribute(key);
    Partner.DeleteMethod(nam);
  end else begin
    setAttributValue(key, key + ' = self.' + nam);
    MakeCommand(Attr, nam);
  end;
end;

procedure TBaseWidget.MakeCommand(Attr, Value: String);
begin
  var func:= CrLF +
         Indent1 + 'def ' + Value +'(self):' + CrLf +
         Indent2 + '# ToDo insert source code here' + CrLf +
         Indent2 + 'pass' + CrLf;
  Partner.InsertProcedure(func);
end;

function TBaseWidget.HandlerName(const event: string): string;
begin
  Result:= Name + '_' + Event;
end;

function TBaseWidget.MakeBinding(Eventname: string): string;
  var Event: TEvent;
begin
  if Eventname = 'ButtonPress' then
    Event:= FButtonPress
  else if Eventname = 'ButtonRelease' then
    Event:= FButtonRelease
  else if Eventname = 'KeyPress' then
    Event:= FKeyPress
  else if Eventname = 'KeyRelease' then
    Event:= FKeyRelease
  else if Eventname = 'Activate' then
    Event:= FActivate
  else if Eventname = 'Configure' then
    Event:= FConfigure
  else if Eventname = 'Deactivate' then
    Event:= FDeactivate
  else if Eventname = 'Enter' then
    Event:= FEnter
  else if Eventname = 'FocusIn' then
    Event:= FFocusIn
  else if Eventname = 'FocusOut' then
    Event:= FFocusOut
  else if Eventname = 'Leave' then
    Event:= FLeave
  else if Eventname = 'Motion' then
    Event:= FMotion
  else
    Event:= FMouseWheel;
  Result:= Indent2 + 'self.' + Name + '.bind(''<' + Event.getModifiers(Eventname) +
           Eventname + Event.getDetail(Eventname) + '>'', self.' + HandlerName(Eventname) + ')';
end;

function TBaseWidget.MakeHandler(const event: string ): string;
begin
  //  Example:
  //  def name(self, event):
  //    // TODO insert source code here
  //    pass
  Result:= Indent1 + 'def ' + HandlerName(Event) + '(self, event):' + CrLf +
           Indent2 + '# ToDo insert source code here' + CrLf +
           Indent2 + 'pass' + CrLf;
end;

procedure TBaseWidget.MakeImage(const Value: string);
  var s, key1, key2, Dest, filename, Path: string;
begin
  // ToDo use PIL if png-file selected
  if Value = '(Image)' then begin
    key1:= 'self.' + Name + 'Image';
    Partner.DeleteAttribute(key1);
    key2:= 'self.' + Name + '[''image'']';
    Partner.DeleteAttribute(key2);
  end else begin
    filename:= ExtractFileName(Value);
    if Pos('images/', filename) = 1 then
      System.delete(filename, 1, 7);
    Path:= ExtractFilePath(Partner.Pathname);
    Dest:= Path + 'images\' + filename;
    ForceDirectories(Path + 'images\');
    if not FileExists(Dest) then
      copyFile(PChar(Value), PChar(Dest), true);
    filename:= 'images/' + filename;
    FObjectInspector.ELPropertyInspector.SetByCaption('Image', filename);
    key1:= 'self.' + Name + 'Image';
    s:= key1 + ' = tk.PhotoImage(file=' + asString(filename) + ')';
    setAttributValue(key1, s);
    key2:= 'self.' + Name + '[''image'']';
    s:= key2 + ' = ' + key1;
    setAttributValue(key2, s);
  end;
end;

procedure TBaseWidget.MakeValidateCommand(Attr, Value: string);
  var key: string;
begin
  if Value = '' then begin
    Partner.DeleteAttribute(Name + 'VC');
    Partner.DeleteAttribute('self.' + Name + '[''validatecommand'']');
    Partner.DeleteMethod(UKoppel.LOldValue);
  end else begin
    key:= 'self.' + Name + 'VC';
    setAttributValue(key, key + ' = self.register(self.' + Name + '_ValidateCommand)');
    ChangeCommand(Attr, Value);
    key:= 'self.' + Name + '[''validatecommand'']';
    setAttributValue(key, key + ' = (self.' + Name + 'VC, ''%d'', ''%i'', ''%S'')');
  end;
end;

procedure TBaseWidget.setScrollbars(Value: TScrollbar);
begin
  if FScrollbars <> Value then begin
    FScrollbars:= Value;
    invalidate;
  end;
end;

procedure TBaseWidget.setScrollbar(Value: boolean);
begin
  if FScrollbar <> Value then begin
    FScrollbar:= Value;
    invalidate;
  end;
end;

procedure TBaseWidget.MakeScrollbar(Value, TkTyp: String);
begin
  if Value = 'True'
    then MakeScrollbars('horizontal', TkTyp)
    else MakeScrollbars('none', TkTyp);
end;

procedure TBaseWidget.MakeScrollbars(Value, TkTyp: String);
  var ScrollbarName, OldValue: String;
     WidthNoScrollbar, HeightNoScrollbar, WidthScrollbar, HeightScrollbar: integer;

  procedure DeleteVertical;
  begin
    Partner.DeleteAttributeValues(ScrollbarName + 'V');
    Partner.DeleteAttribute('self.' + Name +  '[' + asString('yscrollcommand') + ']');
    Dec(WidthNoScrollbar, 20);
  end;

  procedure DeleteHorizontal;
  begin
    Partner.DeleteAttributeValues(ScrollbarName + 'H');
    Partner.DeleteAttribute('self.' + Name +  '[' + asString('sxcrollcommand') + ']');
    Dec(HeightNoScrollbar, 20);
  end;

  procedure InsertVertical;
  begin
    InsertVariable(ScrollbarName + 'V = ' + TkTyp + 'Scrollbar(' + getContainer + ')');
    InsertVariable(ScrollbarName + 'V.place(x=' + IntToStr(x + WidthNoScrollbar - 2) + ', y=' + IntToStr(y) +
                                   ', width=20, height=' + IntToStr(HeightNoScrollbar) + ')');
    InsertVariable(ScrollbarName + 'V[' + asString('command') + '] = self.' + Name + '.yview');
    InsertVariable('self.' + Name + '[' + asString('yscrollcommand') + '] = ' + ScrollbarName + 'V.set');
    Inc(WidthScrollbar, 20);
  end;

  procedure InsertHorizontal;
    var s: string;
  begin
    s:= getContainer;
    if s <> '' then s:= s + ', ';
    s:= s + 'orient=' + asString('horizontal');
    InsertVariable(ScrollbarName + 'H = ' + TkTyp+ 'Scrollbar(' + s + ')');
    InsertVariable(ScrollbarName + 'H.place(x=' + IntToStr(x) + ', y=' + IntToStr(y + HeightNoScrollbar - 2) +
                                   ', width=' + IntToStr(WidthNoScrollbar) + ', height=20)');
    InsertVariable(ScrollbarName + 'H[' + asString('command') + '] = self.' + Name + '.xview');
    InsertVariable('self.' + Name + '[' + asString('xscrollcommand') + '] = ' + ScrollbarName + 'H.set');
    Inc(HeightScrollbar, 20);
  end;

begin
  OldValue:= UKoppel.LOldValue;
  ScrollbarName:= 'self.' + Name + 'Scrollbar';
  Partner.ActiveSynEdit.BeginUpdate;
  WidthNoScrollbar:= Width;
  HeightNoScrollbar:= Height;
  if (OldValue = 'vertical') or (OldValue = 'both') then
    DeleteVertical;
  if (OldValue = 'horizontal') or (OldValue = 'both') or (OldValue = 'True') then
    DeleteHorizontal;
  WidthScrollbar:= WidthNoScrollbar;
  HeightScrollbar:= HeightNoScrollbar;
  if (Value = 'vertical') or (Value = 'both') then
    InsertVertical;
  if (Value = 'horizontal') or (Value = 'both') then
    InsertHorizontal;
  SetBounds(x, y, WidthScrollbar, HeightScrollbar);
  Partner.ActiveSynEdit.EndUpdate;
  FObjectInspector.Invalidate;
end;

procedure TBaseWidget.PaintAScrollbar(Value: boolean);
begin
  if Value then
    PaintScrollbars(_TB_horizontal)
end;

procedure TBaseWidget.PaintScrollbars(Scrollbar: TScrollbar);
  var R: TRect;
begin
  if Scrollbar = _TB_vertical then begin
    R:= ClientRect;
    R.Left:= R.Right - 20;
    PaintScrollbar(R, false);
  end;

  if Scrollbar = _TB_horizontal then begin
    R:= ClientRect;
    R.Top:= R.Bottom - 20;
    PaintScrollbar(R, true);
  end;

  if Scrollbar = _TB_both then begin
    R:= ClientRect;
    R.Left:= R.Right - 20;
    R.Bottom:= R.Bottom - 20;
    PaintScrollbar(R, false);
    R:= ClientRect;
    R.Top:= R.Bottom - 20;
    R.Right:= R.Right - 20;
    PaintScrollbar(R, true);
  end;
end;

procedure TBaseWidget.ShowText(s: String; newWidth, newHeight: integer);
  var th, tw, x, y: integer;
begin
  th:= Canvas.TextHeight(s);
  tw:= Canvas.TextWidth(s);
  y:= (newHeight - th) div 2;
  case Justify of
    _TJ_LEFT:   x:= BorderWidthInt + 2;
    _TJ_CENTER: x:= (newWidth - tw) div 2;
    else        x:= newWidth - BorderWidthInt - tw - 2;
  end;
  Canvas.TextOut(x, y, s);
end;

procedure TBaseWidget.setAnchor(aValue: TAnchor);
begin
  if aValue <> fAnchor then begin
    fAnchor:= aValue;
    Invalidate;
  end;
end;

procedure TBaseWidget.SetBackground(aColor: TColor);
begin
  if aColor <> FBackground then begin
    FBackground:= aColor;
    Invalidate;
  end;
end;

procedure TBaseWidget.SetForeground(aColor: TColor);
begin
  if aColor <> FForeground then begin
    FForeground:= aColor;
    Invalidate;
  end;
end;

procedure TBaseWidget.setBorderWidth(aValue: String);
begin
  if aValue <> fBorderWidth then begin
    fBorderWidth:= aValue;
    Invalidate;
  end;
end;

procedure TBaseWidget.setImage(aValue: string);
begin
  if aValue <> fImage then begin
    fImage:= aValue;
    Invalidate;
  end;
end;

procedure TBaseWidget.setJustify(aValue: TJustify);
begin
  if aValue <> fJustify then begin
    fJustify:= aValue;
    Invalidate;
  end;
end;

procedure TBaseWidget.setUnderline(aValue: integer);
begin
  if aValue <> FUnderline then begin
    FUnderline:= aValue;
    Invalidate;
  end;
end;

procedure TBaseWidget.setWrapLength(aValue: String);
begin
  if aValue <> FWrapLength then begin
    FWrapLength:= aValue;
    Invalidate;
  end;
end;

procedure TBaseWidget.Rename(const OldName, NewName, Events: string);
begin
  Partner.ReplaceComponentname(OldName, NewName, Events);
end;

procedure TBaseWidget.DeleteWidget;
begin
  if FCommand then Partner.DeleteMethod(Name + '_Command');
  Partner.DeleteMethod(Name + 'ScrollbarH.set');
  Partner.DeleteMethod(Name + 'ScrollbarV.set');
  DeleteEvents;
  Partner.DeleteComponent(Self);
  if (Parent is TKPanedWindow) or (Parent is TTKPanedWindow) then
    Partner.DeleteAttribute('self.' + Parent.Name + '.add(self.' + Name);
end;

procedure TBaseWidget.DeleteEventHandler(const Event: string);
begin
  Partner.DeleteMethod(HandlerName(Event));
  Partner.DeleteBinding(Name, Event);
end;

procedure TBaseWidget.DeleteEvents;
  var p: integer; s, Event: string; SL1, SL2: TStringList;
begin
  Partner.ActiveSynEdit.BeginUpdate;
  SL1:= TStringList.Create;
  SL2:= TStringList.Create;
  s:= getEvents(3) + '|';
  p:= Pos('|', s);
  while p > 0 do begin
    Event:= UUtils.Left(s, p-1);
    if Event <> '' then begin
      Partner.DeleteBinding(Name, Event);
      SL1.Add(HandlerName(Event));
    end;
    delete(s, 1, p);
    p:= Pos('|', s);
  end;
  Partner.DeleteOldAddNewMethods(SL1, SL2, 'self, event');
  FreeAndNil(SL1);
  FreeAndNil(SL2);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseWidget.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  InsertVariable('self.' + Name + ' = ' + Widget + '(' + getContainer + ')');
  setPositionAndSize;
  if Parent is TKPanedWindow then begin
    InsertVariable('self.' + Parent.Name + '.add(self.' + Name + ')');
    //ControlStyle:= [];
  end else if Parent is TTKPanedwindow then begin
    InsertVariable('self.' + Parent.Name + '.add(self.' + Name + ', weight=1)');
    //ControlStyle:= [];
  end;
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TBaseWidget.Calculate3DColors(var DarkColor, LightColor: TColor; Background: TColor);
  const MAX_INTENSITY = 255.0;
  var r, g, b: integer; lr, lg, lb, dr, dg, db, tmp1, tmp2: real;  Color: TColor;
begin
  // from: https://github.com/tcltk/tk/blob/main/win/tkWin3d.c
  Color:= Graphics.ColorToRGB(Background);
  Color2RGB(Color, r, g, b);

     if (r*0.5*r + g*1.0*g + b*0.28*b < MAX_INTENSITY*0.05*MAX_INTENSITY) then begin
    dr:= (MAX_INTENSITY + 3*r)/4;
    dg:= (MAX_INTENSITY + 3*g)/4;
    db:= (MAX_INTENSITY + 3*b)/4;
  end else begin
    dr:= (60 * r)/100;
    dg:= (60 * g)/100;
    db:= (60 * b)/100;
  end;
  DarkColor:= RGB2Color(Round(dr), Round(dg), round(db));

     if (g > MAX_INTENSITY*0.95) then begin
    lr:= (90 * r)/100;
    lg:= (90 * g)/100;
    lb:= (90 * b)/100;
  end else begin
       tmp1:= min((14 * r)/10, MAX_INTENSITY);
    tmp2:= (MAX_INTENSITY + r)/2;
    lr:= max(tmp1, tmp2);
    tmp1:= min((14 * g)/10, MAX_INTENSITY);
    tmp2:= (MAX_INTENSITY + g)/2;
    lg:= max(tmp1, tmp2);
    tmp1:= min((14 * b)/10, MAX_INTENSITY);
    tmp2:= (MAX_INTENSITY + b)/2;
    lb:= max(tmp1, tmp2);
  end;
  LightColor:= RGB2Color(Round(lr), Round(lg), Round(lb));
end;

procedure TBaseWidget.InsertVariable(const Variable: string);
begin
  Partner.InsertAttribute(Indent2 + Variable);
end;

function TBaseWidget.getContainer: string;
begin
  if (Parent = nil) or (Parent is TFGUIForm)
    then Result:= ''
    else Result:= 'self.' + Parent.Name;
end;

procedure TBaseWidget.setRelief(aValue: TRelief);
begin
  if fRelief <> aValue then begin
    fRelief:= aValue;
    Invalidate;
  end;
end;

procedure TBaseWidget.setX(aValue: integer);
begin
  if aValue <> Top then begin
    Left:= aValue;
    Invalidate;
  end;
end;

function TBaseWidget.getX: integer;
begin
  Result:= Left;
end;

procedure TBaseWidget.setY(aValue: integer);
begin
  if aValue <> Top then begin
    Top:= aValue;
    Invalidate;
  end;
end;

function TBaseWidget.getY: integer;
begin
  Result:= Top;
end;

function TBaseWidget.Indent1: string;
begin
  Result:= FConfiguration.Indent1
end;

function TBaseWidget.Indent2: string;
begin
  Result:= FConfiguration.Indent2;
end;

function TBaseWidget.Indent3: string;
begin
  Result:= FConfiguration.Indent3;
end;

procedure TBaseWidget.SizeLabelToText;
begin
end;

function TBaseWidget.getType;
begin
  if Pos('TTK', Classname) = 1
    then Result:= copy(Classname, 4, Length(Classname))
    else Result:= copy(Classname, 3, Length(Classname));
end;

function TBaseWidget.getNameAndType;
begin
  Result:= Name + ': ' + getType;
end;

procedure TBaseWidget.UpdateObjectInspector;
begin
  TThread.ForceQueue(nil, procedure
  begin
    FObjectInspector.SetSelectedObject(Self);
  end);
end;

end.
