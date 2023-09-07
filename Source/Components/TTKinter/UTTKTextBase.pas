{-------------------------------------------------------------------------------
 Unit:     UTTKTextBase
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  TKKinter text widgets
-------------------------------------------------------------------------------}

unit UTTKTextBase;

{ class hierarchie

  TKTextBaseWidget
    TTKEntry
    TKSpinbox
    TTKCombobox
}

interface

uses
  Classes, UTtkWidgets;

type

  // for disabeling  - different to TButtonState in TKButtonBase
  TTextState = (disabled, normal, readonly);

  TActiveStyle = (_TS_underline, _TS_dotbox, _TS_none);

  TSelectMode = (browse, single, multiple, extended);

  TValidate = (_TV_none, _TV_all, _TV_key, _TV_focus, _TV_focusin, _TV_focusout);

  TTKTextBaseWidget = class(TTKWidget)
  private
    FExportSelection: boolean;
    FInvalidCommand: boolean;
    FState: TTextState;
    FValidate: TValidate;
    FValidateCommand: boolean;
    procedure setState(aValue: TTextState);
  public
    constructor Create(AOwner: TComponent); override;
    procedure DeleteWidget; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    procedure MakeCommand(Attr, Value: String); override;
    procedure Paint; override;
  published
    property ExportSelection: boolean read FExportSelection write FExportSelection default true;
    property Font;
    property Foreground;
    property InvalidCommand: boolean read FInvalidCommand write FInvalidCommand;
    property Justify;
    property Scrollbar;
    property State: TTextState read FState write setState default normal;
    property Validate: TValidate read FValidate write FValidate default _TV_none;
    property ValidateCommand: Boolean read FValidateCommand write FValidateCommand;
  end;

  TTKEntry = class (TTKTextBaseWidget)
  private
    FShow: boolean;
    FText: String;
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewWidget(Widget: String = ''); override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    function getEvents(ShowEvents: integer): string; override;
    procedure setText(Value: String); override;
    procedure Paint; override;
  published
    {$WARNINGS OFF}
    property Show: boolean read FShow write FShow default true;
    {$WARNINGS ON}
    property Text: string read FText write setText;
    property TakeFocus;
  end;

  TTKSpinbox = class (TTKTextBaseWidget)
  private
    FFormat: String;
    FFrom: String;
    FIncrement: String;
    FTo: String;
    FValue: String;
    FValues: TStrings;
    procedure setValues(Values: TStrings);
    procedure setRValue(aValue: String);
    procedure MakeValues;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure Paint; override;
  published
    property Command;
    property Format: String read FFormat write FFormat;
    property From_: String read FFrom write FFrom;
    property Increment: String read FIncrement write FIncrement;
    property TakeFocus;
    property _To: String read FTo write FTo;
    property Values: TStrings read FValues write setValues;
    property Value: String read FValue write setRValue;
  end;

  TTKCombobox = class(TTKTextBaseWidget)
  private
    FPostCommand: boolean;
    FValue: String;
    FValues: TStrings;
    procedure setRValue(aValue: string);
    procedure setValues(Values: TStrings);
    function getListItems: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getAttributes(ShowAttributes: integer): string; override;
    procedure NewWidget(Widget: String = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  published
    property PostCommand: Boolean read FPostCommand write FPostCommand;
    property TakeFocus;
    property Value: String read FValue write setRValue;
    property Values: TStrings read FValues write setValues;
  end;

implementation

uses Controls, Graphics, SysUtils, Types, UITypes,
     UBaseTkWidgets, UUtils;

{--- TButtonBaseWidget --------------------------------------------------------}

constructor TTKTextBaseWidget.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FExportSelection:= true;
  FState:= normal;
  FValidate:= _TV_none;
  Cursor:= crIBeam;
  Justify:= _TJ_Left;
  Relief:= _TR_solid;
end;

procedure TTKTextBaseWidget.DeleteWidget;
begin
  inherited;
  if FInvalidCommand then Partner.DeleteMethod(Name + '_InvalidCommand');
  if FValidateCommand then Partner.DeleteMethod(Name + '_ValidateCommand');
end;

procedure TTKTextBaseWidget.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Scrollbar' then
    MakeScrollbar(Value, 'ttk.')
  else
    inherited;
end;

function TTKTextBaseWidget.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Background|Show';
  if ShowAttributes >= 2 then
    Result:= Result + '|Justify|Scrollbar|State';
  if ShowAttributes = 3 then
    Result:= Result + '|ExportSelection|Foreground' +
                      '|InvalidCommand|Validate|ValidateCommand';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TTKTextBaseWidget.getEvents(ShowEvents: integer): string;
begin
  Result:= getMouseEvents(ShowEvents);
end;

procedure TTKTextBaseWidget.MakeCommand(Attr, Value: String);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TTKTextbaseWidget.Paint;
begin
  if FState = normal
    then Background:= clWindow
    else Background:= clBtnFace;
  inherited;
end;

procedure TTKTextBaseWidget.setState(aValue: TTextState);
begin
  if aValue <> FState then begin
    FState:= aValue;
    Invalidate;
  end;
end;

{--- TTKEntry ------------------------------------------------------------------}

constructor TTKEntry.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 32;
  Width:= 80;
  Height:= 24;
  FShow:= true;
end;

procedure TTKEntry.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Entry');
  MakeControlVar('textvariable', Name + 'CV', FText);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKEntry.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Text' then  // different from Button.Text
    setValue(Name + 'CV', asString(Value))
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

function TTKEntry.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Text' + inherited getAttributes(ShowAttributes);
end;

function TTKEntry.getEvents(ShowEvents: integer): string;
begin
  Result:= getKeyboardEvents(ShowEvents);
end;

procedure TTKEntry.setText(Value: String);
begin
  if Value <> FText then begin
    FText:= Value;
    Invalidate;
  end;
end;

procedure TTKEntry.Paint;
  var newHeight: integer;
begin
  Canvas.Pen.Color:= $7A7A7A;
  inherited; // shows no text, because FText of TKWidget is overridden
  if Scrollbar
    then newHeight:= Height - 20
    else newHeight:= Height;
  ShowText(FText, Width, newHeight);
  PaintAScrollbar(Scrollbar);
end;

{--- TTKSpinbox ----------------------------------------------------------------}

constructor TTKSpinbox.Create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Tag:= 39;
  Width:= 40;
  Height:= 24;
  FFrom:= '0';
  FTo:= '0';
  FValue:= '0';
  FIncrement:= '1';
  FValues:= TStringList.Create;
end;

destructor TTKSpinbox.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

procedure TTKSpinbox.MakeValues;
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

procedure TTKSpinbox.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    setValue(Name + 'CV', asString(Value))
  else if Attr = 'Values' then
    MakeValues
  else
    inherited;
end;

function TTKSpinbox.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|From_|_To|Increment|Values|Value';
  if ShowAttributes >= 2 then
    Result:= Result + '|Command|Format';
  if ShowAttributes = 3 then
    Result:= Result + '|Exportselection';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TTKSpinbox.setValues(Values: TStrings);
begin
  FValues.Assign(Values);
  Invalidate;
end;

procedure TTKSpinbox.SetRValue(aValue: string);
begin
  if FValue <> aValue then begin
    FValue:= aValue;
    Invalidate;
  end;
end;

procedure TTKSpinbox.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Spinbox');
  MakeControlVar('textvariable', Name + 'CV', FValue);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKSpinbox.Paint;
  var s: string;
      x, y, newHeight: integer;
      Points: Array[0..2] of TPoint;
      R: TRect;
begin
  Canvas.Pen.Color:= $7A7A7A;
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
  ShowText(s, Width - 16, newHeight);

  // paint up/down
  Canvas.Brush.Color:= $F0F0F0;
  Canvas.Pen.Color:= $ACACAC;

  R:= Rect(Width - 19, 2, Width - 2, 11);
  Canvas.FillRect(R);
  R.Inflate(-1, -1);
  Canvas.Rectangle(R);

  R:= Rect(Width - 19, newHeight - 11, Width - 2, newHeight - 2);
  Canvas.FillRect(R);
  R.Inflate(-1, -1);
  Canvas.Rectangle(R);

  Canvas.Brush.Color:= clBlack;
  Canvas.Pen.Color:= clBlack;
  x:= Width - 13;
  y:= 7;
  Points[0]:= Point(x, y);
  Points[1]:= Point(x + 4, y);
  Points[2]:= Point(x + 2, y - 2);
  Canvas.Polygon(Points);

  y:= newHeight - 8;
  Points[0]:= Point(x, y);
  Points[1]:= Point(x + 4, y);
  Points[2]:= Point(x + 2, y + 2);
  Canvas.Polygon(Points);
  PaintAScrollbar(Scrollbar);
end;

{--- TKKCombobox --------------------------------------------------------------}

constructor TTKCombobox.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 38;
  Width:= 80;
  Height:= 24;
  Foreground:= clBtnText;
  FValues:= TStringList.Create;
  FValues.Text:= defaultItems;
end;

destructor TTKCombobox.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

function TTKCombobox.getAttributes(ShowAttributes: integer): string;
begin
  Result:= '|Value|Values';
  if ShowAttributes >= 2 then
    Result:= Result + '|PostCommand';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TTKCombobox.getListItems: String;
  var s: String; i: integer;
begin
  s:= '[';
  for i:= 0 to FValues.Count -1 do
    s:= s + asString(FValues[i]) + ', ';
  delete(s, length(s) - 1, 2);
  Result:= s + ']';
end;

procedure TTKCombobox.setAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    setValue(Name + 'CV', asString(Value))
  else if Attr = 'Values' then
    inherited setAttribute(Attr, getListItems, 'Source')
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

procedure TTKCombobox.setRValue(aValue: string);
begin
  if FValue <> aValue then begin
    FValue:= aValue;
    Invalidate;
  end;
end;

procedure TTKCombobox.setValues(Values: TStrings);
begin
  FValues.Assign(Values);
  Invalidate;
end;

procedure TTKCombobox.NewWidget(Widget: String = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Combobox');
  MakeControlVar('textvariable', Name + 'CV', FValue);
  InsertValue('self.' + Name + '[' + asString('values') + '] = ' + getListItems);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKCombobox.DeleteWidget;
begin
  inherited;
  if FPostCommand then Partner.DeleteMethod(Name + '_PostCommand');
end;

procedure TTKCombobox.Paint;
  var s: string; x, y, newHeight: integer;
begin
  Canvas.Pen.Color:= $7A7A7A;
  inherited;
  if FValue <> ''
    then s:= FValue
    else if FValues.Count > 0
      then s:= FValues[0]
      else s:= '';
  if Scrollbar
    then newHeight:= Height - 20
    else newHeight:= Height;
  ShowText(s, Width - 16, newHeight);

  x:= Width - 14;
  y:= newHeight div 2 - 2;
  Canvas.Pen.Color:= $F1F1F1;
  Canvas.MoveTo(x, y);
  Canvas.LineTo(x + 4, y + 4);
  Canvas.LineTo(x + 5, y + 4);
  Canvas.LineTo(x + 10, y -1);

  Canvas.Pen.Color:= $5C5C5C;
  x:= x + 1;
  Canvas.MoveTo(x, y);
  Canvas.LineTo(x + 3, y + 3);
  Canvas.LineTo(x + 4, y + 3);
  Canvas.LineTo(x + 8, y - 1);

  y:= y - 1;
  Canvas.Pen.Color:= $ADADAD;
  Canvas.MoveTo(x, y);
  Canvas.LineTo(x + 3, y + 3);
  Canvas.LineTo(x + 4, y + 3);
  Canvas.LineTo(x + 8, y - 1);
  PaintAScrollbar(Scrollbar);
end;

end.

