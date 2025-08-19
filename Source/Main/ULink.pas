unit ULink;

interface

uses Graphics;

const
  PythonColorsText = 'white'#13#10'yellow'#13#10'cyan'#13#10'green'#13#10 +
    'orange'#13#10'pink'#13#10'magenta'#13#10'red'#13#10'blue'#13#10 +
    'light gray'#13#10'gray'#13#10'dim gray'#13#10'black'#13#10 +
    'SystemActiveBorder'#13#10'SystemActiveCaption'#13#10'SystemAppWorkspace'#13#10
    + 'SystemBackground'#13#10'SystemButtonFace'#13#10'SystemButtonHighlight'#13#10
    + 'SystemButtonShadow'#13#10'SystemButtonText'#13#10'SystemCaptionText'#13#10
    + 'SystemDisabledText'#13#10'SystemHighlight'#13#10'SystemHighlightText'#13#10
    + 'SystemInactiveBorder'#13#10'SystemInactiveCaption'#13#10'SystemInactiveCaptionText'#13#10
    + 'SystemMenu'#13#10'SystemMenuText'#13#10'SystemScrollbar'#13#10 +
    'SystemWindow'#13#10'SystemWindowFrame'#13#10'SystemWindowText';

var
  GComponentNrToInsert: NativeInt;
  GOldValue: string;
  GPythonCursorText: string;

function Tag2PythonType(Tag: NativeInt): string;

function Python2DelphiColors(const Str: string): string;
function Delphi2PythonColors(Str: string): string;

function Python2DelphiCursor(const Str: string): string;
function Delphi2PythonCursor(const Str: string): string;

function Delphi2PythonValues(const Str: string): string;

function TurnRGB(const Str: string): string;
function TColorToString(Color: TColor): string;

procedure CreateTkCursors;
procedure CreateQtCursors;

implementation

uses
  SysUtils,
  System.Generics.Collections;

const

  PythonTkCursorText =
    'default'#13#10'fleur'#13#10'hand2'#13#10'sb_h_double_arrow'#13#10'sb_v_double_arrow'#13#10
    + 'sizing'#13#10'tcross'#13#10'watch'#13#10'xterm'#13#10'question_arrow'#13#10'center_ptr';

  PythonQtCursorText =
    'ArrowCursor'#13#10'CrossCursor'#13#10'IBeamCursor'#13#10'WaitCursor'#13#10'WhatsThisCursor'#13#10
    + 'SizeVerCursor'#13#10'SizeHorCursor'#13#10'SizeBDiagCursor'#13#10'PointingHandCursor'#13#10
    + 'SizeAllCursor'#13#10'UpArrowCursor';

var
  Delphi2PythonColorTranslate: TDictionary<string, string>;
  Python2DelphiColorTranslate: TDictionary<string, string>;

  Delphi2PythonCursorTranslate: TDictionary<string, string>;
  Python2DelphiCursorTranslate: TDictionary<string, string>;

  Delphi2PythonValuesAndNamesTranslate: TDictionary<string, string>;
  Python2DelphiValuesAndNamesTranslate: TDictionary<string, string>;

  Tag2PythonMap: TDictionary<Integer, string>;

function Tag2PythonType(Tag: NativeInt): string;
begin
  if not Tag2PythonMap.TryGetValue(Tag, Result) then
    Result := '';
end;

procedure AddTkToTag2PythonMap;
begin
  // Tk base components
  Tag2PythonMap.Add(1, 'Label');
  Tag2PythonMap.Add(2, 'Entry');
  Tag2PythonMap.Add(3, 'Text');
  Tag2PythonMap.Add(4, 'Button');
  Tag2PythonMap.Add(5, 'Checkbutton');
  Tag2PythonMap.Add(6, 'Radiobutton');
  Tag2PythonMap.Add(7, 'RadiobuttonGroup');
  Tag2PythonMap.Add(8, 'Listbox');
  Tag2PythonMap.Add(9, 'Spinbox');
  Tag2PythonMap.Add(10, 'Message');
  Tag2PythonMap.Add(11, 'Canvas');
  Tag2PythonMap.Add(12, 'Scrollbar');
  Tag2PythonMap.Add(13, 'Frame');
  Tag2PythonMap.Add(14, 'Labelframe');
  Tag2PythonMap.Add(15, 'Scale');
  Tag2PythonMap.Add(16, 'PanedWindow');
  Tag2PythonMap.Add(17, 'Menubutton');
  Tag2PythonMap.Add(18, 'OptionMenu');
  Tag2PythonMap.Add(19, 'Menu');
  Tag2PythonMap.Add(20, 'PopupMenu');
  // Ttk components
  Tag2PythonMap.Add(31, 'Label');
  Tag2PythonMap.Add(32, 'Entry');
  Tag2PythonMap.Add(34, 'Button');
  Tag2PythonMap.Add(35, 'Checkbutton');
  Tag2PythonMap.Add(36, 'Radiobutton');
  Tag2PythonMap.Add(37, 'RadiobuttonGroup');
  Tag2PythonMap.Add(38, 'Combobox');
  Tag2PythonMap.Add(39, 'Spinbox');
  Tag2PythonMap.Add(42, 'Scrollbar');
  Tag2PythonMap.Add(43, 'Frame');
  Tag2PythonMap.Add(44, 'Labelframe');
  Tag2PythonMap.Add(45, 'Scale');
  Tag2PythonMap.Add(46, 'LabeledScale');
  Tag2PythonMap.Add(47, 'PanedWindow');
  Tag2PythonMap.Add(48, 'Menubutton');
  Tag2PythonMap.Add(49, 'OptionMenu');
  Tag2PythonMap.Add(50, 'Notebook');
  Tag2PythonMap.Add(51, 'Treeview');
  Tag2PythonMap.Add(52, 'Progressbar');
  Tag2PythonMap.Add(53, 'Separator');
  Tag2PythonMap.Add(54, 'SizeGrip');
end;

procedure AddQtToTag2PythonMap;
begin
  // Qt base components
  Tag2PythonMap.Add(71, 'Label');
  Tag2PythonMap.Add(72, 'LineEdit');
  Tag2PythonMap.Add(73, 'PlainTextEdit');
  Tag2PythonMap.Add(74, 'PushButton');
  Tag2PythonMap.Add(75, 'CheckBox');
  Tag2PythonMap.Add(76, 'ButtonGroup');
  Tag2PythonMap.Add(77, 'ListWidget');
  Tag2PythonMap.Add(78, 'ComboBox');
  Tag2PythonMap.Add(79, 'SpinBox');
  Tag2PythonMap.Add(80, 'ScrollBar');
  Tag2PythonMap.Add(81, 'Canvas');
  Tag2PythonMap.Add(82, 'Frame');
  Tag2PythonMap.Add(83, 'GroupBox');
  Tag2PythonMap.Add(84, 'Slider');
  Tag2PythonMap.Add(85, 'MenuBar');
  Tag2PythonMap.Add(86, 'Menu');
  Tag2PythonMap.Add(87, 'TabWidget');
  Tag2PythonMap.Add(88, 'TreeWidget');
  Tag2PythonMap.Add(89, 'TableWidget');
  Tag2PythonMap.Add(90, 'ProgressBar');
  Tag2PythonMap.Add(91, 'StatusBar');
  // Qt control components
  Tag2PythonMap.Add(101, 'TextEdit');
  Tag2PythonMap.Add(102, 'TextBrowser');
  Tag2PythonMap.Add(103, 'ToolButton');
  Tag2PythonMap.Add(104, 'CommandLinkButton');
  Tag2PythonMap.Add(105, 'FontComboBox');
  Tag2PythonMap.Add(106, 'DoubleSpinBox');
  Tag2PythonMap.Add(107, 'LCDNumber');
  Tag2PythonMap.Add(108, 'DateTimeEdit');
  Tag2PythonMap.Add(109, 'DateEdit');
  Tag2PythonMap.Add(110, 'TimeEdit');
  Tag2PythonMap.Add(111, 'Dial');
  Tag2PythonMap.Add(112, 'Line');
  Tag2PythonMap.Add(113, 'ScrollArea');
  Tag2PythonMap.Add(114, 'ToolBox');
  Tag2PythonMap.Add(115, 'StackedWidget');
  Tag2PythonMap.Add(116, 'ListView');
  Tag2PythonMap.Add(117, 'ColumnView');
  Tag2PythonMap.Add(118, 'TreeView');
  Tag2PythonMap.Add(119, 'TableView');
  Tag2PythonMap.Add(120, 'GraphicsView');
end;

procedure CreateColors;

  procedure AddColor(Str1, Str2: string);
  begin
    Delphi2PythonColorTranslate.Add(Str1, Str2);
    Python2DelphiColorTranslate.Add(Str2, Str1);
  end;

begin
  AddColor('clActiveBorder', 'SystemActiveBorder');
  AddColor('clActiveCaption', 'SystemActiveCaption');
  AddColor('clAppWorkSpace', 'SystemAppWorkspace');
  AddColor('clBackground', 'SystemBackground');
  AddColor('clBtnFace', 'SystemButtonFace');
  AddColor('clBtnHighlight', 'SystemButtonHighlight');
  AddColor('clBtnShadow', 'SystemButtonShadow');
  AddColor('clBtnText', 'SystemButtonText');
  AddColor('clCaptionText', 'SystemCaptionText');
  AddColor('clGrayText', 'SystemDisabledText');
  AddColor('clHighlight', 'SystemHighlight');
  AddColor('clHighlightText', 'SystemHighlightText');
  AddColor('clInactiveBorder', 'SystemInactiveBorder');
  AddColor('clInactiveCaption', 'SystemInactiveCaption');
  AddColor('clInactiveCaptionText', 'SystemInactiveCaptionText');
  AddColor('clMenu', 'SystemMenu');
  AddColor('clMenuText', 'SystemMenuText');
  AddColor('clScrollBar', 'SystemScrollbar');
  AddColor('clWindow', 'SystemWindow');
  AddColor('clWindowFrame', 'SystemWindowFrame');
  AddColor('clWindowText', 'SystemWindowText');
  AddColor('clBlack', 'black');
  AddColor('$00404040', 'dim gray');
  AddColor('clGray', 'gray');
  AddColor('$00C0C0C0', 'light gray');
  AddColor('clBlue', 'blue');
  AddColor('$00AFAFFF', 'pink');
  AddColor('$0000C8FF', 'orange');
  AddColor('clGreen', 'green');
  AddColor('clFuchsia', 'magenta');
  AddColor('clAqua', 'cyan');
  AddColor('clRed', 'red');
  AddColor('clWhite', 'white');
  AddColor('clYellow', 'yellow');
end;

procedure CreateTkCursors;

  procedure AddTranslate(Str1, Str2: string);
  begin
    Delphi2PythonCursorTranslate.Add(Str1, Str2);
    Python2DelphiCursorTranslate.Add(Str2, Str1);
  end;

begin
  FreeAndNil(Python2DelphiCursorTranslate);
  FreeAndNil(Delphi2PythonCursorTranslate);
  Python2DelphiCursorTranslate := TDictionary<string, string>.Create;
  Delphi2PythonCursorTranslate := TDictionary<string, string>.Create;

  AddTranslate('crDefault', 'default');
  AddTranslate('crCross', 'tcross');
  AddTranslate('crIBeam', 'xterm');
  AddTranslate('crHourGlass', 'watch');
  AddTranslate('crSizeNESW', 'sizing');
  AddTranslate('crHelp', 'question_arrow');
  AddTranslate('crSizeNS', 'sb_v_double_arrow');
  AddTranslate('crSizeWE', 'sb_h_double_arrow');
  AddTranslate('crHandPoint', 'hand2');
  AddTranslate('crSizeAll', 'fleur');
  AddTranslate('crUpArrow', 'center_ptr');
  GPythonCursorText := PythonTkCursorText;
end;

procedure CreateQtCursors;

  procedure AddTranslate(Str1, Str2: string);
  begin
    Delphi2PythonCursorTranslate.Add(Str1, Str2);
    Python2DelphiCursorTranslate.Add(Str2, Str1);
  end;

begin
  FreeAndNil(Python2DelphiCursorTranslate);
  FreeAndNil(Delphi2PythonCursorTranslate);
  Python2DelphiCursorTranslate := TDictionary<string, string>.Create;
  Delphi2PythonCursorTranslate := TDictionary<string, string>.Create;

  AddTranslate('crDefault', 'ArrowCursor');
  AddTranslate('crCross', 'CrossCursor');
  AddTranslate('crIBeam', 'IBeamCursor');
  AddTranslate('crHourGlass', 'WaitCursor');
  AddTranslate('crSizeNESW', 'SizeBDiagCursor');
  AddTranslate('crHelp', 'WhatsThisCursor');
  AddTranslate('crSizeNS', 'SizeVerCursor');
  AddTranslate('crSizeWE', 'SizeHorCursor');
  AddTranslate('crHandPoint', 'PointinHandCursor');
  AddTranslate('crSizeAll', 'SizeAllCursor');
  AddTranslate('crUpArrow', 'UpArrowCursor');
  GPythonCursorText := PythonQtCursorText;
end;

procedure CreateValuesAndNames;

  procedure AddTranslate(Str1, Str2: string);
  begin
    Delphi2PythonValuesAndNamesTranslate.Add(Str1, Str2);
    Python2DelphiValuesAndNamesTranslate.Add(Str2, Str1);
  end;

begin
  AddTranslate('_To', 'To');
  AddTranslate('fsBold', 'Bold');
  AddTranslate('fsItalic', 'Italic');
  AddTranslate('Caption', 'Title');
  AddTranslate('Left', 'X');
  AddTranslate('Top', 'Y');
end;

function Python2DelphiColors(const Str: string): string;
begin // used to show color combo box
  if not Python2DelphiColorTranslate.TryGetValue(Str, Result) then
    Result := 'clBtnFace';
end;

function Delphi2PythonColors(Str: string): string;
begin
  if not Delphi2PythonColorTranslate.TryGetValue(Str, Result) then
  begin
    if Copy(Str, 1, 3) = '$00' then
      Str := '#' + Copy(Str, 8, 2) + Copy(Str, 6, 2) + Copy(Str, 4, 2)
    else if Str = '' then
      Str := 'SystemButtonFace';
    Result := Str;
  end;
end;

function Python2DelphiCursor(const Str: string): string;
begin
  if not Python2DelphiCursorTranslate.TryGetValue(Str, Result) then
    Result := 'crDefault';
end;

function Delphi2PythonCursor(const Str: string): string;
begin
  if not Delphi2PythonCursorTranslate.TryGetValue(Str, Result) then
    Result := 'default';
end;

function Delphi2PythonValues(const Str: string): string;
begin
  if not Delphi2PythonValuesAndNamesTranslate.TryGetValue(Str, Result) then
    Result := Str;
end;

function TurnRGB(const Str: string): string;
begin
  Result := Str;
  if Copy(Str, 1, 2) = '0x' then
    Result := '0x' + Copy(Str, 7, 2) + Copy(Str, 5, 2) + Copy(Str, 3, 2);
end;

function TColorToString(Color: TColor): string;
var
  Str: string;
begin
  Str := ColorToString(Color);
  Str := Delphi2PythonColors(Str);
  if Copy(Str, 1, 2) = 'cl' then
    FmtStr(Str, '%Str%.8x', [HexDisplayPrefix, Color]);
  if Copy(Str, 1, 2) = '$0' then
    Str := '#' + Copy(Str, 8, 2) + Copy(Str, 6, 2) + Copy(Str, 4, 2);
  Result := Str;
end;

initialization

Python2DelphiCursorTranslate := nil;
Delphi2PythonCursorTranslate := nil;
CreateTkCursors;

Python2DelphiColorTranslate := TDictionary<string, string>.Create;
Delphi2PythonColorTranslate := TDictionary<string, string>.Create;
CreateColors;

Python2DelphiValuesAndNamesTranslate := TDictionary<string, string>.Create;
Delphi2PythonValuesAndNamesTranslate := TDictionary<string, string>.Create;
CreateValuesAndNames;

Tag2PythonMap := TDictionary<Integer, string>.Create;
AddTkToTag2PythonMap;
AddQtToTag2PythonMap;

finalization

FreeAndNil(Python2DelphiColorTranslate);
FreeAndNil(Delphi2PythonColorTranslate);

FreeAndNil(Python2DelphiCursorTranslate);
FreeAndNil(Delphi2PythonCursorTranslate);

FreeAndNil(Python2DelphiValuesAndNamesTranslate);
FreeAndNil(Delphi2PythonValuesAndNamesTranslate);

FreeAndNil(Tag2PythonMap);

end.
