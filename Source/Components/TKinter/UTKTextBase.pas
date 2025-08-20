{ -------------------------------------------------------------------------------
  Unit:     UTKTextBase
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  tkinter text widgets
  ------------------------------------------------------------------------------- }

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
  Classes,
  Controls,
  Graphics,
  UBaseTKWidgets,
  UTKWidgets;

type

  // for disabeling  - different to TButtonState in TKButtonBase
  TTextState2 = (_TS_disabled, _TS_normal);

  TTextState3 = (disabled, normal, readonly);

  TInsert = (hollow, none, solid);

  TTabStyle = (tabular, wordprocessor);

  TWrap = (_TW_char, _TW_none, _TW_word); // none already in TInsert

  TActiveStyle = (_TS_underline, _TS_dotbox, _TS_none);

  TSelectMode = (browse, single, multiple, extended);

  TValidate = (_TV_none, _TV_all, _TV_key, _TV_focus, _TV_focusin,
    _TV_focusout);

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
    constructor Create(Owner: TComponent); override;
    procedure DeleteWidget; override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    property DisabledBackground: TColor read FDisabledBackground
      write FDisabledBackground default clBtnFace;
    property ExportSelection: Boolean read FExportSelection
      write FExportSelection default True;
    property InsertBackground: TColor read FInsertBackground
      write FInsertBackground default clWindowText;
    property InsertBorderwidth: string read FInsertBorderwidth
      write FInsertBorderwidth;
    property InsertOffTime: Integer read FInsertOffTime write FInsertOffTime
      default 300;
    property InsertOnTime: Integer read FInsertOnTime write FInsertOnTime
      default 600;
    property InsertWidth: string read FInsertWidth write FInsertWidth;
    property InvalidCommand: Boolean read FInvalidCommand write FInvalidCommand;
    property ReadOnlyBackground: TColor read FReadOnlyBackground
      write FReadOnlyBackground default clBtnFace;
    property SetGrid: Boolean read FSetGrid write FSetGrid default False;
    property Validate: TValidate read FValidate write FValidate
      default _TV_none;
    property ValidateCommand: Boolean read FValidateCommand
      write FValidateCommand;
  published
    property HighlightBackground;
    property HighlightColor;
    property HighlightThickness;
    property SelectBackground: TColor read FSelectBackground
      write FSelectBackground default clHighlight;
    property SelectForeground: TColor read FSelectForeground
      write FSelectForeground default clHighlightText;
    property SelectBorderWidth: Integer read FSelectBorderWidth
      write FSelectBorderWidth default 0;
  end;

  TKEntry = class(TKTextBaseWidget)
  private
    FShow: Boolean;
    FState: TTextState3;
    FText: string;
    procedure SetState(Value: TTextState3);
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(const Widget: string = ''); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure SetText(const Value: string); override;
    procedure MakeCommand(const Attr, Value: string); override;
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
    {$WARNINGS OFF} // ancestor TControl has method Show
    property Show: Boolean read FShow write FShow default True;
    {$WARNINGS ON}
    property State: TTextState3 read FState write SetState default normal;
    property TakeFocus;
    property Text: string read FText write SetText;
    // override Text in TBaseWidget
    property Validate;
    property ValidateCommand;
  end;

  TKSpinbox = class(TKTextBaseWidget)
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
    procedure SetItems(Items: TStrings);
    procedure SetState(Value: TTextState3);
    procedure SetRValue(const Value: string);
    procedure MakeValues;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeCommand(const Attr, Value: string); override;
    procedure Paint; override;
  published
    property ActiveBackground;
    property ButtonBackground: TColor read FButtonBackground
      write FButtonBackground default clBtnFace;
    property ButtonCursor: TCursor read FButtonCursor write FButtonCursor;
    property ButtonDownRelief: TRelief read FButtonDownRelief
      write FButtonDownRelief default _TR_raised;
    property ButtonUpRelief: TRelief read FButtonUpRelief write FButtonUpRelief
      default _TR_raised;
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
    property RepeatDelay: Integer read FRepeatDelay write FRepeatDelay
      default 400;
    property RepeatInterval: Integer read FRepeatInterval write FRepeatInterval
      default 100;
    property Scrollbar;
    property State: TTextState3 read FState write SetState default normal;
    property TakeFocus;
    property _To: string read FTo write FTo;
    property Validate;
    property ValidateCommand;
    property Values: TStrings read FValues write SetItems;
    property Value: string read FValue write SetRValue;
    property Wrap: Boolean read FWrap write FWrap default False;
  end;

  TKCanvas = class(TKTextBaseWidget)
  private
    FCloseEnough: Real;
    FConfine: Boolean;
    FScrollRegion: string;
    FState: TTextState2;
    FXScrollIncrement: string;
    FYScrollIncrement: string;
    procedure SetState(Value: TTextState2);
    procedure MakeScrollRegion(const Value: string);
  public
    constructor Create(Owner: TComponent); override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure MakeFont; override;
    procedure Paint; override;
  published
    property CloseEnough: Real read FCloseEnough write FCloseEnough;
    property Confine: Boolean read FConfine write FConfine default True;
    property InsertBackground;
    property InsertBorderwidth;
    property InsertOffTime;
    property InsertOnTime;
    property InsertWidth;
    property Scrollbars;
    property ScrollRegion: string read FScrollRegion write FScrollRegion;
    property State: TTextState2 read FState write SetState default _TS_normal;
    property XScrollIncrement: string read FXScrollIncrement
      write FXScrollIncrement;
    property YScrollIncrement: string read FYScrollIncrement
      write FYScrollIncrement;
  end;

  TKText = class(TKTextBaseWidget)
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
    procedure SetState(Value: TTextState2);
    procedure SetStrings(Value: TStrings);
    procedure MakeStrings;
    procedure SetWrap(Value: TWrap);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property AutoSeparators: Boolean read FAutoSeparators write FAutoSeparators
      default True;
    property BlockCursor: Boolean read FBlockCursor write FBlockCursor
      default False;
    property Endline: Integer read FEndline write FEndline default 0;
    property ExportSelection;
    property Font;
    property Foreground;
    property InactiveSelectBackground: TColor read FInactiveSelectBackground
      write FInactiveSelectBackground default clBtnFace;
    property InsertUnfocussed: TInsert read FInsertUnfocussed
      write FInsertUnfocussed default none;
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
    property State: TTextState2 read FState write SetState default _TS_normal;
    property Tabs: string read FTabs write FTabs;
    property TabStyle: TTabStyle read FTabStyle write FTabStyle default tabular;
    property TakeFocus;
    property Text: TStrings read FText write SetStrings;
    property Undo: Boolean read FUndo write FUndo default False;
    property Wrap: TWrap read FWrap write SetWrap default _TW_char;
  end;

  TKListbox = class(TKTextBaseWidget)
  private
    FActiveStyle: TActiveStyle;
    FListItems: TStrings;
    FSelectMode: TSelectMode;
    FState: TTextState2;
    procedure SetListItems(Values: TStrings);
    function GetListItems: string;
    procedure SetState(Value: TTextState2);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(const Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(const Widget: string = ''); override;
    procedure Paint; override;
  published
    property ActiveStyle: TActiveStyle read FActiveStyle write FActiveStyle
      default _TS_underline;
    property DisabledForeground;
    property ExportSelection;
    property Foreground;
    property Font;
    property Justify;
    property ListItems: TStrings read FListItems write SetListItems;
    property Scrollbars;
    property SelectMode: TSelectMode read FSelectMode write FSelectMode
      default browse;
    property SetGrid;
    property State: TTextState2 read FState write SetState default _TS_normal;
    property TakeFocus;
  end;

implementation

uses
  Windows,
  System.Types,
  SysUtils,
  UITypes,
  UUtils,
  UConfiguration;

{ --- TButtonBaseWidget -------------------------------------------------------- }

constructor TKTextBaseWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Anchor := _TA_w;
  BorderWidth := '1';
  Background := clWindow;
  Foreground := clWindowText;
  FDisabledBackground := clBtnFace;
  FExportSelection := True;
  FInsertBackground := clWindowText;
  FInsertBorderwidth := '0';
  FInsertOffTime := 300;
  FInsertOnTime := 600;
  FInsertWidth := '2';
  FReadOnlyBackground := clBtnFace;
  FSelectBackground := clHighlight;
  FSelectForeground := clHighlightText;
  FSelectBorderWidth := 0;
  FSetGrid := False;
  FValidate := _TV_none;
  TakeFocus := True;
end;

procedure TKTextBaseWidget.DeleteWidget;
begin
  inherited;
  if FInvalidCommand then
    Partner.DeleteMethod(Name + '_InvalidCommand');
  if FValidateCommand then
    Partner.DeleteMethod(Name + '_ValidateCommand');
end;

function TKTextBaseWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '';
  if ShowAttributes >= 2 then
    Result := Result + '|Validate|ValidateCommand';
  if ShowAttributes = 3 then
    Result := Result + '|ExportSelection|Foreground' +
      '|HighlightBackground|HighlightColor|HighlightThickness|InsertBackground'
      + '|InsertBorderwidth|InsertOffTime|InsertOnTime|InsertWidth' +
      '|SelectBackground|SelectBorderWidth|SelectForeground' +
      '|State|Underline|WrapLength';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKTextBaseWidget.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Scrollbars' then
    MakeScrollbars(Value, 'tk.')
  else if Attr = 'Scrollbar' then
    MakeScrollbar(Value, 'tk.')
  else
    inherited;
end;

function TKTextBaseWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetMouseEvents(ShowEvents);
end;

{ --- TKEntry ------------------------------------------------------------------ }

constructor TKEntry.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 2;
  Width := 80;
  Height := 24;
  HighlightThickness := '0';
  Cursor := crIBeam;
  FShow := True;
  Justify := _TJ_left;
  Relief := _TR_sunken;
end;

procedure TKEntry.NewWidget(const Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Entry');
  MakeControlVar('textvariable', Name + 'CV', FText);
  Partner.ActiveSynEdit.EndUpdate;
end;

function TKEntry.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Text';
  if ShowAttributes >= 2 then
    Result := Result + '|InvalidCommand|Scrollbar';
  if ShowAttributes >= 3 then
    Result := Result +
      '|DisabledBackground|DisabledForeground|Justify|ReadOnlyBackground|Show';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKEntry.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Text' then // different from Button.Text
    SetValue(Name + 'CV', AsString(Value))
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

function TKEntry.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetKeyboardEvents(ShowEvents);
end;

procedure TKEntry.SetText(const Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    Invalidate;
  end;
end;

procedure TKEntry.MakeCommand(const Attr, Value: string);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TKEntry.Paint;
var
  NewHeight: Integer;
begin
  inherited; // shows no text, because FText of TKWidget is overridden
  if Scrollbar then
    NewHeight := Height - 20
  else
    NewHeight := Height;
  ShowText(FText, Width, NewHeight);
  PaintAScrollbar(Scrollbar);
end;

procedure TKEntry.SetState(Value: TTextState3);
begin
  if Value <> FState then
  begin
    FState := Value;
    Invalidate;
  end;
end;

{ --- TKSpinBox ---------------------------------------------------------------- }

constructor TKSpinbox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 9;
  Width := 40;
  Height := 24;
  FButtonBackground := clBtnFace;
  FButtonDownRelief := _TR_raised;
  FButtonUpRelief := _TR_raised;
  HighlightThickness := '0';
  FFrom := '1';
  FTo := '10';
  FIncrement := '1';
  Relief := _TR_sunken;
  FRepeatDelay := 400;
  FRepeatInterval := 100;
  FValues := TStringList.Create;
  FWrap := False;
  Justify := _TJ_left;
  Cursor := crIBeam;
end;

destructor TKSpinbox.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

procedure TKSpinbox.MakeValues;
var
  Str, AValue, AllValues: string;
begin
  Str := 'self.' + Name + '[''values'']';
  AllValues := '[';
  for var I := 0 to FValues.Count - 1 do
  begin
    AValue := Trim(FValues[I]);
    if AValue = '' then
      Continue;
    AllValues := AllValues + AsString(AValue) + ', ';
  end;
  if Copy(AllValues, Length(AllValues) - 1, 2) = ', ' then
    Delete(AllValues, Length(AllValues) - 1, 2);
  AllValues := AllValues + ']';
  SetAttributValue(Str, Str + ' = ' + AllValues);
end;

procedure TKSpinbox.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Values' then
    MakeValues
  else if Attr = 'Value' then
    SetValue(Name + 'CV', AsString(Value))
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

function TKSpinbox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|From_|_To|Increment|Values|Value';
  if ShowAttributes >= 2 then
    Result := Result + '|Command|Format|InvalidCommand|Scrollbar|Wrap';
  if ShowAttributes = 3 then
    Result := Result +
      '|ActiveBackground|ButtonBackground|ButtonCursor|ButtonDownRelief' +
      '|ButtonUpRelief|DisabledBackground|DisabledForeground|Exportselection|Justify'
      + '|ReadOnlyBackground|RepeatDelay|RepeatInterval';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKSpinbox.SetItems(Items: TStrings);
begin
  FValues.Assign(Items);
  Invalidate;
end;

procedure TKSpinbox.SetRValue(const Value: string);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

procedure TKSpinbox.NewWidget(const Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Spinbox');
  InsertValue('self.' + Name + '[' + AsString('to') + '] = ' + AsString('10'));
  InsertValue('self.' + Name + '[' + AsString('from') + '] = ' + AsString('1'));
  MakeControlVar('textvariable', Name + 'CV', FValue);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKSpinbox.MakeCommand(const Attr, Value: string);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TKSpinbox.Paint;
var
  Str: string;
  ARect: TRect;
  XPos, YPos, NewWidth, NewHeight: Integer;
  Points: array [0 .. 2] of TPoint;
begin
  inherited;
  // paint number/value
  if FValue <> '' then
    Str := FValue
  else if FValues.Count > 0 then
    Str := FValues[0]
  else
    Str := FFrom;
  if Scrollbar then
    NewHeight := Height - 20
  else
    NewHeight := Height;
  ShowText(Str, Width - PPIScale(14), NewHeight);

  // paint up/down
  NewWidth := Width - BorderWidthInt - PPIScale(11);
  ARect := Rect(NewWidth, BorderWidthInt + 1, NewWidth + PPIScale(11),
    NewHeight - BorderWidthInt);
  Canvas.Brush.Color := FButtonBackground;
  Canvas.FillRect(ARect);
  Canvas.Pen.Color := clWhite;
  Canvas.MoveTo(NewWidth, BorderWidthInt);
  Canvas.LineTo(NewWidth, NewHeight - BorderWidthInt);
  Canvas.Pen.Color := clBlack;
  Canvas.MoveTo(NewWidth, NewHeight div 2);
  Canvas.LineTo(NewWidth + PPIScale(12), NewHeight div 2);
  NewWidth := NewWidth + PPIScale(11);
  Canvas.MoveTo(NewWidth, BorderWidthInt);
  Canvas.LineTo(NewWidth, NewHeight - BorderWidthInt);

  Canvas.Brush.Color := RGB(122, 138, 153);
  Canvas.Pen.Color := clBlack;
  XPos := Width - BorderWidthInt - PPIScale(10);
  YPos := BorderWidthInt + (NewHeight - BorderWidthInt) div 4;
  var
  Int2 := PPIScale(2);
  var
  Int4 := PPIScale(4);
  var
  Int6 := PPIScale(6);

  Points[0] := Point(XPos + Int2, YPos + Int2);
  Points[1] := Point(XPos + Int6, YPos + Int2);
  Points[2] := Point(XPos + Int4, YPos);
  Canvas.Polygon(Points);
  YPos := NewHeight - BorderWidthInt - (NewHeight - BorderWidthInt) div 4;
  Points[0] := Point(XPos + Int2, YPos - Int2);
  Points[1] := Point(XPos + Int6, YPos - Int2);
  Points[2] := Point(XPos + Int4, YPos);
  Canvas.Polygon(Points);
  PaintAScrollbar(Scrollbar);
end;

procedure TKSpinbox.SetState(Value: TTextState3);
begin
  if Value <> FState then
  begin
    FState := Value;
    Invalidate;
  end;
end;

{ --- TKCanvas ----------------------------------------------------------------- }

constructor TKCanvas.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 11;
  Height := 80;
  Width := 120;
  Background := clBtnFace;
  BorderWidth := '0';
  HighlightThickness := '2';
  FInsertBackground := clBtnText;
  FCloseEnough := 1.0;
  FConfine := True;
  FSelectBorderWidth := 1;
  FXScrollIncrement := '0';
  FYScrollIncrement := '0';
end;

procedure TKCanvas.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'ScrollRegion' then
    MakeScrollRegion(Value)
  else
    inherited;
end;

procedure TKCanvas.MakeScrollRegion(const Value: string);
var
  Key: string;
begin
  Key := 'self.' + Name + '[''scrollregion'']';
  if Value = '' then
    Partner.DeleteAttribute(Key)
  else if (Value[1] = '(') and (Value[Length(Value)] = ')') then
    SetAttributValue(Key, Key + ' = ' + Value)
  else
  begin
    ScrollRegion := '(0, 0, 100, 100)';
    SetAttributValue(Key, Key + ' = ' + ScrollRegion);
    UpdateObjectInspector;
  end;
end;

function TKCanvas.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Confine|Scrollbars|ScrollRegion|Rechteck';
  if ShowAttributes >= 2 then
    Result := Result + '|CloseEnough';
  if ShowAttributes = 3 then
    Result := Result + '|XScrollIncrement|YScrollIncrement';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TKCanvas.NewWidget(const Widget: string = '');
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

procedure TKCanvas.SetState(Value: TTextState2);
begin
  if Value <> FState then
  begin
    FState := Value;
    Invalidate;
  end;
end;

{ --- TKText ------------------------------------------------------------------- }

constructor TKText.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 3;
  Width := 120;
  Height := 80;
  FAutoSeparators := True;
  FBlockCursor := False;
  Cursor := crIBeam;
  FInactiveSelectBackground := clBtnFace;
  FInsertUnfocussed := none;
  HighlightThickness := '0';
  Font.Name := 'Consolas'; // TkFixedFont
  Font.Size := 10;
  FMaxUndo := 0;
  Relief := _TR_sunken;
  FSpacing1 := '0';
  FSpacing2 := '0';
  FSpacing3 := '0';
  FTabStyle := tabular;
  FText := TStringList.Create;
  FUndo := False;
  FWrap := _TW_char;
end;

destructor TKText.Destroy;
begin
  FreeAndNil(FText);
  inherited;
end;

function TKText.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Wrap|Text|Scrollbars';
  if ShowAttributes >= 2 then
    Result := Result + '|PadX|PadY';
  if ShowAttributes = 3 then
    Result := Result +
      '|AutoSeparators|BlockCursor|Endline|InactiveSelectBackground' +
      '|InsertUnfocussed|MaxUndo|Undo|SetGrid|Startline|Spacing1' +
      '|Spacing2|Spacing3|Tabs|TabStyle';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TKText.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetKeyboardEvents(ShowEvents);
end;

procedure TKText.MakeStrings;
var
  Str1, Str2: string;
begin
  if FText.Count > 0 then
    Str2 := FText[0]
  else
    Str2 := '';
  for var I := 1 to FText.Count - 1 do
    Str2 := Str2 + '\n' + FText[I];
  Str1 := 'self.' + Name + '.insert';
  SetAttributValue(Str1, Str1 + '(''1.0'', ' + AsString(Str2) + ')');
end;

procedure TKText.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'Text' then
    MakeStrings
  else
    inherited;
end;

procedure TKText.NewWidget(const Widget: string = '');
begin
  inherited NewWidget('tk.Text');
end;

procedure TKText.Paint;
var
  TextHeight, ATextWidth, ATextHeight, APadX, APadY: Integer;
  ARect: TRect;
  StringList: TStringList;
  Str: string;

  procedure Split(const Str: string; var Str1, Str2: string);
  var
    Len, Num: Integer;
  begin
    Len := Canvas.TextWidth('abcdefghijklmnopqrstuvwxyz');
    Num := Round(ATextWidth / (Len / 26.0)) + 1;
    Str1 := Copy(Str, 1, Num);
    Str2 := Copy(Str, Num + 1, Length(Str));

    while Canvas.TextWidth(Str1) < ATextWidth do
    begin
      Str1 := Str1 + Str2[1];
      Delete(Str2, 1, 1);
    end;
    while Canvas.TextWidth(Str1) > ATextWidth do
    begin
      Str2 := Str1[Length(Str1)] + Str2;
      Delete(Str1, Length(Str1), 1);
    end;
  end;

  procedure makeSL;
  var
    Str, Str1, Str2: string;
  begin
    StringList.Clear;
    for var I := 0 to FText.Count - 1 do
    begin
      Str := FText[I];
      Str1 := '';
      Str2 := '';
      while Canvas.TextWidth(Str) > ATextWidth do
      begin
        Split(Str, Str1, Str2);
        StringList.Add(Str1);
        Str := Str2;
      end;
      StringList.Add(Str);
    end;
  end;

begin
  inherited;

  // paint text
  if not TryStrToInt(PadX, APadX) then
    APadX := 0;
  if not TryStrToInt(PadY, APadY) then
    APadY := 0;
  Inc(APadX, BorderWidthInt);
  Inc(APadY, BorderWidthInt);

  if FText.Text <> CrLf then
  begin
    StringList := TStringList.Create;
    StringList.Text := FText.Text;

    TextHeight := Canvas.TextHeight('Hg') + 1;
    ATextWidth := Width - APadX - APadX;
    ATextHeight := Height - APadY - APadY;

    if FWrap <> _TW_none then
    begin
      makeSL;
      if StringList.Count * TextHeight > ATextHeight then
      begin
        Dec(ATextWidth, 16);
        makeSL;
      end;
    end;

    Str := StringList.Text;
    ARect := Rect(APadX + 1, APadY + 1, Width - APadX - 1, Height - APadY - 1);
    Canvas.TextRect(ARect, Str);
    FreeAndNil(StringList);
  end;
  PaintScrollbars(Scrollbars);
end;

procedure TKText.SetStrings(Value: TStrings);
begin
  FText.Assign(Value);
  Invalidate;
end;

procedure TKText.SetWrap(Value: TWrap);
begin
  if Value <> FWrap then
  begin
    FWrap := Value;
    Invalidate;
  end;
end;

procedure TKText.SetState(Value: TTextState2);
begin
  if Value <> FState then
  begin
    FState := Value;
    Invalidate;
  end;
end;

{ --- TKListbox ---------------------------------------------------------------- }

constructor TKListbox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 8;
  Width := 120;
  Height := 80;
  Foreground := clBtnText;
  FActiveStyle := _TS_underline;
  FListItems := TStringList.Create;
  FListItems.Text := DefaultItems;
  FSelectMode := browse;
  Justify := _TJ_left;
  Relief := _TR_sunken;
end;

destructor TKListbox.Destroy;
begin
  FreeAndNil(FListItems);
  inherited;
end;

function TKListbox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|ListItems|Scrollbars';
  if ShowAttributes >= 2 then
    Result := Result + '|SelectMode|ActiveStyle|DisabledForeground';
  if ShowAttributes = 3 then
    Result := Result + '|Justify|SetGrid';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TKListbox.GetListItems: string;
var
  Str: string;
begin
  Str := '[';
  for var I := 0 to FListItems.Count - 1 do
    Str := Str + AsString(FListItems[I]) + ', ';
  Delete(Str, Length(Str) - 1, 2);
  Result := Str + ']';
end;

procedure TKListbox.SetAttribute(const Attr, Value, Typ: string);
begin
  if Attr = 'ListItems' then
    SetValue(Name + 'CV', GetListItems)
  else
    inherited;
end;

procedure TKListbox.SetListItems(Values: TStrings);
begin
  FListItems.Assign(Values);
  Invalidate;
end;

procedure TKListbox.NewWidget(const Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('tk.Listbox');
  MakeControlVar('listvariable', Name + 'CV');
  SetAttribute('ListItems', '', '');
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TKListbox.Paint;
var
  Str: string;
  ARect: TRect;
  Format: Integer;
begin
  inherited;
  case Justify of
    _TJ_left:
      Format := DT_LEFT;
    _TJ_center:
      Format := DT_CENTER;
  else
    Format := DT_RIGHT;
  end;
  ARect := ClientRectWithoutScrollbars;
  ARect.Inflate(-BorderWidthInt - 1, -BorderWidthInt - 1);
  Str := FListItems.Text;
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, Format);
  PaintScrollbars(Scrollbars);
end;

procedure TKListbox.SetState(Value: TTextState2);
begin
  if Value <> FState then
  begin
    FState := Value;
    Invalidate;
  end;
end;

end.
