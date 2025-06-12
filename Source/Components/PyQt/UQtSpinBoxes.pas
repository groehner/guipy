{ -------------------------------------------------------------------------------
  Unit:     UQtSpinBoxes
  Author:   Gerhard Röhner
  Date:     July 2022
  Purpose:  PyQt spin boxes
  ------------------------------------------------------------------------------- }
unit UQtSpinBoxes;

{ classes
  TQtAbstractSpinBox
  TQtSpinBox
  TQtDoubleSpinBox
  TQtDateTimeEdit
  TQtDateEdit
  TQTTimeEdit
}

interface

uses
  Windows,
  Classes,
  UBaseQtWidgets;

type

  TButtonSymbols = (UpDownArrows, PlusMinus, NoButtons);

  TCorrectionMode = (CorrectToPreviousValue, CorrectToNearestValue);

  TStepType = (DefaultStepType, AdaptiveDecimalStepType);

  TAlignment = (AlignLeft, AlignRight, AlignHCenter);

  TCurrentSection = (NoSection, AmPmSection, MSecSection, SecondSection,
    MinuteSection, HourSection, DaySection, MonthSection, YearSection,
    TimeSections_Mask, DateSections_Mask);

  TTimeSpec = (LocalTime, UTC, OffsetFromUTC, TimeZone);

  TQtAbstractSpinBox = class(TBaseQtWidget)
  private
    FWrapping: Boolean;
    FFrame: Boolean;
    FAlignment: TAlignment;
    FReadOnly: Boolean;
    FButtonSymbols: TButtonSymbols;
    FSpecialValueText: string;
    FAccelerated: Boolean;
    FCorrectionMode: TCorrectionMode;
    FKeyboardTracking: Boolean;
    FShowGroupSeparator: Boolean;
    FEditingFinished: string;
    procedure SetFrame(Value: Boolean);
    procedure SetButtonSymbols(Value: TButtonSymbols);
    procedure SetShowGroupSeparator(Value: Boolean);
    procedure SetSpecialValueText(Value: string);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure Paint; override;
    function InnerRect: TRect; override;
  published
    property Wrapping: Boolean read FWrapping write FWrapping;
    property Frame: Boolean read FFrame write SetFrame;
    property Alignment: TAlignment read FAlignment write FAlignment;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property ButtonSymbols: TButtonSymbols read FButtonSymbols
      write SetButtonSymbols;
    property SpecialValueText: string read FSpecialValueText
      write SetSpecialValueText;
    property Accelerated: Boolean read FAccelerated write FAccelerated;
    property CorrectionMode: TCorrectionMode read FCorrectionMode
      write FCorrectionMode;
    property KeyboardTracking: Boolean read FKeyboardTracking
      write FKeyboardTracking;
    property ShowGroupSeparator: Boolean read FShowGroupSeparator
      write SetShowGroupSeparator;
    // signals
    property editingFinished: string read FEditingFinished
      write FEditingFinished;
  end;

  TQtSpinBox = class(TQtAbstractSpinBox)
  private
    FPrefix: string;
    FSuffix: string;
    FMinimum: Integer;
    FMaximum: Integer;
    FSingleStep: Integer;
    FStepType: TStepType;
    FValue: Integer;
    FDisplayIntegerBase: Integer;
    FTextChanged: string;
    FValueChanged: string;
    procedure SetPrefix(Value: string);
    procedure SetSuffix(Value: string);
    procedure SetValue(Value: Integer);
    procedure SetDisplayIntegerBase(Value: Integer);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Prefix: string read FPrefix write SetPrefix;
    property Suffix: string read FSuffix write SetSuffix;
    property Minimum: Integer read FMinimum write FMinimum;
    property Maximum: Integer read FMaximum write FMaximum;
    property SingleStep: Integer read FSingleStep write FSingleStep;
    property StepType: TStepType read FStepType write FStepType;
    property Value: Integer read FValue write SetValue;
    property DisplayIntegerBase: Integer read FDisplayIntegerBase
      write SetDisplayIntegerBase;
    // signals
    property textChanged: string read FTextChanged write FTextChanged;
    property valueChanged: string read FValueChanged write FValueChanged;
  end;

  TQtDoubleSpinBox = class(TQtAbstractSpinBox)
  private
    FPrefix: string;
    FSuffix: string;
    FDecimals: Integer;
    FMinimum: Double;
    FMaximum: Double;
    FSingleStep: Double;
    FStepType: TStepType;
    FValue: Double;
    FTextChanged: string;
    FValueChanged: string;
    procedure SetPrefix(Value: string);
    procedure SetSuffix(Value: string);
    procedure SetValue(Value: Double);
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Prefix: string read FPrefix write SetPrefix;
    property Suffix: string read FSuffix write SetSuffix;
    property Decimals: Integer read FDecimals write FDecimals;
    property Minimum: Double read FMinimum write FMinimum;
    property Maximum: Double read FMaximum write FMaximum;
    property SingleStep: Double read FSingleStep write FSingleStep;
    property StepType: TStepType read FStepType write FStepType;
    property Value: Double read FValue write SetValue;
    // signals
    property textChanged: string read FTextChanged write FTextChanged;
    property valueChanged: string read FValueChanged write FValueChanged;
  end;

  TQtDateTimeEdit = class(TQtAbstractSpinBox)
  private
    FDateTime: string;
    FDate: string;
    FTime: string;
    FMaximumDateTime: string;
    FMinimumDateTime: string;
    FMaximumDate: string;
    FMinimumDate: string;
    FMaximumTime: string;
    FMinimumTime: string;
    FCurrentSection: TCurrentSection;
    FDisplayFormat: string;
    FCalendarPopup: Boolean;
    FCurrentSectionIndex: Integer;
    FTimeSpec: TTimeSpec;
    FFormat: string;
    FDateChanged: string;
    FDateTimeChanged: string;
    FTimeChanged: string;
    procedure SetDateTime(Value: string);
    procedure SetDate(Value: string);
    procedure SetTime(Value: string);
    procedure SetDisplayFormat(Value: string);
    procedure MakeDateTime(Value: string);
    procedure MakeDate(Value: string);
    procedure MakeTime(Value: string);
  protected
    procedure ShowValue(Value: string);
    function DateTimeFromDisplayFormat: string; virtual;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure SetAttribute(Attr, Value, Typ: string); override;
    function GetEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const Event: string): string; override;
    procedure GetSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property DateTime: string read FDateTime write SetDateTime;
    property Date: string read FDate write SetDate;
    property Time: string read FTime write SetTime;
    property MaximumDateTime: string read FMaximumDateTime
      write FMaximumDateTime;
    property MinimumDateTime: string read FMinimumDateTime
      write FMinimumDateTime;
    property MaximumDate: string read FMaximumDate write FMaximumDate;
    property MinimumDate: string read FMinimumDate write FMinimumDate;
    property MaximumTime: string read FMaximumTime write FMaximumTime;
    property MinimumTime: string read FMinimumTime write FMinimumTime;
    property CurrentSection: TCurrentSection read FCurrentSection
      write FCurrentSection;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property CalendarPopup: Boolean read FCalendarPopup write FCalendarPopup;
    property CurrentSectionIndex: Integer read FCurrentSectionIndex
      write FCurrentSectionIndex;
    property TimeSpec: TTimeSpec read FTimeSpec write FTimeSpec;
    // signals
    property dateChanged: string read FDateChanged write FDateChanged;
    property dateTimeChanged: string read FDateTimeChanged
      write FDateTimeChanged;
    property timeChanged: string read FTimeChanged write FTimeChanged;
  end;

  TQtDateEdit = class(TQtDateTimeEdit)
  protected
    function DateTimeFromDisplayFormat: string; override;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
  end;

  TQtTimeEdit = class(TQtDateTimeEdit)
  protected
    function DateTimeFromDisplayFormat: string; override;
  public
    constructor Create(Owner: TComponent); override;
    function GetAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
  end;

implementation

uses
  Controls,
  Graphics,
  SysUtils,
  Types,
  DateUtils,
  JvGnugettext,
  UUtils;

{ --- TQtAbstractSpinBox ------------------------------------------------------- }

constructor TQtAbstractSpinBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FFrame := True;
  Height := 24;
  Width := 80;
end;

function TQtAbstractSpinBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '';
  if ShowAttributes >= 2 then
    Result := Result + '|Frame|Wrapping|ButtonSymbols|ShowGroupSeparator';
  if ShowAttributes = 3 then
    Result := Result + '|Alignment|ReadOnly|KeyboardTracking' +
      '|SpecialValueText|Accelerated|CorrectionMode';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtAbstractSpinBox.SetAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'ButtonSymbols') or (Attr = 'CorrectionMode') or (Attr = 'StepType')
  then
    MakeAttribut(Attr, 'QAbstractSpinBox.' + Attr + '.' + Value)
  else if Attr = 'Alignment' then
    MakeAttribut(Attr, 'Qt.AlignmentFlag.' + Value)
  else if Attr = 'ShowGroupSeparator' then
    SetAttribute('GroupSeparatorShown', Value, Typ)
  else
    inherited;
end;

function TQtAbstractSpinBox.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|editingFinished';
  Result := Result + inherited GetEvents(ShowEvents);
end;

procedure TQtAbstractSpinBox.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then
  begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.stepDown');
    Slots.Add(Name + '.stepUp');
  end;
  inherited;
end;

procedure TQtAbstractSpinBox.Paint;
var
  ARect: TRect;
  Points: array [0 .. 2] of TPoint;
  XPos, YPos: Integer;
begin
  inherited;

  if FButtonSymbols <> NoButtons then
  begin
    // paint boxes
    ARect := inherited InnerRect;
    ARect.Left := ARect.Right - PPIScale(16);
    ARect.Inflate(-1, -1);
    Canvas.Pen.Color := $ACACAC;
    Canvas.Brush.Color := $E7E7E7;
    Canvas.Rectangle(ARect);
    Canvas.MoveTo(ARect.Left, Height div 2);
    Canvas.LineTo(ARect.Right, Height div 2);

    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color := clBlack;
    var
    Int2 := PPIScale(2);
    var
    Int3 := PPIScale(3);
    var
    Int4 := PPIScale(4);
    var
    Int5 := PPIScale(5);
    XPos := ARect.Left + Int4;
    if FButtonSymbols = UpDownArrows then
    begin
      // paint up/down
      YPos := (ARect.Top + Height div 2) div 2 + 1;
      Points[0] := Point(XPos, YPos);
      Points[1] := Point(XPos + Int4, YPos);
      Points[2] := Point(XPos + Int2, YPos - Int2);
      Canvas.Polygon(Points);
      YPos := (Height div 2 + ARect.Bottom) div 2 - 1;
      Points[0] := Point(XPos, YPos);
      Points[1] := Point(XPos + Int4, YPos);
      Points[2] := Point(XPos + Int2, YPos + Int2);
      Canvas.Polygon(Points);
    end
    else
    begin
      YPos := (ARect.Top + Height div 2) div 2;
      Canvas.MoveTo(XPos, YPos);
      Canvas.LineTo(XPos + Int5, YPos);
      Canvas.MoveTo(XPos + Int2, YPos - Int2);
      Canvas.LineTo(XPos + Int2, YPos + Int3);
      YPos := (Height div 2 + ARect.Bottom) div 2;
      Canvas.MoveTo(XPos, YPos);
      Canvas.LineTo(XPos + 5, YPos);
    end;
  end;
end;

function TQtAbstractSpinBox.InnerRect: TRect;
begin
  Result := inherited InnerRect;
  if FButtonSymbols <> NoButtons then
    Result.Right := Result.Right - 16;
end;

procedure TQtAbstractSpinBox.SetFrame(Value: Boolean);
begin
  if Value <> FFrame then
  begin
    FFrame := Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSpinBox.SetButtonSymbols(Value: TButtonSymbols);
begin
  if Value <> FButtonSymbols then
  begin
    FButtonSymbols := Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSpinBox.SetShowGroupSeparator(Value: Boolean);
begin
  if Value <> FShowGroupSeparator then
  begin
    FShowGroupSeparator := Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSpinBox.SetSpecialValueText(Value: string);
begin
  if Value <> FSpecialValueText then
  begin
    FSpecialValueText := Value;
    Invalidate;
  end;
end;

{ --- TQtSpinBox --------------------------------------------------------------- }

constructor TQtSpinBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 79;
  Width := 40;
  FMaximum := 99;
  FSingleStep := 1;
  FDisplayIntegerBase := 10;
end;

function TQtSpinBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Minimum|Maximum|SingleStep|Value';
  if ShowAttributes >= 2 then
    Result := Result + '|Suffix|Prefix';
  if ShowAttributes = 3 then
    Result := Result + '|StepType|DisplayIntegerBase';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TQtSpinBox.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|textChanged|valueChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtSpinBox.HandlerInfo(const Event: string): string;
begin
  if Event = 'textChanged' then
    Result := 'QString;text'
  else if Event = 'valueChanged' then
    Result := 'int;I'
  else
    Result := inherited;
end;

procedure TQtSpinBox.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'int' then
    Slots.Add(Name + '.setValue');
  inherited;
end;

procedure TQtSpinBox.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QSpinBox');
end;

procedure TQtSpinBox.Paint;
var
  Align: Integer;
  Str: string;
  ARect: TRect;
begin
  Canvas.Brush.Color := clWhite;
  if FFrame then
    Canvas.Pen.Color := $7A7A7A
  else
    Canvas.Pen.Color := clWhite;
  Canvas.Rectangle(ClientRect);

  inherited;

  Canvas.Brush.Color := clWhite;
  if FShowGroupSeparator then
    Str := Format('%.0n', [FValue * 1.0])
  else
    Str := IntToStr(FValue);
  if FDisplayIntegerBase <> 10 then
  begin
    Str := IntToStr(FValue);
    Str := DecToBase(FDisplayIntegerBase, FValue);
  end;
  Str := FPrefix + Str + FSuffix;
  if (FValue = FMinimum) and (FSpecialValueText <> '') then
    Str := FSpecialValueText;
  ARect := InnerRect;
  ARect.Left := ARect.Left + HalfX;
  ARect.Right := ARect.Right - HalfX;
  ARect.Top := (ARect.Bottom - ARect.Top - Canvas.TextHeight('A')) div 2 + 1;
  case Alignment of
    AlignLeft:
      Align := DT_LEFT;
    AlignRight:
      Align := DT_RIGHT;
  else
    Align := DT_CENTER;
  end;
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, Align);
end;

procedure TQtSpinBox.SetPrefix(Value: string);
begin
  if Value <> FPrefix then
  begin
    FPrefix := Value;
    Invalidate;
  end;
end;

procedure TQtSpinBox.SetSuffix(Value: string);
begin
  if Value <> FSuffix then
  begin
    FSuffix := Value;
    Invalidate;
  end;
end;

procedure TQtSpinBox.SetValue(Value: Integer);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

procedure TQtSpinBox.SetDisplayIntegerBase(Value: Integer);
begin
  if Value <> FDisplayIntegerBase then
  begin
    FDisplayIntegerBase := Value;
    Invalidate;
  end;
end;

{ --- TQtDoubleSpinBox --------------------------------------------------------- }

constructor TQtDoubleSpinBox.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  Tag := 106;
  FDecimals := 2;
  FMaximum := 99.99;
  FSingleStep := 1;
end;

function TQtDoubleSpinBox.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Minimum|Maximum|SingleStep|Value|Decimals';
  if ShowAttributes >= 2 then
    Result := Result + '|Suffix|Prefix|StepType';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

function TQtDoubleSpinBox.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|textChanged|valueChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtDoubleSpinBox.HandlerInfo(const Event: string): string;
begin
  if Event = 'textChanged' then
    Result := 'QString;text'
  else if Event = 'valueChanged' then
    Result := 'double;d'
  else
    Result := inherited;
end;

procedure TQtDoubleSpinBox.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'double' then
    Slots.Add(Name + '.setValue');
  inherited;
end;

procedure TQtDoubleSpinBox.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QDoubleSpinBox');
end;

procedure TQtDoubleSpinBox.Paint;
var
  Align: Integer;
  Str: string;
  ARect: TRect;
begin
  Canvas.Brush.Color := clWhite;
  if FFrame then
    Canvas.Pen.Color := $7A7A7A
  else
    Canvas.Pen.Color := clWhite;
  Canvas.Rectangle(ClientRect);

  inherited;

  Canvas.Brush.Color := clWhite;
  if FShowGroupSeparator then
    Str := Format('%.' + IntToStr(FDecimals) + 'n', [FValue])
  else
    Str := Format('%.' + IntToStr(FDecimals) + 'f', [FValue]);
  Str := FPrefix + Str + FSuffix;
  if (FValue = FMinimum) and (FSpecialValueText <> '') then
    Str := FSpecialValueText;
  ARect := InnerRect;
  ARect.Left := ARect.Left + HalfX;
  ARect.Right := ARect.Right - HalfX;
  ARect.Top := (ARect.Bottom - ARect.Top - Canvas.TextHeight('A')) div 2 + 1;
  case Alignment of
    AlignLeft:
      Align := DT_LEFT;
    AlignRight:
      Align := DT_RIGHT;
  else
    Align := DT_CENTER;
  end;
  DrawText(Canvas.Handle, PChar(Str), Length(Str), ARect, Align);
end;

procedure TQtDoubleSpinBox.SetPrefix(Value: string);
begin
  if Value <> FPrefix then
  begin
    FPrefix := Value;
    Invalidate;
  end;
end;

procedure TQtDoubleSpinBox.SetSuffix(Value: string);
begin
  if Value <> FSuffix then
  begin
    FSuffix := Value;
    Invalidate;
  end;
end;

procedure TQtDoubleSpinBox.SetValue(Value: Double);
begin
  if Value <> FValue then
  begin
    FValue := Value;
    Invalidate;
  end;
end;

{ --- TQtDateTimeEdit ---------------------------------------------------------- }

constructor TQtDateTimeEdit.Create(Owner: TComponent);
var
  FormatSet: TFormatSettings;
  DateTime: TDateTime;
begin
  inherited Create(Owner);
  Tag := 108;
  Width := 128;
  FormatSet := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FFormat := MyStringReplace(FormatSet.ShortDateFormat + ' ' +
    FormatSet.LongTimeFormat, '/', FormatSet.DateSeparator);
  FDisplayFormat := FFormat;
  DateTime := Now;
  FDateTime := DateTimeToStr(DateTime);
  FDate := DateToStr(DateTime);
  FTime := TimeToStr(DateTime);
  FMaximumDateTime := DateTimeToStr(EncodeDateTime(9999, 12, 31, 23,
    59, 59, 0));
  FMinimumDateTime := DateTimeToStr(EncodeDateTime(1752, 9, 14, 0, 0, 0, 0));
  FMaximumDate := DateToStr(EncodeDateTime(9999, 12, 31, 0, 0, 0, 0));
  FMinimumDate := DateToStr(EncodeDateTime(1752, 9, 14, 0, 0, 0, 0));
  FMaximumTime := TimeToStr(EncodeDateTime(1, 1, 1, 23, 59, 59, 999));
  FMinimumTime := TimeToStr(EncodeDateTime(1, 1, 1, 0, 0, 0, 0));
  FCurrentSection := DaySection;
  FTimeSpec := LocalTime;
end;

function TQtDateTimeEdit.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|DateTime|MaximumDateTime|MinimumDateTime|DisplayFormat';
  if ShowAttributes >= 2 then
    Result := Result + '|Date|Time|MaximumDate|MinimumDate|MaximumTime' +
      '|MinimumTime|CurrentSection|CalendarPopup' +
      '|CurrentSectionIndex|TimeSpec';
  Result := Result + inherited GetAttributes(ShowAttributes);
end;

procedure TQtDateTimeEdit.SetAttribute(Attr, Value, Typ: string);
begin
  if Attr = 'DateTime' then
    MakeDateTime(Value)
  else if Attr = 'Date' then
    MakeDate(Value)
  else if Attr = 'Time' then
    MakeTime(Value)
  else if Attr = 'CurrentSection' then
    MakeAttribut(Attr, 'QDateTimeEdit.Section.' + Value)
  else if Attr = 'TimeSpec' then
    MakeAttribut(Attr, 'Qt.TimeSpec.' + Value)
  else
    inherited;
end;

function TQtDateTimeEdit.GetEvents(ShowEvents: Integer): string;
begin
  Result := '|dateChanged|dateTimeChanged|timeChanged';
  Result := Result + inherited GetEvents(ShowEvents);
end;

function TQtDateTimeEdit.HandlerInfo(const Event: string): string;
begin
  if Event = 'dateChanged' then
    Result := 'QDate;date'
  else if Event = 'dateTimeChanged' then
    Result := 'QDateTime;datetime'
  else if Event = 'timeChanged' then
    Result := 'QTime;time'
  else
    Result := inherited;
end;

procedure TQtDateTimeEdit.GetSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = 'QDate' then
    Slots.Add(Name + '.setDate')
  else if Parametertypes = 'QDateTime' then
    Slots.Add(Name + '.setDateTime')
  else if Parametertypes = 'QTime' then
    Slots.Add(Name + '.setTime');
  inherited;
end;

procedure TQtDateTimeEdit.NewWidget(Widget: string = '');
begin
  if Widget = '' then
  begin
    inherited NewWidget('QDateTimeEdit');
    MakeDateTime(FDateTime);
    SetAttribute('DisplayFormat', FDisplayFormat, 'string');
  end
  else
    inherited NewWidget(Widget);
end;

procedure TQtDateTimeEdit.MakeDateTime(Value: string);
var
  Key, Str: string;
  DateTime: TDateTime;
begin
  try
    DateTime := StrToDateTime(Value);
  except
    DateTime := Now;
    FDateTime := DateTimeToStr(DateTime);
    UpdateObjectInspector;
  end;
  FDate := DateToStr(DateTime);
  FTime := TimeToStr(DateTime);
  Key := 'self.' + Name + '.setDateTime';
  Str := Key + '(QDateTime.fromString(' + AsString(FDateTime) + ', ' +
    AsString(FFormat) + '))';
  SetAttributValue(Key, Str);
  UpdateObjectInspector;
end;

procedure TQtDateTimeEdit.MakeDate(Value: string);
var
  Key, Str: string;
  DateTime: TDateTime;
  Posi: Integer;
begin
  try
    DateTime := StrToDate(Value);
  except
    DateTime := Now;
  end;
  FDate := DateToStr(DateTime);
  Posi := Pos(' ', FDateTime);
  FDateTime := FDate + Copy(FDateTime, Posi, Length(FDateTime));
  Key := 'self.' + Name + '.setDateTime';
  Str := Key + '(QDateTime.fromString(' + AsString(FDateTime) + ', ' +
    AsString(FFormat) + '))';
  SetAttributValue(Key, Str);
  UpdateObjectInspector;
end;

procedure TQtDateTimeEdit.MakeTime(Value: string);
var
  Key, Str: string;
  DateTime: TDateTime;
  Posi: Integer;
begin
  try
    DateTime := StrToTime(Value);
  except
    DateTime := Now;
  end;
  FTime := TimeToStr(DateTime);
  Posi := Pos(' ', FDateTime);
  FDateTime := Copy(FDateTime, 1, Posi) + FTime;
  Key := 'self.' + Name + '.setDateTime';
  Str := Key + '(QDateTime.fromString(' + AsString(FDateTime) + ', ' +
    AsString(FFormat) + '))';
  SetAttributValue(Key, Str);
  UpdateObjectInspector;
end;

function TQtDateTimeEdit.DateTimeFromDisplayFormat: string;
var
  DateTime: TDateTime;
  FormatSet: TFormatSettings;
  Posi: Integer;
begin
  FormatSet := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  Posi := Pos(' ', FDisplayFormat);
  if Posi > 0 then
  begin
    FormatSet.ShortDateFormat := Copy(FDisplayFormat, 1, Posi - 1);
    FormatSet.LongTimeFormat := Copy(FDisplayFormat, Posi + 1,
      Length(FDisplayFormat));
  end;
  if TryStrToDateTime(FDateTime, DateTime, FormatSet) then
    Result := DateTimeToStr(DateTime, FormatSet)
  else
    Result := _('invalid date time format');
end;

procedure TQtDateTimeEdit.Paint;
begin
  Canvas.Brush.Color := clWhite;
  if FFrame then
    Canvas.Pen.Color := $7A7A7A
  else
    Canvas.Pen.Color := clWhite;
  Canvas.Rectangle(ClientRect);
  inherited;
  ShowValue(DateTimeFromDisplayFormat);
end;

procedure TQtDateTimeEdit.ShowValue(Value: string);
var
  Align: Integer;
  ARect: TRect;
begin
  Canvas.Brush.Color := clWhite;
  ARect := InnerRect;
  ARect.Left := ARect.Left + HalfX;
  ARect.Right := ARect.Right - HalfX;
  ARect.Top := (ARect.Bottom - ARect.Top - Canvas.TextHeight('A')) div 2 + 1;
  case Alignment of
    AlignLeft:
      Align := DT_LEFT;
    AlignRight:
      Align := DT_RIGHT;
  else
    Align := DT_CENTER;
  end;
  DrawText(Canvas.Handle, PChar(Value), Length(Value), ARect, Align);
end;

procedure TQtDateTimeEdit.SetDateTime(Value: string);
var
  Posi: Integer;
begin
  if Value <> FDateTime then
  begin
    FDateTime := Value;
    Posi := Pos(' ', FDateTime);
    if Posi > 0 then
    begin
      FDate := Trim(Copy(FDateTime, 1, Posi - 1));
      FTime := Trim(Copy(FDateTime, Posi + 1, Length(FDateTime)));
    end;
    Invalidate;
  end;
end;

procedure TQtDateTimeEdit.SetDate(Value: string);
begin
  if Value <> FDate then
  begin
    FDate := Value;
    FDateTime := FDate + ' ' + FTime;
    Invalidate;
  end;
end;

procedure TQtDateTimeEdit.SetTime(Value: string);
begin
  if Value <> FTime then
  begin
    FTime := Value;
    FDateTime := FDate + ' ' + FTime;
    Invalidate;
  end;
end;

procedure TQtDateTimeEdit.SetDisplayFormat(Value: string);
begin
  if Value <> FDisplayFormat then
  begin
    FDisplayFormat := Value;
    Invalidate;
  end;
end;

{ --- TQtDateEdit -------------------------------------------------------------- }

constructor TQtDateEdit.Create(Owner: TComponent);
var
  FormatSet: TFormatSettings;
begin
  inherited Create(Owner);
  Tag := 109;
  Width := 80;
  FormatSet := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FDisplayFormat := MyStringReplace(FormatSet.ShortDateFormat, '/',
    FormatSet.DateSeparator);
end;

function TQtDateEdit.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Date|MaximumDate|MinimumDate';
  if ShowAttributes >= 2 then
    Result := Result +
      '|DateTime|Time|MaximumDateTime|MinimumDateTime|MaximumTime' +
      '|MinimumTime|CurrentSection|CalendarPopup' +
      '|CurrentSectionIndex|TimeSpec';
  Result := Result + inherited GetAttributes(ShowAttributes);
  if ShowAttributes = 1 then
  begin
    var
    Posi := Pos('|DateTime', Result);
    Delete(Result, Posi, 41);
  end;
end;

procedure TQtDateEdit.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QDateEdit');
  SetAttribute('DisplayFormat', FDisplayFormat, 'string');
end;

function TQtDateEdit.DateTimeFromDisplayFormat: string;
var
  DateTime: TDateTime;
  FormatSet: TFormatSettings;
begin
  FormatSet := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FormatSet.ShortDateFormat := FDisplayFormat;
  if TryStrToDate(FDate, DateTime, FormatSet) then
    Result := DateTimeToStr(DateTime, FormatSet)
  else
    Result := _('invalid date format');
end;

{ --- TQtTimeEdit -------------------------------------------------------------- }

constructor TQtTimeEdit.Create(Owner: TComponent);
var
  FormatSet: TFormatSettings;
begin
  inherited Create(Owner);
  Tag := 110;
  Width := 80;
  FormatSet := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FDisplayFormat := FormatSet.LongTimeFormat;
end;

function TQtTimeEdit.GetAttributes(ShowAttributes: Integer): string;
begin
  Result := '|Time|MaximumTime|MinimumTime';
  if ShowAttributes >= 2 then
    Result := Result +
      '|DateTime|Date|MaximumDateTime|MinimumDateTime|MaximumDate' +
      '|MinimumDate|CurrentSection|CalendarPopup' +
      '|CurrentSectionIndex|TimeSpec';
  Result := Result + inherited GetAttributes(ShowAttributes);
  if ShowAttributes = 1 then
  begin
    var
    Posi := Pos('|DateTime', Result);
    Delete(Result, Posi, 41);
  end;
end;

procedure TQtTimeEdit.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QTimeEdit');
  SetAttribute('DisplayFormat', FDisplayFormat, 'string');
end;

function TQtTimeEdit.DateTimeFromDisplayFormat: string;
var
  DateTime: TDateTime;
  FormatSet: TFormatSettings;
  Posi: Integer;
begin
  FormatSet := TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FormatSet.LongTimeFormat := FDisplayFormat;
  if TryStrToTime(FTime, DateTime, FormatSet) then
  begin
    Result := DateTimeToStr(DateTime, FormatSet);
    Posi := Pos(' ', Result);
    if Posi > 0 then
      Result := Copy(Result, Posi + 1, Length(Result));
  end
  else
    Result := _('invalid time format');
end;

end.
