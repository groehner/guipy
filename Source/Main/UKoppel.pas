unit UKoppel;

interface

uses Graphics, Classes;

Const
  PythonTkCursorText = 'default'#13#10'fleur'#13#10'hand2'#13#10'sb_h_double_arrow'#13#10'sb_v_double_arrow'#13#10 +
                       'sizing'#13#10'tcross'#13#10'watch'#13#10'xterm'#13#10'question_arrow'#13#10'center_ptr';

  PythonQtCursorText = 'ArrowCursor'#13#10'CrossCursor'#13#10'IBeamCursor'#13#10'WaitCursor'#13#10'WhatsThisCursor'#13#10 +
                       'SizeVerCursor'#13#10'SizeHorCursor'#13#10'SizeBDiagCursor'#13#10'PointingHandCursor'#13#10 +
                       'SizeAllCursor'#13#10'UpArrowCursor';

  PythonColorsText = 'white'#13#10'yellow'#13#10'cyan'#13#10'green'#13#10 +
                     'orange'#13#10'pink'#13#10'magenta'#13#10'red'#13#10'blue'#13#10 +
                     'light gray'#13#10'gray'#13#10'dim gray'#13#10'black'#13#10 +
                     'SystemActiveBorder'#13#10'SystemActiveCaption'#13#10'SystemAppWorkspace'#13#10 +
                     'SystemBackground'#13#10'SystemButtonFace'#13#10'SystemButtonHighlight'#13#10 +
                     'SystemButtonShadow'#13#10'SystemButtonText'#13#10'SystemCaptionText'#13#10 +
                     'SystemDisabledText'#13#10'SystemHighlight'#13#10'SystemHighlightText'#13#10 +
                     'SystemInactiveBorder'#13#10'SystemInactiveCaption'#13#10'SystemInactiveCaptionText'#13#10 +
                     'SystemMenu'#13#10'SystemMenuText'#13#10'SystemScrollbar'#13#10 +
                     'SystemWindow'#13#10'SystemWindowFrame'#13#10'SystemWindowText';

  MouseEvents1    = '|ButtonPress|ButtonRelease|Motion';
  MouseEvents2    = '|Enter|Leave|MouseWheel';
  KeyboardEvents1 = '|KeyPress|KeyRelease';
  MiscEvents      = '|Activate|Deactivate|Configure|FocusIn|FocusOut';
  AllEvents       =  MouseEvents1 + MouseEvents2 + KeyboardEvents1 + MiscEvents + '|';

var
  ComponentNrToInsert: integer;
  PanelCanvasType: string;
  LOldValue: String;
  PythonCursorText:string;

  function Tag2PythonType(Tag: integer): string;

  function Python2DelphiColors(s: string): string;
  function Delphi2PythonColors(s: string): string;

  function Python2DelphiCursor(s: string): string;
  function Delphi2PythonCursor(s: string): string;

  function Delphi2PythonValues(s: string): string;
  function Python2DelphiValues(s: string): string;

  function turnRGB(const s: string): string;
  function TColorToString(Color: TColor): string;
  function isEvent(s: string): boolean;

  procedure CreateTkCursors;
  procedure CreateQtCursors;

implementation

uses SysUtils, System.Generics.Collections;

var
  Delphi2PythonColorTranslate: TDictionary<String, String>;
  Python2DelphiColorTranslate: TDictionary<String, String>;

  Delphi2PythonCursorTranslate: TDictionary<String, String>;
  Python2DelphiCursorTranslate: TDictionary<String, String>;

  Delphi2PythonValuesAndNamesTranslate: TDictionary<String, String>;
  Python2DelphiValuesAndNamesTranslate: TDictionary<String, String>;


function Tag2PythonType(Tag: integer): string;
begin
  Result:= '';
  case Tag of
     1: Result:= 'Label';
     2: Result:= 'Entry';
     3: Result:= 'Text';
     4: Result:= 'Button';
     5: Result:= 'Checkbutton';
     6: Result:= 'Radiobutton';
     7: Result:= 'RadiobuttonGroup';
     8: Result:= 'Listbox';
     9: Result:= 'Spinbox';
    10: Result:= 'Message';
    11: Result:= 'Canvas';
    12: Result:= 'Scrollbar';
    13: Result:= 'Frame';
    14: Result:= 'Labelframe';
    15: Result:= 'Scale';
    16: Result:= 'PanedWindow'; // PanedWindow
    17: Result:= 'Menubutton';
    18: Result:= 'OptionMenu';
    19: Result:= 'Menu';
    20: Result:= 'PopupMenu';
    // TTK
    31: Result:= 'Label';
    32: Result:= 'Entry';
    34: Result:= 'Button';
    35: Result:= 'Checkbutton';
    36: Result:= 'Radiobutton';
    37: Result:= 'RadiobuttonGroup';
    38: Result:= 'Combobox';
    39: Result:= 'Spinbox';
    42: Result:= 'Scrollbar';
    43: Result:= 'Frame';
    44: Result:= 'Labelframe';
    45: Result:= 'Scale';
    46: Result:= 'LabeledScale';
    47: Result:= 'Panedwindow';  // Panedwindow
    48: Result:= 'Menubutton';
    49: Result:= 'OptionMenu';
    50: Result:= 'Notebook';
    51: Result:= 'Treeview';
    52: Result:= 'Progressbar';
    53: Result:= 'Separator';
    54: Result:= 'Sizegrip';
    // Qt Base
    71: Result:= 'Label';
    72: Result:= 'LineEdit';
    73: Result:= 'PlainTextEdit';
    74: Result:= 'PushButton';
    75: Result:= 'CheckBox';
    76: Result:= 'ButtonGroup';
    77: Result:= 'ListWidget';
    78: Result:= 'ComboBox';
    79: Result:= 'SpinBox';
    80: Result:= 'ScrollBar';
    81: Result:= 'Canvas';
    82: Result:= 'Frame';
    83: Result:= 'GroupBox';
    84: Result:= 'Slider';
    85: Result:= 'MenuBar';
    86: Result:= 'ContextMenu';
    87: Result:= 'TabWidget';
    88: Result:= 'TreeWidget';
    89: Result:= 'TableWidget';
    90: Result:= 'ProgressBar';
    91: Result:= 'StatusBar';
    // Qt Controls
   101: Result:= 'TextEdit';
   102: Result:= 'TextBrowser';
   103: Result:= 'ToolButton';
   104: Result:= 'CommandLinkButton';
   105: Result:= 'FontComboBox';
   106: Result:= 'DoubleSpinBox';
   107: Result:= 'LCDNumber';
   108: Result:= 'DateTimeEdit';
   109: Result:= 'DateEdit';
   110: Result:= 'TimeEdit';
   111: Result:= 'Dial';
   112: Result:= 'Line';
   113: Result:= 'ScrollArea';
   114: Result:= 'ToolBox';
   115: Result:= 'StackedWidget';
   116: Result:= 'ListView';
   117: Result:= 'ColumnView';
   118: Result:= 'TableView';
   119: Result:= 'GraphicsView';
  end;
end;

procedure CreateColors;

  procedure AddColor(s1, s2: string);
  begin
     Delphi2PythonColorTranslate.Add(s1, s2);
     Python2DelphiColorTranslate.Add(s2, s1);
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

procedure CreateTKCursors;

  procedure AddTranslate(s1, s2: string);
  begin
     Delphi2PythonCursorTranslate.Add(s1, s2);
     Python2DelphiCursorTranslate.Add(s2, s1);
  end;

begin
  FreeAndNil(Python2DelphiCursorTranslate);
  FreeAndNil(Delphi2PythonCursorTranslate);
  Python2DelphiCursorTranslate:= TDictionary<String, String>.Create;
  Delphi2PythonCursorTranslate:= TDictionary<String, String>.Create;

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
  PythonCursorText:= PythonTkCursorText;
end;

procedure CreateQtCursors;

  procedure AddTranslate(s1, s2: string);
  begin
     Delphi2PythonCursorTranslate.Add(s1, s2);
     Python2DelphiCursorTranslate.Add(s2, s1);
  end;

begin
  FreeAndNil(Python2DelphiCursorTranslate);
  FreeAndNil(Delphi2PythonCursorTranslate);
  Python2DelphiCursorTranslate:= TDictionary<String, String>.Create;
  Delphi2PythonCursorTranslate:= TDictionary<String, String>.Create;

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
  PythonCursorText:= PythonQtCursorText;
end;

procedure CreateValuesAndNames;

  procedure AddTranslate(s1, s2: string);
  begin
     Delphi2PythonValuesAndNamesTranslate.Add(s1, s2);
     Python2DelphiValuesAndNamesTranslate.Add(s2, s1);
  end;

begin
  AddTranslate('_To', 'To');
  AddTranslate('fsBold', 'Bold');
  AddTranslate('fsItalic', 'Italic');
  AddTranslate('Caption', 'Title');
  AddTranslate('Left', 'X');
  AddTranslate('Top', 'Y');
end;

function Python2DelphiColors(s: string): string;
begin // used to show color combo box
  if not Python2DelphiColorTranslate.TryGetValue(s, Result) then
    Result:= 'clBtnFace';
end;

function Delphi2PythonColors(s: string): string;
begin
  if not Delphi2PythonColorTranslate.TryGetValue(s, Result) then begin
    if copy(s, 1, 3) = '$00' then
      s:= '#' + copy(s, 8, 2) + copy(s, 6, 2) + copy(s, 4, 2)
    else if s = '' then
      s:= 'SystemButtonFace';
    Result:= s;
  end;
end;

function Python2DelphiCursor(s: string): string;
begin
  if not Python2DelphiCursorTranslate.TryGetValue(s, Result) then
    Result:= 'crDefault';
end;

function Delphi2PythonCursor(s: string): string;
begin
  if not Delphi2PythonCursorTranslate.TryGetValue(s, Result) then
    Result:= 'default';
end;

function Delphi2PythonValues(s: string): string;
begin
  if not Delphi2PythonValuesAndNamesTranslate.TryGetValue(s, Result) then
    Result:= s;
end;

function Python2DelphiValues(s: string): string;
begin
  if not Python2DelphiValuesAndNamesTranslate.TryGetValue(s, Result) then
    Result:= s;
end;

function turnRGB(const s: string): string;
begin
  Result:= s;
  if copy(s, 1, 2) = '0x' then
    Result:= '0x' + copy(s, 7, 2) + copy(s, 5, 2) + copy(s, 3, 2);
end;

function TColorToString(Color: TColor): string;
  var s: string;
begin
  s:= ColorToString(Color);
  s:= Delphi2PythonColors(s);
  if copy(s, 1, 2) = 'cl' then
    FmtStr(s, '%s%.8x', [HexDisplayPrefix, Color]);
  if copy(s, 1, 2) = '$0' then
    s:= '#' + copy(s, 8, 2) + copy(s, 6, 2) + copy(s, 4, 2);
  Result:= s;
end;

function isEvent(s: string): boolean;
begin      // Tk                   or  Qt
  Result:= (Pos(s, AllEvents) > 0) or (s <> '') and (CharInSet(s[1], ['a'..'z']));
end;

Initialization
  Python2DelphiColorTranslate:= TDictionary<String, String>.Create;
  Delphi2PythonColorTranslate:= TDictionary<String, String>.Create;

  Python2DelphiCursorTranslate:= nil;
  Delphi2PythonCursorTranslate:= nil;

  Python2DelphiValuesAndNamesTranslate:= TDictionary<String, String>.Create;
  Delphi2PythonValuesAndNamesTranslate:= TDictionary<String, String>.Create;

  CreateColors;
  CreateTkCursors;
  CreateValuesAndNames;

Finalization
  FreeAndNil(Python2DelphiColorTranslate);
  FreeAndNil(Delphi2PythonColorTranslate);

  FreeAndNil(Python2DelphiCursorTranslate);
  FreeAndNil(Delphi2PythonCursorTranslate);

  FreeAndNil(Python2DelphiValuesAndNamesTranslate);
  FreeAndNil(Delphi2PythonValuesAndNamesTranslate);
end.
