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
    FExportSelection: Boolean;
    FInsertBackground: TColor;
    FInsertBorderwidth: string;
    FInsertOffTime: Integer;
    FInsertOnTime: Integer;
    FInsertWidth: string;
    FInvalidCommand: Boolean;
    FReadOnlyBackground: TColor;
    FSelectBackground: TColor;
    FSelectForeground: TColor;
    FSelectBorderWidth: Integer;
    FSetGrid: Boolean;
    FValidate: TValidate;
    FValidateCommand: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DeleteWidget; override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    
    property DisabledBackground: TColor read FDisabledBackground write FDisabledBackground default clBtnFace;
    property ExportSelection: Boolean read FExportSelection write FExportSelection default True;
    property InsertBackground: TColor read FInsertBackground write FInsertBackground default clWindowText;
    property InsertBorderwidth: string read FInsertBorderwidth write FInsertBorderwidth;
    property InsertOffTime: Integer read FInsertOffTime write FInsertOffTime default 300;
    property InsertOnTime: Integer read FInsertOnTime write FInsertOnTime default 600;
    property InsertWidth: string read FInsertWidth write FInsertWidth;
    property InvalidCommand: Boolean read FInvalidCommand write FInvalidCommand;
    property ReadOnlyBackground: TColor read FReadOnlyBackground write FReadOnlyBackground default clBtnFace;
    property SetGrid: Boolean read FSetGrid write FSetGrid default False;
    property Validate: TValidate read FValidate write FValidate default _TV_none;
    property ValidateCommand: Boolean read FValidateCommand write FValidateCommand;
  published
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property SelectBackground: TColor read FSelectBackground write FSelectBackground default clHighlight;
    property SelectForeground: TColor read FSelectForeground write FSelectForeground default clHighlightText;
    property SelectBorderWidth: Integer read FSelectBorderWidth write FSelectBorderWidth default 0;
  end;

  TKEntry = class (TKTextBaseWidget)
  private
    FShow: Boolean;
    FState: TTextState3;
    FText: string;
    procedure setState(Value: TTextState3);
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    procedure setText(Value: string); override;
    procedure MakeCommand(Attr, Value: string); override;
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
    property Show: Boolean read FShow write FShow default True;
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
    FFormat: string;
    FFrom: string;
    FIncrement: string;
    FRepeatDelay: Integer;
    FRepeatInterval: Integer;
    FState: TTextState3;
    FTo: string;
    FValue: string;
    FValues: TStrings;
    FWrap: Boolean;
    procedure setItems(aItems: TStrings);
    procedure setState(Value: TTextState3);
    procedure setRValue(aValue: string);
    procedure MakeValues;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeCommand(Attr, Value: string); override;
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
    property Format: string read FFormat write FFormat;
    property From_: string read FFrom write FFrom;
    property Increment: string read FIncrement write FIncrement;
    property InsertBackground;
    property InsertBorderwidth;
    property InsertOffTime;
    property InsertOnTime;
    property InsertWidth;
    property InvalidCommand;
    property Justify;
    property ReadOnlyBackground;
    property RepeatDelay: Integer read FRepeatDelay write FRepeatDelay default 400;
    property RepeatInterval: Integer read FRepeatInterval write FRepeatInterval default 100;
    property Scrollbar;
    property State: TTextState3 read FState write setState default normal;
    property TakeFocus;
    property _To: string read FTo write FTo;
    property Validate;
    property ValidateCommand;
    property Values: TStrings read FValues write setItems;
    property Value: string read FValue write setRValue;
    property Wrap: Boolean read FWrap write FWrap default False;
  end;

  TKCanvas = class (TKTextBaseWidget)
  private
    FCloseEnough: real;
    FConfine: Boolean;
    FScrollregion: string;
    FState: TTextState2;
    FXScrollIncrement: string;
    FYScrollIncrement: string;
    procedure setState(Value: TTextState2);
    procedure MakeScrollRegion(Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property CloseEnough: real read FCloseEnough write FCloseEnough;
    property Confine: Boolean read FConfine write FConfine default True;
    property InsertBackground;
    property InsertBorderwidth;
    property InsertOffTime;
    property InsertOnTime;
    property InsertWidth;
    property Scrollbars;
    property ScrollRegion: string read FScrollRegion write FScrollRegion;
    property State: TTextState2 read FState write setState default _TS_normal;
    property XScrollIncrement: string read FXScrollIncrement write FXScrollIncrement;
    property YScrollIncrement: string read FYScrollIncrement write FYScrollIncrement;
  end;

  TKText = class (TKTextBaseWidget)
  private
    FAutoSeparators: Boolean;
    FBlockCursor: Boolean;
    FEndline: Integer;
    FInactiveSelectBackground: TColor;
    FInsertUnfocussed: TInsert;
    FMaxUndo: Integer;
    FSpacing1: string;
    FSpacing2: string;
    FSpacing3: string;
    FStartline: Integer;
    FState: TTextState2;
    FTabs: string;
    FTabStyle: TTabStyle;
    FText: TStrings;
    FUndo: Boolean;
    FWrap: TWrap;
    procedure setState(Value: TTextState2);
    procedure setStrings(Value: TStrings);
    procedure MakeStrings;
    procedure setWrap(aValue: TWrap);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    function getEvents(ShowEvents: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property AutoSeparators: Boolean read FAutoSeparators write FAutoSeparators default True;
    property BlockCursor: Boolean read FBlockCursor write FBlockCursor default False;
    property Endline: Integer read FEndline write FEndline default 0;
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
    property MaxUndo: Integer read FMaxUndo write FMaxUndo default 0;
    property PadX;
    property PadY;
    property Scrollbars;
    property SetGrid;
    property Spacing1: string read FSpacing1 write FSpacing1;
    property Spacing2: string read FSpacing2 write FSpacing2;
    property Spacing3: string read FSpacing3 write FSpacing3;
    property Startline: Integer read FStartline write FStartline default 0;
    property State: TTextState2 read FState write setState default _TS_normal;
    property Tabs: string read FTabs write FTabs;
    property TabStyle: TTabStyle read FTabStyle write FTabStyle default tabular;
    property TakeFocus;
    property Text: TStrings read FText write setStrings;
    property Undo: Boolean read FUndo write FUndo default False;
    property Wrap: TWrap read FWrap write setWrap default _TW_char;
  end;

  TKListbox = class(TKTextBaseWidget)
  private
    FActiveStyle: TActiveStyle;
    FListItems: TStrings;
    FSelectMode: TSelectMode;
    FState: TTextState2;
    procedure setListItems(Values: TStrings);
    function getListItems: string;
    procedure setState(Value: TTextState2);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
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
  inherited Create(AOwner);
  Anchor:= _TA_W;
  BorderWidth:= '1';
  Background:= clWindow;
  Foreground:= clWindowText;
  FDisabledBackground:= clBtnFace;
  FExportSelection:= True;
  FInsertBackground:= clWindowText;
  FInsertBorderwidth:= '0';
  FInsertOffTime:= 300;
  FInsertOnTime:= 600;
  FInsertWidth:= '2';
  FReadOnlyBackground:= clBtnFace;
  FSelectBackground:= clHighlight;
  FSelectForeground:= clHighlightText;
  FSelectBorderWidth:= 0;
  FSetGrid:= False;
  FValidate:= _TV_none;
  TakeFocus:= True;
end;

procedure TKTextBaseWidget.DeleteWidget;
begin
  inherited;
  if FInvalidCommand then Partner.DeleteMethod(Name + '_InvalidCommand');
  if FValidateCommand then Partner.DeleteMethod(Name +  '_ValidateCommand');
end;

function TKTextBaseWidget.getAttributes(ShowAttributes: Integer): string;
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

function TKTextBaseWidget.getEvents(ShowEvents: Integer): string;
begin
  Result:= getMouseEvents(ShowEvents);
end;

{--- TKEntry ------------------------------------------------------------------}

constructor TKEntry.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 2;
  Width:= 80;
  Height:= 24;
  HighlightThickness:= '0';
  Cursor:= crIBeam;
  FShow:= True;
  Justify:= _TJ_left;
  Relief:= _TR_sunken;
end;

procedure TKEntry.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Entry');
  MakeControlVar('textvariable', Name + 'CV', FText);
  Partner.ActiveSynEdit.EndUpdate;
end;

function TKEntry.getAttributes(ShowAttributes: Integer): string;
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

function TKEntry.getEvents(ShowEvents: Integer): string;
begin
  Result:= getKeyboardEvents(ShowEvents);
end;

procedure TKEntry.setText(Value: string);
begin
  if Value <> FText then begin
    FText:= Value;
    Invalidate;
  end;
end;

procedure TKEntry.MakeCommand(Attr, Value: string);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TKEntry.Paint;
  var newHeight: Integer;
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
  inherited Create(AOwner);
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
  FWrap:= False;
  Justify:= _TJ_left;
  Cursor:= crIBeam;
end;

destructor TKSpinbox.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

procedure TKSpinbox.MakeValues;
  var s1, Value, AllValues: string; i: Integer;
begin
  s1:= 'self.' + Name + '[''values'']';
  AllValues:= '[';
  for i := 0 to FValues.Count - 1 do begin
    Value:= Trim(FValues[i]);
    if Value = '' then Continue;
    AllValues:= AllValues + asString(Value) + ', ';
  end;
  if Copy(AllValues, Length(AllValues) -1, 2) = ', ' then
    Delete(AllValues, Length(AllValues)-1, 2);
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

function TKSpinbox.getAttributes(ShowAttributes: Integer): string;
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

procedure TKSpinbox.SetRValue(aValue: string);
begin
  if FValue <> aValue then begin
    FValue:= aValue;
    Invalidate;
  end;
end;

procedure TKSpinbox.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Spinbox');
  MakeControlVar('textvariable', Name + 'CV', FValue);
  InsertValue('self.' + Name + '[' + asString('to') + '] = ' + asString('10'));
  InsertValue('self.' + Name + '[' + asString('from') + '] = ' + asString('1'));
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKSpinbox.MakeCommand(Attr, Value: string);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TKSpinbox.Paint;
  var s: string; R: TRect;
      x, y, w, newHeight: Integer;
      Points: array[0..2] of TPoint;
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
  FConfine:= True;
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

procedure TKCanvas.MakeScrollRegion(Value: string);
  var key: string;
begin
  key:= 'self.' + Name + '[''scrollregion'']';
  if Value = '' then
    Partner.DeleteAttribute(key)
  else if (Value[1] = '(') and (Value[Length(Value)] = ')') then
    setAttributValue(key, key + ' = ' + Value)
  else begin
    ScrollRegion:= '(0, 0, 100, 100)';
    setAttributValue(key, key + ' = ' + ScrollRegion);
    UpdateObjectInspector;
  end;
end;

function TKCanvas.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Confine|Scrollbars|ScrollRegion|Rechteck';
  if ShowAttributes >= 2 then
    Result:= Result + '|CloseEnough';
  if ShowAttributes = 3 then
    Result:= Result + '|XScrollIncrement|YScrollIncrement';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TKCanvas.NewWidget(Widget: string = '');
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
  inherited Create(AOwner);
  Tag:= 3;
  Width:= 120;
  Height:= 80;
  FAutoSeparators:= True;
  FBlockCursor:= False;
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
  FUndo:= False;
  FWrap:= _TW_char;
end;

destructor TKText.Destroy;
begin
  FreeAndNil(FText);
  inherited;
end;

function TKText.getAttributes(ShowAttributes: Integer): string;
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

function TKText.getEvents(ShowEvents: Integer): string;
begin
  Result:= getKeyboardEvents(ShowEvents);
end;

procedure TKText.MakeStrings;
  var s1, s2: string; i: Integer;
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

procedure TKText.NewWidget(Widget: string = '');
begin
  inherited NewWidget('tk.Text');
end;

procedure TKText.Paint;
  var th, taw, tah, px, py: Integer;
      R: TRect;
      SL: TStringList; s: string;

  procedure Split(const s: string; var s1, s2: string);
    var len, n: Integer;
  begin
    len:= Canvas.TextWidth('abcdefghijklmnopqrstuvwxyz');
    n:= round(taw / (len / 26.0)) + 1;
    s1:= Copy(s, 1, n);
    s2:= Copy(s, n+1, Length(s));

    while Canvas.Textwidth(s1) < taw do begin
      s1:= s1 + s2[1];
      Delete(s2, 1, 1);
    end;
    while Canvas.TextWidth(s1) > taw do begin
      s2:= s1[Length(s1)] + s2;
      Delete(s1, Length(s1), 1);
    end;
  end;

  procedure makeSL;
    var s, s1, s2: string; i: Integer;
  begin
    SL.Clear;
    for i:= 0 to FText.Count - 1 do begin
      s:= FText[i]; s1:= ''; s2:= '';
      while Canvas.TextWidth(s) > taw do begin
        Split(s, s1, s2);
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
  Inc(px, BorderWidthInt);
  Inc(py, BorderWidthInt);

  if FText.Text <> CrLf then begin
    SL:= TStringList.Create;
    SL.Text:= FText.Text;

    th:= Canvas.TextHeight('Hg') + 1;
    taw:= Width - px - px;
    tah:= Height - py - py;

    if FWrap <> _TW_none then begin
      makeSL;
      if SL.Count * th > tah then begin
        Dec(taw, 16);
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

constructor TKListbox.Create(AOwner: TComponent);
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

function TKListbox.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|ListItems|Scrollbars';
  if ShowAttributes >= 2 then
    Result:= Result + '|SelectMode|ActiveStyle|DisabledForeground';
  if ShowAttributes = 3 then
    Result:= Result + '|Justify|SetGrid';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TKListbox.getListItems: string;
  var s: string; i: Integer;
begin
  s:= '[';
  for i:= 0 to FListItems.Count -1 do
    s:= s + asString(FListItems[i]) + ', ';
  Delete(s, Length(s) - 1, 2);
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

procedure TKListbox.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Listbox');
  MakeControlVar('listvariable', Name + 'CV');
  setAttribute('ListItems', '', '');
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKListbox.Paint;
  var s: string; R: TRect; format: Integer;
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

