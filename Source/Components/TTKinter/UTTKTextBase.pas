{ -------------------------------------------------------------------------------
  Unit:     UTTKTextBase
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  TKKinter text widgets
  ------------------------------------------------------------------------------- }

unit UTTKTextBase;

{ class hierarchy

  TKTextBaseWidget
  TTKEntry
  TKSpinbox
  TTKCombobox
}

interface

uses
  Classes,
  UTTKWidgets;

type

  // for disabeling  - different to TButtonState in TKButtonBase
  TTextState = (disabled, normal, readonly);

  TActiveStyle = (_TS_underline, _TS_dotbox, _TS_none);

  TSelectMode = (browse, single, multiple, extended);

  TValidate = (_TV_none, _TV_all, _TV_key, _TV_focus, _TV_focusin,
    _TV_focusout);

  TTKTextBaseWidget = class(TTKWidget)
  private
    FExportSelection: Boolean;
    FInvalidCommand: Boolean;
    FState: TTextState;
    FValidate: TValidate;
    FValidateCommand: Boolean;
    procedure SetState(aValue: TTextState);
  public
    constructor Create(Owner: TComponent); override;
    procedure DeleteWidget; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure MakeCommand(Attr, Value: string); override;
    procedure Paint; override;
  published
    property ExportSelection: Boolean read FExportSelection
      write FExportSelection default True;
    property Font;
    property Foreground;
    property InvalidCommand: Boolean read FInvalidCommand write FInvalidCommand;
    property Justify;
    property Scrollbar;
    property State: TTextState read FState write SetState default normal;
    property Validate: TValidate read FValidate write FValidate
      default _TV_none;
    property ValidateCommand: Boolean read FValidateCommand
      write FValidateCommand;
  end;

  TTKEntry = class(TTKTextBaseWidget)
  private
    FShow: Boolean;
    FText: string;
  public
    constructor Create(Owner: TComponent); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure SetText(Value: string); override;
    procedure Paint; override;
  published
    property Show: Boolean read FShow write FShow default True;
    property Text: string read FText write SetText;
    property TakeFocus;
  end;

  TTKSpinbox = class(TTKTextBaseWidget)
  private
    FFormat: string;
    FFrom: string;
    FIncrement: string;
    FTo: string;
    FValue: string;
    FValues: TStrings;
    procedure SetValues(Values: TStrings);
    procedure SetRValue(Value: string);
    procedure MakeValues;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Command;
    property Format: string read FFormat write FFormat;
    property From_: string read FFrom write FFrom;
    property Increment: string read FIncrement write FIncrement;
    property TakeFocus;
    property _To: string read FTo write FTo;
    property Values: TStrings read FValues write SetValues;
    property Value: string read FValue write SetRValue;
  end;

  TTKCombobox = class(TTKTextBaseWidget)
  private
    FPostCommand: Boolean;
    FValue: string;
    FValues: TStrings;
    procedure SetRValue(Value: string);
    procedure SetValues(Values: TStrings);
    function GetListItems: string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
    procedure DeleteWidget; override;
    procedure Paint; override;
  published
    property PostCommand: Boolean read FPostCommand write FPostCommand;
    property TakeFocus;
    property Value: string read FValue write SetRValue;
    property Values: TStrings read FValues write SetValues;
  end;

implementation

uses
  Controls,
  Graphics,
  SysUtils,
  Types,
  UITypes,
  UBaseTKWidgets,
  UUtils;

{ --- TButtonBaseWidget -------------------------------------------------------- }

constructor TTKTextBaseWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FExportSelection := True;
  FState := normal;
  FValidate := _TV_none;
  Cursor := crIBeam;
  Justify := _TJ_left;
  Relief := _TR_solid;
end;

procedure TTKTextBaseWidget.DeleteWidget;
begin
  inherited;
  if FInvalidCommand then
    Partner.DeleteMethod(Name + '_InvalidCommand');
  if FValidateCommand then
    Partner.DeleteMethod(Name + '_ValidateCommand');
end;

procedure TTKTextBaseWidget.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Scrollbar' then
    MakeScrollbar(Value, 'ttk.')
  else
    inherited;
end;

function TTKTextBaseWidget.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Background|Show';
  if ShowAttributes >= 2 then
    Result := Result + '|Justify|Scrollbar|State';
  if ShowAttributes = 3 then
    Result := Result + '|ExportSelection|Foreground' +
      '|InvalidCommand|Validate|ValidateCommand';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TTKTextBaseWidget.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetMouseEvents(ShowEvents);
end;

procedure TTKTextBaseWidget.MakeCommand(Attr, Value: string);
begin
  inherited;
  if Attr = 'ValidateCommand' then
    AddParameter(Value, 'why, where, what');
end;

procedure TTKTextBaseWidget.Paint;
begin
  if FState = normal then
    Background := clWindow
  else
    Background := clBtnFace;
  inherited;
end;

procedure TTKTextBaseWidget.SetState(aValue: TTextState);
begin
  if aValue <> FState then
  begin
    FState := aValue;
    Invalidate;
  end;
end;

{ --- TTKEntry ----------------------------------------------------------------- }

constructor TTKEntry.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 32;
  Width := 80;
  Height := 24;
  FShow := True;
end;

procedure TTKEntry.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Entry');
  MakeControlVar('textvariable', Name + 'CV', FText);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKEntry.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Text' then // different from Button.Text
    SetValue(Name + 'CV', AsString(Value))
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

function TTKEntry.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Text' + inherited GetAttributes(ShowAttributes);
end;

function TTKEntry.GetEvents(ShowEvents: Integer): string;
begin
  Result := GetKeyboardEvents(ShowEvents);
end;

procedure TTKEntry.SetText(Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    Invalidate;
  end;
end;

procedure TTKEntry.Paint;
var
  NewHeight: Integer;
begin
  Canvas.Pen.Color := $7A7A7A;
  inherited; // shows no text, because FText of TKWidget is overridden
  if Scrollbar then
    NewHeight := Height - 20
  else
    NewHeight := Height;
  ShowText(FText, Width, NewHeight);
  PaintAScrollbar(Scrollbar);
end;

{ --- TTKSpinbox ---------------------------------------------------------------- }

constructor TTKSpinbox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 39;
  Width := 40;
  Height := 24;
  FFrom := '0';
  FTo := '0';
  FValue := '0';
  FIncrement := '1';
  FValues := TStringList.Create;
end;

destructor TTKSpinbox.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

procedure TTKSpinbox.MakeValues;
var
  Str, Value, AllValues: string;
begin
  Str := 'self.' + Name + '[''values'']';
  AllValues := '[';
  for var I := 0 to FValues.Count - 1 do
  begin
    Value := Trim(FValues[I]);
    if Value = '' then
      Continue;
    AllValues := AllValues + AsString(Value) + ', ';
  end;
  if Copy(AllValues, Length(AllValues) - 1, 2) = ', ' then
    Delete(AllValues, Length(AllValues) - 1, 2);
  AllValues := AllValues + ']';
  SetAttributValue(Str, Str + ' = ' + AllValues);
end;

procedure TTKSpinbox.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    SetValue(Name + 'CV', AsString(Value))
  else if Attr = 'Values' then
    MakeValues
  else
    inherited;
end;

function TTKSpinbox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|From_|_To|Increment|Values|Value';
  if ShowAttributes >= 2 then
    Result := Result + '|Command|Format';
  if ShowAttributes = 3 then
    Result := Result + '|Exportselection';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TTKSpinbox.SetValues(Values: TStrings);
begin
  FValues.Assign(Values);
  Invalidate;
end;

procedure TTKSpinbox.SetRValue(Value: string);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

procedure TTKSpinbox.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Spinbox');
  MakeControlVar('textvariable', Name + 'CV', FValue);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKSpinbox.Paint;
var
  Str: string;
  XPos, YPos, NewHeight: Integer;
  Points: array [0 .. 2] of TPoint;
  ARect: TRect;
begin
  Canvas.Pen.Color := $7A7A7A;
  inherited;
  // paint number/value
  if FValue <> '' then
    Str := FValue
  else if FValues.Count > 0 then
    Str := FValues[0]
  else
    Str := FFrom;
  if Scrollbar then
    NewHeight := Height - PPIScale(20)
  else
    NewHeight := Height;
  ShowText(Str, Width - PPIScale(16), NewHeight);

  // paint up/down
  Canvas.Brush.Color := $F0F0F0;
  Canvas.Pen.Color := $ACACAC;

  ARect := Rect(Width - PPIScale(19), 2, Width - 2, PPIScale(11));
  Canvas.FillRect(ARect);
  ARect.Inflate(-1, -1);
  Canvas.Rectangle(ARect);

  ARect := Rect(Width - PPIScale(19), NewHeight - PPIScale(11), Width - 2,
    NewHeight - 2);
  Canvas.FillRect(ARect);
  ARect.Inflate(-1, -1);
  Canvas.Rectangle(ARect);

  Canvas.Brush.Color := clBlack;
  Canvas.Pen.Color := clBlack;
  XPos := Width - PPIScale(13);
  YPos := PPIScale(7);
  var
  Int2 := PPIScale(2);
  var
  Int4 := PPIScale(4);
  Points[0] := Point(XPos, YPos);
  Points[1] := Point(XPos + Int4, YPos);
  Points[2] := Point(XPos + Int2, YPos - Int2);
  Canvas.Polygon(Points);

  YPos := NewHeight - PPIScale(8);
  Points[0] := Point(XPos, YPos);
  Points[1] := Point(XPos + Int4, YPos);
  Points[2] := Point(XPos + Int2, YPos + Int2);
  Canvas.Polygon(Points);
  PaintAScrollbar(Scrollbar);
end;

{ --- TKKCombobox -------------------------------------------------------------- }

constructor TTKCombobox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 38;
  Width := 80;
  Height := 24;
  Foreground := clBtnText;
  FValues := TStringList.Create;
  FValues.Text := DefaultItems;
end;

destructor TTKCombobox.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

function TTKCombobox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Value|Values';
  if ShowAttributes >= 2 then
    Result := Result + '|PostCommand';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TTKCombobox.GetListItems: string;
var
  Str: string;
begin
  Str := '[';
  for var I := 0 to FValues.Count - 1 do
    Str := Str + AsString(FValues[I]) + ', ';
  Delete(Str, Length(Str) - 1, 2);
  Result := Str + ']';
end;

procedure TTKCombobox.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'Value' then
    SetValue(Name + 'CV', AsString(Value))
  else if Attr = 'Values' then
    inherited SetAttribute(Attr, GetListItems, 'Source')
  else if Attr = 'ValidateCommand' then
    MakeValidateCommand(Attr, Value)
  else
    inherited;
end;

procedure TTKCombobox.SetRValue(Value: string);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

procedure TTKCombobox.SetValues(Values: TStrings);
begin
  FValues.Assign(Values);
  Invalidate;
end;

procedure TTKCombobox.NewWidget(Widget: string = '');
begin
  Partner.ActiveSynEdit.BeginUpdate;
  inherited NewWidget('ttk.Combobox');
  MakeControlVar('textvariable', Name + 'CV', FValue);
  InsertValue('self.' + Name + '[' + AsString('values') + '] = ' +
    GetListItems);
  Partner.ActiveSynEdit.EndUpdate;
end;

procedure TTKCombobox.DeleteWidget;
begin
  inherited;
  if FPostCommand then
    Partner.DeleteMethod(Name + '_PostCommand');
end;

procedure TTKCombobox.Paint;
var
  Str: string;
  XPos, YPos, NewHeight, Int3, Int4, Int5, Int8, Int10: Integer;
begin
  Canvas.Pen.Color := $7A7A7A;
  inherited;
  Int3 := PPIScale(3);
  Int4 := PPIScale(4);
  Int5 := PPIScale(5);
  Int8 := PPIScale(8);
  Int10 := PPIScale(10);
  if FValue <> '' then
    Str := FValue
  else if FValues.Count > 0 then
    Str := FValues[0]
  else
    Str := '';
  if Scrollbar then
    NewHeight := Height - 20
  else
    NewHeight := Height;
  ShowText(Str, Width - PPIScale(16), NewHeight);

  XPos := Width - PPIScale(14);
  YPos := NewHeight div 2 - 2;
  Canvas.Pen.Color := $F1F1F1;
  Canvas.MoveTo(XPos, YPos);
  Canvas.LineTo(XPos + Int4, YPos + Int4);
  Canvas.LineTo(XPos + Int5, YPos + Int4);
  Canvas.LineTo(XPos + Int10, YPos - 1);

  Canvas.Pen.Color := $5C5C5C;
  XPos := XPos + 1;
  Canvas.MoveTo(XPos, YPos);
  Canvas.LineTo(XPos + Int3, YPos + Int3);
  Canvas.LineTo(XPos + Int4, YPos + Int3);
  Canvas.LineTo(XPos + Int8, YPos - 1);

  YPos := YPos - 1;
  Canvas.Pen.Color := $ADADAD;
  Canvas.MoveTo(XPos, YPos);
  Canvas.LineTo(XPos + Int3, YPos + Int3);
  Canvas.LineTo(XPos + Int4, YPos + Int3);
  Canvas.LineTo(XPos + Int8, YPos - 1);
  PaintAScrollbar(Scrollbar);
end;

end.
