{-------------------------------------------------------------------------------
 Unit:     UTKTextBase
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  tkinter text widgets
-------------------------------------------------------------------------------}

unit UTKTextBase;

{ class hierarchie

  TKTextBaseWidget
    TKEntry
    TKSpinbox
    TKCanvas
    TKText
    TKListbox
}

interface

uses
  Classes, Controls, Graphics, UBaseTkWidgets, UTkWidgets;

type

  // for disabeling  - different to TButtonState in TKButtonBase
  TTextState2 = (_TS_disabled, _TS_normal);

  TTextState3 = (disabled, normal, readonly);

  TInsert = (hollow, none, solid);

  TTabStyle = (tabular, wordprocessor);

  TWrap = (_TW_char, _TW_none, _TW_word);  // none already in TInsert

  TActiveStyle = (_TS_underline, _TS_dotbox, _TS_none);

  TSelectMode = (browse, single, multiple, extended);

  TValidate = (_TV_none, _TV_all, _TV_key, _TV_focus, _TV_focusin, _TV_focusout);

  TKTextBaseWidget = class(TKWidget)
  private
    FDisabledBackground: TColor;
    FExportSelection: boolean;
    FInsertBackground: TColor;
    FInsertBorderwidth: String;
    FInsertOffTime: integer;
    FInsertOnTime: integer;
    FInsertWidth: String;
    FInvalidCommand: boolean;
    FReadOnlyBackground: TColor;
    FSelectBackground: TColor;
    FSelectForeground: TColor;
    FSelectBorderWidth: integer;
    FSetGrid: boolean;
    FValidate: TValidate;
    FValidateCommand: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DeleteWidget; override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    
    property DisabledBackground: TColor read FDisabledBackground write FDisabledBackground default clBtnFace;
    property ExportSelection: boolean read FExportSelection write FExportSelection default true;
    property InsertBackground: TColor read FInsertBackground write FInsertBackground default clWindowText;
    property InsertBorderwidth: String read FInsertBorderwidth write FInsertBorderwidth;
    property InsertOffTime: integer read FInsertOffTime write FInsertOffTime default 300;
    property InsertOnTime: integer read FInsertOnTime write FInsertOnTime default 600;
    property InsertWidth: String read FInsertWidth write FInsertWidth;
    property InvalidCommand: boolean read FInvalidCommand write FInvalidCommand;
    property ReadOnlyBackground: TColor read FReadOnlyBackground write FReadOnlyBackground default clBtnFace;
    property SetGrid: boolean read FSetGrid write FSetGrid default false;
    property Validate: TValidate read FValidate write FValidate default _TV_none;
    property ValidateCommand: Boolean read FValidateCommand write FValidateCommand;
  published
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property SelectBackground: TColor read FSelectBackground write FSelectBackground default clHighlight;
    property SelectForeground: TColor read FSelectForeground write FSelectForeground default clHighlightText;
    property SelectBorderWidth: integer read FSelectBorderWidth write FSelectBorderWidth default 0;
  end;

  TKEntry = class (TKTextBaseWidget)
  private
    FShow: boolean;
    FState: TTextState3;
    FText: String;
    procedure setState(Value: TTextState3);
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: String = ''); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: integer): string; override;
    procedure setText(Value: String); override;
    procedure MakeCommand(Attr, Value: String); override;
    procedure Paint; override;
  published
    property ExportSelection;
    property Font;
    property Foreground;
    property InsertBackground;
    property InsertBorderwidth;
    property InsertOffTime;
    property InsertOnTime;
    property InsertWidth;
    property InvalidCommand;
    property Justify;
    property ReadOnlyBackground;
    property Scrollbar;
    {$WARN HIDING_MEMBER OFF}
    property Show: boolean read FShow write FShow default true;
    {$WARN HIDING_MEMBER ON}
    property State: TTextState3 read FState write setState default normal;
    property TakeFocus;
    // override Text in TBaseWidget
    property Text: string read FText write setText;
    property Validate;
    property ValidateCommand;
  end;

  TKSpinbox = class (TKTextBaseWidget)
  private
    FButtonBackground: TColor;
    FButtonCursor: TCursor;
    FButtonDownRelief: TRelief;
    FButtonUpRelief: TRelief;
    FFormat: String;
    FFrom: String;
    FIncrement: String;
    FRepeatDelay: integer;
    FRepeatInterval: integer;
    FState: TTextState3;
    FTo: String;
    FValue: String;
    FValues: TStrings;
    FWrap: boolean;
    procedure setItems(aItems: TStrings);
    procedure setState(Value: TTextState3);
    procedure setRValue(aValue: String);
    procedure MakeValues;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure MakeCommand(Attr, Value: String); override;
    procedure Paint; override;
  published
    property ActiveBackground;
    property ButtonBackground: TColor read FButtonBackground write FButtonBackground default clBtnFace;
    property ButtonCursor: TCursor read FButtonCursor write FButtonCursor;
    property ButtonDownRelief: TRelief read FButtonDownRelief write FButtonDownRelief default _TR_raised;
    property ButtonUpRelief: TRelief read FButtonUpRelief write FButtonUpRelief default _TR_raised;
    property Command;
    property DisabledBackground;
    property DisabledForeground;
    property ExportSelection;
    property Font;
    property Foreground;
    property Format: String read FFormat write FFormat;
    property From_: String read FFrom write FFrom;
    property Increment: String read FIncrement write FIncrement;
    property InsertBackground;
    property InsertBorderwidth;
    property InsertOffTime;
    property InsertOnTime;
    property InsertWidth;
    property InvalidCommand;
    property Justify;
    property ReadOnlyBackground;
    property RepeatDelay: integer read FRepeatDelay write FRepeatDelay default 400;
    property RepeatInterval: integer read FRepeatInterval write FRepeatInterval default 100;
    property Scrollbar;
    property State: TTextState3 read FState write setState default normal;
    property TakeFocus;
    property _To: String read FTo write FTo;
    property Validate;
    property ValidateCommand;
    property Values: TStrings read FValues write setItems;
    property Value: String read FValue write setRValue;
    property Wrap: boolean read FWrap write FWrap default false;
  end;

  TKCanvas = class (TKTextBaseWidget)
  private
    FCloseEnough: real;
    FConfine: boolean;
    FScrollregion: String;
    FState: TTextState2;
    FXScrollIncrement: String;
    FYScrollIncrement: String;
    procedure setState(Value: TTextState2);
    procedure MakeScrollRegion(Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property CloseEnough: real read FCloseEnough write FCloseEnough;
    property Confine: boolean read FConfine write FConfine default true;
    property InsertBackground;
    property InsertBorderwidth;
    property InsertOffTime;
    property InsertOnTime;
    property InsertWidth;
    property Scrollbars;
    property ScrollRegion: String read FScrollRegion write FScrollRegion;
    property State: TTextState2 read FState write setState default _TS_normal;
    property XScrollIncrement: String read FXScrollIncrement write FXScrollIncrement;
    property YScrollIncrement: String read FYScrollIncrement write FYScrollIncrement;
  end;

  TKText = class (TKTextBaseWidget)
  private
    FAutoSeparators: boolean;
    FBlockCursor: boolean;
    FEndline: integer;
    FInactiveSelectBackground: TColor;
    FInsertUnfocussed: TInsert;
    FMaxUndo: integer;
    FSpacing1: String;
    FSpacing2: String;
    FSpacing3: String;
    FStartline: integer;
    FState: TTextState2;
    FTabs: String;
    FTabStyle: TTabStyle;
    FText: TStrings;
    FUndo: boolean;
    FWrap: TWrap;
    procedure setState(Value: TTextState2);
    procedure setStrings(Value: TStrings);
    procedure MakeStrings;
    procedure setWrap(aValue: TWrap);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property AutoSeparators: boolean read FAutoSeparators write FAutoSeparators default true;
    property BlockCursor: boolean read FBlockCursor write FBlockCursor default false;
    property Endline: integer read FEndline write FEndline default 0;
    property ExportSelection;
    property Font;
    property Foreground;
    property InactiveSelectBackground: TColor read FInactiveSelectBackground write FInactiveSelectBackground default clBtnFace;
    property InsertUnfocussed: TInsert read FInsertUnfocussed write FInsertUnfocussed default none;
    property InsertBackground;
    property InsertBorderwidth;
    property InsertOffTime;
    property InsertOnTime;
    property InsertWidth;
    property MaxUndo: integer read FMaxUndo write FMaxUndo default 0;
    property PadX;
    property PadY;
    property Scrollbars;
    property SetGrid;
    property Spacing1: String read FSpacing1 write FSpacing1;
    property Spacing2: String read FSpacing2 write FSpacing2;
    property Spacing3: String read FSpacing3 write FSpacing3;
    property Startline: integer read FStartline write FStartline default 0;
    property State: TTextState2 read FState write setState default _TS_normal;
    property Tabs: String read FTabs write FTabs;
    property TabStyle: TTabStyle read FTabStyle write FTabStyle default tabular;
    property TakeFocus;
    property Text: TStrings read FText write setStrings;
    property Undo: boolean read FUndo write FUndo default false;
    property Wrap: TWrap read FWrap write setWrap default _TW_char;
  end;

  TKListbox = class(TKTextBaseWidget)
  private
    FActiveStyle: TActiveStyle;
    FListItems: TStrings;
    FSelectMode: TSelectMode;
    FState: TTextState2;
    procedure setListItems(Values: TStrings);
    function getListItems: String;
    procedure setState(Value: TTextState2);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property ActiveStyle: TActiveStyle read FActiveStyle write FActiveStyle default _TS_underline;
    property DisabledForeground;
    property ExportSelection;
    property Foreground;
    property Font;
    property Justify;
    property ListItems: TStrings read FListItems write setListItems;
    property Scrollbars;
    property SelectMode: TSelectMode read FSelectMode write FSelectMode default browse;
    property SetGrid;
    property State: TTextState2 read FState write setState default _TS_normal;
    property TakeFocus;
  end;

implementation

uses System.Types, Windows, Math, SysUtils, UITypes, UUtils, UConfiguration;

{--- TButtonBaseWidget --------------------------------------------------------}

constructor TKTextBaseWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Anchor:= _TA_W;
  BorderWidth:= '1';
  Background:= clWindow;
  Foreground:= clWindowText;
  FDisabledBackground:= clBtnFace;
  FExportSelection:= true;
  FInsertBackground:= clWindowText;
  FInsertBorderwidth:= '0';
  FInsertOffTime:= 300;
  FInsertOnTime:= 600;
  FInsertWidth:= '2';
  FReadOnlyBackground:= clBtnFace;
  FSelectBackground:= clHighlight;
  FSelectForeground:= clHighlightText;
  FSelectBorderWidth:= 0;
  FSetGrid:= false;
  FValidate:= _TV_none;
  TakeFocus:= true;
end;

procedure TKTextBaseWidget.DeleteWidget;
begin
  inherited;
  if FInvalidCommand then Partner.DeleteMethod(Name + '_InvalidCommand');
  if FValidateCommand then Partner.DeleteMethod(Name +  '_ValidateCommand');
end;

function TKTextBaseWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '';
  if ShowAttributes >= 2 then
    Result:= Result + '|Validate|ValidateCommand';
  if ShowAttributes = 3 then
    Result:= Result + '|ExportSelection|Foreground' +
     '|HighlightBackground|HighlightColor|HighlightThickness|InsertBackground' +
     '|InsertBorderwidth|InsertOffTime|InsertOnTime|InsertWidth'+
     '|SelectBackground|SelectBorderWidth|SelectForeground' +
     '|State|Underline|WrapLength';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKTextBaseWidget.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Scrollbars' then
    MakeScrollbars(Value, 'tk.')
  else if Attr = 'Scrollbar' then
    MakeScrollbar(Value, 'tk.')
  else
    inherited;
end;

function TKTextBaseWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= getMouseEvents(ShowEvents);
end;

{--- TKEntry ------------------------------------------------------------------}

constructor TKEntry.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 2;
  Width:= 80;
  Height:= 24;
  HighlightThickness:= '0';
  Cursor:= crIBeam;
  FShow:= true;
  Justify:= _TJ_left;
  Relief:= _TR_sunken;
end;

procedure TKEntry.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Entry');
  MakeControlVar('textvariable', Name + 'CV', FText);
  Partner.ActiveSynEdit.EndUpdate;
end;

function TKEntry.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Text';
  if ShowAttributes >= 2 then
    Result:= Result + '|InvalidCommand|Scrollbar';
  if ShowAttributes >= 3 then
    Result:= Result + '|DisabledBackground|DisabledForeground|Justify|ReadOnlyBackground|Show';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKEntry.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Text' then  // different from Button.Text
    setValue(Name + 'CV', asString(Value))
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

function TKEntry.getEvents(ShowEvents: integer): string;
begin
  Result:= getKeyboardEvents(ShowEvents);
end;

procedure TKEntry.setText(Value: String);
begin
  if Value <> FText then begin
    FText:= Value;
    Invalidate;
  end;
end;

procedure TKEntry.MakeCommand(Attr, Value: String);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TKEntry.Paint;
  var newHeight: integer;
begin
  inherited; // shows no text, because FText of TKWidget is overridden
  if Scrollbar
    then newHeight:= Height - 20
    else newHeight:= Height;
  ShowText(FText, Width, newHeight);
  PaintAScrollbar(Scrollbar);
end;

procedure TKEntry.setState(Value: TTextState3);
begin
  if Value <> FState then begin
    FState:= Value;
    Invalidate;
  end;
end;

{--- TKSpinBox ----------------------------------------------------------------}

constructor TKSpinbox.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 9;
  Width:= 40;
  Height:= 24;
  FButtonBackground:= clBtnFace;
  FButtonDownRelief:= _TR_raised;
  FButtonUpRelief:= _TR_raised;
  HighlightThickness:= '0';
  FFrom:= '1';
  FTo:= '10';
  FIncrement:= '1';
  Relief:= _TR_sunken;
  FRepeatDelay:= 400;
  FRepeatInterval:= 100;
  FValues:= TStringList.Create;
  FWrap:= false;
  Justify:= _TJ_left;
  Cursor:= crIBeam;
end;

destructor TKSpinbox.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

procedure TKSpinbox.MakeValues;
  var s1, Value, AllValues: string; i: integer;
begin
  s1:= 'self.' + Name + '[''values'']';
  AllValues:= '[';
  for i := 0 to FValues.Count - 1 do begin
    Value:= trim(FValues[i]);
    if Value = '' then continue;
    AllValues:= AllValues + asString(Value) + ', ';
  end;
  if copy(AllValues, length(AllValues) -1, 2) = ', ' then
    delete(AllValues, length(AllValues)-1, 2);
  AllValues:= AllValues + ']';
  setAttributValue(s1, s1 + ' = ' + AllValues);
end;

procedure TKSpinbox.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Values' then
    MakeValues
  else if Attr = 'Value' then
    setValue(Name + 'CV', asString(Value))
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

function TKSpinbox.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|From_|_To|Increment|Values|Value';
  if ShowAttributes >= 2 then
    Result:= Result + '|Command|Format|InvalidCommand|Scrollbar|Wrap';
  if ShowAttributes = 3 then
    Result:= Result + '|ActiveBackground|ButtonBackground|ButtonCursor|ButtonDownRelief' +
      '|ButtonUpRelief|DisabledBackground|DisabledForeground|Exportselection|Justify' +
      '|ReadOnlyBackground|RepeatDelay|RepeatInterval';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKSpinbox.setItems(aItems: TStrings);
begin
  FValues.Assign(aItems);
  Invalidate;
end;

procedure TKSpinbox.SetRValue(aValue: String);
begin
  if FValue <> aValue then begin
    FValue:= aValue;
    Invalidate;
  end;
end;

procedure TKSpinbox.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Spinbox');
  MakeControlVar('textvariable', Name + 'CV', FValue);
  InsertValue('self.' + Name + '[' + asString('to') + '] = ' + asString('10'));
  InsertValue('self.' + Name + '[' + asString('from') + '] = ' + asString('1'));
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKSpinbox.MakeCommand(Attr, Value: String);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TKSpinbox.Paint;
  var s: string; R: TRect;
      x, y, w, newHeight: integer;
      Points: Array[0..2] of TPoint;
begin
  inherited;
  // paint number/value
  if FValue <> ''
    then s:= FValue
    else if FValues.Count > 0
      then s:= FValues[0]
      else s:= FFrom;
  if Scrollbar
    then newHeight:= Height - 20
    else newHeight:= Height;
  ShowText(s, Width - PPIScale(14), newHeight);

  // paint up/down
  w:= Width - BorderWidthInt - PPIScale(11);
  R:= Rect(w, BorderWidthInt + 1, w + PPIScale(11), newHeight - BorderWidthInt);
  Canvas.Brush.Color:= FButtonBackground;
  Canvas.FillRect(R);
  Canvas.Pen.Color:= clWhite;
  Canvas.MoveTo(w, BorderWidthInt);
  Canvas.LineTo(w, newHeight - BorderWidthInt);
  Canvas.Pen.Color:= clBlack;
  Canvas.MoveTo(w, newHeight div 2);
  Canvas.LineTo(w + PPIScale(12), newHeight div 2);
  w:= w + PPIScale(11);
  Canvas.MoveTo(w, BorderWidthInt);
  Canvas.LineTo(w, newHeight - BorderWidthInt);

  Canvas.Brush.Color:= RGB(122, 138, 153);
  Canvas.Pen.Color:= clBlack;
  x:= Width - BorderWidthInt - PPIScale(10);
  y:= BorderWidthInt + (newHeight - BorderWidthInt) div 4;
  var i2:= PPIScale(2);
  var i4:= PPIScale(4);
  var i6:= PPIScale(6);

  Points[0]:= Point(x + i2, y + i2);
  Points[1]:= Point(x + i6, y + i2);
  Points[2]:= Point(x + i4, y);
  Canvas.Polygon(Points);
  y:= newHeight - BorderWidthInt - (newHeight - BorderWidthInt) div 4;
  Points[0]:= Point(x + i2, y - i2);
  Points[1]:= Point(x + i6, y - i2);
  Points[2]:= Point(x + i4, y);
  Canvas.Polygon(Points);
  PaintAScrollbar(Scrollbar);
end;

procedure TKSpinbox.setState(Value: TTextState3);
begin
  if Value <> FState then begin
    FState:= Value;
    Invalidate;
  end;
end;

{--- TKCanvas -----------------------------------------------------------------}

constructor TKCanvas.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 11;
  Height:= 80;
  Width:= 120;
  Background:= clBtnFace;
  BorderWidth:= '0';
  HighlightThickness:= '2';
  FInsertBackground:= clBtnText;
  FCloseEnough:= 1.0;
  FConfine:= true;
  FSelectBorderWidth:= 1;
  FXScrollIncrement:= '0';
  FYScrollIncrement:= '0';
end;

procedure TKCanvas.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'ScrollRegion' then
    MakeScrollRegion(Value)
  else
    inherited;
end;

procedure TKCanvas.MakeScrollRegion(Value: String);
  var key: String;
begin
  key:= 'self.' + Name + '[''scrollregion'']';
  if Value = '' then
    Partner.DeleteAttribute(key)
  else if (Value[1] = '(') and (Value[length(Value)] = ')') then
    setAttributValue(key, key + ' = ' + Value)
  else begin
    ScrollRegion:= '(0, 0, 100, 100)';
    setAttributValue(key, key + ' = ' + ScrollRegion);
    UpdateObjectInspector;
  end;
end;

function TKCanvas.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Confine|Scrollbars|ScrollRegion|Rechteck';
  if ShowAttributes >= 2 then
    Result:= Result + '|CloseEnough';
  if ShowAttributes = 3 then
    Result:= Result + '|XScrollIncrement|YScrollIncrement';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKCanvas.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.Canvas');
end;

procedure TKCanvas.MakeFont;
begin
  // no font
end;

procedure TKCanvas.Paint;
begin
  inherited;
  PaintScrollbars(Scrollbars);
end;

procedure TKCanvas.setState(Value: TTextState2);
begin
  if Value <> FState then begin
    FState:= Value;
    Invalidate;
  end;
end;

{--- TKText -------------------------------------------------------------------}

constructor TKText.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 3;
  Width:= 120;
  Height:= 80;
  FAutoSeparators:= true;
  FBlockCursor:= false;
  Cursor:= crIBeam;
  FInactiveSelectBackground:= clBtnFace;
  FInsertUnfocussed:= none;
  HighlightThickness:= '0';
  Font.Name:= 'Consolas';  // TkFixedFont
  Font.Size:= 10;
  FMaxUndo:= 0;
  Relief:= _TR_sunken;
  FSpacing1:= '0';
  FSpacing2:= '0';
  FSpacing3:= '0';
  FTabStyle:= tabular;
  FText:= TStringList.Create;
  FUndo:= false;
  FWrap:= _TW_char;
end;

destructor TKText.Destroy;
begin
  FreeAndNil(FText);
  inherited;
end;

function TKText.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Wrap|Text|Scrollbars';
  if ShowAttributes >= 2 then
    Result:= Result + '|PadX|PadY';
  if ShowAttributes = 3 then
    Result:= Result + '|AutoSeparators|BlockCursor|Endline|InactiveSelectBackground' +
                      '|InsertUnfocussed|MaxUndo|Undo|SetGrid|Startline|Spacing1' +
                      '|Spacing2|Spacing3|Tabs|TabStyle';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TKText.getEvents(ShowEvents: integer): string;
begin
  Result:= getKeyboardEvents(ShowEvents);
end;

procedure TKText.MakeStrings;
  var s1, s2: string; i: integer;
begin
  if FText.Count > 0
    then s2:= FText[0]
    else s2:= '';
  for i:= 1 to FText.Count - 1 do
    s2:= s2 + '\n' + FText[i];
  s1:= 'self.' + Name  + '.insert';
  SetAttributValue(s1, s1 + '(''1.0'', ' + asString(s2) + ')');
end;

procedure TKText.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Text' then
    MakeStrings
  else
    inherited;
end;

procedure TKText.NewWidget(Widget: String = '');
begin
  inherited NewWidget('tk.Text');
end;

procedure TKText.Paint;
  var th, taw, tah, px, py: integer;
      R: TRect;
      SL: TStringList; s: String;

  procedure split(const s: string; var s1, s2: string);
    var len, n: integer;
  begin
    len:= Canvas.TextWidth('abcdefghijklmnopqrstuvwxyz');
    n:= round(taw / (len / 26.0)) + 1;
    s1:= copy(s, 1, n);
    s2:= copy(s, n+1, length(s));

    while Canvas.Textwidth(s1) < taw do begin
      s1:= s1 + s2[1];
      delete(s2, 1, 1);
    end;
    while Canvas.TextWidth(s1) > taw do begin
      s2:= s1[length(s1)] + s2;
      delete(s1, length(s1), 1);
    end;
  end;

  procedure makeSL;
    var s, s1, s2: string; i: integer;
  begin
    SL.Clear;
    for i:= 0 to FText.Count - 1 do begin
      s:= FText[i]; s1:= ''; s2:= '';
      while Canvas.TextWidth(s) > taw do begin
        split(s, s1, s2);
        SL.Add(s1);
        s:= s2;
      end;
      SL.Add(s);
    end;
  end;

begin
  inherited;

  // paint text
  if not TryStrToInt(PadX, px) then px:= 0;
  if not TryStrToInt(PadY, py) then py:= 0;
  inc(px, BorderWidthInt);
  inc(py, BorderWidthInt);

  if FText.Text <> CrLf then begin
    SL:= TStringList.Create;
    SL.Text:= FText.Text;

    th:= Canvas.TextHeight('Hg') + 1;
    taw:= Width - px - px;
    tah:= Height - py - py;

    if FWrap <> _TW_none then begin
      makeSL;
      if SL.Count * th > tah then begin
        dec(taw, 16);
        makeSL;
      end;
    end;

    s:= SL.Text;
    R:= Rect(px + 1, py + 1, Width - px - 1, Height - py - 1);
    Canvas.TextRect(R, s);
    FreeAndNil(SL);
  end;
  PaintScrollbars(Scrollbars);
end;

procedure TKText.SetStrings(Value: TStrings);
begin
  FText.Assign(Value);
  Invalidate;
end;

procedure TKText.setWrap(aValue: TWrap);
begin
  if aValue <> FWrap then begin
    FWrap:= aValue;
    Invalidate;
  end;
end;

procedure TKText.setState(Value: TTextState2);
begin
  if Value <> FState then begin
    FState:= Value;
    Invalidate;
  end;
end;

{--- TKListbox ----------------------------------------------------------------}

constructor TKListbox.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 8;
  Width:= 120;
  Height:= 80;
  Foreground:= clBtnText;
  FActiveStyle:= _TS_underline;
  FListItems:= TStringList.Create;
  FListItems.Text:= defaultItems;
  FSelectMode:= browse;
  Justify:= _TJ_left;
  Relief:= _TR_sunken;
end;

destructor TKListbox.Destroy;
begin
  FreeAndNil(FListItems);
  inherited;
end;

function TKListbox.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|ListItems|Scrollbars';
  if ShowAttributes >= 2 then
    Result:= Result + '|SelectMode|ActiveStyle|DisabledForeground';
  if ShowAttributes = 3 then
    Result:= Result + '|Justify|SetGrid';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TKListbox.getListItems: String;
  var s: String; i: integer;
begin
  s:= '[';
  for i:= 0 to FListItems.Count -1 do
    s:= s + asString(FListItems[i]) + ', ';
  delete(s, length(s) - 1, 2);
  Result:= s + ']';
end;

procedure TKListbox.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'ListItems' then
    setValue(Name + 'CV', getListItems)
  else
    inherited;
end;

procedure TKListbox.setListItems(Values: TStrings);
begin
  FListItems.Assign(Values);
  Invalidate;
end;

procedure TKListbox.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Listbox');
  MakeControlVar('listvariable', Name + 'CV');
  setAttribute('ListItems', '', '');
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKListbox.Paint;
  var s: String; R: TRect; format: integer;
begin
  inherited;
  case Justify of
    _TJ_left:   format:= DT_LEFT;
    _TJ_center: format:= DT_CENTER;
    else        format:= DT_RIGHT;
  end;
  R:= ClientRectWithoutScrollbars;
  R.Inflate(-BorderWidthInt-1, -BorderWidthInt-1);
  s:= FListItems.Text;
  DrawText(Canvas.Handle, PChar(s), Length(s), R, format);
  PaintScrollbars(Scrollbars);
end;

procedure TKListbox.setState(Value: TTextState2);
begin
  if Value <> FState then begin
    FState:= Value;
    Invalidate;
  end;
end;

end.

