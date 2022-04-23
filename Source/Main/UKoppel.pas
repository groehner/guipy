unit UKoppel;

interface

uses Graphics, Classes;

Const
  PythonCursorText = 'default'#13#10'fleur'#13#10'hand2'#13#10'sb_h_double_arrow'#13#10'sb_v_double_arrow'#13#10 +
                     'sizing'#13#10'tcross'#13#10'watch'#13#10'xterm'#13#10'question_arrow'#13#10'center_ptr';

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


{  PythonCursorText = 'default'#13#10'X_cursor'#13#10'based_arrow_down'#13#10'based_arrow_down'#13#10'boat'#13#10 +
                     'bogosity'#13#10'bogosity'#13#10'bottom_right_corner'#13#10'bottom_side'#13#10 +
                     'bottom_tee'#13#10'box_spiral'#13#10'center_ptr'#13#10'circle'#13#10'circle'#13#10 +
                     'coffee_mug'#13#10'dot'#13#10'dotbox'#13#10'double_arrow'#13#10'draft_large'#13#10 +
                     'draft_small'#13#10'draped_box'#13#10'exchange'#13#10'fleur'#13#10'gobbler'#13#10 +
                     'gumby'#13#10'hand1'#13#10'hand2'#13#10'heart'#13#10'icon'#13#10 +
                     'iron_cross'#13#10'left_ptr'#13#10'left_side'#13#10'left_tee'#13#10'leftbutton'#13#10 +
                     'll_angle'#13#10'lr_angle'#13#10'man'#13#10'middlebutton'#13#10'mouse'#13#10 +
                     'pencil'#13#10'pirate'#13#10'plus'#13#10'question_arrow'#13#10'right_ptr'#13#10 +
                     'right_side'#13#10'right_tee'#13#10'rightbutton'#13#10'rtl_logo'#13#10'sailboat'#13#10 +
                     'sb_down_arrow'#13#10'sb_v_double_arrow'#13#10'sb_h_double_arrow'#13#10'sb_left_arrow'#13#10'circle'#13#10 +
                     'sb_right_arrow'#13#10'shuttle'#13#10'sizing'#13#10'spider'#13#10'spraycan'#13#10 +
                     'star'#13#10'target'#13#10'tcross'#13#10'tcross'#13#10'top_left_corner'#13#10 +
                     'top_right_corner'#13#10'box_spiral'#13#10'center_ptr'#13#10'circle'#13#10'circle'#13#10 +
                     'sb_down_arrow'#13#10'top_side'#13#10'top_tee'#13#10'trek'#13#10'ul_angle'#13#10 +
                     'watch'#13#10'xterm';
 }

  MouseEvents1    = '|ButtonPress|ButtonRelease|Motion';
  MouseEvents2    = '|Enter|Leave|MouseWheel';

  KeyboardEvents1 = '|KeyPress|KeyRelease';

  MiscEvents      = '|Activate|Deactivate|Configure|FocusIn|FocusOut';

  AllEvents       =  MouseEvents1 + MouseEvents2 + KeyboardEvents1 + MiscEvents + '|';

  AllCommands     = '|Command|PostCommand|InvalidCommand|ValidateCommand|';

var
  ComponentNrToInsert: integer;
  PanelCanvasType: string;
  SelectStrings: TStrings;
  LOldValue: String;

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
  function isCommand(s: string): boolean;

implementation

uses SysUtils, System.Generics.Collections;

var
  Delphi2PythonTranslate: TDictionary<String, String>;
  Pyhton2DelphiTranslate: TDictionary<String, String>;

// also: function TFGuiDesigner.Tag2Class(Tag: integer): TControlClass;

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
  end;
end;

procedure CreateColors;

  procedure AddColor(s1, s2: string);
  begin
     Delphi2PythonTranslate.Add(s1, s2);
     Pyhton2DelphiTranslate.Add(s2, s1);
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

procedure CreateValuesAndNames;

  procedure AddTranslate(s1, s2: string);
  begin
     Delphi2PythonTranslate.Add(s1, s2);
     Pyhton2DelphiTranslate.Add(s2, s1);
  end;

begin
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
  //AddTranslate('False', 'false');
  //AddTranslate('True', 'True');
  AddTranslate('_To', 'To');
  AddTranslate('fsBold', 'Bold');
  AddTranslate('fsItalic', 'Italic');
  AddTranslate('Caption', 'Title');
  AddTranslate('Left', 'X');
  AddTranslate('Top', 'Y');
end;

function Python2DelphiColors(s: string): string;
begin // used to show color combo box
  if not Pyhton2DelphiTranslate.TryGetValue(s, Result) then
    Result:= 'clBtnFace';
end;

function Delphi2PythonColors(s: string): string;
begin
  if not Delphi2PythonTranslate.TryGetValue(s, Result) then begin
    if copy(s, 1, 3) = '$00' then
      s:= '#' + copy(s, 8, 2) + copy(s, 6, 2) + copy(s, 4, 2)
    else if s = '' then
      s:= 'SystemButtonFace';
    Result:= s;
  end;
end;

function Python2DelphiCursor(s: string): string;
begin
  if not Pyhton2DelphiTranslate.TryGetValue(s, Result) then
    Result:= 'crDefault';
end;

function Delphi2PythonCursor(s: string): string;
begin
  if not Delphi2PythonTranslate.TryGetValue(s, Result) then
    Result:= 'default';
end;

function Delphi2PythonValues(s: string): string;
begin
  if not Delphi2PythonTranslate.TryGetValue(s, Result) then
    Result:= s;
end;

function Python2DelphiValues(s: string): string;
begin
  if not Pyhton2DelphiTranslate.TryGetValue(s, Result) then
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
begin
  Result:= (Pos(s, AllEvents) > 0);
end;

function isCommand(s: string): boolean;
begin
  Result:= (Pos(s, AllCommands) > 0);
end;

Initialization
  SelectStrings:= TStringlist.Create;
  Pyhton2DelphiTranslate:= TDictionary<String, String>.Create;
  Delphi2PythonTranslate:= TDictionary<String, String>.Create;

  CreateColors;
  CreateValuesAndNames;

Finalization
  SelectStrings.Destroy;
  Pyhton2DelphiTranslate.Destroy;
  Delphi2PythonTranslate.Destroy;

end.
