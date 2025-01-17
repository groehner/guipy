{-------------------------------------------------------------------------------
 Unit:     UQtSpinBoxes
 Author:   Gerhard Röhner
 Date:     July 2022
 Purpose:  PyQt spin boxes
-------------------------------------------------------------------------------}
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
  Windows, Classes, UBaseQtWidgets;

type

  TButtonSymbols = (UpDownArrows, PlusMinus, NoButtons);

  TCorrectionMode = (CorrectToPreviousValue, CorrectToNearestValue);

  TStepType = (DefaultStepType, AdaptiveDecimalStepType);

  TAlignment = (AlignLeft, AlignRight, AlignHCenter);

  TCurrentSection = (NoSection, AmPmSection, MSecSection, SecondSection,
                     MinuteSection, HourSection, DaySection, MonthSection,
                     YearSection, TimeSections_Mask, DateSections_Mask);

  TTimeSpec = (LocalTime, UTC, OffsetFromUTC, TimeZone);


  TQtAbstractSpinBox = class(TBaseQTWidget)
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
    procedure setFrame(Value: Boolean);
    procedure setButtonSymbols(Value: TButtonSymbols);
    procedure setShowGroupSeparator(Value: Boolean);
    procedure setSpecialValueText(Value: string);
  public
    constructor Create(aOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure Paint; override;
    function InnerRect: TRect; override;
  published
    property Wrapping: Boolean read FWrapping write FWrapping;
    property Frame: Boolean read FFrame write setFrame;
    property Alignment: TAlignment read FAlignment write FAlignment;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property ButtonSymbols: TButtonSymbols read FButtonSymbols write setButtonSymbols;
    property SpecialValueText: string read FSpecialValueText write setSpecialValueText;
    property Accelerated: Boolean read FAccelerated write FAccelerated;
    property CorrectionMode: TCorrectionMode read FCorrectionMode write FCorrectionMode;
    property KeyboardTracking: Boolean read FKeyboardTracking write FKeyboardTracking;
    property ShowGroupSeparator: Boolean read FShowGroupSeparator write setShowGroupSeparator;
    // signals
    property editingFinished: string read FEditingFinished write FEditingFinished;
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
    procedure setPrefix(Value: string);
    procedure setSuffix(Value: string);
    procedure setValue(Value: Integer);
    procedure setDisplayIntegerBase(Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Prefix: string read FPrefix write setPrefix;
    property Suffix: string read FSuffix write setSuffix;
    property Minimum: Integer read FMinimum write FMinimum;
    property Maximum: Integer read FMaximum write FMaximum;
    property SingleStep: Integer read FSingleStep write FSingleStep;
    property StepType: TStepType read FStepType write FStepType;
    property Value: Integer read FValue write setValue;
    property DisplayIntegerBase: Integer read FDisplayIntegerBase write setDisplayIntegerBase;
    // signals
    property textChanged: string read FTextChanged write FTextChanged;
    property valueChanged: string read FValueChanged write FValueChanged;
  end;

  TQtDoubleSpinBox = class(TQtAbstractSpinBox)
  private
    FPrefix: string;
    FSuffix: string;
    FDecimals: Integer;
    FMinimum: double;
    FMaximum: double;
    FSingleStep: double;
    FStepType: TStepType;
    FValue: double;
    FTextChanged: string;
    FValueChanged: string;
    procedure setPrefix(Value: string);
    procedure setSuffix(Value: string);
    procedure setValue(Value: double);
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property Prefix: string read FPrefix write setPrefix;
    property Suffix: string read FSuffix write setSuffix;
    property Decimals: Integer read FDecimals write FDecimals;
    property Minimum: double read FMinimum write FMinimum;
    property Maximum: double read FMaximum write FMaximum;
    property SingleStep: double read FSingleStep write FSingleStep;
    property StepType: TStepType read FStepType write FStepType;
    property Value: double read FValue write setValue;
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
    format: string;
    FDateChanged: string;
    FDateTimeChanged: string;
    FTimeChanged: string;
    procedure setDateTime(Value: string);
    procedure setDate(Value: string);
    procedure setTime(Value: string);
    procedure setDisplayFormat(Value: string);
    procedure MakeDateTime(Value: string);
    procedure MakeDate(Value: string);
    procedure MakeTime(Value: string);
  protected
    procedure ShowValue(Value: string);
    function DateTimeFromDisplayFormat: string; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure setAttribute(Attr, Value, Typ: string); override;
    function getEvents(ShowEvents: Integer): string; override;
    function HandlerInfo(const event: string): string; override;
    procedure getSlots(Parametertypes: string; Slots: TStrings); override;
    procedure NewWidget(Widget: string = ''); override;
    procedure Paint; override;
  published
    property DateTime: string read FDateTime write setDateTime;
    property Date: string read FDate write setDate;
    property Time: string read FTime write setTime;
    property MaximumDateTime: string read FMaximumDateTime write FMaximumDateTime ;
    property MinimumDateTime: string read FMinimumDateTime write FMinimumDateTime;
    property MaximumDate: string read FMaximumDate write FMaximumDate;
    property MinimumDate: string read FMinimumDate write FMinimumDate;
    property MaximumTime: string read FMaximumTime write FMaximumTime;
    property MinimumTime: string read FMinimumTime write FMinimumTime;
    property CurrentSection: TCurrentSection read FCurrentSection write FCurrentSection;
    property DisplayFormat: string read FDisplayFormat write setDisplayFormat;
    property CalendarPopup: Boolean read FCalendarPopup write FCalendarPopup;
    property CurrentSectionIndex: Integer read FCurrentSectionIndex write FCurrentSectionIndex;
    property TimeSpec: TTimeSpec read FTimeSpec write FTimeSpec;
    // signals
    property dateChanged: string read FDateChanged write FDateChanged;
    property dateTimeChanged: string read FDateTimeChanged write FDateTimeChanged;
    property timeChanged: string read FTimeChanged write FTimeChanged;
  end;

  TQtDateEdit = class(TQtDateTimeEdit)
  protected
    function DateTimeFromDisplayFormat: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
  end;

  TQtTimeEdit = class(TQtDateTimeEdit)
  protected
    function DateTimeFromDisplayFormat: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    function getAttributes(ShowAttributes: Integer): string; override;
    procedure NewWidget(Widget: string = ''); override;
  end;


implementation

uses Controls, Graphics, SysUtils, Types, DateUtils,
     JvGnugettext, UUtils;

{--- TQtAbstractSpinBox -------------------------------------------------------}

constructor TQtAbstractSpinBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FFrame:= True;
  Height:= 24;
  Width:= 80;
end;

function TQtAbstractSpinBox.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '';
  if ShowAttributes >= 2 then
    Result:= Result + '|Frame|Wrapping|ButtonSymbols|ShowGroupSeparator';
  if ShowAttributes = 3 then
    Result:= Result + '|Alignment|ReadOnly|KeyboardTracking' +
                      '|SpecialValueText|Accelerated|CorrectionMode';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtAbstractSpinBox.setAttribute(Attr, Value, Typ: string);
begin
  if (Attr = 'ButtonSymbols') or (Attr = 'CorrectionMode') or
     (Attr = 'StepType') then
    MakeAttribut(Attr, 'QAbstractSpinBox.' + Attr + '.' + Value)
  else if Attr = 'Alignment' then
    MakeAttribut(Attr, 'Qt.AlignmentFlag.' + Value)
  else if Attr = 'ShowGroupSeparator' then
    setAttribute('GroupSeparatorShown', Value, Typ)
  else
    inherited;
end;

function TQtAbstractSpinBox.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|editingFinished';
  Result:= Result + inherited getEvents(ShowEvents);
end;

procedure TQtAbstractSpinBox.getSlots(Parametertypes: string; Slots: TStrings);
begin
  if Parametertypes = '' then begin
    Slots.Add(Name + '.clear');
    Slots.Add(Name + '.selectAll');
    Slots.Add(Name + '.stepDown');
    Slots.Add(Name + '.stepUp');
  end;
  inherited;
end;

procedure TQtAbstractSpinBox.Paint;
  var R: TRect; Points: array[0..2] of TPoint; x, y: Integer;
begin
  inherited;

  if FButtonSymbols <> NoButtons then begin
    // paint boxes
    R:= inherited InnerRect;
    R.Left:= R.Right - PPIScale(16);
    R.Inflate(-1, -1);
    Canvas.Pen.Color:= $ACACAC;
    Canvas.Brush.Color:= $E7E7E7;
    Canvas.Rectangle(R);
    Canvas.MoveTo(R.Left, Height div 2);
    Canvas.LineTo(R.Right, Height div 2);

    Canvas.Brush.Color:= clBlack;
    Canvas.Pen.Color:= clBlack;
    var i2:= PPIScale(2);
    var i3:= PPIScale(3);
    var i4:= PPIScale(4);
    var i5:= PPIScale(5);
    x:= R.Left + i4;
    if FButtonSymbols = UpDownArrows then begin
      // paint up/down
      y:= (R.Top + Height div 2) div 2 + 1;
      Points[0]:= Point(x, y);
      Points[1]:= Point(x + i4, y);
      Points[2]:= Point(x + i2, y - i2);
      Canvas.Polygon(Points);
      y:= (Height div 2 + R.Bottom) div 2 - 1;
      Points[0]:= Point(x, y);
      Points[1]:= Point(x + i4, y);
      Points[2]:= Point(x + i2, y + i2);
      Canvas.Polygon(Points);
    end else begin
      y:= (R.Top + Height div 2) div 2;
      Canvas.MoveTo(x, y);
      Canvas.LineTo(x + i5, y);
      Canvas.MoveTo(x + i2, y - i2);
      Canvas.LineTo(x + i2, y + i3);
      y:= (Height div 2 + R.Bottom) div 2;
      Canvas.MoveTo(x, y);
      Canvas.LineTo(x + 5, y);
    end;
  end;
end;

function TQtAbstractSpinBox.InnerRect: TRect;
begin
  Result:= inherited InnerRect;
  if FButtonSymbols <> NoButtons then
    Result.Right:= Result.Right - 16;
end;

procedure TQtAbstractSpinBox.setFrame(Value: Boolean);
begin
  if Value <> FFrame then begin
    FFrame:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSpinBox.setButtonSymbols(Value: TButtonSymbols);
begin
  if Value <> FButtonSymbols then begin
    FButtonSymbols:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSpinBox.setShowGroupSeparator(Value: Boolean);
begin
  if Value <> FShowGroupSeparator then begin
    FShowGroupSeparator:= Value;
    Invalidate;
  end;
end;

procedure TQtAbstractSpinBox.setSpecialValueText(Value: string);
begin
  if Value <> FSpecialValueText then begin
    FSpecialValueText:= Value;
    Invalidate;
  end;
end;

{--- TQtSpinBox ---------------------------------------------------------------}

constructor TQtSpinBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 79;
  Width:= 40;
  FMaximum:= 99;
  FSingleStep:= 1;
  FDisplayIntegerBase:= 10;
end;

function TQtSpinBox.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Minimum|Maximum|SingleStep|Value';
  if ShowAttributes >= 2 then
    Result:= Result + '|Suffix|Prefix';
  if ShowAttributes = 3 then
    Result:= Result + '|StepType|DisplayIntegerBase';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TQtSpinBox.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|textChanged|valueChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtSpinBox.HandlerInfo(const event: string): string;
begin
  if event = 'textChanged' then
    Result:= 'QString;text'
  else if event = 'valueChanged' then
    Result:= 'int;i'
  else
    Result:= inherited;
end;

procedure TQtSpinBox.getSlots(Parametertypes: string; Slots: TStrings);
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
  var align: Integer; s: string; R: TRect;
begin
  Canvas.Brush.Color:= clWhite;
  if FFrame
    then Canvas.Pen.Color:= $7A7A7A
    else Canvas.Pen.Color:= clWhite;
  Canvas.Rectangle(ClientRect);

  inherited;

  Canvas.Brush.Color:= clWhite;
  if FShowGroupSeparator
    then s:= Format('%.0n', [FValue * 1.0])
    else s:= IntToStr(FValue);
  if FDisplayIntegerBase <> 10 then begin
    s:= IntTostr(FValue);
    s:= DecToBase(FDisplayIntegerBase, FValue);
  end;
  s:= FPrefix + s + FSuffix;
  if (FValue = FMinimum) and (FSpecialValueText <> '') then
    s:= FSpecialValueText;
  R:= InnerRect;
  R.Left:= R.Left + HalfX;
  R.Right:= R.Right - HalfX;
  R.Top:= (R.Bottom - R.Top - Canvas.TextHeight('A')) div 2 + 1;
  case Alignment of
    AlignLeft:  align:= DT_LEFT;
    AlignRight: align:= DT_RIGHT;
    else        align:= DT_CENTER;
  end;
  DrawText(Canvas.Handle, PChar(s), Length(s), R, align);
end;

procedure TQtSpinBox.setPrefix(Value: string);
begin
  if Value <> FPrefix then begin
    FPrefix:= Value;
    Invalidate;
  end;
end;

procedure TQtSpinBox.setSuffix(Value: string);
begin
  if Value <> FSuffix then begin
    FSuffix:= Value;
    Invalidate;
  end;
end;

procedure TQtSpinBox.setValue(Value: Integer);
begin
  if Value <> FValue then begin
    FValue:= Value;
    Invalidate;
  end;
end;

procedure TQtSpinBox.setDisplayIntegerBase(Value: Integer);
begin
  if Value <> FDisplayIntegerBase then begin
    FDisplayIntegerBase:= Value;
    Invalidate;
  end;
end;

{--- TQtDoubleSpinBox ---------------------------------------------------------}

constructor TQtDoubleSpinBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tag:= 106;
  FDecimals:= 2;
  FMaximum:= 99.99;
  FSingleStep:= 1;
end;

function TQtDoubleSpinBox.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Minimum|Maximum|SingleStep|Value|Decimals';
  if ShowAttributes >= 2 then
    Result:= Result + '|Suffix|Prefix|StepType';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

function TQtDoubleSpinBox.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|textChanged|valueChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtDoubleSpinBox.HandlerInfo(const event: string): string;
begin
  if event = 'textChanged' then
    Result:= 'QString;text'
  else if event = 'valueChanged' then
    Result:= 'double;d'
  else
    Result:= inherited;
end;

procedure TQtDoubleSpinBox.getSlots(Parametertypes: string; Slots: TStrings);
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
  var align: Integer; s: string; R: TRect;
begin
  Canvas.Brush.Color:= clWhite;
  if FFrame
    then Canvas.Pen.Color:= $7A7A7A
    else Canvas.Pen.Color:= clWhite;
  Canvas.Rectangle(ClientRect);

  inherited;

  Canvas.Brush.Color:= clWhite;
  if FShowGroupSeparator
    then s:= Format('%.' + IntToStr(FDecimals) + 'n', [FValue])
    else s:= Format('%.' + IntToStr(FDecimals) + 'f', [fValue]);
  s:= FPrefix + s + FSuffix;
  if (FValue = FMinimum) and (FSpecialValueText <> '') then
    s:= FSpecialValueText;
  R:= InnerRect;
  R.Left:= R.Left + HalfX;
  R.Right:= R.Right - HalfX;
  R.Top:= (R.Bottom - R.Top - Canvas.TextHeight('A')) div 2 + 1;
  case Alignment of
    AlignLeft:  align:= DT_LEFT;
    AlignRight: align:= DT_RIGHT;
    else        align:= DT_CENTER;
  end;
  DrawText(Canvas.Handle, PChar(s), Length(s), R, align);
end;

procedure TQtDoubleSpinBox.setPrefix(Value: string);
begin
  if Value <> FPrefix then begin
    FPrefix:= Value;
    Invalidate;
  end;
end;

procedure TQtDoubleSpinBox.setSuffix(Value: string);
begin
  if Value <> FSuffix then begin
    FSuffix:= Value;
    Invalidate;
  end;
end;

procedure TQtDoubleSpinBox.setValue(Value: double);
begin
  if Value <> FValue then begin
    FValue:= Value;
    Invalidate;
  end;
end;

{--- TQtDateTimeEdit ----------------------------------------------------------}

constructor TQtDateTimeEdit.Create(AOwner: TComponent);
  var FS: TFormatSettings; DateTime: TDateTime;
begin
  inherited Create(AOwner);
  Tag:= 108;
  Width:= 128;
  FS:= TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  format:= myStringReplace(FS.ShortDateFormat + ' ' + FS.LongTimeFormat, '/', FS.DateSeparator);
  FDisplayFormat:= format;
  DateTime:= Now();
  FDateTime:= DateTimeToStr(DateTime);
  FDate:= DateToStr(DateTime);
  FTime:= TimeToStr(DateTime);
  FMaximumDateTime:= DateTimeToStr(EncodeDateTime(9999, 12, 31, 23, 59, 59, 0));
  FMinimumDateTime:= DateTimeToStr(EncodeDateTime(1752, 9, 14, 0, 0, 0, 0));
  FMaximumDate:= DateToStr(EncodeDateTime(9999, 12, 31, 0, 0, 0, 0));
  FMinimumDate:= DateToStr(EncodeDateTime(1752, 9, 14, 0, 0, 0, 0));
  FMaximumTime:= TimeToStr(EncodeDateTime(1, 1, 1, 23, 59, 59, 999));
  FMinimumTime:= TimeToStr(EncodeDateTime(1, 1, 1, 0, 0, 0, 0));
  FCurrentSection:= DaySection;
  FTimeSpec:= LocalTime;
end;

function TQtDateTimeEdit.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|DateTime|MaximumDateTime|MinimumDateTime|DisplayFormat';
  if ShowAttributes >= 2 then
    Result:= Result + '|Date|Time|MaximumDate|MinimumDate|MaximumTime' +
                      '|MinimumTime|CurrentSection|CalendarPopup' +
                      '|CurrentSectionIndex|TimeSpec';
  Result:= Result + inherited getAttributes(ShowAttributes);
end;

procedure TQtDateTimeEdit.setAttribute(Attr, Value, Typ: string);
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

function TQtDateTimeEdit.getEvents(ShowEvents: Integer): string;
begin
  Result:= '|dateChanged|dateTimeChanged|timeChanged';
  Result:= Result + inherited getEvents(ShowEvents);
end;

function TQtDateTimeEdit.HandlerInfo(const event: string): string;
begin
  if event = 'dateChanged' then
    Result:= 'QDate;date'
  else if event = 'dateTimeChanged' then
    Result:= 'QDateTime;datetime'
  else if event = 'timeChanged' then
    Result:= 'QTime;time'
  else
    Result:= inherited;
end;

procedure TQtDateTimeEdit.getSlots(Parametertypes: string; Slots: TStrings);
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
  if Widget = '' then begin
    inherited NewWidget('QDateTimeEdit');
    MakeDateTime(FDateTime);
    setAttribute('DisplayFormat', FDisplayFormat, 'string');
  end else
    inherited NewWidget(Widget);
end;

procedure TQtDateTimeEdit.MakeDateTime(Value: string);
  var key, s: string; DateTime: TDateTime;
begin
  try
    DateTime:= StrToDateTime(Value);
  except
    DateTime:= Now();
    FDateTime:= DateTimeToStr(DateTime);
    UpdateObjectInspector;
  end;
  FDate:= DateToStr(DateTime);
  FTime:= TimeToStr(DateTime);
  key:= 'self.' + Name + '.setDateTime';
  s:= key + '(QDateTime.fromString(' + asString(FDateTime) + ', ' + asString(format) + '))';
  setAttributValue(key, s);
  UpdateObjectInspector;
end;

procedure TQtDateTimeEdit.MakeDate(Value: string);
  var key, s: string; DateTime: TDateTime; p: Integer;
begin
  try
    DateTime:= StrToDate(Value);
  except
    DateTime:= Now();
  end;
  FDate:= DateToStr(DateTime);
  p:= Pos(' ', FDateTime);
  FDateTime:= FDate + Copy(FDateTime, p, Length(FDateTime));
  key:= 'self.' + Name + '.setDateTime';
  s:= key + '(QDateTime.fromString(' + asString(FDateTime) + ', ' + asString(format) + '))';
  setAttributValue(key, s);
  UpdateObjectInspector;
end;

procedure TQtDateTimeEdit.MakeTime(Value: string);
  var key, s: string; DateTime: TDateTime; p: Integer;
begin
  try
    DateTime:= StrToTime(Value);
  except
    DateTime:= Now();
  end;
  FTime:= TimeToStr(DateTime);
  p:= Pos(' ', FDateTime);
  FDateTime:= Copy(FDateTime, 1, p) + FTime;
  key:= 'self.' + Name + '.setDateTime';
  s:= key + '(QDateTime.fromString(' + asString(FDateTime) + ', ' + asString(format) + '))';
  setAttributValue(key, s);
  UpdateObjectInspector;
end;

function TQtDateTimeEdit.DateTimeFromDisplayFormat: string;
  var DateTime: TDateTime; FS: TFormatSettings; p: Integer;
begin
  FS:= TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  p:= Pos(' ', FDisplayFormat);
  if p > 0 then begin
    FS.ShortDateFormat:= Copy(FDisplayFormat, 1, p-1);
    FS.LongTimeFormat:= Copy(FDisplayFormat, p+1, Length(FDisplayFormat));
  end;
  if TryStrToDateTime(FDateTime, DateTime, FS)
    then Result:= DateTimeToStr(DateTime, FS)
    else Result:= _('invalid date time format');
end;

procedure TQtDateTimeEdit.Paint;
begin
  Canvas.Brush.Color:= clWhite;
  if FFrame
    then Canvas.Pen.Color:= $7A7A7A
    else Canvas.Pen.Color:= clWhite;
  Canvas.Rectangle(ClientRect);
  inherited;
  ShowValue(DateTimeFromDisplayFormat);
end;

procedure TQtDateTimeEdit.ShowValue(Value: string);
  var align: Integer; R: TRect;
begin
  Canvas.Brush.Color:= clWhite;
  R:= InnerRect;
  R.Left:= R.Left + HalfX;
  R.Right:= R.Right - HalfX;
  R.Top:= (R.Bottom - R.Top - Canvas.TextHeight('A')) div 2 + 1;
  case Alignment of
    AlignLeft:  align:= DT_LEFT;
    AlignRight: align:= DT_RIGHT;
    else        align:= DT_CENTER;
  end;
  DrawText(Canvas.Handle, PChar(Value), Length(Value), R, align);
end;

procedure TQtDateTimeEdit.setDateTime(Value: string);
  var p: Integer;
begin
  if Value <> FDateTime then begin
    FDateTime:= Value;
    p:= Pos(' ', FDateTime);
    if p > 0 then begin
      FDate:= Trim(Copy(FDateTime, 1, p-1));
      FTime:= Trim(Copy(FDateTime, p+1, Length(FDateTime)));
    end;
    Invalidate;
  end;
end;

procedure TQtDateTimeEdit.setDate(Value: string);
begin
  if Value <> FDate then begin
    FDate:= Value;
    FDateTime:= FDate + ' ' + FTime;
    Invalidate;
  end;
end;

procedure TQtDateTimeEdit.setTime(Value: string);
begin
  if Value <> FTime then begin
    FTime:= Value;
    FDateTime:= FDate + ' ' + FTime;
    Invalidate;
  end;
end;

procedure TQtDateTimeEdit.setDisplayFormat(Value: string);
begin
  if Value <> FDisplayFormat then begin
    FDisplayFormat:= Value;
    Invalidate;
  end;
end;

{--- TQtDateEdit --------------------------------------------------------------}

constructor TQtDateEdit.Create(AOwner: TComponent);
  var FS: TFormatSettings;
begin
  inherited Create(AOwner);
  Tag:= 109;
  Width:= 80;
  FS:= TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FDisplayFormat:= myStringReplace(FS.ShortDateFormat, '/', FS.DateSeparator);;
end;

function TQtDateEdit.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Date|MaximumDate|MinimumDate';
  if ShowAttributes >= 2 then
    Result:= Result + '|DateTime|Time|MaximumDateTime|MinimumDateTime|MaximumTime' +
                      '|MinimumTime|CurrentSection|CalendarPopup' +
                      '|CurrentSectionIndex|TimeSpec';
  Result:= Result + inherited getAttributes(ShowAttributes);
  if ShowAttributes = 1 then begin
    var p:= Pos('|DateTime', Result);
    Delete(Result, p, 41);
  end;
end;

procedure TQtDateEdit.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QDateEdit');
  setAttribute('DisplayFormat', FDisplayFormat, 'string');
end;

function TQtDateEdit.DateTimeFromDisplayFormat: string;
  var DateTime: TDateTime; FS: TFormatSettings;
begin
  FS:= TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FS.ShortDateFormat:= FDisplayFormat;
  if TryStrToDate(FDate, DateTime, FS)
    then Result:= DateTimeToStr(DateTime, FS)
    else Result:= _('invalid date format');
end;

{--- TQtTimeEdit --------------------------------------------------------------}

constructor TQtTimeEdit.Create(AOwner: TComponent);
  var FS: TFormatSettings;
begin
  inherited Create(AOwner);
  Tag:= 110;
  Width:= 80;
  FS:= TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FDisplayFormat:= FS.LongTimeFormat;
end;

function TQtTimeEdit.getAttributes(ShowAttributes: Integer): string;
begin
  Result:= '|Time|MaximumTime|MinimumTime';
  if ShowAttributes >= 2 then
    Result:= Result + '|DateTime|Date|MaximumDateTime|MinimumDateTime|MaximumDate' +
                      '|MinimumDate|CurrentSection|CalendarPopup' +
                      '|CurrentSectionIndex|TimeSpec';
  Result:= Result + inherited getAttributes(ShowAttributes);
  if ShowAttributes = 1 then begin
    var p:= Pos('|DateTime', Result);
    Delete(Result, p, 41);
  end;
end;

procedure TQtTimeEdit.NewWidget(Widget: string = '');
begin
  inherited NewWidget('QTimeEdit');
  setAttribute('DisplayFormat', FDisplayFormat, 'string');
end;

function TQtTimeEdit.DateTimeFromDisplayFormat: string;
  var DateTime: TDateTime; FS: TFormatSettings; p: Integer;
begin
  FS:= TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FS.LongTimeFormat:= FDisplayFormat;
  if TryStrToTime(FTime, DateTime, FS) then begin
    Result:= DateTimeToStr(DateTime, FS);
    p:= Pos(' ', Result);
    if p > 0 then
      Result:= Copy(Result, p + 1, Length(Result));
  end else
    Result:= _('invalid time format');
end;

end.
