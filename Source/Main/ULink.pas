unit ULink;

interface

uses Graphics;

const
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

var
  GComponentNrToInsert: Integer;
  GOldValue: string;
  GPythonCursorText:string;

function Tag2PythonType(Tag: Integer): string;

function Python2DelphiColors(Str: string): string;
function Delphi2PythonColors(Str: string): string;

function Python2DelphiCursor(Str: string): string;
function Delphi2PythonCursor(Str: string): string;

function Delphi2PythonValues(Str: string): string;

function TurnRGB(const Str: string): string;
function TColorToString(Color: TColor): string;

procedure CreateTkCursors;
procedure CreateQtCursors;


implementation

uses
  SysUtils,
  System.Generics.Collections;

const

  PythonTkCursorText = 'default'#13#10'fleur'#13#10'hand2'#13#10'sb_h_double_arrow'#13#10'sb_v_double_arrow'#13#10 +
                       'sizing'#13#10'tcross'#13#10'watch'#13#10'xterm'#13#10'question_arrow'#13#10'center_ptr';

  PythonQtCursorText = 'ArrowCursor'#13#10'CrossCursor'#13#10'IBeamCursor'#13#10'WaitCursor'#13#10'WhatsThisCursor'#13#10 +
                       'SizeVerCursor'#13#10'SizeHorCursor'#13#10'SizeBDiagCursor'#13#10'PointingHandCursor'#13#10 +
                       'SizeAllCursor'#13#10'UpArrowCursor';

var
  Delphi2PythonColorTranslate: TDictionary<string, string>;
  Python2DelphiColorTranslate: TDictionary<string, string>;

  Delphi2PythonCursorTranslate: TDictionary<string, string>;
  Python2DelphiCursorTranslate: TDictionary<string, string>;

  Delphi2PythonValuesAndNamesTranslate: TDictionary<string, string>;
  Python2DelphiValuesAndNamesTranslate: TDictionary<string, string>;


function Tag2PythonType(Tag: Integer): string;
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
    86: Result:= 'Menu';
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
   118: Result:= 'TreeView';
   119: Result:= 'TableView';
   120: Result:= 'GraphicsView';
  end;
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
  Python2DelphiCursorTranslate:= TDictionary<string, string>.Create;
  Delphi2PythonCursorTranslate:= TDictionary<string, string>.Create;

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
  GPythonCursorText:= PythonTkCursorText;
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
  Python2DelphiCursorTranslate:= TDictionary<string, string>.Create;
  Delphi2PythonCursorTranslate:= TDictionary<string, string>.Create;

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
  GPythonCursorText:= PythonQtCursorText;
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

function Python2DelphiColors(Str: string): string;
begin // used to show color combo box
  if not Python2DelphiColorTranslate.TryGetValue(Str, Result) then
    Result:= 'clBtnFace';
end;

function Delphi2PythonColors(Str: string): string;
begin
  if not Delphi2PythonColorTranslate.TryGetValue(Str, Result) then begin
    if Copy(Str, 1, 3) = '$00' then
      Str:= '#' + Copy(Str, 8, 2) + Copy(Str, 6, 2) + Copy(Str, 4, 2)
    else if Str = '' then
      Str:= 'SystemButtonFace';
    Result:= Str;
  end;
end;

function Python2DelphiCursor(Str: string): string;
begin
  if not Python2DelphiCursorTranslate.TryGetValue(Str, Result) then
    Result:= 'crDefault';
end;

function Delphi2PythonCursor(Str: string): string;
begin
  if not Delphi2PythonCursorTranslate.TryGetValue(Str, Result) then
    Result:= 'default';
end;

function Delphi2PythonValues(Str: string): string;
begin
  if not Delphi2PythonValuesAndNamesTranslate.TryGetValue(Str, Result) then
    Result:= Str;
end;

function TurnRGB(const Str: string): string;
begin
  Result:= Str;
  if Copy(Str, 1, 2) = '0x' then
    Result:= '0x' + Copy(Str, 7, 2) + Copy(Str, 5, 2) + Copy(Str, 3, 2);
end;

function TColorToString(Color: TColor): string;
  var Str: string;
begin
  Str:= ColorToString(Color);
  Str:= Delphi2PythonColors(Str);
  if Copy(Str, 1, 2) = 'cl' then
    FmtStr(Str, '%Str%.8x', [HexDisplayPrefix, Color]);
  if Copy(Str, 1, 2) = '$0' then
    Str:= '#' + Copy(Str, 8, 2) + Copy(Str, 6, 2) + Copy(Str, 4, 2);
  Result:= Str;
end;

initialization
  Python2DelphiColorTranslate:= TDictionary<string, string>.Create;
  Delphi2PythonColorTranslate:= TDictionary<string, string>.Create;

  Python2DelphiCursorTranslate:= nil;
  Delphi2PythonCursorTranslate:= nil;

  Python2DelphiValuesAndNamesTranslate:= TDictionary<string, string>.Create;
  Delphi2PythonValuesAndNamesTranslate:= TDictionary<string, string>.Create;

  CreateColors;
  CreateTkCursors;
  CreateValuesAndNames;

finalization
  FreeAndNil(Python2DelphiColorTranslate);
  FreeAndNil(Delphi2PythonColorTranslate);

  FreeAndNil(Python2DelphiCursorTranslate);
  FreeAndNil(Delphi2PythonCursorTranslate);

  FreeAndNil(Python2DelphiValuesAndNamesTranslate);
  FreeAndNil(Delphi2PythonValuesAndNamesTranslate);
end.
