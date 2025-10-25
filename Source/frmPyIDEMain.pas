{ -----------------------------------------------------------------------------
  Unit Name: frmPyIDEMain
  Author:    Kiriakos Vlahos
  #          Gerhard Röhner
  Date:      11-Feb-2005
  Purpose:   The main form of the Python IDE

  History:   v 1.1
  Improved Python Syntax highlighting
  HTML documentation and disassembly views (Tools, Source Views menu)
  TODO list view
  Find and Replace in Files
  Powerful parameter functionality (see parameters.txt)
  Parameterized Code Templates (Ctrl-J)
  Accept files dropped from Explorer
  File change notification
  sys.stdin and raw_input implemented
  Choice of Python version to run via command line parameters
  External Tools (External run and caputure output)
  Integration with Python tools such as PyLint
  Run Python Script externally (highly configurable)
  Persist and optionally reopen open files
  Bug fixes
  History:   v 1.2
  Updated the User Interface using Themes
  Messages History
  Previous/Next identifier reference (as in GExperts)
  Find Definition/Find references using BicycleRepairMan
  Find definition by clicking as in Delphi
  Reduced flicker on start and exit and somewhat on resizing**
  Converting line breaks (Windows, Unix, Mac)
  Detecting loading/saving UTF-8 encoded files
  Help file and context sensitive Help
  Check for updates

  History:   v 1.3
  Code completion in the editor (Press Ctrl+Space while or before typing a name)
  Parameter completion in the editor (Press Shift+Ctrl+Space)
  Find definition and find references independent of
  BicycleRepairMan and arguably faster and better
  Find definition by clicking works for imported modules and names
  Revamped Code Explorer Window featuring incremental search, properties,
  global variables, docstrings in hints etc.
  A new feature-rich Python code parser was developed for implementing the above
  Improved the Variable Windows
  shows interpreter globals when not debugging and Doc strings
  Improved code and parameter completion in the interactive interpreter
  Integrated regular expression tester
  Code and debugger hints
  Set the current directory to the Path of the running script
  Added IDE option MaskFUPExceptions for resolving problems in importing Scipy
  Tested with FastMM4 for memory leaks etc. and fixed a couple of related bugs

  Note on Code and Parameter completion:
  The code and parameter completion should be one of the best you can
  find in any Python IDE.  However,if you find that code and parameter
  completion is not very accurate for certain modules and packages
  such as wxPython and scipy you can achieve near perfect completion
  if you add these packages to the IDE option "Special Packages"
  (comma separated text). By default it is set to "wx, scipy". Special
  packages are imported to the interpreter instead of scanning their
  source code.

  History:   v 1.5
  New Features
  Unit test integration (Automatic generation of tests, and testing GUI)
  Added highlighting of HTML, XML and CSS files
  Command line parameters for scripts run internally or debugged
  Conditional breakpoints
  Persistence of breakpoints, watches, bookmarks and file positions
  Save and restore IDE windows FLayouts
  Generate stack information when untrapped exceptions occur and give
  users the option to mail the generated report
  Running scripts does not polute the namespace of PyScripter
  Names in variables window are now sorted
  Allow only a single Instance of Pyscripter and open command line
  files of additional invocations at new tabs
  Interpreter window is now searchable
  Added option to File Explorer to browse the directory of the Active script
  New distinctive application icon thanks to Frank Mersmann and Tobias Hartwich
  IDE shortcut customization
  File Explorer autorefreshes
  Improved bracket highlighting
  Copy to Clipboard Breakpoins, Watches and Messages
  User customization (PyScripter.ini) is now stored in the user's
  Application Data direcrory to support network installations(breaking change)
  To restore old settings copy the ini file to the new location.
  Bug fixes
  Resolved problems with dropping files from File Explorer
  Restore open files options not taken into account
  Resolved problems with long Environment variables in Tools Configure
  Resolved problems with help files
  Reduced problems with running wxPython scripts
  Changing the Python Open dialog filter did not affect syntax highlighting
  CodeExplorer slow when InitiallyExpanded is set
  Help related issues
  Other fixes.

  History:   v 1.7.1
  New Features
  Unicode based editor and interactive interpreter
  Full support for Python source file encodings
  Support for Python v2.5 and Current User installations
  Check syntax as you type and syntax hints (IDE option)
  Tab indents and Shift-Tab unindents (Editor Options - Tab Indents)
  Editor Zoom in/out with keyboard Alt+- and Ctrl+mouse wheel
  Improved Debugger hints and completion in the interpreter
  work with expressions e.g. sys.Path[1].
  for debugger expression hints place the cursor on ')' or ']'
  Improved activation of code/debugger hints
  IDE options to Clean up Interpreter namespace and sys.modules after run
  File Open can open multiple files
  Syntax highlighting scheme selection from the menu
  File filters for HTML, XML and CSS files can be customized
  Option to disable gutter Gradient (Editor Options - Gutter Gradient)
  Option to disable theming of text selection (Editor Options - theme selection)
  Option to hide the executable line marks.
  Active Line Color Editor option added.  Set to None to use default background
  Files submenu in Tabs popup for easy open file selection
  Add Watch at Cursor added to the Run menu and the Waches Window popup menu
  Pop up menu added to the External Process indicator to allow easy termination of such processes
  If the PyScripter.ini file exists in PyScripter directory it is used in preference to the User Directory
  in order to allow USB storage installations
  Editor options for each open file are persisted
  Improved speed of painting the Interpreter window
  Auto close brackets
  Interactive Interpreter Pop up menu with separately persisted Editor Options
  Toggle comment (Ctrl+^) in addition to comment/uncomment
  File Explorer improvements (Favorites, Create New Folder)
  File Templates
  Windows Explorer file association (installation and IDE option)
  Command line history
  Color coding of new and changed variables in the Variables Window
  Repeat scrolling of editor tabs
  Massively improved start up time
  Faster Python source file scanning
  Bug fixes
  Gutter glyphs painted when gutter is invisible
  Bracket highlighting related bugs
  Selecting whole lines by dragging mouse in the gutter sets breakpoint
  Speed improvements and bugfixes related to FLayouts
  Error in Variable Windows when showing dictionaries with non string keys
  File notification error for Novell network disks
  Wrong line number in External Run traceback message
  No horizontal scroll in output window
  Code completion Error with packages containing module with the same name
  Problems with sys.stdin.readline() and partial line output (stdout) statements
  Infinite loop when root of package is the top directory of a drive
  Infinite loop with cyclical Python imports

  History:   v 1.7.2
  New Features
  Store toolbar positions
  Improved bracket completion now also works with strings (Issue #4)
  Bug fixes
  Bracket highlighting with non default background
  Opening wrongly encoded UTF8 files results in empty module
  File Format (Line End) choice not respected
  Initial Empty module was not syntax highlighted
  Save As dialog had no default extension set
  Unit Testing broken (regression)
  Gap in the default tool bar (Issue #3)

  History:   v 1.9.9.6
  New Features
  Remote interpreter and debugger
  Python 2.6, 3.0 and 3.1 support
  Project Explorer supporting multiple run configurations with advanced options
  New debugger command: Pause
  Execute selection command added (Ctrl-F7)
  Interpreter command history improvements:
  - Delete duplicates
  - Filter history by typing the first few command characters
  - Up|Down keys at the prompt recall commands from history
  Code Explorer shows imported names for (from ... import) syntax (Issue 12)
  Improved sort order in code completion
  Save modified files dialog on exit
  Finer control on whether the UTF-8 BOM is written
  - Three file encodings supported (ANSI, UTF-8, UTF-8 without BOM)
  IDE option to detect UTF-8 encoding (useful for non-Python files)
  IDE options for default line breaks and encoding for new files
  Warning when file encoding results in information loss
  IDE option to position the editor tabs at the top
  IDE window navigation shortcuts
  Pretty print interpreter output option (on by default)
  Pyscripter is now Vista ready
  Docking window improvements
  PYTHONDLLPATH command line option so that Pyscripter can work with unregistered Python
  Watches Window: DblClick on empty space adds a watch, pressing Delete deletes (Issue 45)
  Wrapping in Search & Replace (Issue 38)
  New IDE Option "Save Environment Before Run"  (Issue 50)
  New IDE command Restore Editor pair to Maximize Editor (both work by double clicking  the TabControl)
  New IDE Option "Smart Next Previous Tab" (z-Order) on by default (Issue 20)
  Word Wrap option exposed in Editor Options
  New File Reload command
  Import/Export Settings (Shortcuts, Highlighter schemes)
  New IDE option "Auto-reload changed files" on by default (Issue 25)
  New menu command to show/hide the menu bar.  The shortcut is Shift-F10 (Issue 63)
  New command line option --DPIAWARE (-D) to avoid scaling in VISTA high DPI displays (Issue 77)
  New command line option --NEWINSTANCE (-N) to start a new instance of PyScripter
  You can disable a breakpoint by Ctrl+Clicking in the gutter
  Syntax Errors are indicated by icon in the TabControl (Issue 93)
  Command to jump to the first syntax error (Shift+Ctrl+E)
  New Firefox-like search/replace interface
  Incremental Search (Issue 100)
  New command "Highlight search text" (Shift+Ctrl+H)
  New command line option --DEBUG (-B) to use debug version of Python dll (Issue 108)
  New command "Word wrap" visible in the Editor toolbar (Issue 112)
  New command "Go to Debugger Position" (Issue 118)
  The size of the auto completion list is now persisted
  Split Editor View (Issue 31)
  New parameter $[CmdLineArgs] that returns the active command line arguments
  and can be used with external tools
  New IDE options "Editor code completion" and "Interpreter code completion"
  which can be used to disable code completion
  New IDE option "Show Tab Close Button"
  New debugger command "Post mortem" (Issue 26)
  New IDE option "Post mortem on exception"
  Auto-resizing the fields of list views by double clicking on column separators
  Advanced search and replace external tool added (uses re.sub)
  Enhanced Execute Selection command (Issue 73)
  Two new IDE options added (Dock Animation Interval and Dock Animation Move Width - Issue 134)
  Toolbar customization
  Two new IDE options added ("Interpreter History Size" and "Save Command History") (Issue 131)
  Cut and copy without selection now cut and copy the current line (as in Visual Studio, Issue 64)
  Removed the Interpeter options "Clean up Namespace" and "Clean up sys.modules"
  Improved HTML, XML highlighting with code completion and Web preview
  C/C++ highlighting added
  Two new interpreter commands added: Copy without prompts, and Paste with prompts (Issue 183)
  Localization using gettext
  YAML highlighter added
  Ability to run initialization scripts (see help file)
  Bug fixes
  Shell Integration - Error when opening multiple files
  Configure External Run - ParseTraceback not saved properly
  Order of tabs not preserved in minimised docked forms
  sys.argv contained unicode strings instead of ansi strings
  Bug fixes and improvements in Editor Options Keystrokes tab (Issue 6)
  Better error handling of File Open and File Save
  Page Setup Header and Footer not saved  (Issue 7)
  Hidden Tabbed windows reappearing when restarting
  Duplicate two-key editor command not detected
  "Clean up namespace" and "Clean up sys modules" settings
  become effective after restarting PyScripter
  Exception when setting the Active Line Color in Editor Options dialog
  Raw_input does not accept unicode strings
  Error in docstring extraction (Issue 11)
  Fixed some problems with the toggle comment command
  Fixed rare bug in restoring layout
  Code tips wrong if comments are present among parameters (Issue 15)
  Notification of file changes can miss files (Issue 17)
  Certain syntax coloring options were not saved
  ToDo List did not support encoded files and unicode
  ToDo List did not support multiline comments (Issue 14)
  Fixed bug in IDE Shortcuts dialog
  Swapped the positions of the indent/dedent buttons (Issue 23)
  Syntax highlighter changes to the interpreter are not persisted
  Multiple target assignments are now parsed correctly
  Gutter gradient setting not saved
  Handling of string exceptions
  Disabling a breakpoint had no effect
  Tab order not preserved when restarting PyScripter
  Disassembly and Documentation views not working with remote engines
  PyScripter "freezes" when displaying modal dialogs when running GUI scripts with remote engines
  More robust "Reinitialize" of remote Python engines (Issues 143, 145)
  Shift-Tab does not work well with the Trim Trailing Spaces editor option
  Issues 28, 32, 39, 40, 41, 46, 47, 48, 49, 52, 55, 56, 57, 65, 66, 67, 70,
  71, 72, 74, 75, 76, 81, 82, 83, 86, 88, (89), 90, 91, 92, 94, 96, 98, 99
  100, 102, 105, 106, 107, 109, 113, 117, 119, 120, 122, 123, 125,
  132, 134, 135, 136, 137, 138, 139, 140, 141, 146, 147, 150, 153, 155,
  160, 164, 165, 166, 167, 168, 169, 171, 174, 178, (182), 186,
  193, 195, 196, 197, 198, 201, 202, 204, 206, 208, 212, 219, 226,
  228, 229, 234, 235, 237, 253, 261 fixed

  History:   v 1.9.9.7
  New Features
  Updated theme engine with customizable themes
  Python 3.1 support
  Bug fixes
  Issues  269, 273, 287, 291, 292

  History:   v 2.0
  New Features
  Support for Python 2.7
  Moved to Rpyc v3.07, now bundled with PyScripter
  IDE Option "Reinitialize before run" was added defaulting to True
  The default Python engine is now the remote engine
  Spanish translation by Javier Pim�s (incomplete) was added
  Bug fixes
  Issues  236, 304, 322, 333, 334
  History:   v 2.1.1
  New Features
  Support for Python 3.2
  New IDE Option added "Jump to error on Exception"  (Issue 130)
  New IDE Option added "File template for new Python scirpts"  (Issue 385)
  New IDE Option added "Auto completion font"  (Issue 365)
  French translation by Groupe AmiensPython added
  Bug fixes
  Issues  297, 307, 346, 354, 358, 371, 375, 376, 382, 384, 387, 389

  History:   v 2.3.3
  New Features
  Native unicode strings throught (speed improvements on XP)
  Revamped Code Explorer (Issues 192, 163, 213, 225)
  Improvements to Code completion
  -  Auto-completion for the import statement in Python 2.5 and later (Issue 230)
  -  Processing of function return statements
  -  Background module parsing and caching of parsed modules
  Start-up Python scripts pyscripter_init.py and python_init.py. See help file for details.
  Imporved "Match Brace" (Issue 426) and New Editor Command "Select to brace"
  Italian translation by Vincenzo Demasi added
  Russian translation by Aleksander Dragunkin added
  New IDE option "Highlight selected word" (Issue 404)
  New IDE option "Use Python colors in IDE"
  New Edit command "Copy File Name" available at the contex menu of the tab bar
  New commands "Previous Frame", "Next Frame" to change frame using the keyboard (Issue 399)
  JavaScript and PHP Syntax Highlighters added
  Issues addressed
  103, 239, 267, 270, 271, 294, 317, 324, 343, 378,
  395, 403, 405, 407, 411, 412, 413, 419, 421, 422,
  425, 432

  History:   v 2.3.4
  New Features
  Compatibility with Python 3.1.3rc, 3.2a4
  Add watches by dragging and dropping text
  Ctrl + Mouse scroll scrolls whole pages in print preview
  Search for custom skins first in the Skins subdirectory of the Exe file if it exists
  Issues addressed
  430, 434, 435, 439, 440, 441, 443, 446

  History:   v 2.4.1
  New Features
  Side-by-side file editing (Issue 214)
  Enhanced regular expression window (findall - Issue 161)
  Open file at a specific line:column (Issue 447)
  Issues addressed
  Reduced flicker when resizing form and panels
  415, 437, 449

  History:   v 2.4.3
  New Features
  100% portable by placing PyScripter.ini in the PyScripter exe directory
  Ctrl+Mousewheel for zooming the interpreter (Issue 475)
  Show docstrings during completion list (Issue 274)
  New IDE Option "File Change Notification" introduced with possible
  values Full, NoMappedDrives(default), Disabled (Issue 470)
  Background color for Matching and Unbalanced braces (Issue 472)
  New IDE option "Case Sensitive Code Completion" (default True)
  New IDE option "Complete Python keywords" (default True)
  New IDE option "Complete as you type" (default True, Issue 473)
  New IDE option "Complete with word-break chars" (default True)
  New IDE option "Auto-complete with one entry" (default True, Issue 452)
  Issues addressed
  Command line history not saved
  Editing a watch to an empty string crashes PyScripter
  Replace in Find-in-Files now supports subexpression substitution (Issue 332)
  Import statement completion does not include builtin module names
  461, 463, 468, 471, 474, 478, 488, 496, 504, 508,
  509, 511, 512, 515, 525, 526, 527, 528, 532, 559, 560

  History:   v 2.5.1
  New Features
  This is the first joint 32-bit and 64-bit version release
  Python 3.3 support added
  Recent Projects menu item added
  Expandable lists and tuples in the Variables window (Issue 583)
  Expandable watches as in the Variables window (Issue 523)
  Basic support for Cython files added (Issue 542)
  New interpreter action Paste & Execute (Issue 500) Replaces Paste with Prompt
  New PyIDE option "Display package names in editor tabs" default True (Issue 115)
  New search option "Auto Case Sensitive" (case insensitive when search text is lower case)
  The Abort command raises a KeyboardInterrupt at the Remote Engine (Issue 618)
  Incremental search in the Project Explorer matches any part of a Filename (Issue 623)
  New IDE option "File line limit for syntax check as you type" default 1000
  Issues addressed
  516, 348, 549, 563, 564, 568, 576, 587, 591, 592,
  594, 597, 598, 599, 612, 613, 615

  History:   v 2.5.1
  New Features
  Issues addressed
  639, 657, 673
  History:   v 2.6
  New Features
  Compatibility with Python 3.4
  History:   v 3.0
  New Features
  Python 3.5, 3.6 and 3.7 support
  New Style Engine (VCL Styles) with high quality choices
  Visual Style Preview and selection (View, Select Style)
  Visual Source highligther theme selection (Editor Options, Select theme)
  German Translation added

  History:   v 3.1
  New Features
  Code folding
  Indentation lines
  New IDE option "Compact line numbers"
  pip tool added
  Internal Interpreter is hidden by default
  Kabyle language added
  Issues addressed
  16, 571, 685, 690, 718, 721, 765, 814, 836

  History:   v 3.2
  New Features
  Dpi awareness (Issue 769)
  Issues addressed
  #705 #711 #717, #748

  History:   v 3.3
  New Features
  Thread debugging (#455)
  Much faster Python output redirection
  Form Layout and placement stored in PyScripter.local.ini
  Issues addressed
  #659, #827, #848, #849

  History:   v 3.4
  New Features
  Switch Python Engines without exiting PyScripter
  Faster loading times
  Initial support for running Jupyter notebooks inside PyScripter
  Syntax highlighting for JSON files
  New IDE option "Style Main Window Border"
  Find in Files and ToDo folders can include parameters (#828)
  Issues addressed
  #627, #852, #858, #862, #868, #872

  History:   v 3.4.2
  New Features
  New Edit Command Read Only (#883)
  Files opened by PyScripter from the Python directory during debugging
  are read only by default to prevent accidental changes.
  Close All to the Right Editor command added (#866)
  New editor parameter [$-CurLineNumber] (#864)
  New IDE Option "File Explorer background processing'. Set to False
  if you get File Explorer errors
  Console output including multiprocessing is now shown in interpreter #891
  Issues addressed
  #645, #672, #722, #762, #793, #800, #869, #879, #889, #890,
  #893, #896, #898, #899, #906

  History:   v 3.5
  New Features
  Open and work with remote files from Windows and Linux machines as if they were local
  Run and Debug scripts on remote Windows and Linux machines using SSH
  Python 3 type hints used in code completion
  Connection to Python server with Windows named pipes. Avoids firewall issues.
  Requires the installation of pywin32 (pip install pywin32).
  IDE option to force the use of sockets for connection to the Python server.  (default True)
  New Editor commands Copy Line Up/Down (Shift+Alt+Up/Down) and
  Move Line Up/Down (Alt + Up/Down) as in Visual Studio
  PyScripter icons given a facelift by Salim Saddaquzzaman
  Upgraded rpyc to 4.x.  As a result Python 2.5 is no longer supported.
  Issues addressed
  #501, #682, #907

  History:   v 3.6
  New Features
  Much faster Remote Engine using asynchronous Windows named pipes if pywin32 is available.
  IDE option to force the use of sockets for connection to the Python
  server now defaults to False
  Enhancements to the SSH Engine - now compatible with PuTTY
  Execute system commands in the interpreter with !. Supports parameter substitution.
  Clickable status panels with Python version and engine type
  Text drag & drop between PyScripter and other applications (#554)
  Triple-click selects line and Quadraple-click selects all
  Double-click drag selects whole words - triple-click drag selects whole lines
  Consistent syntax color themes accross supported languages (#855)
  New IDE option "Trim trailing spaces when saving files" (#667)
  New IDE Option 'Step into open files only'.  Defaults to False. (#510)
  Localization of the installer
  Issues addressed
  #624, #743, #857, #904, #922, #927, 928, #929, #936

  History:   v 3.6.1
  New Features
  Python 3.8 support.  Dropped support for Python 3.0 and 3.1.
  Compatibility with conda distributions
  JSON and YAML file templates added
  Three new styles added (Windows10BlackPearl, Windows10BlueWhale, Windows10ClearDay)
  Translation improvements
  "Always Use Sockets" IDE option is True by default (#938)
  Issues addressed
  #311, #941, #955

  History:   v 3.6.2
  New Features
  Improved compatibility with venv virtual environments
  Restore code folding state when you start PyScripter (#973)
  Syntax for adding and removing parameters (#971)
  $[proc=?Question] adds parameter proc and $[proc=] removes it
  Highlighters and styles are now installed under ProgramData
  Improved DPI scaling
  Two new styles added (Calypso and Stellar)
  Issues addressed
  #948, #962, #966, #967, #968, #972

  History:   v 3.6.3
  New Features
  The status panel with text position info can now be clicked to
  show the "Go to line" dialog.
  Issues addressed
  #983, #985

  History:   v 3.6.4
  New Features
  Added support for Python 3.9 (and removed support for Python 2.6)
  Added support for virtualenv v20+.  Dropped support for earlier versions.
  Added support for font ligatures
  Issues addressed
  #998, #1001, #1003, #1008, #1009

  History:   v 4.0
  New Features
  Major redesign of the User Interface - Material icons and new logo
  Re-architecture the interaction with python, code-completion etc.
  It should result in a more responsive user experience without delays and freezes.
  Added support for Python 3.10
  Removed support for Python 2.7, 3.2
  Installer and executable are now code-signed
  Persian translation added
  New IDE option "Restore open project"
  New File Explorer command "Select Directory..." (#1034)
  Issues addressed
  #824, #990, #1031, #1035, #1038, #1039, #1040, #1105, #1109, #1111

  History:   v 4.1
  New Features
  - Implementation of the Language Server Protocol
  - Python language support provided by the Jedi language server
  - Two new styles added Windows11_Light and Windows11_Dark
  - Copy and paste code as html to Powerpoint and other applications
  - Removed support for python 3.3-3.5
  - Read only indicator on tabs
  - Added traditional Chinese translation
  Issues addressed
  #939, #951, #1116, #1118, #1119, #1122, #1123, #1125, #1129, #1133
  #1136

  History:   v 4.2
  New Features
  - Python 3.11 support added - Support for python 3.6 removed
  - Spell checking of comments and strings #84
  - Track changes bar as in Visual Studio
  - Editor Unicode handling improvements (emojis, bi-directional text, etc.)
  - Editor selection options (alpha blending, fill whole lines)
  - Portuguese translations (pt_PT, pt_BR) added
  Issues addressed
  #1140, #1146, #1149, #1151, #1163, #1165

  History:   v 4.2.2
  New Features
  - Internet Explorer replaced with the Edge browser
  - Added Format Selection external tool using the "black" module
  - New IDE option 'Automatic Restart' (#1188)
  - Recovery of unsaved files on system shutdown or application crash
  - New IDE command "Zoom Reset" Atl+Num 0 (#650)
  - Two new styles added: Windows 11 Polar Dark and Windows 11 Polar Light
  Issues addressed
  #1152, #1155, #1177, #1181, #1182, #1183, #1185, #1186, #1187, #1189

  History:   v 4.2.6
  New Features
  Issues addressed
  #1195

  History:   v 4.2.8
  New Features
  - Python 3.12 support added
  - Improved display in multi-monitor setups
  - Customizable user interface content font size (#1209)
  - Screen reader support in the editor
  Issues addressed
  #1172, #1195, #1197, #1198, #1199, #1208, #1210, #1214

  History:  v 1.0.0
  First published GuiPy version.

}

{ TODO: Review Search and Replace }
{ TODO: Auto PEP8 tool }
{ TODO: LiveTemplates features for Code Templates }

{ ------------------------------------------------------------------------------ }

// Bugs and minor features
// TODO: Internal Tool as in pywin
// TODO: Find module expert
// TODO: Code helpers, automatically fill the self parameter in methods

// TODO: UML Editor View
// TODO: Refactorings

// TODO: Plugin architecture
// TODO Package as an Application Scripter Component

unit frmPyIDEMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Actions,
  System.ImageList,
  System.Messaging,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  Vcl.DdeMan,
  Vcl.ToolWin,
  Vcl.Menus,
  Vcl.WinXCtrls,
  SVGIconImageCollection,
  JclSysUtils,
  JvAppInst,
  JvDockControlForm,
  JvAppStorage,
  JvAppIniStorage,
  JvDSADialogs,
  JvComponentBase,
  TB2Dock,
  TB2Toolbar,
  TB2Item,
  SpTBXCustomizer,
  SpTBXSkins,
  SpTBXItem,
  SpTBXEditors,
  SpTBXMDIMRU,
  SpTBXTabs,
  SpTBXDkPanels,
  SynEditMiscClasses,
  SynEdit,
  uEditAppIntfs,
  cFileTemplates,
  cPySupportTypes,
  frmEditor,
  UUMLForm,
  UGUIForm,
  UBrowser;

const
  WM_FINDDEFINITION = WM_USER + 100;
  WM_CHECKFORUPDATES = WM_USER + 110;
  WM_SEARCHREPLACEACTION = WM_USER + 130;

type
  { Interposer class to add functionality to TTSpTBXTabControl }
  TSpTBXTabControl = class(SpTBXTabs.TSpTBXTabControl)
  private
    FZOrder: TList;
    FZOrderPos: Integer;
    FZOrderProcessing: Boolean;
  public
    procedure WMDropFiles(var Msg: WinApi.Messages.TMessage); message WM_DROPFILES;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ZOrder: TList read FZOrder write FZOrder;
  end;

  TPyIDEMainForm = class(TForm, IIDELayouts, IPyIDEServices)
    DockServer: TJvDockServer;
    AppStorage: TJvAppIniFileStorage;
    MachineStorage: TJvAppIniFileStorage;
    BGPanel: TPanel;
    TBXDockTop: TSpTBXDockablePanel;
    MainMenu: TSpTBXToolbar;
    FileMenu: TSpTBXSubmenuItem;
    mnNewModule: TSpTBXItem;
    mnFileOpen: TSpTBXItem;
    N14Sep: TSpTBXSeparatorItem;
    mnFileClose: TSpTBXItem;
    mnFileCloseAll: TSpTBXItem;
    N1Sep: TSpTBXSeparatorItem;
    mnFileSave: TSpTBXItem;
    mnFileSaveAs: TSpTBXItem;
    mnFileSaveAll: TSpTBXItem;
    N2Sep: TSpTBXSeparatorItem;
    PageSetup1: TSpTBXItem;
    PrinterSetup1: TSpTBXItem;
    PrintPreview1: TSpTBXItem;
    Print1: TSpTBXItem;
    N4Sep: TSpTBXSeparatorItem;
    mnFileExit: TSpTBXItem;
    EditMenu: TSpTBXSubmenuItem;
    mnEditUndo: TSpTBXItem;
    mnEditRedo: TSpTBXItem;
    N5Sep: TSpTBXSeparatorItem;
    mnEditCut: TSpTBXItem;
    mnEditPaste: TSpTBXItem;
    mnEditDelete: TSpTBXItem;
    mnEditSelectAll: TSpTBXItem;
    N6Sep: TSpTBXSeparatorItem;
    mnEditParameters1: TSpTBXSubmenuItem;
    mnInsertParameter: TSpTBXItem;
    mnInsertModifier: TSpTBXItem;
    N16Sep: TSpTBXSeparatorItem;
    mnReplaceParameter: TSpTBXItem;
    mnIsertCodeTemplate: TSpTBXItem;
    mnSourceCode: TSpTBXSubmenuItem;
    mnIndentBlock: TSpTBXItem;
    mnDedentBlock: TSpTBXItem;
    mnToggleComment: TSpTBXItem;
    mnTabify: TSpTBXItem;
    mnUnTabify: TSpTBXItem;
    SearchMenu: TSpTBXSubmenuItem;
    mnSearchFind: TSpTBXItem;
    mnSearchFindNext: TSpTBXItem;
    mnSearchFindPrevious: TSpTBXItem;
    mnSearchReplace: TSpTBXItem;
    N15Sep: TSpTBXSeparatorItem;
    mnFindinFiles: TSpTBXItem;
    N7Sep: TSpTBXSeparatorItem;
    mnGoToLine: TSpTBXItem;
    mnFindFunction: TSpTBXItem;
    N23Sep: TSpTBXSeparatorItem;
    mnMatchingBrace: TSpTBXItem;
    RunMenu: TSpTBXSubmenuItem;
    mnSyntaxCheck: TSpTBXItem;
    mnImportModule: TSpTBXItem;
    mnRun: TSpTBXItem;
    N22Sep: TSpTBXSeparatorItem;
    mnExternalRun: TSpTBXItem;
    mnConfigureExternalRun: TSpTBXItem;
    N8Sep: TSpTBXSeparatorItem;
    mnDebug: TSpTBXItem;
    mnRunToCursor: TSpTBXItem;
    mnStepInto: TSpTBXItem;
    mnStepOver: TSpTBXItem;
    mnStepOut: TSpTBXItem;
    mnAbortDebugging: TSpTBXItem;
    N9Sep: TSpTBXSeparatorItem;
    mnTogglebreakpoint: TSpTBXItem;
    mnClearAllBreakpoints: TSpTBXItem;
    ToolsMenu: TSpTBXSubmenuItem;
    mnPythonPath: TSpTBXItem;
    N13Sep: TSpTBXSeparatorItem;
    N20Sep: TSpTBXSeparatorItem;
    OptionsMenu: TSpTBXSubmenuItem;
    ViewMenu: TSpTBXSubmenuItem;
    mnNextEditor: TSpTBXItem;
    mnPreviousEditor: TSpTBXItem;
    N10Sep: TSpTBXSeparatorItem;
    mnuToolbars: TSpTBXSubmenuItem;
    mnViewStatusBar: TSpTBXItem;
    HelpMenu: TSpTBXSubmenuItem;
    mnHelpPythonManuals: TSpTBXItem;
    N18Sep: TSpTBXSeparatorItem;
    PyScripter1: TSpTBXSubmenuItem;
    mnHelpParameters: TSpTBXItem;
    mnHelpExternalTools: TSpTBXItem;
    N17Sep: TSpTBXSeparatorItem;
    mnHelpAbout: TSpTBXItem;
    MainToolBar: TSpTBXToolbar;
    tbiFileOpen: TSpTBXItem;
    tbiFileSave: TSpTBXItem;
    tbiFileSaveAll: TSpTBXItem;
    tbiEditUndo: TSpTBXItem;
    tbiEditRedo: TSpTBXItem;
    DebugToolbar: TSpTBXToolbar;
    tbiRunRun: TSpTBXItem;
    tbiRunDebug: TSpTBXItem;
    tbiRunRunToCursor: TSpTBXItem;
    tbiRunStepInto: TSpTBXItem;
    tbiRunStepOver: TSpTBXItem;
    tbiRunAbort: TSpTBXItem;
    TBXDockLeft: TSpTBXDock;
    TBXDockRight: TSpTBXDock;
    TBXDockBottom: TSpTBXDock;
    mnTools: TSpTBXSubmenuItem;
    TabControlPopupMenu: TSpTBXPopupMenu;
    mnNewModule2: TSpTBXItem;
    mnFileClose2: TSpTBXItem;
    mnFileCloseAll2: TSpTBXItem;
    N12Sep: TSpTBXSeparatorItem;
    RecentSubmenu: TSpTBXSubmenuItem;
    EditorViewsMenu: TSpTBXSubmenuItem;
    EditorToolbar: TSpTBXToolbar;
    tbiEditDedent: TSpTBXItem;
    tbiEditIndent: TSpTBXItem;
    TBXSeparatorItem10: TSpTBXSeparatorItem;
    tbiEditToggleComment: TSpTBXItem;
    TBXSeparatorItem11: TSpTBXSeparatorItem;
    tbiEditLineNumbers: TSpTBXItem;
    mnFindPreviousReference: TSpTBXItem;
    mnFindNextReference: TSpTBXItem;
    mnFindDefinition: TSpTBXItem;
    TBXSeparatorItem9: TSpTBXSeparatorItem;
    TBXSubmenuItem3: TSpTBXSubmenuItem;
    mnEditLBMac: TSpTBXItem;
    mnEditLBUnix: TSpTBXItem;
    mnEditLBDos: TSpTBXItem;
    TBXSeparatorItem12: TSpTBXSeparatorItem;
    mnEditUtf8: TSpTBXItem;
    mnFindReferences: TSpTBXItem;
    tbiBrowseNext: TSpTBXSubmenuItem;
    tbiBrowsePrevious: TSpTBXSubmenuItem;
    TBXSeparatorItem14: TSpTBXSeparatorItem;
    mnHelpContents: TSpTBXItem;
    mnHelpEditorShortcuts: TSpTBXItem;
    TBXSeparatorItem15: TSpTBXSeparatorItem;
    mnCheckForUpdates: TSpTBXItem;
    mnCommandLineParams: TSpTBXItem;
    mnUnitTestWizard: TSpTBXItem;
    mnLayouts: TSpTBXSubmenuItem;
    mnLayOutSeparator: TSpTBXSeparatorItem;
    TBXItem47: TSpTBXItem;
    TBXItem48: TSpTBXItem;
    TBXItem49: TSpTBXItem;
    TBXSeparatorItem17: TSpTBXSeparatorItem;
    TBXSeparatorItem18: TSpTBXSeparatorItem;
    TBXSeparatorItem19: TSpTBXSeparatorItem;
    mnNoSyntax: TSpTBXItem;
    TBXSeparatorItem20: TSpTBXSeparatorItem;
    TBXSeparatorItem21: TSpTBXSeparatorItem;
    mnSyntax: TSpTBXSubmenuItem;
    mnZoomOut: TSpTBXItem;
    mnZoomIn: TSpTBXItem;
    mnFiles: TSpTBXSubmenuItem;
    mnAddWatchAtCursor: TSpTBXItem;
    RunningProcessesPopUpMenu: TSpTBXPopupMenu;
    TBXSubmenuItem5: TSpTBXSubmenuItem;
    TBXSeparatorItem23: TSpTBXSeparatorItem;
    mnNewFile: TSpTBXItem;
    JvAppInstances: TJvAppInstances;
    mnEditAnsi: TSpTBXItem;
    mnEditUtf8NoBom: TSpTBXItem;
    mnPause: TSpTBXItem;
    mnPythonEngines: TSpTBXSubmenuItem;
    mnEngineRemoteWx: TSpTBXItem;
    mnEngineRemoteTk: TSpTBXItem;
    mnEngineRemote: TSpTBXItem;
    mnEngineInternal: TSpTBXItem;
    mnReinitEngine: TSpTBXItem;
    TBXSeparatorItem26: TSpTBXSeparatorItem;
    TBXSeparatorItem27: TSpTBXSeparatorItem;
    mnExecSelection: TSpTBXItem;
    mnViewRestoreEditor: TSpTBXItem;
    TBXSeparatorItem28: TSpTBXSeparatorItem;
    mnMaximizeEditor2: TSpTBXItem;
    mnFileReload: TSpTBXItem;
    mnImportShortcuts: TSpTBXItem;
    mnExportShortcuts: TSpTBXItem;
    TBXSeparatorItem30: TSpTBXSeparatorItem;
    mnImportHighlighters: TSpTBXItem;
    mnExportHighlighters: TSpTBXItem;
    mnViewMainMenu: TSpTBXItem;
    FindToolbar: TSpTBXToolbar;
    tbiFindLabel: TSpTBXLabelItem;
    tbiFindNext: TSpTBXItem;
    tbiFindPrevious: TSpTBXItem;
    tbiReplaceSeparator: TSpTBXSeparatorItem;
    tbiReplaceLabel: TSpTBXLabelItem;
    TBXSeparatorItem32: TSpTBXSeparatorItem;
    tbiSearchOptions: TSpTBXSubmenuItem;
    tbiWholeWords: TSpTBXItem;
    tbiSearchInSelection: TSpTBXItem;
    tbiRegExp: TSpTBXItem;
    tbiCaseSensitive: TSpTBXItem;
    tbiIncrementalSearch: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    tbiHighlight: TSpTBXItem;
    tbiReplaceExecute: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    tbiSearchFromCaret: TSpTBXItem;
    TBXSeparatorItem31: TSpTBXSeparatorItem;
    mnGotoSyntaxError: TSpTBXItem;
    mnSearchHighlight: TSpTBXItem;
    mnGoToDebugLine: TSpTBXItem;
    mnSplitEditors: TSpTBXSubmenuItem;
    mnSplitEditorVer: TSpTBXItem;
    mnSplitEditorHor: TSpTBXItem;
    mnHideSecondEditor: TSpTBXItem;
    TBXSeparatorItem33: TSpTBXSeparatorItem;
    mnPostMortem: TSpTBXItem;
    SpTBXCustomizer: TSpTBXCustomizer;
    ToolbarPopupMenu: TSpTBXPopupMenu;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    mnViewCustomizeToolbars: TSpTBXItem;
    ProjectMenu: TSpTBXSubmenuItem;
    mnProjectSaveAs: TSpTBXItem;
    mnProjectSave: TSpTBXItem;
    mnProjectOpen: TSpTBXItem;
    mnProjectNew: TSpTBXItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    mnNavProjectExplorer2: TSpTBXItem;
    mnFileCloseAllOther: TSpTBXItem;
    mnEditUtf16BE: TSpTBXItem;
    mnEditUtf16LE: TSpTBXItem;
    StatusBar: TSpTBXStatusBar;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    lbStatusMessage: TSpTBXLabelItem;
    SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem;
    lbStatusCaret: TSpTBXLabelItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    lbStatusModified: TSpTBXLabelItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    lbStatusOverwrite: TSpTBXLabelItem;
    SpTBXSeparatorItem8: TSpTBXSeparatorItem;
    lbStatusCaps: TSpTBXLabelItem;
    SpTBXSeparatorItem9: TSpTBXSeparatorItem;
    mnMainToolbarVisibilityToggle: TSpTBXItem;
    mnDebugtoolbarVisibilityToggle: TSpTBXItem;
    mnEditorToolbarVisibilityToggle: TSpTBXItem;
    mnViewToolbarVisibilityToggle: TSpTBXItem;
    mnuUserToolbarVisibilityToggle: TSpTBXItem;
    mnLanguage: TSpTBXSubmenuItem;
    actlImmutable: TActionList;
    actViewPreviousEditor: TAction;
    actViewNextEditor: TAction;
    actlStandard: TActionList;
    actNavProjectExplorer: TAction;
    actViewProjectExplorer: TAction;
    actViewCustomizeToolbars: TAction;
    actPostMortem: TAction;
    actViewHideSecondEditor: TAction;
    actViewSplitEditorHor: TAction;
    actExecSelection: TAction;
    actNavEditor: TAction;
    actNavOutput: TAction;
    actNavUnitTests: TAction;
    actNavTodo: TAction;
    actNavCodeExplorer: TAction;
    actNavFileExplorer: TAction;
    actNavMessages: TAction;
    actNavCallStack: TAction;
    actNavVariables: TAction;
    actNavInterpreter: TAction;
    actNavBreakpoints: TAction;
    actNavWatches: TAction;
    actFileNewFile: TAction;
    actPythonRemoteWx: TAction;
    actPythonRemoteTk: TAction;
    actPythonRemote: TAction;
    actPythonInternal: TAction;
    actPythonReinitialize: TAction;
    actAddWatchAtCursor: TAction;
    actViewSplitEditorVer: TAction;
    actEditorZoomOut: TAction;
    actEditorZoomIn: TAction;
    actMaximizeEditor: TAction;
    actLayoutDebug: TAction;
    actLayoutsDelete: TAction;
    actLayoutSave: TAction;
    actViewRegExpTester: TAction;
    actBrowseForward: TAction;
    actBrowseBack: TAction;
    actFindReferences: TAction;
    actFindDefinition: TAction;
    actViewUnitTests: TAction;
    actViewOutput: TAction;
    actViewFindResults: TAction;
    actViewToDoList: TAction;
    actViewFileExplorer: TAction;
    actViewCodeExplorer: TAction;
    actViewII: TAction;
    actMessagesWin: TAction;
    actWatchesWin: TAction;
    actBreakPointsWin: TAction;
    actClearAllBreakpoints: TAction;
    actToggleBreakPoint: TAction;
    actRunLastScript: TAction;
    actRunLastScriptExternal: TAction;
    actDebugAbort: TAction;
    actDebugPause: TAction;
    actStepOut: TAction;
    actStepOver: TAction;
    actStepInto: TAction;
    actRunToCursor: TAction;
    actRestoreEditor: TAction;
    actDebug: TAction;
    actRunDebugLastScript: TAction;
    actExternalRunConfigure: TAction;
    actExternalRun: TAction;
    actViewStatusBar: TAction;
    actFileExit: TAction;
    actFileCloseAll: TAction;
    actFileOpen: TAction;
    actFileNewModule: TAction;
    actImportModule: TAction;
    actCommandLine: TAction;
    actRun: TAction;
    actSyntaxCheck: TAction;
    actVariablesWin: TAction;
    actCallStackWin: TAction;
    actViewMainMenu: TAction;
    tbiRecentFileList: TSpTBXMRUListItem;
    mnPreviousList: TSpTBXMRUListItem;
    mnNextList: TSpTBXMRUListItem;
    tbiSearchText: TSpTBXComboBox;
    TBControlItem2: TTBControlItem;
    tbiReplaceText: TSpTBXComboBox;
    TBControlItem4: TTBControlItem;
    TabControl1: TSpTBXTabControl;
    tbiRightAlign: TSpTBXRightAlignSpacerItem;
    tbiScrollLeft: TSpTBXItem;
    tbiTabClose: TSpTBXItem;
    tbiScrollRight: TSpTBXItem;
    tbiTabFiles: TSpTBXSubmenuItem;
    tbiTabSep: TSpTBXSeparatorItem;
    SpTBXSeparatorItem11: TSpTBXSeparatorItem;
    SpTBXItem1: TSpTBXItem;
    SpTBXSeparatorItem12: TSpTBXSeparatorItem;
    mnToolsEditStartupScript: TSpTBXItem;
    TabControl2: TSpTBXTabControl;
    SpTBXRightAlignSpacerItem2: TSpTBXRightAlignSpacerItem;
    SpTBXSeparatorItem13: TSpTBXSeparatorItem;
    tbiTabFiles2: TSpTBXSubmenuItem;
    tbiScrollLeft2: TSpTBXItem;
    tbiScrollRight2: TSpTBXItem;
    tbiTabClose2: TSpTBXItem;
    TabSplitter: TSpTBXSplitter;
    actViewSplitWorkspaceVer: TAction;
    actViewSplitWorkspaceHor: TAction;
    actViewHideSecondaryWorkspace: TAction;
    mnSplitWorkspace: TSpTBXSubmenuItem;
    SpTBXItem7: TSpTBXItem;
    SpTBXItem8: TSpTBXItem;
    SpTBXItem9: TSpTBXItem;
    SpTBXSeparatorItem14: TSpTBXSeparatorItem;
    SpTBXSeparatorItem15: TSpTBXSeparatorItem;
    SpTBXSeparatorItem16: TSpTBXSeparatorItem;
    SpTBXSubmenuItem1: TSpTBXSubmenuItem;
    tbiRecentProjects: TSpTBXMRUListItem;
    tbiAutoCaseSensitive: TSpTBXItem;
    actSelectStyle: TAction;
    mnStyles: TSpTBXItem;
    LocalAppStorage: TJvAppIniFileStorage;
    SpTBXSeparatorItem17: TSpTBXSeparatorItem;
    mnPythonVersions: TSpTBXSubmenuItem;
    actPythonSetup: TAction;
    SpTBXSeparatorItem18: TSpTBXSeparatorItem;
    SpTBXItem4: TSpTBXItem;
    SpTBXItem6: TSpTBXItem;
    SpTBXSeparatorItem19: TSpTBXSeparatorItem;
    mnEditReadOnly: TSpTBXItem;
    SpTBXSeparatorItem20: TSpTBXSeparatorItem;
    SpTBXItem11: TSpTBXItem;
    actRemoteFileOpen: TAction;
    SpTBXSeparatorItem21: TSpTBXSeparatorItem;
    mnRemoteFileOpen: TSpTBXItem;
    mnRemoteFileSave: TSpTBXItem;
    actPythonSSH: TAction;
    mnPythonEngineSSH: TSpTBXItem;
    SpTBXItem14: TSpTBXItem;
    SpTBXSeparatorItem22: TSpTBXSeparatorItem;
    lbPythonVersion: TSpTBXLabelItem;
    SpTBXSeparatorItem23: TSpTBXSeparatorItem;
    lbPythonEngine: TSpTBXLabelItem;
    vilImages: TVirtualImageList;
    icIndicators: TSVGIconImageCollection;
    vilIndicators: TVirtualImageList;
    spiStatusLED: TSpTBXItem;
    spiExternalToolsLED: TSpTBXItem;
    spiLspLed: TSpTBXItem;
    vilTabDecorators: TVirtualImageList;
    TabControlWidgets: TSpTBXTabControl;
    SpTBXTabItem2: TSpTBXTabItem;
    SpTBXTabSheetTkinter: TSpTBXTabSheet;
    SpTBXTabItem1: TSpTBXTabItem;
    SpTBXTabSheetProgram: TSpTBXTabSheet;
    SpTBXTabItem3: TSpTBXTabItem;
    SpTBXTabSheetTTK: TSpTBXTabSheet;
    ToolbarProgram: TToolBar;
    TBClass: TToolButton;
    TBStructogram: TToolButton;
    TBSequence: TToolButton;
    TBConsole: TToolButton;
    TBTkApplication: TToolButton;
    ToolbarTkinter: TToolBar;
    TBLabel: TToolButton;
    TBEntry: TToolButton;
    TBText: TToolButton;
    TBButton: TToolButton;
    TBCheckbutton: TToolButton;
    TBRadiobuttonGroup: TToolButton;
    TBListbox: TToolButton;
    TBSpinBox: TToolButton;
    TBScrollbar: TToolButton;
    TBTMessage: TToolButton;
    TBCanvas: TToolButton;
    TBFrame: TToolButton;
    TBLabelFrame: TToolButton;
    TBScale: TToolButton;
    TBPanedWindow: TToolButton;
    TBMenu: TToolButton;
    TBPopupMenu: TToolButton;
    TBMenubutton: TToolButton;
    TBOptionMenu: TToolButton;
    ToolbarTTK: TToolBar;
    TBTTKLabel: TToolButton;
    TBTTKEntry: TToolButton;
    TBTTKText: TToolButton;
    TBTTKButton: TToolButton;
    TBTTKCheckbutton: TToolButton;
    TBTTKRadiogroup: TToolButton;
    TBTTKListbox: TToolButton;
    TBTTKCombobox: TToolButton;
    TBTTKSpinbox: TToolButton;
    TBTTKScrollbar: TToolButton;
    TBTTKMessage: TToolButton;
    TBTTKCanvas: TToolButton;
    TBTTKFrame: TToolButton;
    TBTTKLabelFrame: TToolButton;
    TBTTKScale: TToolButton;
    TBTTKLabeldScale: TToolButton;
    TBTTKPanedWindow: TToolButton;
    TBTTKMenu: TToolButton;
    TBTTKPopupMenu: TToolButton;
    TBTTKMenuButton: TToolButton;
    TBTTKOptionMenu: TToolButton;
    TBTTKNotebook: TToolButton;
    TBTTKTreeview: TToolButton;
    TBTTKProgressbar: TToolButton;
    TBTTKSeparator: TToolButton;
    TBTTKSizegrip: TToolButton;
    UMLMenu: TSpTBXSubmenuItem;
    mnSaveAsPicture: TSpTBXItem;
    mnDiagramFromOpenFiles: TSpTBXItem;
    mnRefresh: TSpTBXItem;
    mnNewLayout: TSpTBXItem;
    mnNewComment: TSpTBXItem;
    mnOpenClass: TSpTBXItem;
    mnNewClass: TSpTBXItem;
    mnNewUML: TSpTBXItem;
    actUMLNewUML: TAction;
    actUMLNewClass: TAction;
    actUMLOpenClass: TAction;
    actUMLNewComment: TAction;
    actUMLNewLayout: TAction;
    actUMLRefresh: TAction;
    actUMLDiagramFromOpenFiles: TAction;
    actUMLSaveAsPicture: TAction;
    mnToolsTextCompare: TSpTBXItem;
    actToolsTextDiff: TAction;
    actToolsConfiguration: TAction;
    mnToolsConfiguration: TSpTBXItem;
    mnEditClass: TSpTBXItem;
    actUMLEditClass: TAction;
    mnFileNewClass: TSpTBXItem;
    mnFileNewStrutogram: TSpTBXItem;
    mnFileNewSequencediagram: TSpTBXItem;
    mnFileNewTkApplication: TSpTBXItem;
    mnCopyMenu: TSpTBXSubmenuItem;
    mnEditCopy: TSpTBXItem;
    mnEditCopyRTF: TSpTBXItem;
    mnEditCopyRTFNumbered: TSpTBXItem;
    mnEditCopyHTML: TSpTBXItem;
    mnEditCopyHTMLAsText: TSpTBXItem;
    mnEditCopyNumbered: TSpTBXItem;
    mnFileExport: TSpTBXItem;
    tbiFindClose: TSpTBXItem;
    SpTBXSeparatorItem10: TSpTBXSeparatorItem;
    mnViewDebugLayout: TSpTBXItem;
    mnViewDefaultLayout: TSpTBXItem;
    mnToolsGit: TSpTBXSubmenuItem;
    mnToolsGitStatus: TSpTBXItem;
    mnToolsGitAdd: TSpTBXItem;
    mnToolsGitCommit: TSpTBXItem;
    mnToolsGitLog: TSpTBXItem;
    SpTBXSeparatorItem24: TSpTBXSeparatorItem;
    mnToolsGitReset: TSpTBXItem;
    mnToolsGitCheckout: TSpTBXItem;
    mnToolsGitRemove: TSpTBXItem;
    SpTBXSeparatorItem25: TSpTBXSeparatorItem;
    mnToolsGitRemote: TSpTBXItem;
    mnToolsGitFetch: TSpTBXItem;
    mnToolsGitPush: TSpTBXItem;
    SpTBXSeparatorItem26: TSpTBXSeparatorItem;
    mnToolsGitGUI: TSpTBXItem;
    mnToolsGitViewer: TSpTBXItem;
    mnToolsGitConsole: TSpTBXItem;
    actToolsGit: TAction;
    mnToolsSVN: TSpTBXSubmenuItem;
    mnToolsSVNCommit: TSpTBXItem;
    mnToolsSVNAdd: TSpTBXItem;
    mnToolsSVNLog: TSpTBXItem;
    mnToolsSVNCompare: TSpTBXItem;
    SpTBXSeparatorItem27: TSpTBXSeparatorItem;
    mnToolsSVNStatus: TSpTBXItem;
    mnToolsSVNTree: TSpTBXItem;
    mnToolsSVNUpdate: TSpTBXItem;
    actViewObjectinspector: TAction;
    mnToolsBrowser: TSpTBXItem;
    mnViewUnitTests: TSpTBXItem;
    mnViewRegExpTester: TSpTBXItem;
    mnViewII: TSpTBXItem;
    mnObjectInspector: TSpTBXItem;
    mnViewFileExplorer: TSpTBXItem;
    mnViewCodeExplorer: TSpTBXItem;
    mnViewToDoList: TSpTBXItem;
    mnViewFindResults: TSpTBXItem;
    mnViewOutput: TSpTBXItem;
    SpTBXSeparatorItem28: TSpTBXSeparatorItem;
    mnViewBreakpoints: TSpTBXItem;
    mnViewCallStack: TSpTBXItem;
    mnViewMessages: TSpTBXItem;
    mnViewVariables: TSpTBXItem;
    mnViewWatches: TSpTBXItem;
    mnMaximizeEditor: TSpTBXItem;
    mnConfigureTools: TSpTBXItem;
    mnHelpProjectHome: TSpTBXItem;
    mnHelpWebSupport: TSpTBXItem;
    mnViewStructure: TSpTBXItem;
    actNavStructure: TAction;
    TBControlItem1: TTBControlItem;
    TBControlItem3: TTBControlItem;
    tbitbiDiagramFromOpenFiles: TSpTBXItem;
    mnPopupFileOpen: TSpTBXItem;
    SpTBXTabItem4: TSpTBXTabItem;
    SpTBXTabSheetQtBase: TSpTBXTabSheet;
    ToolbarQtBase: TToolBar;
    TBQtLabel: TToolButton;
    TBQtLineEdit: TToolButton;
    TBQtPlainTextEdit: TToolButton;
    TBQtPushButton: TToolButton;
    TBQtCheckBox: TToolButton;
    TBQtButtonGroup: TToolButton;
    TBQtListWidget: TToolButton;
    TBQtComboBox: TToolButton;
    TBQtSpinBox: TToolButton;
    TBQtScrollbar: TToolButton;
    TBQtCanvas: TToolButton;
    TBQtFrame: TToolButton;
    TBQtSlider: TToolButton;
    TBQMenuBar: TToolButton;
    TBQtMenu: TToolButton;
    TBQtTabWidget: TToolButton;
    TBQtTreeWidget: TToolButton;
    TBQtProgressBar: TToolButton;
    TBQtGroupBox: TToolButton;
    TBQtStatusBar: TToolButton;
    TBQtApplication: TToolButton;
    TBQtTableWidget: TToolButton;
    SpTBXTabItem5: TSpTBXTabItem;
    SpTBXTabSheetQtControls: TSpTBXTabSheet;
    ToolbarQtControls: TToolBar;
    TBQtTextedit: TToolButton;
    TBQtTextBrowser: TToolButton;
    TBQtToolButton: TToolButton;
    TBQtCommandLinkButton: TToolButton;
    TBQtFontComboBox: TToolButton;
    TBQtDoubleSpinBox: TToolButton;
    TBQtLCDNumber: TToolButton;
    TBQtDateTimeEdit: TToolButton;
    TBQtDateEdit: TToolButton;
    TBQtTimeEdit: TToolButton;
    TBQtDial: TToolButton;
    TBQtStackWidget: TToolButton;
    TBQtTableView: TToolButton;
    TBQtListView: TToolButton;
    TBQtColumnView: TToolButton;
    TBQtToolBox: TToolButton;
    TBQtLine: TToolButton;
    TBQtScrollArea: TToolButton;
    TBQtGraphicsView: TToolButton;
    mnFileNewQtApplication: TSpTBXItem;
    actFileNewTkApp: TAction;
    actFileNewQtApp: TAction;
    TBQtTreeView: TToolButton;
    SpTBXSeparatorItem29: TSpTBXSeparatorItem;
    mnSpelling: TSpTBXSubmenuItem;
    actEditorZoomReset: TAction;
    lbFileFormat: TSpTBXLabelItem;
    SpTBXSeparatorItem30: TSpTBXSeparatorItem;
    mnToolsRestartLS: TSpTBXItem;
    DdeServerConv: TDdeServerConv;
    DockTopPanel: TPanel;
    vilTkInterLight: TVirtualImageList;
    vilTkInterDark: TVirtualImageList;
    vilTTKLight: TVirtualImageList;
    vilTTKDark: TVirtualImageList;
    vilQtBaseLight: TVirtualImageList;
    vilQtBaseDark: TVirtualImageList;
    vilQtControls: TVirtualImageList;
    vilProgramLight: TVirtualImageList;
    vilProgramDark: TVirtualImageList;
    mnOpenFolder: TSpTBXItem;
    actUMLOpenFolder: TAction;
    mnRecognizeAssociations: TSpTBXItem;
    actUMLRecognizeAssociations: TAction;
    ActivityIndicator: TActivityIndicator;
    spiAssistant: TTBControlItem;
    mnViewChat: TSpTBXItem;
    actNavChat: TAction;
    actPythonFreeThreaded: TAction;
    mnViewUMLInteractive: TSpTBXItem;
    actViewUMLInteractive: TAction;
    mnFormatCode: TSpTBXItem;
    mnCodeCheck: TSpTBXItem;
    mnClearIssues: TSpTBXItem;
    SpTBXSeparatorItem31: TSpTBXSeparatorItem;
    mnPreviousIssue: TSpTBXItem;
    mnNextIssue: TSpTBXItem;
    mnFixAll: TSpTBXItem;
    mnOrganizeImports: TSpTBXItem;
    SpTBXSeparatorItem32: TSpTBXSeparatorItem;
    mnRefactor: TSpTBXSubmenuItem;
    mnRefactorRename: TSpTBXItem;
    SpTBXSeparatorItem33: TSpTBXSeparatorItem;
    procedure mnFilesClick(Sender: TObject);
    procedure actEditorZoomInExecute(Sender: TObject);
    procedure actEditorZoomOutExecute(Sender: TObject);
    procedure mnNoSyntaxClick(Sender: TObject);
    procedure mnSyntaxPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure actMaximizeEditorExecute(Sender: TObject);
    procedure actLayoutDebugExecute(Sender: TObject);
    procedure actLayoutsDeleteExecute(Sender: TObject);
    procedure actLayoutSaveExecute(Sender: TObject);
    procedure actViewUnitTestsExecute(Sender: TObject);
    procedure actCommandLineExecute(Sender: TObject);
    procedure JvAppInstancesCmdLineReceived(Sender: TObject; CmdLine: TStrings);
    procedure actViewRegExpTesterExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabContolContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure actSyntaxCheckExecute(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure actToggleBreakPointExecute(Sender: TObject);
    procedure actClearAllBreakpointsExecute(Sender: TObject);
    procedure actDebugExecute(Sender: TObject);
    procedure actStepIntoExecute(Sender: TObject);
    procedure actStepOverExecute(Sender: TObject);
    procedure actStepOutExecute(Sender: TObject);
    procedure actRunToCursorExecute(Sender: TObject);
    procedure actDebugAbortExecute(Sender: TObject);
    procedure actViewIIExecute(Sender: TObject);
    procedure actMessagesWinExecute(Sender: TObject);
    procedure actNextEditorExecute(Sender: TObject);
    procedure actPreviousEditorExecute(Sender: TObject);
    procedure actCallStackWinExecute(Sender: TObject);
    procedure actVariablesWinExecute(Sender: TObject);
    procedure actBreakPointsWinExecute(Sender: TObject);
    procedure actWatchesWinExecute(Sender: TObject);
    procedure actViewCodeExplorerExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actViewStatusBarExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actFileNewModuleExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileCloseAllExecute(Sender: TObject);
    procedure actViewFileExplorerExecute(Sender: TObject);
    procedure TabControlTabClosing(Sender: TObject;
      var Allow, CloseAndFree: Boolean);
    procedure DrawCloseButton(Sender: TObject; ACanvas: TCanvas;
      State: TSpTBXSkinStatesType; const PaintStage: TSpTBXPaintStage;
      var AImageList: TCustomImageList; var AImageIndex: Integer;
      var ARect: TRect; var PaintDefault: Boolean);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure actImportModuleExecute(Sender: TObject);
    procedure actViewToDoListExecute(Sender: TObject);
    procedure actViewFindResultsExecute(Sender: TObject);
    procedure actViewOutputExecute(Sender: TObject);
    procedure actExternalRunExecute(Sender: TObject);
    procedure actExternalRunConfigureExecute(Sender: TObject);
    procedure actFindDefinitionExecute(Sender: TObject);
    procedure actFindReferencesExecute(Sender: TObject);
    procedure PreviousListClick(Sender: TObject; Str: string);
    procedure tbiBrowsePreviousClick(Sender: TObject);
    procedure NextListClick(Sender: TObject; Str: string);
    procedure tbiBrowseNextClick(Sender: TObject);
    function ApplicationHelp(Command: Word; Data: THelpEventData;
      var CallHelp: Boolean): Boolean;
    procedure FormShow(Sender: TObject);
    procedure actAddWatchAtCursorExecute(Sender: TObject);
    procedure actFileNewFileExecute(Sender: TObject);
    procedure actNavWatchesExecute(Sender: TObject);
    procedure actNavBreakpointsExecute(Sender: TObject);
    procedure actNavInterpreterExecute(Sender: TObject);
    procedure actNavVariablesExecute(Sender: TObject);
    procedure actNavCallStackExecute(Sender: TObject);
    procedure actNavMessagesExecute(Sender: TObject);
    procedure actNavFileExplorerExecute(Sender: TObject);
    procedure actNavCodeExplorerExecute(Sender: TObject);
    procedure actNavTodoExecute(Sender: TObject);
    procedure actNavUnitTestsExecute(Sender: TObject);
    procedure actNavOutputExecute(Sender: TObject);
    procedure actNavRETesterExecute(Sender: TObject);
    procedure actNavEditorExecute(Sender: TObject);
    procedure actDebugPauseExecute(Sender: TObject);
    procedure actPythonReinitializeExecute(Sender: TObject);
    procedure actPythonEngineExecute(Sender: TObject);
    procedure actExecSelectionExecute(Sender: TObject);
    procedure actRestoreEditorExecute(Sender: TObject);
    procedure actViewMainMenuExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SearchOptionsChanged(Sender: TObject);
    procedure tbiSearchOptionsPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure tbiSearchTextChange(Sender: TObject);
    procedure tbiSearchTextKeyPress(Sender: TObject; var Key: Char);
    procedure tbiReplaceTextChange(Sender: TObject);
    procedure actViewSplitEditorVerExecute(Sender: TObject);
    procedure actViewSplitEditorHorExecute(Sender: TObject);
    procedure actViewHideSecondEditorExecute(Sender: TObject);
    procedure actPostMortemExecute(Sender: TObject);
    procedure FindToolbarVisibleChanged(Sender: TObject);
    procedure actViewCustomizeToolbarsExecute(Sender: TObject);
    procedure SpTBXCustomizerGetCustomizeForm(Sender: TObject;
      var CustomizeFormClass: TSpTBXCustomizeFormClass);
    procedure actViewProjectExplorerExecute(Sender: TObject);
    procedure actNavProjectExplorerExecute(Sender: TObject);
    procedure actRunLastScriptExternalExecute(Sender: TObject);
    procedure actRunLastScriptExecute(Sender: TObject);
    procedure actRunDebugLastScriptExecute(Sender: TObject);
    procedure EditorViewsMenuClick(Sender: TObject);
    procedure tbiRecentFileListClick(Sender: TObject; const FileName: string);
    procedure tbiSearchTextExit(Sender: TObject);
    procedure tbiReplaceTextKeyPress(Sender: TObject; var Key: Char);
    procedure TabControlActiveTabChange(Sender: TObject; TabIndex: Integer);
    procedure tbiScrollLeftClick(Sender: TObject);
    procedure tbiScrollRightClick(Sender: TObject);
    procedure actViewSplitWorkspaceVerExecute(Sender: TObject);
    procedure actViewSplitWorkspaceHorExecute(Sender: TObject);
    procedure actViewHideSecondaryWorkspaceExecute(Sender: TObject);
    procedure tbiRecentProjectsClick(Sender: TObject; const FileName: string);
    procedure actSelectStyleExecute(Sender: TObject);
    procedure mnPythonVersionsPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure PythonVersionsClick(Sender: TObject);
    procedure actPythonSetupExecute(Sender: TObject);
    procedure actRemoteFileOpenExecute(Sender: TObject);
    procedure lbPythonVersionClick(Sender: TObject);
    procedure lbPythonEngineClick(Sender: TObject);
    procedure tbiReplaceTextExit(Sender: TObject);
    procedure lbStatusCaretClick(Sender: TObject);
    procedure actUMLOpenClassExecute(Sender: TObject);
    procedure actUMLNewUMLExecute(Sender: TObject);
    procedure actUMLNewCommentExecute(Sender: TObject);
    procedure actUMLNewLayoutExecute(Sender: TObject);
    procedure actUMLRefreshExecute(Sender: TObject);
    procedure actUMLDiagramFromOpenFilesExecute(Sender: TObject);
    procedure actUMLSaveAsPictureExecute(Sender: TObject);
    procedure actUMLNewClassExecute(Sender: TObject);
    procedure actToolsConfigurationExecute(Sender: TObject);
    procedure actToolsTextDiffExecute(Sender: TObject);
    procedure actFileNewStructogramExecute(Sender: TObject);
    procedure actFileNewSequencediagramExecute(Sender: TObject);
    procedure actFileNewTkinterExecute(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure actUMLEditClassExecute(Sender: TObject);
    procedure tbiFindCloseClick(Sender: TObject);
    procedure mnViewDebugLayoutClick(Sender: TObject);
    procedure mnViewDefaultLayoutClick(Sender: TObject);
    procedure mnToolsGitClick(Sender: TObject);
    procedure mnToolsSVNClick(Sender: TObject);
    procedure mnLanguageClick(Sender: TObject);
    procedure actViewObjectinspectorExecute(Sender: TObject);
    procedure mnToolsBrowserClick(Sender: TObject);
    procedure actNavStructureExecute(Sender: TObject);
    procedure ToolButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolButtonStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure TBQtApplicationClick(Sender: TObject);
    procedure actEditorZoomResetExecute(Sender: TObject);
    procedure DdeServerConvExecuteMacro(Sender: TObject; Msg: TStrings);
    procedure FormAfterMonitorDpiChanged(Sender: TObject;
      OldDPI, NewDPI: Integer);
    procedure actUMLOpenFolderExecute(Sender: TObject);
    procedure actUMLRecognizeAssociationsExecute(Sender: TObject);
    procedure actNavChatExecute(Sender: TObject);
    procedure actPythonFreeThreadedExecute(Sender: TObject);
    procedure actViewUMLInteractiveExecute(Sender: TObject);
    procedure mnRefactorClosePopup(Sender: TObject);
    procedure mnRefactorInitPopup(Sender: TObject; PopupView: TTBView);
  private
    FLanguageList: TStringList;
    FDSAAppStorage: TDSAAppStorage;
    FShellExtensionFiles: TStringList;
    FDragRectangle: TButton;
    FTabControlsShowing: Integer;
    procedure DebugActiveScript(ActiveEditor: IEditor;
      InitStepIn: Boolean = False; RunToCursorLine: Integer = -1);
    procedure SetupRunConfiguration(var RunConfig: TRunConfiguration; ActiveEditor: IEditor);
    procedure TbiSearchTextAcceptText(const NewText: string);
    procedure TbiReplaceTextAcceptText(const NewText: string);
    function GetActiveTabControl: TSpTBXCustomTabControl;
    procedure SetActiveTabControl(const Value: TSpTBXCustomTabControl);
    procedure OpenInitialFiles;
    procedure ChangeMenuSystem;
    procedure ClassEdit(Editor: IEditor; const Status: string; UML: TFUMLForm);
  protected
    FCurrentBrowseInfo: string;
    function CmdLineOpenFiles: Boolean;
    function OpenCmdLineFile(const FileName: string): Boolean;
    procedure UpdateStandardActions;
    procedure UpdateStatusBarPanels;
    procedure ApplicationOnHint(Sender: TObject);
    procedure ApplcationOnShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: Vcl.Controls.THintInfo);
    procedure ApplicationActionUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure ApplicationActionExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure TabToolbarDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TabToolbarlDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure WMFindDefinition(var Msg: WinApi.Messages.TMessage); message WM_FINDDEFINITION;
    procedure WMSearchReplaceAction(var Msg: WinApi.Messages.TMessage);
      message WM_SEARCHREPLACEACTION;
    procedure WMCheckForUpdates(var Msg: WinApi.Messages.TMessage); message WM_CHECKFORUPDATES;
    procedure WMSpSkinChange(var Message: WinApi.Messages.TMessage); message WM_SPSKINCHANGE;
    procedure CMStyleChanged(var Message: WinApi.Messages.TMessage); message CM_STYLECHANGED;
    procedure SyntaxClick(Sender: TObject);
    procedure SelectEditor(Sender: TObject);
    // Remote Desktop
    // See https://blogs.embarcadero.com/how-to-speed-up-remote-desktop-applications/
    procedure CreateWnd; override;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMEndSession(var Msg: TWMEndSession); message WM_ENDSESSION;
    procedure WMWTSSessionChange(var Message: WinApi.Messages.TMessage);
      message WM_WTSSESSION_CHANGE;
    // Browse MRU stuff
    procedure PrevClickHandler(Sender: TObject);
    procedure NextClickHandler(Sender: TObject);
    procedure PrevMRUAdd(const Str: string);
    procedure NextMRUAdd(const Str: string);
    procedure FormShowDelayedActions; virtual;
  private
    FActiveTabControlIndex: Integer;
    FOldMonitorProfile: string;
    FShellImages: TCustomImageList;
    FLastLayout: string;
    FLayouts: TStringList;
    FMenuHelpRequested: Boolean;
    FPythonKeywordHelpRequested: Boolean;
    // IIDELayouts implementation
    function LayoutExists(const Layout: string): Boolean;
    procedure LoadLayout(const Layout: string);
    procedure SaveLayout(const Layout: string);
    procedure LoadCurrentLayout;
    procedure LoadDefaultLayout;
    procedure LoadDebugLayout;
    procedure LoadPredefinedDefaultLayout;
    procedure LoadPredefinedDebugLayout;
    procedure CreateDefaultLayout;
    // IPyIDEServices implementation
    function ReplaceParams(const AText: string): string;
    function GetActiveEditor: IEditor;
    function GetIsClosing: Boolean;
    procedure WriteStatusMsg(const Msg: string);
    function FileIsPythonSource(const FileName: string): Boolean;
    function ShowFilePosition(FileName: string; Line: Integer = 1;
      Offset: Integer = 1; SelLen: Integer = 0; ForceToMiddle: Boolean = True;
      FocusEditor: Boolean = True): Boolean;
    procedure ClearPythonWindows;
    procedure SaveEnvironment;
    procedure SaveFileModules;
    procedure SetRunLastScriptHints(const ScriptName: string);
    procedure SetActivityIndicator(TurnOn: Boolean; Hint: string = '';
      OnClick: TNotifyEvent = nil);
    function GetStoredScript(const Name: string): TStrings;
    function GetMessageServices: IMessageServices;
    function GetUnitTestServices: IUnitTestServices;
    function GetIDELayouts: IIDELayouts;
    function GetAppStorage: TJvCustomAppStorage;
    function GetLocalAppStorage: TJvCustomAppStorage;
    function GetLogger: TJclSimpleLog;
    procedure MRUAddFile(AFile: IFile);
    procedure ChangeStyle;
    procedure DeleteObjectsInUMLForms;
    function GetCachedPycFilename(const FileName: string): string;
    procedure RemoveDefunctEditorOptions;
    procedure ShowIDEDockForm(Form: TForm; Activate: Boolean = True);
  public
    procedure StoreApplicationData;
    procedure RestoreApplicationData;
    procedure StoreLocalApplicationData;
    procedure RestoreLocalApplicationData;
    function NewFileFromTemplate(FileTemplate: TFileTemplate;
      TabControlIndex: Integer = 1; FileName: string = ''): IEditor;
    procedure UpdateDebugCommands;
    procedure DebuggerStateChange(Sender: TObject);
    procedure ApplicationOnIdle(Sender: TObject; var Done: Boolean);
    procedure PyIDEOptionsChanged(const Sender: TObject; const Msg:
        System.Messaging.TMessage);
    procedure SetupCustomizer;
    procedure SetupLanguageMenu;
    procedure SetupToolsMenu;
    procedure SetupLayoutsMenu;
    procedure SetupSyntaxMenu;
    procedure SetupPythonVersionsMenu;
    procedure SetDockTopPanel;
    procedure LayoutClick(Sender: TObject);
    procedure LoadToolbarLayout(const Layout: string);
    procedure LoadToolbarItems(const Path: string);
    procedure SaveToolbarLayout(const Layout: string);
    procedure SaveToolbarItems(const Path: string);
    function JumpToFilePosInfo(const FilePosInfo: string): Boolean;
    procedure FindDefinition(Editor: IEditor; TextCoord: TBufferCoord;
      ShowMessages, Silent, JumpToFirstMatch: Boolean; var FilePosInfo: string);
    procedure AdjustBrowserLists(const FileName: string; Line: Integer; Col: Integer;
      const FilePosInfo: string);
    procedure ThemeEditorGutter(Gutter: TSynGutter);
    procedure UpdateCaption;
    procedure ChangeLanguage(const LangCode: string);
    function GetLanguageCode(Index: Integer): string;
    function FileFromTab(Tab: TSpTBXTabItem): IFile;
    procedure SplitWorkspace(SecondTabsVisible: Boolean;
      Alignment: TAlign = alRight; Size: Integer = -1);
    procedure MoveTab(Tab: TSpTBXTabItem; TabControl: TSpTBXCustomTabControl;
      Index: Integer = -1);
    function TabControl(TabControlIndex: Integer = 1): TSpTBXCustomTabControl;
    function TabControlIndex(TabControl: TSpTBXCustomTabControl): Integer;
    function GetActiveTextDiff: ISearchCommands;
    procedure CloseTextDiffsAndFromTemplate;
    function GetActiveFile: IFile;
    function GuiDesignerOpen: Boolean;

    function DoOpen(const AFilename: string): IFile;
    function DoOpenAsEditor(const AFilename: string): IEditor;
    procedure DoOpenInUMLWindow(const FileName: string);
    procedure ActivateFile(const FileName: string);
    function CreateUMLForm(const FileName: string): TFUMLForm;
    function GetFilename(const Extension: string; Path: string = ''): string;
    procedure PrepareClassEdit(Editor: IEditor; const Status: string;
      UML: TFUMLForm);
    procedure ConnectGUIandPyWindow(GUIForm: TFGuiForm);
    procedure StructogramFromText(Sourcecode, Pathname: string);
    procedure DoExport(const Pathname: string; Bitmap: TBitmap);

    procedure NewTkOrQTFile(FileTemplate: TFileTemplate);
    procedure NewTextDiff(Form1, Form2: TEditorForm);
    function NewBrowser(Adresse: string): TFBrowser;
    procedure RunEditor(ActiveEditor: IEditor);
    procedure ImportModule(const Pathname: string);
    function IsAValidClass(const Pathname: string): Boolean;
    procedure CreatePycFilesForUMLWindows;
    procedure SetLayoutMenus(Predefined: Boolean);
    procedure DropFiles(Sender: TObject; X, Y: Integer; AFiles: TStrings);
    procedure RunFile(AFile: IFile);
    procedure ShowTkOrQt(FrameType: Integer);

    property ActiveTabControl: TSpTBXCustomTabControl read GetActiveTabControl
      write SetActiveTabControl;
    property ActiveTabControlIndex: Integer read FActiveTabControlIndex
      write FActiveTabControlIndex;
    property Layouts: TStringList read FLayouts;
    property MenuHelpRequested: Boolean read FMenuHelpRequested
      write FMenuHelpRequested;
    property PythonKeywordHelpRequested: Boolean
      read FPythonKeywordHelpRequested write FPythonKeywordHelpRequested;
  end;

const
  FactoryToolbarItems = 'Factory Toolbar Items v1.0';

var
  PyIDEMainForm: TPyIDEMainForm;

implementation

uses
  Winapi.ShellAPI,
  Winapi.Wtsapi32,
  System.SysUtils,
  System.Contnrs,
  System.Math,
  System.IniFiles,
  System.RegularExpressions,
  System.IOUtils,
  System.StrUtils,
  System.Generics.Collections,
  Vcl.Clipbrd,
  Vcl.StdActns,
  Vcl.Dialogs,
  Vcl.Themes,
  Vcl.Imaging.pngimage,
  JclSysInfo,
  JvJVCLUtils,
  TB2ExtItems,
  MPCommonObjects,
  dmResources,
  dmCommands,
  JvDockVSNetStyle,
  uHighlighterProcs,
  VirtualTrees,
  SynHighlighterPython,
  SynEditHighlighter,
  SynEditTypes,
  SynEditKeyCmds,
  PythonEngine,
  JvGnugettext,
  StringResources,
  uCmdLine,
  uCommonFunctions,
  uSearchHighlighter,
  uParams,
  dlgNewFile,
  dlgCommandLine,
  dlgToolProperties,
  dlgPickList,
  frmFile,
  frmIDEDockWin,
  frmCommandOutput,
  frmPythonII,
  frmProjectExplorer,
  frmMessages,
  frmCallStack,
  frmBreakPoints,
  frmVariables,
  frmWatches,
  frmCodeExplorer,
  frmFileExplorer,
  frmRegExpTester,
  frmUnitTests,
  frmToDo,
  frmFindResults,
  frmLLMChat,
  frmWebPreview,
  frmModSpTBXCustomize,
  cTools,
  cParameters,
  cFilePersist,
  cPyControl,
  cPyRemoteDebugger,
  cPyBaseDebugger,
  cPyDebugger,
  cPyScripterSettings,
  cProjectClasses,
  dlgPythonVersions,
  dlgRemoteFile,
  cSSHSupport,
  cLspClients,
  dlgCustomShortcuts,
  UStructogram,
  UUtils,
  UTextDiff,
  UConfiguration,
  UImages,
  UClassEditor,
  UObjectGenerator,
  UObjectInspector,
  UFileStructure,
  UUMLInteractive,
  UGUIDesigner,
  UGit,
  USubversion,
  UUpdate,
  ULink;

{$R *.DFM}

const
  CtkRemember: TDSACheckTextKind = 100;

  { TWorkbookMainForm }

function TPyIDEMainForm.DoOpen(const AFilename: string): IFile;
begin
  Result := GI_EditorFactory.OpenFile(AFilename, '',
    TabControlIndex(ActiveTabControl));
end;

function TPyIDEMainForm.DoOpenAsEditor(const AFilename: string): IEditor;
begin
  Result := GI_EditorFactory.OpenFile(AFilename, '',
    TabControlIndex(ActiveTabControl), True) as IEditor;
end;

procedure TPyIDEMainForm.DoOpenInUMLWindow(const FileName: string);
var
  UMLForm: TFUMLForm;
  AFile: IFile;
  AFilename: string;
begin
  if not HasPythonExtension(FileName) then
    Exit;
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
  begin
    UMLForm := TFUMLForm(AFile.Form);
    UMLForm.MainModul.UnSelectAllElements;
    UMLForm.MainModul.AddToProject(FileName);
    UMLForm.Modified := True;
    if UMLForm.MainModul.Diagram.ShowObjectDiagram then
    begin
      UMLForm.MainModul.Diagram.ShowObjectDiagram := False;
      UMLForm.TBObjectDiagram.Down := False;
    end;
  end
  else
  begin
    AFilename := ChangeFileExt(FileName, '.puml');
    if FileExists(AFilename) then
    begin
      UMLForm := TFUMLForm(DoOpen(AFilename).Form);
      UMLForm.MainModul.AddToProject(FileName);
    end
    else
    begin
      UMLForm := CreateUMLForm(AFilename);
      UMLForm.MainModul.AddToProject(FileName);
      UMLForm.DoSave;
    end;
  end;
  UMLForm.SetActiveControl(UMLForm.MainModul.Diagram.GetPanel);
  UMLForm.CreateTVFileStructure;
end;

function TPyIDEMainForm.CreateUMLForm(const FileName: string): TFUMLForm;
begin
  Result := nil;
  var
  TabCtrl := TSpTBXTabControl(GetActiveTabControl);
  TabCtrl.Toolbar.BeginUpdate;
  try
    var
    AFile := GI_FileFactory.NewFile(fkUML, FActiveTabControlIndex);
    if Assigned(AFile) then
    begin
      Result := TFUMLForm(AFile.Form);
      Result.Pathname := FileName;
      Result.DoUpdateCaption;
      AFile.Activate;
    end;
  finally
    TabCtrl.Toolbar.EndUpdate;
    if Assigned(TabCtrl.ActiveTab) then
      TabCtrl.MakeVisible(TabCtrl.ActiveTab);
  end;
end;

procedure TPyIDEMainForm.ActivateFile(const FileName: string);
var
  AFile: IFile;
  TabCtrl: TSpTBXTabControl;
begin
  TabCtrl := TSpTBXTabControl(GetActiveTabControl);
  if Assigned(GI_FileFactory) then
  begin
    AFile := GI_FileFactory.GetFileByFileId(FileName);
    if Assigned(AFile) then
    begin
      AFile.Activate;
      if Assigned(TabCtrl.ActiveTab) then
        TabCtrl.MakeVisible(TabCtrl.ActiveTab);
    end;
  end;
end;

function TPyIDEMainForm.GetFilename(const Extension: string;
  Path: string = ''): string;
var
  Pathname: string;
  Num: Integer;
  AFile: IFile;

  function isOpened(Pathname: string): Boolean;
  var
    AFile: IFile;
  begin
    Result := False;
    for var I := 0 to GI_FileFactory.Count - 1 do
    begin
      AFile := GI_FileFactory[I];
      if CompareText(AFile.FileName, Pathname) = 0 then
        Exit(True);
    end;
  end;

begin
  if Path = '' then
  begin
    for var I := 0 to GI_FileFactory.Count - 1 do
    begin
      AFile := GI_FileFactory[I];
      Path := ExtractFilePath(AFile.FileName);
      if Path <> '' then
        Break;
    end;
    if Path = '' then
      Path := GuiPyOptions.Sourcepath;
  end;
  Path := WithTrailingSlash(Path);
  Num := 1;
  Pathname := Path + _('File') + IntToStr(Num) + Extension;
  while isOpened(Pathname) or FileExists(Pathname) do
  begin
    Inc(Num);
    Pathname := Path + _('File') + IntToStr(Num) + Extension;
  end;
  Result := Pathname;
end;

procedure TPyIDEMainForm.ConnectGUIandPyWindow(GUIForm: TFGuiForm);
var
  FileName: string;
  AEditor: IEditor;
begin
  FileName := ChangeFileExt(GUIForm.Pathname, '.pyw');
  AEditor := GI_EditorFactory.GetEditorByName(FileName);
  if Assigned(AEditor) then
  begin
    (AEditor.Form as TEditorForm).Partner := GUIForm;
    GUIForm.Partner := AEditor.Form as TEditorForm;
    AEditor.GUIFormOpen := True;
  end
  else
    ErrorMsg(Format(_('Associated python file %s not found.'), [FileName]));
end;

procedure TPyIDEMainForm.DeleteObjectsInUMLForms;
begin
  GI_FileFactory.ApplyToFiles(
    procedure(AFile: IFile)
    begin
      if (AFile as TFile).GetFileKind = fkUML then
        ((AFile as TFile).Form as TFUMLForm).DeleteObjects;
    end);
end;

procedure TPyIDEMainForm.StructogramFromText(Sourcecode, Pathname: string);
var
  AFile: IFile;
  Msg: string;
  ModelResult: Integer;
begin
  AFile := GI_FileFactory.GetFileByName(Pathname);
  if Assigned(AFile) then
  begin
    (AFile.Form as TFStructogram).RenewFromText(Sourcecode);
    DoOpen(Pathname);
  end
  else
  begin
    Msg := Format(_(LNGFileAlreadyExists), [Pathname]);
    if FileExists(Pathname) then
    begin
      ModelResult := StyledMessageDlg(Msg, mtConfirmation, mbYesNoCancel, 0);
      case ModelResult of
        mrYes:
          System.IOUtils.TFile.Delete(Pathname);
        mrNo:
          Pathname := GetFilename('.psg');
      else
        Exit;
      end;
    end;
    AFile := GI_EditorFactory.OpenFile(Pathname);
    (AFile.Form as TFStructogram).FromText(Sourcecode);
  end;
end;

procedure TPyIDEMainForm.DoExport(const Pathname: string; Bitmap: TBitmap);
var
  Folder, Ext: string;

  procedure InToPng(FileName: string);
  var
    Png: TPngImage;
  begin
    Png := TPngImage.Create;
    try
      Png.Assign(Bitmap);
      Png.SaveToFile(FileName);
    finally
      FreeAndNil(Png);
    end;
  end;

  procedure InToBmp(FileName: string);
  begin
    Bitmap.SaveToFile(FileName);
  end;

  procedure InToWMF(FileName: string);
  var
    Metafile: TMetafile;
    MetafileCanvas: TMetafileCanvas;
    DeviceContext: HDC;
    ScreenLogPixels: Integer;
  begin
    Metafile := TMetafile.Create;
    try
      DeviceContext := GetDC(0);
      ScreenLogPixels := GetDeviceCaps(DeviceContext, LOGPIXELSY);
      Metafile.Inch := ScreenLogPixels;
      Metafile.Width := Bitmap.Width + 20;
      Metafile.Height := Bitmap.Height + 20;
      MetafileCanvas := TMetafileCanvas.Create(Metafile, DeviceContext);
      ReleaseDC(0, DeviceContext);
      try
        MetafileCanvas.Draw(0, 0, Bitmap);
      finally
        FreeAndNil(MetafileCanvas);
      end;
      Metafile.Enhanced := False;
      Metafile.SaveToFile(FileName);
    finally
      Metafile.Destroy;
    end;
  end;

begin
  with ResourcesDataModule.dlgFileSave do
  begin
    Title := _('Export to');
    Filter := 'PNG (*.png)|*.png|BMP (*.bmp)|*.bmp|WMF (*.wmf)|*.wmf|';
    Folder := ExtractFilePath(Pathname);
    if Folder <> '' then
      InitialDir := Folder
    else
      InitialDir := GuiPyOptions.Sourcepath;
    FileName := ChangeFileExt(Pathname, '');
    if Execute then
    begin
      if ExtractFileExt(FileName) = '' then
        case FilterIndex of
          1:
            FileName := FileName + '.png';
          2:
            FileName := FileName + '.bmp';
          3:
            FileName := FileName + '.wmf';
        end;
      if not FileExists(FileName) or FileExists(FileName) and
        (StyledMessageDlg(Format(_(LNGFileAlreadyExists), [FileName]), mtError,
        [mbYes, mbNo, mbCancel], 0) = mrYes) then
      begin
        Ext := LowerCase(ExtractFileExt(FileName));
        if Ext = '.png' then
          InToPng(FileName)
        else if Ext = '.bmp' then
          InToBmp(FileName)
        else if Ext = '.wmf' then
          InToWMF(FileName);
      end;
      GuiPyOptions.Sourcepath := ExtractFilePath(FileName);
    end;
  end;
end;

procedure TPyIDEMainForm.EditorViewsMenuClick(Sender: TObject);
begin
  GI_EditorFactory.UpdateEditorViewsMenu(EditorViewsMenu);
end;

type
  TTBCustomItemAccess = class(TTBCustomItem);

procedure TPyIDEMainForm.FormCreate(Sender: TObject);
begin
  // Shell Images
  FShellImages := TCommonVirtualImageList.Create(Self);
  TCommonVirtualImageList(FShellImages).SourceImageList := SmallSysImages;
  FShellImages.SetSize(MulDiv(FShellImages.Width, FCurrentPPI,
    Screen.PixelsPerInch), MulDiv(FShellImages.Height, FCurrentPPI,
    Screen.PixelsPerInch));

  // Set the HelpFile
  Application.HelpFile := ExtractFilePath(Application.ExeName) +
    'PyScripter.chm';
  Application.OnHelp := Self.ApplicationHelp;

  DockServer.DockStyle := ResourcesDataModule.DockStyle;

  // App Instances
  FShellExtensionFiles := TStringList.Create;
  if not CmdLineReader.ReadFlag('NEWINSTANCE') then
  begin
    JvAppInstances.Active := True;
    JvAppInstances.Check;
  end;

  // Layout stuff
  FLayouts := TStringList.Create;
  FLayouts.Sorted := True;
  FLayouts.Duplicates := dupError;

  // GI_PyIDEServices
  GI_PyIDEServices := Self;

  // Activity Indicator
  SetActivityIndicator(False);

  // Application Storage
  AppStorage.Encoding := TEncoding.UTF8;
  AppStorage.FileName := TPyScripterSettings.OptionsFileName;

  // LocalAppStorage
  LocalAppStorage.FileName := TPath.ChangeExtension
    (TPyScripterSettings.OptionsFileName, '.local.ini');

  // Machine Storage
  MachineStorage.Encoding := TEncoding.UTF8;
  MachineStorage.FileName := TPath.Combine(ExtractFilePath(Application.ExeName),
    'GuiPyMachine.ini');

  // OutputDebugString(PWideChar(Format('%s ElapsedTime %d ms', ['Before All Forms', StopWatch.ElapsedMilliseconds])));
  // Create and layout IDE windows
  PythonIIForm := TPythonIIForm.Create(Self);
  CallStackWindow := TCallStackWindow.Create(Self);
  VariablesWindow := TVariablesWindow.Create(Self);
  WatchesWindow := TWatchesWindow.Create(Self);
  BreakPointsWindow := TBreakPointsWindow.Create(Self);
  OutputWindow := TOutputWindow.Create(Self);
  MessagesWindow := TMessagesWindow.Create(Self);
  CodeExplorerWindow := TCodeExplorerWindow.Create(Self);
  FileExplorerWindow := TFileExplorerWindow.Create(Self);
  ToDoWindow := TToDoWindow.Create(Self);
  RegExpTesterWindow := TRegExpTesterWindow.Create(Self);
  UnitTestWindow := TUnitTestWindow.Create(Self);
  FindResultsWindow := TFindResultsWindow.Create(Self);
  ProjectExplorerWindow := TProjectExplorerWindow.Create(Self);
  LLMChatForm := TLLMChatForm.Create(Self);
  FUMLInteractive := TFUMLInteractive.Create(Self);

  FConfiguration := TFConfiguration.Create(Self);
  FConfiguration.PopupParent := Self;
  DMImages := TDMImages.Create(Self);

  FGUIDesigner := TFGuiDesigner.Create(Self);
  FObjectInspector := TFObjectInspector.Create(Self);
  FObjectGenerator := TFObjectGenerator.Create(Self);
  FFileStructure := TFFileStructure.Create(Self);
  FClassEditor := TFClassEditor.Create(Self);
  FDragRectangle := nil;

  // And now translate after all the docking forms have been created
  // They will be translated as well
  TP_GlobalIgnoreClass(TVirtualImageList);
  TranslateComponent(Self);

  // OutputDebugString(PWideChar(Format('%s ElapsedTime %d ms', ['After Translate', StopWatch.ElapsedMilliseconds])));

  // Setup Languages
  FLanguageList := TStringList.Create;
  SetupLanguageMenu;

  // ActionLists
  TActionProxyCollection.ActionLists :=
    [actlStandard, CommandsDataModule.actlMain,
    PythonIIForm.InterpreterActionList, ProjectExplorerWindow.ProjectActionList,
    CallStackWindow.actlCallStack];

  // Notifications
  TMessageManager.DefaultManager.SubscribeToMessage(TIDEOptionsChangedMessage,
    PyIDEOptionsChanged);
  SkinManager.AddSkinNotification(Self);
  SkinManager.BroadcastSkinNotification;

  // Application Restart
  if PyIDEOptions.AutoRestart then
    RegisterApplicationRestart;

  // Read Settings from GuiPy.ini
  if FileExists(AppStorage.IniFile.FileName) then
    RestoreApplicationData
  else
  begin
    PyIDEOptions.Changed;
    FConfiguration.ApplyColorTheme;
  end;

  // Read Settings from GuiPy.local.ini
  if FileExists(LocalAppStorage.IniFile.FileName) then
    RestoreLocalApplicationData
  else
    WindowState := TWindowState.wsMaximized;

  // DSA stuff - Don't Show Again
  FDSAAppStorage := TDSAAppStorage.Create(AppStorage, 'DSA');
  RegisterDSACheckMarkText(CtkRemember, _(SDSActkRememberText));
  RegisterDSA(dsaSearchFromStart, 'SearchFromStart',
    'Search from start question', FDSAAppStorage, CtkRemember);
  RegisterDSA(dsaReplaceFromStart, 'ReplaceFromStart',
    'Replace from start question', FDSAAppStorage, CtkRemember);
  RegisterDSA(dsaReplaceNumber, 'ReplaceNumber',
    'Information about number of replacements', FDSAAppStorage, ctkShow);
  RegisterDSA(dsaSearchStartReached, 'SearchStartReached',
    'Information: search start reached', FDSAAppStorage, ctkShow);
  RegisterDSA(dsaPostMortemInfo, 'PostMortemInfo', 'Instructions: Post Mortem',
    FDSAAppStorage, ctkShow);
  RegisterDSA(dsaDictonaryNA, 'DictornayNA', 'DictionaryNA',
    FDSAAppStorage, ctkShow);

  // Store Factory Settings
  if not AppStorage.PathExists(FactoryToolbarItems) then
    SaveToolbarItems(FactoryToolbarItems);

  if FOldMonitorProfile = MonitorProfile then
    if GuiPyOptions.UsePredefinedLayouts then
      LoadPredefinedDefaultLayout
    else
      LoadCurrentLayout
  else
    CreateDefaultLayout;

  Application.OnIdle := ApplicationOnIdle;
  Application.OnHint := ApplicationOnHint;
  Application.OnShowHint := ApplcationOnShowHint;
  Application.OnActionUpdate := ApplicationActionUpdate;
  Application.OnActionExecute := ApplicationActionExecute;

  // last place
  // Editor Views Menu
  GI_EditorFactory.SetupEditorViewsMenu(EditorViewsMenu, vilImages);
  ChangeMenuSystem;

  // Tab Conrol Drag Drop and other TabControl events
  TabControl1.Toolbar.OnDragOver := TabToolbarDragOver;
  TabControl1.Toolbar.OnDragDrop := TabToolbarlDragDrop;
  TabControl2.Toolbar.OnDragOver := TabToolbarDragOver;
  TabControl2.Toolbar.OnDragDrop := TabToolbarlDragDrop;
  TabControl1.Toolbar.OnMouseDown := TabControlMouseDown;
  TabControl2.Toolbar.OnMouseDown := TabControlMouseDown;
  TabControlWidgets.ActiveTabIndex := 0;
  FTabControlsShowing := 0;

  // Flicker
  MainMenu.DoubleBuffered := True;
  MainToolBar.DoubleBuffered := True;
  DebugToolbar.DoubleBuffered := True;
  EditorToolbar.DoubleBuffered := True;
  FindToolbar.DoubleBuffered := True;

  // SkinManager.AddSkinNotification(Self);
  // SkinManager.BroadcastSkinNotification;
  FConfiguration.PatchConfiguration;
  ChangeStyle;
end;

procedure TPyIDEMainForm.ChangeMenuSystem;
begin
  SetLayoutMenus(GuiPyOptions.UsePredefinedLayouts);
  PythonIIForm.mnPythonVersions.Visible := False;
  PythonIIForm.TBXPythonEngines.Visible := False;
  var
  ViewMenuItem := EditorViewsMenu[2];
  EditorViewsMenu.Remove(ViewMenuItem);
  ToolsMenu.Insert(2, ViewMenuItem);
  ViewMenuItem.Tag := 0;
end;

procedure TPyIDEMainForm.SetLayoutMenus(Predefined: Boolean);
begin
  mnLayouts.Visible := not Predefined;
  mnViewDefaultLayout.Visible := Predefined;
  mnViewDebugLayout.Visible := Predefined;
  if Predefined then
    FLayouts.Text := 'Debug'#13#10'Default'#13#10
  else
    LocalAppStorage.ReadStringList('Layouts', FLayouts, True);
end;

procedure TPyIDEMainForm.FormAfterMonitorDpiChanged(Sender: TObject;
OldDPI, NewDPI: Integer);
var
  Files: array [0 .. 10] of string;
  FilesCount: Integer;
  AFile: IFile;
  ActiveFilename: string;
begin
  SetDockTopPanel;
  FilesCount := 0;

  TThread.ForceQueue(nil,
    procedure
    begin
      Invalidate;
      MainMenu.Invalidate;
      MainToolBar.Invalidate;
      DebugToolbar.Invalidate;
      TabControlWidgets.Invalidate;
      FFileStructure.Invalidate; // not necessary with ParentFont = False

      // a structogram form loses it's components during dpi switching!
      // workaround: save, close and reopen
      AFile := GetActiveFile;
      if Assigned(AFile) then
        ActiveFilename := (AFile.Form as TFileForm).Pathname
      else
        ActiveFilename := '';
      for var I := 0 to GI_FileFactory.Count - 1 do
      begin
        AFile := GI_FileFactory[I];
        if AFile.FileKind = fkStructogram then
        begin
          Files[FilesCount] := (AFile.Form as TFStructogram).Pathname;
          Inc(FilesCount);
        end;
        (AFile.Form as TFileForm).DPIChanged;
      end;
      for var I := 0 to FilesCount - 1 do
      begin
        var
        Pathname := Files[I];
        AFile := GI_FileFactory.GetFileByName(Pathname);
        (AFile.Form as TFileForm).DoSave;
        (AFile as IFileCommands).ExecClose;
        DoOpen(Pathname);
      end;
      if ActiveFilename <> '' then
        ActivateFile(ActiveFilename);
    end);
end;

procedure TPyIDEMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  procedure DelayedClose;
  begin
    TThread.ForceQueue(nil,
      procedure
      begin
        PostMessage(Application.Handle, WM_CLOSE, 0, 0);
      end, 1000);
  end;

begin
  if JvGlobalDockIsLoading then
  begin
    CanClose := False;
    DelayedClose;
    Exit;
  end
  else if GI_PyControl.DebuggerState <> dsInactive then
  begin
    if StyledMessageDlg(_(SAbortDebugging), mtWarning, [mbYes, mbNo], 0) = mrYes
    then
    begin
      if (GI_PyControl.DebuggerState in [dsPaused, dsPostMortem]) or
        (PyControl.ActiveDebugger is TPyInternalDebugger) then
      begin
        CanClose := False;
        PyControl.ActiveDebugger.Abort;
        DelayedClose;
        Exit;
      end
      else
      begin
        CanClose := False;
        PyControl.ActiveInterpreter.ReInitialize;
        DelayedClose;
        Exit;
      end;
    end
    else
    begin // mrNo
      CanClose := False;
      Exit;
    end;
  end;

  if OutputWindow.IsRunning then
    if StyledMessageDlg(_(SKillExternalTool), mtConfirmation, [mbYes, mbCancel],
      0) = mrYes then
    begin
      OutputWindow.actToolTerminateExecute(Self);
      CanClose := True;
    end
    else
      CanClose := False;

  // Ask about saving unsaved editor buffers
  if CanClose and not PyIDEOptions.SaveFilesAutomatically and
    Assigned(GI_FileFactory) then
    CanClose := GI_FileFactory.CanCloseAll;

  // Ask about saving unsaved project
  if CanClose and not PyIDEOptions.SaveFilesAutomatically then
    CanClose := CanClose and ProjectExplorerWindow.CanClose;

  if CanClose then
  begin
    // Shut down help
    Application.OnHelp := nil;
    // QC25183
    try
      Application.HelpCommand(HELP_QUIT, 0);
    except
    end;

    // Disconnect ChangeNotify
    FileExplorerWindow.FileExplorerTree.Active := False;
    FileExplorerWindow.ConfigureThreads(fcnDisabled, False);

    // Stop accepting files
    DragAcceptFiles(TabControl1.Handle, False);
    DragAcceptFiles(TabControl2.Handle, False);
    ClearPythonWindows;
    CloseTextDiffsAndFromTemplate;

    // Give the time to the treads to terminate
    Sleep(200);

    // We need to do this here so that MRU and docking information are persisted
    try
      SaveEnvironment;
    except
      on E: EFileStreamError do
        StyledMessageDlg(Format(_(SFileSaveError), [AppStorage.FullFileName,
          E.Message]), mtError, [mbOK], 0);
    end;

    TabControl1.Toolbar.BeginUpdate;
    TabControl2.Toolbar.BeginUpdate;
    try
      if Assigned(GI_FileFactory) then
        GI_FileFactory.CloseAll;
    finally
      TabControl1.Toolbar.EndUpdate;
      TabControl2.Toolbar.EndUpdate;
    end;

    SkinManager.RemoveSkinNotification(Self);
  end;
end;

procedure TPyIDEMainForm.TabContolContextPopup(Sender: TObject;
MousePos: TPoint; var Handled: Boolean);
var
  ItemViewer: TTBItemViewer;
  TabCtrl: TSpTBXTabControl;
begin
  TabCtrl := Sender as TSpTBXTabControl;
  ActiveTabControl := TabCtrl;
  ItemViewer := TabCtrl.View.ViewerFromPoint
    (TabCtrl.Toolbar.ScreenToClient(TabCtrl.ClientToScreen(MousePos)));
  if Assigned(ItemViewer) and (ItemViewer.Item is TSpTBXTabItem) then
    ItemViewer.Item.Checked := True;
  // To update File Close
  CommandsDataModule.UpdateMainActions;
  Handled := False;
end;

procedure TPyIDEMainForm.actNavBreakpointsExecute(Sender: TObject);
begin
  ShowDockForm(BreakPointsWindow);
  BreakPointsWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavCallStackExecute(Sender: TObject);
begin
  ShowDockForm(CallStackWindow);
  CallStackWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavChatExecute(Sender: TObject);
begin
  if not LLMChatForm.Visible then
    ShowDockForm(LLMChatForm)
  else
    HideDockForm(LLMChatForm);
end;

procedure TPyIDEMainForm.actNavCodeExplorerExecute(Sender: TObject);
begin
  ShowDockForm(CodeExplorerWindow);
  CodeExplorerWindow.FormActivate(Sender);
  // only when activated by the menu or the keyboard - Will be reset by frmIDEDockWin
  ResourcesDataModule.DockStyle.ChannelOption.MouseleaveHide := False;
end;

procedure TPyIDEMainForm.actNavEditorExecute(Sender: TObject);
begin
  var
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.Activate;
end;

procedure TPyIDEMainForm.ShowIDEDockForm(Form: TForm; Activate: Boolean = True);
begin
  if not Activate then
    DockServer.AutoFocusDockedForm := False;
  ShowDockForm(Form as TIDEDockWindow);
  if Activate then
  begin
    if Assigned(Form.OnActivate) then
      Form.OnActivate(Self);
    // only when activated by the menu or the keyboard - Will be reset by frmIDEDockWin
    //ResourcesDataModule.DockStyle.ChannelOption.MouseleaveHide := False;
  end;
  ResourcesDataModule.DockStyle.ChannelOption.MouseleaveHide := False;
  DockServer.AutoFocusDockedForm := True;
end;

procedure TPyIDEMainForm.PrepareClassEdit(Editor: IEditor; const Status: string;
UML: TFUMLForm);
begin
  TThread.ForceQueue(nil,
    procedure
    begin
      ClassEdit(Editor, Status, UML);
    end);
end;

procedure TPyIDEMainForm.ClassEdit(Editor: IEditor; const Status: string;
UML: TFUMLForm);
begin
  var
  Editform := TEditorForm(Editor.Form);
  if Assigned(UML) then
    ActivateFile(UML.Pathname);

  if FClassEditor.CreateTreeView(Editform, UML) then
  begin
    Editor.ActiveSynEdit.LockUndo;
    try
      Application.ProcessMessages;
      if FClassEditor.ShowModal = mrOk then
      begin
        Editform.mnEditAddImportsClick(Self);
        Editform.DoSave;
        if Assigned(UML) then
        begin
          try
            LockFormUpdate(UML);
            UML.MainModul.AddToProject(Editor.FileName);
            UML.SaveAndReload;
            RunFile(UML.GetFile);
          finally
            UnlockFormUpdate(UML);
          end;
        end
        else
          RunFile(Editor);
      end;
    finally
      Editor.ActiveSynEdit.UnlockUndo;
    end;
  end
  else
  begin
    var
    Msg := ChangeFileExt(ExtractFileName(Editor.FileName), '');
    ErrorMsg(Format(_('Class not found %s'), [Msg]));
  end;
  if Assigned(UML) then
  begin
    UML.OpenWindow(Self);
    UML.SetActiveControl(UML.MainModul.Diagram.GetPanel);
  end;
end;

procedure TPyIDEMainForm.ClearPythonWindows;
begin
  GI_VariablesWindow.ClearAll;
  GI_CallStackWindow.ClearAll;
  UnitTestWindow.ClearAll;
  RegExpTesterWindow.Clear;
end;

procedure TPyIDEMainForm.CloseTextDiffsAndFromTemplate;
var
  AFile: IFile;
begin
  for var I := GI_FileFactory.Count - 1 downto 0 do
  begin
    AFile := GI_FileFactory.GetFile(I);
    if (AFile.FileKind = fkTextdiff) { or
      AFile.FromTemplate and not AFile.Modified } then
      (AFile as IFileCommands).ExecClose;
  end;
end;

procedure TPyIDEMainForm.actNavFileExplorerExecute(Sender: TObject);
begin
  ShowIDEDockForm(FileExplorerWindow);
end;

procedure TPyIDEMainForm.actNavInterpreterExecute(Sender: TObject);
begin
  ShowIDEDockForm(PythonIIForm);
end;

procedure TPyIDEMainForm.actNavMessagesExecute(Sender: TObject);
begin
  ShowIDEDockForm(MessagesWindow);
end;

procedure TPyIDEMainForm.actNavOutputExecute(Sender: TObject);
begin
  ShowIDEDockForm(OutputWindow);
end;

procedure TPyIDEMainForm.actNavProjectExplorerExecute(Sender: TObject);
begin
  ShowIDEDockForm(ProjectExplorerWindow);
end;

procedure TPyIDEMainForm.actNavRETesterExecute(Sender: TObject);
begin
  ShowIDEDockForm(RegExpTesterWindow);
end;

procedure TPyIDEMainForm.actNavStructureExecute(Sender: TObject);
begin
  ShowIDEDockForm(FFileStructure);
  CodeExplorerWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavTodoExecute(Sender: TObject);
begin
  ShowIDEDockForm(ToDoWindow);
end;

procedure TPyIDEMainForm.actNavUnitTestsExecute(Sender: TObject);
begin
  ShowIDEDockForm(UnitTestWindow);
end;

procedure TPyIDEMainForm.actNavVariablesExecute(Sender: TObject);
begin
  ShowIDEDockForm(VariablesWindow);
end;

procedure TPyIDEMainForm.actNavWatchesExecute(Sender: TObject);
begin
  ShowIDEDockForm(WatchesWindow);
end;

procedure TPyIDEMainForm.actFileNewFileExecute(Sender: TObject);
begin
  var NewFileDialog := TNewFileDialog.Create(Self);
  try
    if NewFileDialog.ShowModal = mrOk then
      NewFileFromTemplate(NewFileDialog.SelectedTemplate);
  finally
    NewFileDialog.Free;
  end;
end;

procedure TPyIDEMainForm.actNextEditorExecute(Sender: TObject);
var
  TabItem: TSpTBXTabItem;
  TabCtrl: TSpTBXTabControl;
begin
  TabCtrl := ActiveTabControl as TSpTBXTabControl;
  if TabCtrl.PagesCount <= 1 then
    Exit;
  TabItem := nil;
  if PyIDEOptions.SmartNextPrevPage then
    with TabCtrl do
    begin
      repeat
        Inc(FZOrderPos);
        if FZOrderPos >= FZOrder.Count then
          FZOrderPos := 0;
        while FZOrderPos < FZOrder.Count do
        begin
          TabItem := FZOrder[FZOrderPos];
          if Items.IndexOf(TabItem) < 0 then
          begin
            FZOrder.Delete(FZOrderPos);
            TabItem := nil;
          end
          else
            Break;
        end;
      until Assigned(TabItem) or (FZOrder.Count = 0);
      KeyPreview := True;
      FZOrderProcessing := True;
    end
  else
  begin
    if Assigned(TabCtrl.ActivePage) then
      TabItem := TabCtrl.ActivePage.Item.GetNextTab(True, sivtNormal)
    else
      TabItem := TabCtrl.Pages[0].Item;
  end;

  if not Assigned(TabItem) and (TabCtrl.PagesCount > 0) then
    TabItem := TabCtrl.Pages[0].Item;
  if Assigned(TabItem) then
    TabItem.Checked := True;
end;

procedure TPyIDEMainForm.actUMLOpenFolderExecute(Sender: TObject);
begin
  CreateUMLForm(GetFilename('.puml')).OpenFolder;
end;

procedure TPyIDEMainForm.actUMLNewCommentExecute(Sender: TObject);
var
  AFile: IFile;
begin
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
    TFUMLForm(AFile.Form).TBCommentClick(Self);
end;

procedure TPyIDEMainForm.actUMLNewLayoutExecute(Sender: TObject);
var
  AFile: IFile;
begin
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
    TFUMLForm(AFile.Form).MainModul.DoLayout;
end;

procedure TPyIDEMainForm.actUMLRefreshExecute(Sender: TObject);
var
  AFile: IFile;
begin
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
    TFUMLForm(AFile.Form).TBRefreshClick(Self);
end;

procedure TPyIDEMainForm.actUMLSaveAsPictureExecute(Sender: TObject);
begin
  var
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
    TFUMLForm(AFile.Form).MainModul.SaveDiagramActionExecute(Self);
end;

procedure TPyIDEMainForm.actUMLDiagramFromOpenFilesExecute(Sender: TObject);
var
  ModelResult: Integer;
  FileName, Path: string;
  StringList: TStringList;
  AFile: IFile;
begin
  StringList := TStringList.Create;
  StringList.Sorted := True;
  try
    Path := '';
    for var I := 0 to GI_EditorFactory.Count - 1 do
    begin
      if GI_EditorFactory[I].HasPythonFile then
      begin
        FileName := GI_EditorFactory[I].FileName;
        if Path = '' then
          Path := ExtractFilePath(FileName);
        StringList.Add(ChangeFileExt(ExtractFileName(FileName), ''));
      end;
    end;
    if StringList.Count > 0 then
    begin
      FileName := Path;
      for var I := 0 to StringList.Count - 1 do
        FileName := FileName + StringList[I];
      FileName := FileName + '.puml';

      ModelResult := mrNone;
      if FileExists(FileName) then
      begin
        ModelResult := StyledMessageDlg(Format(_(LNGFileAlreadyExists),
          [FileName]), mtError, [mbYes, mbNo, mbCancel], 0);
        if ModelResult = mrNo then
          GI_EditorFactory.OpenFile(FileName);
      end;
      if ModelResult = mrYes then
      begin
        AFile := GI_FileFactory.GetFileByName(FileName);
        if Assigned(AFile) then
          (AFile as IFileCommands).ExecClose;
        Application.ProcessMessages;
      end;
      if ModelResult in [mrYes, mrNone] then
        CreateUMLForm(FileName).OpenFiles;
    end;
  finally
    FreeAndNil(StringList);
  end;
end;

procedure TPyIDEMainForm.actUMLEditClassExecute(Sender: TObject);
begin
  var
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
    TFUMLForm(AFile.Form).ClassEdit
  else
  begin
    var
    AEditor := GI_PyIDEServices.GetActiveEditor;
    if TEditorForm(AEditor.Form).IsPython then
      PrepareClassEdit(AEditor, 'Edit', nil);
  end;
end;

procedure TPyIDEMainForm.actUMLNewClassExecute(Sender: TObject);
var
  NewName: string;
  Editor: IEditor;
  FileTemplate: TFileTemplate;
  UML: TFUMLForm;
begin
  var
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
  begin
    TFUMLForm(AFile.Form).MainModul.UnSelectAllElements;
    TFUMLForm(AFile.Form).TBClassDefinitionClick(Self);
  end
  else
  begin
    NewName := '';
    if ResourcesDataModule.GetSaveFileName(NewName,
      ResourcesDataModule.SynPythonSyn, 'py') then
    begin
      FileTemplate := FileTemplates.TemplateByName(SClassTemplateName);
      if not Assigned(FileTemplate) then
      begin
        FileTemplates.AddClassTemplate;
        FileTemplate := FileTemplates.TemplateByName(SClassTemplateName);
      end;
      Editor := NewFileFromTemplate(FileTemplate,
        TabControlIndex(ActiveTabControl), NewName);
      UML := TFUMLForm(GI_EditorFactory.OpenFile(ChangeFileExt(NewName,
        '.puml')).Form);
      PrepareClassEdit(Editor, 'New', UML);
    end;
  end;
end;

procedure TPyIDEMainForm.actUMLNewUMLExecute(Sender: TObject);
begin
  GI_EditorFactory.OpenFile(GetFilename('.puml'));
end;

procedure TPyIDEMainForm.actUMLOpenClassExecute(Sender: TObject);
begin
  LockFormUpdate(Self);
  with ResourcesDataModule.dlgFileOpen do
  begin
    if Assigned(GI_PyIDEServices.GetActiveFile) then
      InitialDir := ExtractFilePath(GI_PyIDEServices.GetActiveFile.FileName)
    else
      InitialDir := GuiPyOptions.Sourcepath;
    if not DirectoryExists(InitialDir) then
      InitialDir := GetDocumentsPath;
    FileName := '*.py';
    FilterIndex := 1;
    Options := Options + [ofAllowMultiSelect];
    if Execute then
    begin
      for var I := 0 to Files.Count - 1 do
        DoOpenInUMLWindow(Files[I]);
      if Files.Count > 0 then
        GuiPyOptions.Sourcepath := ExtractFilePath(Files[0]);
      actRunExecute(Self);
    end;
  end;
  UnlockFormUpdate(Self);
end;

procedure TPyIDEMainForm.actPostMortemExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.EnterPostMortem;
end;

procedure TPyIDEMainForm.actPreviousEditorExecute(Sender: TObject);
var
  TabItem: TSpTBXTabItem;
  TabCtrl: TSpTBXTabControl;
begin
  TabCtrl := ActiveTabControl as TSpTBXTabControl;
  if TabCtrl.PagesCount <= 1 then
    Exit;
  TabItem := nil;
  if PyIDEOptions.SmartNextPrevPage then
    with TabCtrl do
    begin
      repeat
        Dec(FZOrderPos);
        if FZOrderPos < 0 then
          FZOrderPos := FZOrder.Count - 1;
        while FZOrderPos < FZOrder.Count do
        begin
          TabItem := FZOrder[FZOrderPos];
          if Items.IndexOf(TabItem) < 0 then
          begin
            FZOrder.Delete(FZOrderPos);
            TabItem := nil;
          end
          else
            Break;
        end;
      until Assigned(TabItem) or (FZOrder.Count = 0);
      KeyPreview := True;
      FZOrderProcessing := True;
    end
  else
  begin
    if Assigned(TabCtrl.ActivePage) then
      TabItem := TabCtrl.ActivePage.Item.GetNextTab(False, sivtNormal)
    else
      TabItem := TabCtrl.Pages[TabCtrl.PagesCount - 1].Item;
  end;
  if not Assigned(TabItem) then
    TabItem := TabCtrl.Pages[TabCtrl.PagesCount - 1].Item;
  if Assigned(TabItem) then
    TabItem.Checked := True;
end;

procedure TPyIDEMainForm.actPythonEngineExecute(Sender: TObject);
var
  EngineType: TPythonEngineType;
  SSHServer: string;
begin
  EngineType := TPythonEngineType((Sender as TAction).Tag);
  if EngineType = peSSH then
  begin
    SSHServer := SelectSSHServer;
    if SSHServer <> '' then
      PyControl.ActiveSSHServerName := SSHServer
    else
      Exit;
  end;
  PyControl.PythonEngineType := EngineType;
  GI_PyInterpreter.PrintEngineType;
end;

procedure TPyIDEMainForm.actPythonFreeThreadedExecute(Sender: TObject);
begin
  PyIDEOptions.PreferFreeThreaded := actPythonFreeThreaded.Checked;
  actPythonReinitializeExecute(Sender);
end;

procedure TPyIDEMainForm.actPythonReinitializeExecute(Sender: TObject);
begin
  if not GI_PyControl.Inactive then
  begin
    if StyledMessageDlg(_(STerminateInterpreter), mtWarning, [mbYes, mbNo], 0) = idNo
    then
      Exit;
  end;
  PyControl.ActiveInterpreter.ReInitialize;
end;

procedure TPyIDEMainForm.actPythonSetupExecute(Sender: TObject);
begin
  TThread.ForceQueue(nil,
    procedure
    begin
      with TPythonVersionsDialog.Create(Self) do
      begin
        ShowModal;
        Release;
        SetupPythonVersionsMenu;
      end;
    end);
end;

procedure TPyIDEMainForm.actSyntaxCheckExecute(Sender: TObject);
begin
  var ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then Exit;

  ActiveEditor.PullDiagnostics;
end;

procedure TPyIDEMainForm.actToolsConfigurationExecute(Sender: TObject);
begin
  // due to visible/modal-exception
  if not FConfiguration.Visible then
  begin
    FConfiguration.PrepareShow;
    FConfiguration.ShowModal;
  end;
end;

procedure TPyIDEMainForm.actToolsTextDiffExecute(Sender: TObject);
var
  Forms: array [0 .. 1] of TEditorForm;
  I: Integer;
  Editor: IEditor;
begin
  Forms[0] := nil;
  Forms[1] := nil;
  for I := 0 to Min(2, GI_EditorFactory.Count) - 1 do
  begin
    Editor := GI_EditorFactory.GetEditor(I);
    Forms[I] := Editor.Form as TEditorForm;
    if Forms[I].Modified or Editor.FromTemplate then
      Forms[I].DoSave;
  end;
  NewTextDiff(Forms[0], Forms[1]);
end;

procedure TPyIDEMainForm.NewTextDiff(Form1, Form2: TEditorForm);
var
  TabCtrl: TSpTBXTabControl;
  AFile: IFile;
  TextDiff: TFTextDiff;
begin
  // create a new textdiff
  TabCtrl := TSpTBXTabControl(GetActiveTabControl);
  TabCtrl.Toolbar.BeginUpdate;
  try
    AFile := GI_FileFactory.CreateFile(fkTextdiff, FActiveTabControlIndex);
    if Assigned(AFile) then
    begin
      TextDiff := TFTextDiff(AFile.Form);
      try
        TextDiff.New(Form1, Form2);
        TextDiff.DoUpdateCaption;
        AFile.Activate;
      except
        AFile.Close;
        raise;
      end;
    end;
  finally
    TabCtrl.Toolbar.EndUpdate;
    if Assigned(TabCtrl.ActiveTab) then
      TabCtrl.MakeVisible(TabCtrl.ActiveTab);
  end;
end;

function TPyIDEMainForm.NewBrowser(Adresse: string): TFBrowser;
var
  TabCtrl: TSpTBXTabControl;
  AFile: IFile;
begin
  Result := nil;
  TabCtrl := nil;
  if IsHttp(Adresse) and GuiPyOptions.LockedInternet then
    Adresse := 'about:' + _('Internet locked!');
  if IsHttp(Adresse) then
    Adresse := HttpToWeb(Adresse);
  if GuiPyOptions.OnlyOneBrowserWindow then
    AFile := GI_FileFactory.GetFileByType(fkBrowser)
  else
    AFile := GI_FileFactory.GetFileByNameAndType(Adresse, fkBrowser);
  if not Assigned(AFile) then
  begin
    TabCtrl := TSpTBXTabControl(GetActiveTabControl);
    TabCtrl.Toolbar.BeginUpdate;
    AFile := GI_FileFactory.CreateFile(fkBrowser, FActiveTabControlIndex);
    TabCtrl.Toolbar.EndUpdate;
  end;
  if Assigned(AFile) then
  begin
    Result := (AFile.Form as TFBrowser);
    Result.OpenFile(Adresse);
    AFile.Activate;
  end;
  if Assigned(TabCtrl) then
    TabCtrl.MakeVisible(TabCtrl.ActiveTab);
  UpdateCaption;
end;

procedure TPyIDEMainForm.actImportModuleExecute(Sender: TObject);
var
  Py: IPyEngineAndGIL;
  ActiveEditor: IEditor;
begin
  ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then
    Exit;

  Py := SafePyEngine;
  var
  PyModule := PyControl.ActiveInterpreter.ImportModule(ActiveEditor, True);
  VarClear(PyModule);

  GI_PyIDEServices.Messages.AddMessage(Format(_(SModuleImportedOK),
    [ActiveEditor.FileTitle]));
  ShowDockForm(MessagesWindow);
end;

procedure TPyIDEMainForm.actToggleBreakPointExecute(Sender: TObject);
var
  ActiveEditor: IEditor;
begin
  ActiveEditor := GetActiveEditor;
  if Assigned(ActiveEditor) and ActiveEditor.HasPythonFile then
    GI_BreakpointManager.ToggleBreakpoint(ActiveEditor.FileId,
      ActiveEditor.SynEdit.CaretY);
end;

procedure TPyIDEMainForm.actClearAllBreakpointsExecute(Sender: TObject);
begin
  GI_BreakpointManager.ClearAllBreakpoints;
end;

procedure TPyIDEMainForm.actCommandLineExecute(Sender: TObject);
begin
  with TCommandLineDlg.Create(Self) do
  begin
    SynParameters.Text := PyIDEOptions.CommandLine;
    cbUseCommandLine.Checked := PyIDEOptions.UseCommandLine;
    if ShowModal = mrOk then
    begin
      PyIDEOptions.CommandLine := SynParameters.Text;
      PyIDEOptions.UseCommandLine := cbUseCommandLine.Checked;
    end;
    Release;
  end;
end;

procedure TPyIDEMainForm.actRunDebugLastScriptExecute(Sender: TObject);
begin
  if GI_PyControl.Inactive then
    PyControl.Debug(PyControl.RunConfig);
end;

procedure TPyIDEMainForm.actRunExecute(Sender: TObject);
begin
  RunFile(GetActiveFile);
end;

procedure TPyIDEMainForm.RunFile(AFile: IFile);
begin
  if Assigned(AFile) then
  begin
    if AFile.FileKind = fkEditor then
      RunEditor(AFile as IEditor) // without import, starts a thread
    else
    begin
      if PyIDEOptions.ReinitializeBeforeRun then
        actPythonReinitializeExecute(nil);
      if PyIDEOptions.SaveFilesBeforeRun then
      begin
        GI_PyIDEServices.SaveFileModules;
        Application.MainForm.Refresh; // To update save flags
      end;
    end;

    // runEditor thread finished
    TThread.ForceQueue(nil,
      procedure
      begin
        CreatePycFilesForUMLWindows;
        for var I := 0 to GI_FileFactory.Count - 1 do
          if GI_FileFactory[I].FileKind = fkUML then
            (GI_FileFactory[I].Form as TFUMLForm)
              .MainModul.Diagram.RefreshDiagram;
      end);
  end;
end;

procedure TPyIDEMainForm.CreatePycFilesForUMLWindows;
var
  I: Integer;
begin
  DeleteObjectsInUMLForms;
  if not GI_PyControl.Running then
  begin
    var
    StringList := TStringList.Create(dupIgnore, True, False);
    try
      for I := 0 to GI_FileFactory.Count - 1 do
        if GI_FileFactory[I].FileKind = fkUML then
          StringList.AddStrings((GI_FileFactory[I].Form as TFUMLForm)
            .MainModul.GetFiles);
      for I := 0 to StringList.Count - 1 do
        if FileExists(StringList[I]) then
          ImportModule(StringList[I]); // creates the .pyc file
    finally
      FreeAndNil(StringList);
    end;
  end;
end;

function TPyIDEMainForm.GetCachedPycFilename(const FileName: string): string;
begin
  Result := TPath.Combine(ExtractFilePath(FileName),
    TPath.Combine('__pycache__', TPath.GetFileNameWithoutExtension(FileName) +
    '.cpython-' + MyStringReplace(PyControl.PythonVersion.SysVersion, '.',
    '') + '.pyc'));
end;

procedure TPyIDEMainForm.ImportModule(const Pathname: string);
var
  Path, Modul: string;
begin
  PyControl.ActiveInterpreter.RunSource('import os', '<interactive input>');
  Path := ExtractFilePath(Pathname);
  Path := MyStringReplace(Path, '\', '\\');
  PyControl.ActiveInterpreter.RunSource('os.chdir(' + AsString(Path) + ')',
    '<interactive input>');
  Modul := ChangeFileExt(ExtractFileName(Pathname), '');
  PyControl.ActiveInterpreter.RunSource('from ' + Modul + ' import *',
    '<interactive input>');
end;

function TPyIDEMainForm.IsAValidClass(const Pathname: string): Boolean;
var
  Editor: IEditor;
  Modified: Boolean;
  FDCached, FDPath: TDateTime;
  CachedFile: string;
begin
  if (Pathname = '') or not FileExists(Pathname) then
    Exit(True);
  Editor := GI_EditorFactory.GetEditorByName(Pathname);
  Modified := Assigned(Editor) and Editor.Modified;
  if Modified then
    Exit(False);
  CachedFile := GetCachedPycFilename(Pathname);
  Result := False;
  if FileExists(CachedFile) and FileAge(CachedFile, FDCached) and
    FileAge(Pathname, FDPath) then
    Result := (FDCached >= FDPath);
end;

procedure TPyIDEMainForm.RunEditor(ActiveEditor: IEditor);
var
  RunConfig: TRunConfiguration;
begin
  Application.ProcessMessages;
  ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then Exit;

  RunConfig :=  TRunConfiguration.Create;
  try
    SetupRunConfiguration(RunConfig, ActiveEditor);
    PyControl.Run(RunConfig);
  finally
    RunConfig.Free;
  end;

  WriteStatusMsg(_(StrScriptRunOK));
end;

procedure TPyIDEMainForm.actRunLastScriptExecute(Sender: TObject);
begin
  if GI_PyControl.Inactive then
    PyControl.Run(PyControl.RunConfig);
end;

procedure TPyIDEMainForm.actRunLastScriptExternalExecute(Sender: TObject);
begin
  PyControl.ExternalRun(PyControl.RunConfig);
end;

procedure TPyIDEMainForm.actDebugExecute(Sender: TObject);
var
  ActiveEditor: IEditor;
begin
  Assert(GI_PyControl.PythonLoaded and not GI_PyControl.Running);
  DeleteObjectsInUMLForms;
  ActiveEditor := GetActiveEditor;
  if Assigned(ActiveEditor) then
  begin
    if GI_PyControl.Inactive then
      DebugActiveScript(ActiveEditor)
    else if GI_PyControl.DebuggerState = dsPaused then
      PyControl.ActiveDebugger.Resume;
  end;
end;

procedure TPyIDEMainForm.actDebugPauseExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.Pause;
end;

procedure TPyIDEMainForm.actSelectStyleExecute(Sender: TObject);
begin
  // TStyleSelectorForm.Execute;
end;

procedure TPyIDEMainForm.actStepIntoExecute(Sender: TObject);
var
  ActiveEditor: IEditor;
begin
  Assert(GI_PyControl.PythonLoaded and not GI_PyControl.Running);
  DeleteObjectsInUMLForms;
  ActiveEditor := GetActiveEditor;
  if Assigned(ActiveEditor) then
  begin
    if GI_PyControl.Inactive then
      DebugActiveScript(ActiveEditor, True)
    else if GI_PyControl.DebuggerState = dsPaused then
      PyControl.ActiveDebugger.StepInto;
  end;
end;

procedure TPyIDEMainForm.actStepOverExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.StepOver;
end;

procedure TPyIDEMainForm.actStepOutExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.StepOut;
end;

procedure TPyIDEMainForm.actDebugAbortExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.Abort;
end;

procedure TPyIDEMainForm.actRunToCursorExecute(Sender: TObject);
var
  ActiveEditor: IEditor;
begin
  Application.ProcessMessages;
  ActiveEditor := GetActiveEditor;
  if Assigned(ActiveEditor) then
  begin
    if GI_PyControl.Inactive then
      DebugActiveScript(ActiveEditor, False, ActiveEditor.SynEdit.CaretY)
    else if GI_PyControl.DebuggerState = dsPaused then
      PyControl.ActiveDebugger.RunToCursor(ActiveEditor,
        ActiveEditor.SynEdit.CaretY);
  end;
end;

procedure TPyIDEMainForm.UpdateCaption;
begin
  if GetIsClosing then
    Exit;

  TThread.ForceQueue(nil,
    procedure
    begin
      var
      AFile := GetActiveFile;
      if Assigned(AFile) then
        Caption := Format('GuiPy - %s%s', [AFile.FileId, Iff(AFile.Modified,
          '*', '')])
      else
        Caption := 'GuiPy';
    end);
end;

procedure TPyIDEMainForm.SetupRunConfiguration(var RunConfig: TRunConfiguration;
  ActiveEditor: IEditor);
begin
  RunConfig.ScriptName := ActiveEditor.FileId;
  RunConfig.EngineType := PyControl.PythonEngineType;
  RunConfig.Parameters := CommandLineParams;
  RunConfig.ExternalRun.Assign(ExternalPython);
  RunConfig.ExternalRun.Parameters := Parameters.ReplaceInText(RunConfig.ExternalRun.Parameters);
  RunConfig.ReinitializeBeforeRun := PyIDEOptions.ReinitializeBeforeRun;
  RunConfig.WorkingDir := '';
end;

procedure TPyIDEMainForm.DebugActiveScript(ActiveEditor: IEditor;
InitStepIn: Boolean = False; RunToCursorLine: Integer = -1);
var
  RunConfig: TRunConfiguration;
begin
  Assert(GI_PyControl.Inactive);
  RunConfig := TRunConfiguration.Create;
  try
    SetupRunConfiguration(RunConfig, ActiveEditor);
    PyControl.Debug(RunConfig, InitStepIn, RunToCursorLine);
  finally
    RunConfig.Free;
  end;
end;

procedure TPyIDEMainForm.UpdateDebugCommands;
begin
  var
  Editor := GetActiveEditor;
  var
  AFile := GetActiveFile;
  var
  PyFileActive := Assigned(Editor) and
    (Editor.SynEdit.Highlighter = ResourcesDataModule.SynPythonSyn);
  var
  DbgState := GI_PyControl.DebuggerState;
  actSyntaxCheck.Enabled := PyFileActive and GI_PyControl.Inactive;
  actRun.Enabled := (PyFileActive or Assigned(AFile) and
    (AFile.FileKind = fkUML)) and GI_PyControl.Inactive;
  actExternalRun.Enabled := PyFileActive and GI_PyControl.Inactive;
  actImportModule.Enabled := PyFileActive and GI_PyControl.Inactive;
  actDebug.Enabled := PyFileActive and
    (GI_PyControl.Inactive or (DbgState = dsPaused));
  actStepInto.Enabled := PyFileActive and
    (GI_PyControl.Inactive or (DbgState = dsPaused));
  actStepOut.Enabled := DbgState = dsPaused;
  actStepOver.Enabled := DbgState = dsPaused;
  actDebugAbort.Enabled := DbgState in [dsPaused, dsDebugging, dsRunning,
    dsPostMortem];
  actDebugPause.Enabled := DbgState = dsDebugging;
  actRunToCursor.Enabled := PyFileActive and
    (GI_PyControl.Inactive or (DbgState = dsPaused)) and
    TPyRegExpr.IsExecutableLine(Editor.SynEdit.LineText);
  actToggleBreakPoint.Enabled := PyFileActive;
  actClearAllBreakpoints.Enabled := PyFileActive;
  actAddWatchAtCursor.Enabled := PyFileActive;
  actExecSelection.Enabled := GI_PyControl.PythonLoaded and
    not GI_PyControl.Running and PyFileActive;
  actPythonReinitialize.Enabled := Assigned(PyControl.ActiveInterpreter) and
    (icReInitialize in PyControl.ActiveInterpreter.InterpreterCapabilities) and
    not(DbgState in [dsPaused, dsPostMortem]);
  actPostMortem.Enabled := GI_PyControl.Inactive and
    Assigned(PyControl.ActiveDebugger) and
    PyControl.ActiveDebugger.PostMortemEnabled;
  if DbgState = dsPaused then
  begin
    actDebug.Caption := _(SResumeCaption);
    actDebug.Hint := _(SResumeHint);
  end
  else
  begin
    actDebug.Caption := _('Debug');
    actDebug.Hint := _(SDebugHint);
  end;
  actRunLastScript.Enabled := GI_PyControl.Inactive and
    (PyControl.RunConfig.ScriptName <> '');
  actRunDebugLastScript.Enabled := actRunLastScript.Enabled;
  actRunLastScriptExternal.Enabled := actRunLastScript.Enabled;

  CallStackWindow.actPreviousFrame.Enabled := (DbgState = dsPaused);
  CallStackWindow.actNextFrame.Enabled := (DbgState = dsPaused);
end;

procedure TPyIDEMainForm.SetActiveTabControl(const Value
  : TSpTBXCustomTabControl);
begin
  FActiveTabControlIndex := TabControlIndex(Value);
end;

type
  TCrackActivityIndicator = class(TActivityIndicator);

procedure TPyIDEMainForm.SetActivityIndicator(TurnOn: Boolean; Hint: string;
OnClick: TNotifyEvent);
begin
  ActivityIndicator.Visible := TurnOn;
  ActivityIndicator.Hint := Hint;
  ActivityIndicator.Animate := TurnOn;
  TCrackActivityIndicator(ActivityIndicator).OnClick := OnClick;
end;

procedure TPyIDEMainForm.SetRunLastScriptHints(const ScriptName: string);
var
  FName: string;
begin
  FName := TPath.GetFileName(ScriptName);
  if FName <> '' then
    FName := Format(' - %s ', [FName]);
  actRunLastScript.Hint := _(SHintRun) + FName;
  actRunDebugLastScript.Hint := _(SHintDebug) + FName;
  actRunLastScriptExternal.Hint := _(SHintExternalRun) + FName;
end;

procedure TPyIDEMainForm.DebuggerStateChange(Sender: TObject);
var
  StatusMsg: string;
begin
  if GetIsClosing then
    Exit;

  if GI_PyControl.PythonLoaded then
    case GI_PyControl.DebuggerState of
      dsDebugging, dsRunning:
        begin
          StatusMsg := _('Running');
          icIndicators.SVGIconItems[0].FixedColor := $4444E2;
        end;
      dsPaused:
        begin
          StatusMsg := _('Paused');
          icIndicators.SVGIconItems[0].FixedColor := $00CEFF;
        end;
      dsInactive:
        begin
          StatusMsg := _('Ready');
          icIndicators.SVGIconItems[0].FixedColor := $22AA22;
        end;
      dsPostMortem:
        begin
          StatusMsg := _('Post mortem');
          icIndicators.SVGIconItems[0].FixedColor := clPurple;
        end;
    end
  else
  begin
    StatusMsg := _('Python not available');
    icIndicators.SVGIconItems[0].FixedColor := clGray;
  end;
  spiStatusLED.Hint := _('Debugger state: ') + StatusMsg;
  lbStatusMessage.Caption := ' ' + StatusMsg;
  StatusBar.Refresh;

  UpdateDebugCommands;
end;

procedure TPyIDEMainForm.SaveFileModules;
begin
  GI_FileFactory.ApplyToFiles(
    procedure(AFile: IFile)
    begin
      if ((AFile.FileName <> '') or (AFile.RemoteFileName <> '')) and AFile.Modified
      then
      begin
        var
        FileCommands := AFile as IFileCommands;
        if Assigned(FileCommands) then
          FileCommands.ExecSave;
      end;
    end);
end;

procedure TPyIDEMainForm.ApplicationOnIdle(Sender: TObject; var Done: Boolean);
var
  I: Integer;
begin
  UpdateStandardActions;
  CommandsDataModule.UpdateMainActions;
  PythonIIForm.UpdateInterpreterActions;
  UpdateStatusBarPanels;
  UpdateDebugCommands;
  if Assigned(GI_PyIDEServices.ActiveFile) then
    (GI_PyIDEServices.ActiveFile as TFile).DoOnIdle;

  // If a Tk or Wx remote engine is active pump up event handling
  // This is for processing input output coming from event handlers
  if (PyControl.ActiveInterpreter is TPyRemoteInterpreter) and GI_PyControl.Inactive
  then
    with TPyRemoteInterpreter(PyControl.ActiveInterpreter) do
    begin
      if Connected and (EngineType in [peRemoteTk, peRemoteWx]) then
        try
          // Ignore exceptions here
          var
          Py := SafePyEngine;
          ServeConnection;
        except
        end;
    end;

  if FShellExtensionFiles.Count > 0 then
  begin
    for I := 0 to FShellExtensionFiles.Count - 1 do
      OpenCmdLineFile(FShellExtensionFiles[I]);
    FShellExtensionFiles.Clear;
  end;

  if not Application.Active then
  begin
    if CommandsDataModule.SynCodeCompletion.Form.Visible then
      CommandsDataModule.SynCodeCompletion.CancelCompletion;
    if CommandsDataModule.SynParamCompletion.Form.Visible then
      CommandsDataModule.SynParamCompletion.CancelCompletion;
  end;

  Done := True;
end;

procedure TPyIDEMainForm.ApplicationOnHint(Sender: TObject);
var
  Str: string;
begin
  Str := StringReplace(GetLongHint(Application.Hint), sLineBreak, ' ',
    [rfReplaceAll]);
  WriteStatusMsg(Str);
end;

procedure TPyIDEMainForm.ApplcationOnShowHint(var HintStr: string;
var CanShow: Boolean; var HintInfo: Vcl.Controls.THintInfo);
begin
  if HintInfo.HintControl is TBaseVirtualTree then
    HintInfo.HideTimeout := 5000;
end;

function TPyIDEMainForm.ShowFilePosition(FileName: string; Line: Integer = 1;
Offset: Integer = 1; SelLen: Integer = 0; ForceToMiddle: Boolean = True;
FocusEditor: Boolean = True): Boolean;
var
  Editor: IEditor;
  AFile: IFile;
begin
  Result := False;
  if FileName <> '' then
  begin
    if (FileName[1] = '<') and (FileName[Length(FileName)] = '>') then
      FileName := Copy(FileName, 2, Length(FileName) - 2);
    AFile := GI_FileFactory.GetFileByFileId(FileName);
    if not Assigned(AFile) and (FileName.StartsWith('ssh') or
      FileExists(FileName)) then
    begin
      try
        GI_EditorFactory.OpenFile(FileName);
      except
        Exit;
      end;
      AFile := GI_FileFactory.GetFileByFileId(FileName);
    end;

    if Assigned(AFile) then
      if AFile.FileKind = fkEditor then
      begin
        Editor := AFile as IEditor;
        if GI_PyControl.PythonLoaded and Editor.FileName.StartsWith
          (GI_PyControl.PythonVersion.InstallPath, True) then
          Editor.ReadOnly := True;
        Result := True;

        TThread.ForceQueue(nil,
          procedure
          begin
            // sets the focus to the editor
            if (Editor <> GetActiveEditor) or FocusEditor then
              Editor.Activate(False);
            if (Line > 0) then
            begin
              MouseCapture := True;
              with Editor.ActiveSynEdit do
              begin
                var
                Caret := BufferCoord(Offset, Line);
                SetCaretAndSelection(Caret, Caret, Caret, True, ForceToMiddle);
                if SelLen > 0 then
                  SelLength := SelLen;
              end;
              MouseCapture := False;
            end;
          end);
      end
      else if AFile <> GetActiveFile then
        AFile.Activate;
  end;
end;

procedure TPyIDEMainForm.SpTBXCustomizerGetCustomizeForm(Sender: TObject;
var CustomizeFormClass: TSpTBXCustomizeFormClass);
begin
  CustomizeFormClass := TSpTBXCustomizeFormMod;
end;

procedure TPyIDEMainForm.actViewSplitEditorHorExecute(Sender: TObject);
var
  Editor: IEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.SplitEditorHorizontally;
end;

procedure TPyIDEMainForm.actViewSplitEditorVerExecute(Sender: TObject);
var
  Editor: IEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.SplitEditorVertrically;
end;

procedure TPyIDEMainForm.actViewSplitWorkspaceHorExecute(Sender: TObject);
begin
  SplitWorkspace(True, alBottom);
end;

procedure TPyIDEMainForm.actViewSplitWorkspaceVerExecute(Sender: TObject);
begin
  SplitWorkspace(True, alRight);
end;

procedure TPyIDEMainForm.actViewStatusBarExecute(Sender: TObject);
begin
  StatusBar.Visible := not StatusBar.Visible;
  // This is to avoid the Status bar appearing above Bottom Dock Tab
  if StatusBar.Visible then
    StatusBar.Top := Height - StatusBar.Height;
end;

procedure TPyIDEMainForm.actViewIIExecute(Sender: TObject);
begin
  if not PythonIIForm.Visible then
    ShowDockForm(PythonIIForm)
  else
    HideDockForm(PythonIIForm);
end;

procedure TPyIDEMainForm.actViewMainMenuExecute(Sender: TObject);
begin
  MainMenu.Visible := not MainMenu.Visible;
end;

procedure TPyIDEMainForm.actViewCodeExplorerExecute(Sender: TObject);
begin
  if not CodeExplorerWindow.Visible then
    ShowDockForm(CodeExplorerWindow)
  else
    HideDockForm(CodeExplorerWindow);
end;

procedure TPyIDEMainForm.actViewCustomizeToolbarsExecute(Sender: TObject);
begin
  SpTBXCustomizer.Show;
end;

procedure TPyIDEMainForm.actViewFileExplorerExecute(Sender: TObject);
begin
  if not FileExplorerWindow.Visible then
    ShowDockForm(FileExplorerWindow)
  else
    HideDockForm(FileExplorerWindow);
end;

procedure TPyIDEMainForm.actViewToDoListExecute(Sender: TObject);
begin
  if not ToDoWindow.Visible then
  begin
    ShowDockForm(ToDoWindow);
    ToDoWindow.ToDoView.SetFocus;
  end
  else
    HideDockForm(ToDoWindow);
end;

procedure TPyIDEMainForm.actViewRegExpTesterExecute(Sender: TObject);
begin
  if not RegExpTesterWindow.Visible then
    ShowDockForm(RegExpTesterWindow)
  else
    HideDockForm(RegExpTesterWindow);
end;

procedure TPyIDEMainForm.actViewUMLInteractiveExecute(Sender: TObject);
begin
  if not FUMLInteractive.Visible then
    ShowDockForm(FUMLInteractive)
  else
    HideDockForm(FUMLInteractive);
end;

procedure TPyIDEMainForm.actViewUnitTestsExecute(Sender: TObject);
begin
  if not UnitTestWindow.Visible then
    ShowDockForm(UnitTestWindow)
  else
    HideDockForm(UnitTestWindow);
end;

procedure TPyIDEMainForm.actViewObjectinspectorExecute(Sender: TObject);
begin
  if not FObjectInspector.Visible then
    ShowDockForm(FObjectInspector)
  else
    HideDockForm(FObjectInspector);
end;

procedure TPyIDEMainForm.actViewOutputExecute(Sender: TObject);
begin
  if not OutputWindow.Visible then
    ShowDockForm(OutputWindow)
  else
    HideDockForm(OutputWindow);
end;

procedure TPyIDEMainForm.actViewProjectExplorerExecute(Sender: TObject);
begin
  if not ProjectExplorerWindow.Visible then
    ShowDockForm(ProjectExplorerWindow)
  else
    HideDockForm(ProjectExplorerWindow);
end;

procedure TPyIDEMainForm.actViewFindResultsExecute(Sender: TObject);
begin
  if not FindResultsWindow.Visible then
  begin
    ShowDockForm(FindResultsWindow);
  end
  else
    HideDockForm(FindResultsWindow);
end;

procedure TPyIDEMainForm.actViewHideSecondaryWorkspaceExecute(Sender: TObject);
begin
  SplitWorkspace(False);
end;

procedure TPyIDEMainForm.actViewHideSecondEditorExecute(Sender: TObject);
begin
  var
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.SplitEditorHide;
end;

procedure TPyIDEMainForm.actMessagesWinExecute(Sender: TObject);
begin
  if not MessagesWindow.Visible then
    ShowDockForm(MessagesWindow)
  else
    HideDockForm(MessagesWindow);
end;

procedure TPyIDEMainForm.actCallStackWinExecute(Sender: TObject);
begin
  if not CallStackWindow.Visible then
    ShowDockForm(CallStackWindow)
  else
    HideDockForm(CallStackWindow);
end;

procedure TPyIDEMainForm.actVariablesWinExecute(Sender: TObject);
begin
  if not VariablesWindow.Visible then
    ShowDockForm(VariablesWindow)
  else
    HideDockForm(VariablesWindow);
end;

procedure TPyIDEMainForm.actAddWatchAtCursorExecute(Sender: TObject);
var
  Editor: IEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    TEditorForm(Editor.Form).AddWatchAtCursor;
end;

procedure TPyIDEMainForm.actBreakPointsWinExecute(Sender: TObject);
begin
  if not BreakPointsWindow.Visible then
    ShowDockForm(BreakPointsWindow)
  else
    HideDockForm(BreakPointsWindow);
end;

procedure TPyIDEMainForm.actWatchesWinExecute(Sender: TObject);
begin
  if not WatchesWindow.Visible then
    ShowDockForm(WatchesWindow)
  else
    HideDockForm(WatchesWindow);
end;

function TPyIDEMainForm.GetActiveEditor: IEditor;
{
  Returns the active editor irrespective of whether it is has the focus
  If want the active editor with focus then use GI_ActiveEditor
}
var
  ActivePage: TSpTBXTabSheet;
begin
  // Find Active Page
  ActivePage := ActiveTabControl.ActivePage;
  if not Assigned(ActivePage) then
  begin
    ActivePage := TabControl1.ActivePage;
    if not Assigned(ActivePage) then
      ActivePage := TabControl2.ActivePage;
  end;

  if Assigned(ActivePage) and (ActivePage.ComponentCount > 0) and
    (ActivePage.Components[0] is TEditorForm) then
    Result := TEditorForm(ActivePage.Components[0]).GetEditor
  else
    Result := nil;
end;

function TPyIDEMainForm.GetActiveTextDiff: ISearchCommands;
{
  Returns the active textdiff irrespective of whether it is has the focus
}
var
  ActivePage: TSpTBXTabSheet;
begin
  // Find Active Page
  ActivePage := ActiveTabControl.ActivePage;
  if not Assigned(ActivePage) then
  begin
    ActivePage := TabControl1.ActivePage;
    if not Assigned(ActivePage) then
      ActivePage := TabControl2.ActivePage;
  end;

  if Assigned(ActivePage) and (ActivePage.ComponentCount > 0) and
    (ActivePage.Components[0] is TFTextDiff) then
    Result := TFTextDiff(ActivePage.Components[0]) as ISearchCommands
  else
    Result := nil;
end;

function TPyIDEMainForm.GetActiveFile: IFile;
{
  Returns the active file irrespective of whether it is has the focus
  If want the active editor with focus then use GI_ActiveEditor
}
var
  ActivePage: TSpTBXTabSheet;
begin
  // Find Active Page
  ActivePage := ActiveTabControl.ActivePage;
  if not Assigned(ActivePage) then
  begin
    ActivePage := TabControl1.ActivePage;
    if not Assigned(ActivePage) then
      ActivePage := TabControl2.ActivePage;
  end;

  if Assigned(ActivePage) and (ActivePage.ComponentCount > 0) and
    (ActivePage.Components[0] is TFileForm) then
    Result := TFileForm(ActivePage.Components[0]).GetFile
  else
    Result := nil;
end;

function TPyIDEMainForm.GetActiveTabControl: TSpTBXCustomTabControl;
begin
  if FActiveTabControlIndex = 2 then
    Result := TabControl2
  else
    Result := TabControl1;
end;

function TPyIDEMainForm.GetAppStorage: TJvCustomAppStorage;
begin
  Result := AppStorage;
end;

function TPyIDEMainForm.GetIDELayouts: IIDELayouts;
begin
  Result := Self;
end;

function TPyIDEMainForm.GetIsClosing: Boolean;
begin
  // Use Application.OnHelp to signal exit
  // Application.Help is set to nil as soon as we are about to close
  Result := not Assigned(Application.OnHelp);
end;

function TPyIDEMainForm.GetLocalAppStorage: TJvCustomAppStorage;
begin
  Result := LocalAppStorage;
end;

function TPyIDEMainForm.GetLogger: TJclSimpleLog;
begin
  Result := ResourcesDataModule.Logger;
end;

function TPyIDEMainForm.GetMessageServices: IMessageServices;
begin
  Result := MessagesWindow;
end;

function TPyIDEMainForm.GetStoredScript(const Name: string): TStrings;
begin
  Result := ResourcesDataModule.PythonScripts.StringsByName[Name];
  Result.WriteBOM := False;
end;

function TPyIDEMainForm.GetUnitTestServices: IUnitTestServices;
begin
  Result := UnitTestWindow;
end;

function TPyIDEMainForm.TabControl(TabControlIndex: Integer = 1):
  TSpTBXCustomTabControl;
begin
  if TabControlIndex = 0 then
    Result := ActiveTabControl
  else if TabControlIndex = 2 then
    Result := TabControl2
  else
    Result := TabControl1;
end;

function TPyIDEMainForm.TabControlIndex(TabControl
  : TSpTBXCustomTabControl): Integer;
begin
  if TabControl = TabControl2 then
    Result := 2
  else
    Result := 1;
end;

procedure TPyIDEMainForm.UpdateStatusBarPanels;
var
  PtCaret: TPoint;
  Editor: IEditor;
begin
  Editor := GI_ActiveEditor;
  if Assigned(Editor) then
  begin
    PtCaret := Editor.GetCaretPos;
    if Editor.ActiveSynEdit.Selections.Count > 1 then
      lbStatusCaret.Caption := IntToStr(Editor.ActiveSynEdit.Selections.Count) +
        ' ' + _('carets')
    else if (PtCaret.X > 0) and (PtCaret.Y > 0) then
      lbStatusCaret.Caption := Format('%d:%d', [PtCaret.Y, PtCaret.X])
    else
      lbStatusCaret.Caption := '';
    if GI_ActiveEditor.GetModified then
      lbStatusModified.Caption := _(SModified)
    else
      lbStatusModified.Caption := ' ';
    lbStatusOverwrite.Caption := Editor.GetEditorState;
  end
  else
  begin
    lbStatusCaret.Caption := '';
    lbStatusModified.Caption := '';
    lbStatusOverwrite.Caption := '';
  end;
  if GetCapsLockKeyState then
    lbStatusCaps.Caption := 'CAPS'
  else
    lbStatusCaps.Caption := ' ';

  if GI_PyControl.PythonLoaded then
  begin
    lbPythonVersion.Caption := PyControl.PythonVersion.DisplayName;
    lbPythonEngine.Caption := _(EngineTypeName[PyControl.PythonEngineType]);
  end
  else
  begin
    lbPythonVersion.Caption := _('Python Not Available');
    lbPythonEngine.Caption := ' ';
  end;

  if TPyLspClient.MainLspClient.Ready then
  begin
    spiLspLed.Hint := _('Language Server') + ': ' + _('Ready');
    icIndicators.SVGIconItems[2].FixedColor := $1F5FFF;
  end
  else
  begin
    spiLspLed.Hint := _('Language Server') + ': ' + _('Not available');
    icIndicators.SVGIconItems[2].FixedColor := clGray;
  end;

  spiExternalToolsLED.Visible := OutputWindow.IsRunning;
end;

function TPyIDEMainForm.CmdLineOpenFiles: Boolean;
begin
  Result := False;
  for var I := Low(CmdLineReader.ReadNamelessString)
    to High(CmdLineReader.ReadNamelessString) do
    Result := OpenCmdLineFile(CmdLineReader.ReadNamelessString[I]) or Result;

  // Project Filename
  if CmdLineReader.ReadString('PROJECT') <> '' then
    ProjectExplorerWindow.DoOpenProjectFile
      (CmdLineReader.ReadString('PROJECT'));
end;

procedure TPyIDEMainForm.CreateWnd;
begin
  try
    inherited;
    WTSRegisterSessionNotification(Handle, NOTIFY_FOR_THIS_SESSION);
  except // Error during installation?
  end;
end;

procedure TPyIDEMainForm.OpenInitialFiles;
begin
  TabControl1.Toolbar.BeginUpdate;
  TabControl2.Toolbar.BeginUpdate;
  try
    // Open Files on the command line
    // if there was no file on the command line try restoring open files
    if not CmdLineOpenFiles and PyIDEOptions.RestoreOpenFiles then
      TPersistFileInfo.ReadFromAppStorage(AppStorage, 'Open Files');

    // Recovered files
    GI_EditorFactory.RecoverFiles;

    // If we still have no open file then open an empty file
    if GI_FileFactory.Count = 0 then
      actFileNewModuleExecute(Self);
  finally
    TabControl1.Toolbar.EndUpdate;
    TabControl2.Toolbar.EndUpdate;
    if Assigned(TabControl1.ActiveTab) then
      TabControl1.MakeVisible(TabControl1.ActiveTab);
    if Assigned(TabControl2.ActiveTab) then
      TabControl2.MakeVisible(TabControl2.ActiveTab);
    // if Assigned(GetActiveFile()) then
    // GetActiveFile.Activate;
    UpdateCaption;
  end;
end;

procedure TPyIDEMainForm.FormDestroy(Sender: TObject);
begin
  GI_PyIDEServices := nil;
  SkinManager.RemoveSkinNotification(Self);
  TMessageManager.DefaultManager.Unsubscribe(TIDEOptionsChangedMessage,
    PyIDEOptionsChanged);
  FreeAndNil(FLayouts);
  FreeAndNil(FLanguageList);
  FreeAndNil(FDSAAppStorage);
  FreeAndNil(FShellExtensionFiles);
end;

procedure TPyIDEMainForm.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TPyIDEMainForm.actFileNewSequencediagramExecute(Sender: TObject);
begin
  GI_EditorFactory.OpenFile(GetFilename('.psd'));
end;

procedure TPyIDEMainForm.actFileNewStructogramExecute(Sender: TObject);
begin
  GI_EditorFactory.OpenFile(GetFilename('.psg'));
end;

procedure TPyIDEMainForm.NewTkOrQTFile(FileTemplate: TFileTemplate);
var
  GUIForm: TFGuiForm;
  AEditor: IEditor;
begin
  AEditor := NewFileFromTemplate(FileTemplate,
    TabControlIndex(ActiveTabControl));
  if Assigned(AEditor) then
  begin
    GUIForm := TFGuiForm.Create(nil);
    GUIForm.Open(ChangeFileExt(AEditor.FileName, '.pfm'),
      Point(GuiPyOptions.FrameWidth, GuiPyOptions.FrameHeight),
      TEditorForm(AEditor.Form));
    GUIForm.Caption := 'CAPTION';
    GUIForm.InitEvents;
    FObjectInspector.ELPropertyInspector.SetByCaption('Title', 'CAPTION');
    AEditor.SynEdit.ClearUndo; // because GUIForm.Open changes geometry
  end;
  ShowDockForm(FObjectInspector);
end;

procedure TPyIDEMainForm.actFileNewModuleExecute(Sender: TObject);
begin
  var
  FileTemplate := FileTemplates.TemplateByName(SPythonTemplateName);
  if not Assigned(FileTemplate) then
  begin
    FileTemplates.AddPythonTemplate;
    FileTemplate := FileTemplates.TemplateByName(SPythonTemplateName);
  end;
  NewFileFromTemplate(FileTemplate, TabControlIndex(ActiveTabControl));
end;

procedure TPyIDEMainForm.actFileNewTkinterExecute(Sender: TObject);
begin
  var
  FileTemplate := FileTemplates.TemplateByName(STkinterTemplateName);
  if not Assigned(FileTemplate) then
  begin
    FileTemplates.AddTkinterTemplate;
    FileTemplate := FileTemplates.TemplateByName(STkinterTemplateName);
  end;
  NewTkOrQTFile(FileTemplate);
end;

procedure TPyIDEMainForm.TBQtApplicationClick(Sender: TObject);
begin
  var
  FileTemplate := FileTemplates.TemplateByName(SQtTemplateName);
  if not Assigned(FileTemplate) then
  begin
    FileTemplates.AddTkinterTemplate;
    FileTemplate := FileTemplates.TemplateByName(SQtTemplateName);
  end;
  NewTkOrQTFile(FileTemplate);
end;

procedure TPyIDEMainForm.actFileOpenExecute(Sender: TObject);
var
  AFile: IFile;
begin
  with ResourcesDataModule.dlgFileOpen do
  begin
    Title := _(SOpenFile);
    FileName := '';
    // doesn't support structogram, sequence diagram...
    // Filter := GetHighlightersFilter(CommandsDataModule.Highlighters) + _(SFilterAllFiles);
    Filter := FConfiguration.GetFileFilters;
    AFile := GetActiveFile;
    if Assigned(AFile) and (AFile.FileName <> '') and
      (ExtractFileDir(AFile.FileName) <> '') then
    begin
      InitialDir := ExtractFileDir(AFile.FileName);
      if not DirectoryExists(InitialDir) then
        InitialDir := GuiPyOptions.Sourcepath;
      if not DirectoryExists(InitialDir) then
        InitialDir := GetDocumentsPath;
    end;

    Options := Options + [ofAllowMultiSelect];
    if Execute then
    begin
      GuiPyOptions.Sourcepath := ExtractFilePath(FileName);
      if Assigned(AFile) and (AFile.FileKind = fkTextdiff) then
        if Files.Count >= 2 then
          (AFile.Form as TFTextDiff).Open(Files[0], Files[1])
        else
          (AFile.Form as TFTextDiff).Open(FileName)
        else
          for var I := 0 to Files.Count - 1 do
          begin
            GI_EditorFactory.OpenFile(Files[I], '');
            if (TPath.GetExtension(Files[I]) = '.pyw') then
            begin
              var
              PfmFile := TPath.ChangeExtension(Files[I], '.pfm');
              GI_EditorFactory.OpenFile(PfmFile, '');
            end;
          end;
    end;
    Options := Options - [ofAllowMultiSelect];
  end;
end;

procedure TPyIDEMainForm.actFileCloseAllExecute(Sender: TObject);
begin
  if Assigned(GI_FileFactory) then
  begin
    if GI_FileFactory.CanCloseAll then
    begin
      TabControl1.Toolbar.BeginUpdate;
      TabControl2.Toolbar.BeginUpdate;
      try
        GI_FileFactory.CloseAll;
      finally
        TabControl1.Toolbar.EndUpdate;
        TabControl2.Toolbar.EndUpdate;
        UpdateCaption;
      end;
    end;
  end;
end;

procedure TPyIDEMainForm.PyIDEOptionsChanged(const Sender: TObject; const Msg:
   System.Messaging.TMessage);
begin
  Application.DefaultFont.Size := PyIDEOptions.UIContentFontSize;

  if PyIDEOptions.StyleMainWindowBorder then
    Self.StyleElements := Self.StyleElements + [seBorder]
  else
    Self.StyleElements := Self.StyleElements - [seBorder];

  MaskFPUExceptions(PyIDEOptions.MaskFPUExceptions);

  // Set Python engine
  actPythonInternal.Visible := not PyIDEOptions.InternalInterpreterHidden;
  if not actPythonInternal.Visible and
    (PyIDEOptions.PythonEngineType = peInternal) then
    PyIDEOptions.PythonEngineType := peRemote;

  if PyIDEOptions.ShowTabCloseButton then
  begin
    TabControl1.TabCloseButton := tcbAll;
    TabControl2.TabCloseButton := tcbAll;
  end
  else
  begin
    TabControl1.TabCloseButton := tcbNone;
    TabControl2.TabCloseButton := tcbNone;
  end;

  if TabControl1.TabPosition <> PyIDEOptions.EditorsTabPosition then
  begin
    if PyIDEOptions.EditorsTabPosition = ttpTop then
    begin
      TabControl1.TabPosition := ttpTop;
      TabControl2.TabPosition := ttpTop;
    end
    else // ttpBottom:
    begin
      TabControl1.TabPosition := ttpBottom;
      TabControl2.TabPosition := ttpBottom;
    end;
  end;

  if not PyIDEOptions.AutoRestart then
    UnregisterApplicationRestart;

  tbiRecentFileList.MaxItems := PyIDEOptions.NoOfRecentFiles;

  var
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.SynEdit.InvalidateGutter;
end;

procedure TPyIDEMainForm.StoreApplicationData;
begin
  var
  TempCursor := WaitCursor;
  var
  TempStringList := TSmartPtr.Make(TStringList.Create)();

  AppStorage.BeginUpdate;
  try
    AppStorage.StorageOptions.SetAsString := True;
    AppStorage.StorageOptions.StoreDefaultValues := True;
    AppStorage.WritePersistent('IDE Options', PyIDEOptions);
    AppStorage.StorageOptions.StoreDefaultValues := False;

    AppStorage.WriteString('GuiPy Version', ApplicationVersion);
    AppStorage.WriteString('Language', GetCurrentLanguage);

    TempStringList.AddStrings(['TrackChanges', 'SelectedColor', 'IndentGuides',
      'DisplayFlowControl', 'BookmarkOptions']);
    AppStorage.DeleteSubTree('Editor Options');
    AppStorage.WritePersistent('Editor Options', GEditorOptions, True,
      TempStringList);
    AppStorage.WritePersistent('Editor Search Options', EditorSearchOptions);

    // GuiPyOptions
    AppStorage.DeleteSubTree('GuiPy Options');
    GuiPyOptions.RemovePortableDrives;
    AppStorage.WritePersistent('GuiPy Options', GuiPyOptions);
    GuiPyOptions.AddPortableDrives;
    AppStorage.WritePersistent('GuiPy Language Options\' + GetCurrentLanguage,
      GuiPyLanguageOptions);

    AppStorage.DeleteSubTree('Highlighters');
    // Store dock form settings
    for var I := 0 to Screen.FormCount - 1 do
      if Screen.Forms[I] is TIDEDockWindow then
        TIDEDockWindow(Screen.Forms[I]).StoreSettings(AppStorage);

    // Store Highlighters
    for var Highlighter in ResourcesDataModule.Highlighters do
      if ResourcesDataModule.IsHighlighterStored(Highlighter) then
        AppStorage.WritePersistent('Highlighters\' +
          Highlighter.FriendlyLanguageName, Highlighter);

    with CommandsDataModule do
    begin
      TempStringList.Clear;
      TempStringList.AddStrings(['Lines', 'Highlighter']);
      AppStorage.DeleteSubTree('Print Options');
      AppStorage.WritePersistent('Print Options', SynEditPrint, True,
        TempStringList);
      AppStorage.WriteString('Print Options\HeaderItems',
        SynEditPrint.Header.AsString);
      AppStorage.WriteString('Print Options\FooterItems',
        SynEditPrint.Footer.AsString);
    end;

    // File and Code Templates - Preserve leading-trailing whitespace
    AppStorage.StorageOptions.PreserveLeadingTrailingBlanks := True;
    AppStorage.DeleteSubTree('File Templates');
    AppStorage.WriteObjectList('File Templates', FileTemplates);

    AppStorage.DeleteSubTree('Code Templates');
    AppStorage.WriteStringList('Code Templates',
      ResourcesDataModule.CodeTemplatesCompletion.AutoCompleteList);
    AppStorage.StorageOptions.PreserveLeadingTrailingBlanks := False;

    AppStorage.WritePersistent('Class Editor Options', FClassEditor);
    AppStorage.WritePersistent('Object Generator Options', FObjectGenerator);
    AppStorage.WritePersistent('Object Inspector Options', FObjectInspector);
    AppStorage.WritePersistent('UMLInteractive Options', FUMLInteractive);

    AppStorage.WriteStringList('Custom Params', CustomParams);
    AppStorage.DeleteSubTree('Tools');
    AppStorage.WriteCollection('Tools', ToolsCollection, 'Tool');
    AppStorage.DeleteSubTree('SSH');
    AppStorage.StorageOptions.StoreDefaultValues := True;
    AppStorage.WriteCollection('SSH', SSHServers, 'Server');
    AppStorage.StorageOptions.StoreDefaultValues := False;
    AppStorage.WritePersistent('Tools\External Run', ExternalPython);
    AppStorage.WriteBoolean('Status Bar', StatusBar.Visible);

    // Save Style Name
    AppStorage.WriteString('Style Name', TFConfiguration.CurrentSkinName);

    // Save Toolbar Items
    SaveToolbarItems('Toolbar Items');

    // Needed since save toolbar Items below does not save secondary shortcuts! Issue 307
    // Save IDE Shortcuts
    AppStorage.DeleteSubTree('IDE Shortcuts');
    var
    ActionProxyCollection := TActionProxyCollection.Create(apcctChanged);
    try
      AppStorage.WriteCollection('IDE Shortcuts', ActionProxyCollection,
        'Action');
    finally
      ActionProxyCollection.Free;
    end;

    // Project Filename
    AppStorage.WriteString('Active Project', ActiveProject.FileName);
  finally
    AppStorage.EndUpdate;
  end;

  if FileExists(MachineStorage.FileName) and IsAdministrator then
  begin
    MachineStorage.WriteBoolean('Restricted\LockedDOSWindow',
      GuiPyOptions.LockedDOSWindow);
    MachineStorage.WriteBoolean('Restricted\LockedInternet',
      GuiPyOptions.LockedInternet);
    MachineStorage.WriteBoolean('Restricted\LockedPaths',
      GuiPyOptions.LockedPaths);
    MachineStorage.WriteBoolean('Restricted\LockedStructogram',
      GuiPyOptions.LockedStructogram);
    MachineStorage.WriteBoolean('Restricted\UsePredefinedLayouts',
      GuiPyOptions.UsePredefinedLayouts);
  end;

  // Save MRU Lists
  tbiRecentFileList.SaveToIni(AppStorage.IniFile, 'MRU File List');
  tbiRecentProjects.SaveToIni(AppStorage.IniFile, 'MRU Project List');

  AppStorage.Flush;
end;

procedure TPyIDEMainForm.StoreLocalApplicationData;
begin
  LocalAppStorage.BeginUpdate;
  try
    LocalAppStorage.WriteString('GuiPy Version', ApplicationVersion);
    LocalAppStorage.WriteString('Monitor profile', MonitorProfile);

    LocalAppStorage.WriteStringList('Layouts', FLayouts);

    // Store Python Versions
    PyControl.WriteToAppStorage(LocalAppStorage);
  finally
    LocalAppStorage.EndUpdate;
  end;
  LocalAppStorage.Flush;
end;

function TPyIDEMainForm.ReplaceParams(const AText: string): string;
begin
  Result := Parameters.ReplaceInText(AText);
end;

procedure TPyIDEMainForm.RestoreApplicationData;
const
  DefaultHeader = '$TITLE$\.1\.0\.-13\.Arial\.0\.96\.10\.0\.1\.2';
  DefaultFooter =
    '$PAGENUM$\\.$PAGECOUNT$\.1\.0\.-13\.Arial\.0\.96\.10\.0\.1\.2';
begin
  // user specific options can be overwritten by admin controlled options from GuiPyMachine.ini

  // since 5.11
  RemoveDefunctEditorOptions;
  AppStorage.Reload;

  // Remove since it is now stored in PyScripter.local.ini
  if AppStorage.PathExists('Layouts') then
    AppStorage.DeleteSubTree('Layouts');
  // since version 6.07
  if AppStorage.PathExists('File Structure Options') then
    AppStorage.DeleteSubTree('File Structure Options');

  AppStorage.StorageOptions.SetAsString := True;

  var
  CurLang := AppStorage.ReadString('Language', GetCurrentLanguage);
  MachineStorage.DefaultSection := 'Other Settings';
  CurLang := MachineStorage.ReadString('Language', CurLang);
  ChangeLanguage(CurLang);

  if AppStorage.PathExists('IDE Options') then
    AppStorage.ReadPersistent('IDE Options', PyIDEOptions);
  if MachineStorage.PathExists('IDE Options') then
    MachineStorage.ReadPersistent('IDE Options', PyIDEOptions);
  if AppStorage.PathExists('IDE Options') or
    MachineStorage.PathExists('IDE Options') then
    PyIDEOptions.Changed;

  if AppStorage.PathExists('GuiPy Options') then
  begin
    AppStorage.ReadPersistent('GuiPy Options', GuiPyOptions);
    GuiPyOptions.AddPortableDrives;
    GuiPyLanguageOptions.GetInLanguage(CurLang);
    AppStorage.ReadPersistent('GuiPy Language Options\' + CurLang,
      GuiPyLanguageOptions);
  end;
  if MachineStorage.PathExists('GuiPy Options') then
  begin
    MachineStorage.ReadPersistent('GuiPy Options', GuiPyOptions);
    GuiPyOptions.AddPortableDrives;
    MachineStorage.ReadPersistent('GuiPy Language Options\' + CurLang,
      GuiPyLanguageOptions);
  end;

  var
  TempStringList := TSmartPtr.Make(TStringList.Create)();
  TempStringList.AddStrings(['TrackChanges', 'SelectedColor', 'IndentGuides',
    'DisplayFlowControl']);
  if AppStorage.PathExists('Editor Options') then
    AppStorage.ReadPersistent('Editor Options', GEditorOptions, True, True,
      TempStringList);
  if MachineStorage.PathExists('Editor Options') then
    MachineStorage.ReadPersistent('Editor Options', GEditorOptions, True, True,
      TempStringList);
  if AppStorage.PathExists('Editor Options') or
    MachineStorage.PathExists('Editor Options') then
    GEditorOptions.Options := GEditorOptions.Options + [eoBracketsHighlight,
      eoCopyPlainText];

  if AppStorage.PathExists('Editor Search Options') then
    AppStorage.ReadPersistent('Editor Search Options', EditorSearchOptions);
  if MachineStorage.PathExists('Editor Search Options') then
    MachineStorage.ReadPersistent('Editor Search Options', EditorSearchOptions);
  if AppStorage.PathExists('Editor Search Options') or
    MachineStorage.PathExists('Editor Search Options') then
  begin
    tbiSearchText.Items.CommaText := EditorSearchOptions.SearchTextHistory;
    tbiReplaceText.Items.CommaText := EditorSearchOptions.ReplaceTextHistory;
  end;

  // Restore dock form settings
  for var I := 0 to Screen.FormCount - 1 do
    if Screen.Forms[I] is TIDEDockWindow then
    begin
      TIDEDockWindow(Screen.Forms[I]).RestoreSettings(AppStorage);
      TIDEDockWindow(Screen.Forms[I]).RestoreSettings(MachineStorage);
    end;

  // Restore highlighters
  for var Highlighter in ResourcesDataModule.Highlighters do
  begin
    Highlighter.BeginUpdate;
    try
      AppStorage.ReadPersistent('Highlighters\' +
        Highlighter.FriendlyLanguageName, Highlighter);
      if MachineStorage.PathExists('Highlighters\' +
        Highlighter.FriendlyLanguageName) then
        MachineStorage.ReadPersistent('Highlighters\' +
          Highlighter.FriendlyLanguageName, Highlighter);
    finally
      Highlighter.EndUpdate;
    end;
  end;
  CommandsDataModule.ApplyEditorOptions;

  AppStorage.DeleteSubTree('Highlighters');

  with CommandsDataModule do
  begin
    AppStorage.ReadPersistent('Print Options', SynEditPrint);
    if MachineStorage.PathExists('Print Options') then
      MachineStorage.ReadPersistent('Print Options', SynEditPrint);
    SynEditPrint.Header.AsString := AppStorage.ReadString
      ('Print Options\HeaderItems', DefaultHeader);
    SynEditPrint.Footer.AsString := AppStorage.ReadString
      ('Print Options\FooterItems', DefaultFooter);
    if MachineStorage.ValueStored('Print Options\HeaderItems') then
      SynEditPrint.Header.AsString := MachineStorage.ReadString
        ('Print Options\HeaderItems', DefaultHeader);
    if MachineStorage.ValueStored('Print Options\FooterItems') then
      SynEditPrint.Footer.AsString := MachineStorage.ReadString
        ('Print Options\FooterItems', DefaultHeader);
  end;

  // File and Code Templates - Preserve leading-trailing whitespace
  AppStorage.StorageOptions.PreserveLeadingTrailingBlanks := True;
  if MachineStorage.PathExists('File Templates') then
    MachineStorage.ReadObjectList('File Templates', FileTemplates,
      FileTemplates.CreateListItem);
  if AppStorage.PathExists('File Templates') then
    AppStorage.ReadObjectList('File Templates', FileTemplates,
      FileTemplates.CreateListItem);
  FileTemplates.AddDefaultTemplates;

  var
  StringList := TStringList.Create;
  if MachineStorage.PathExists('Code Templates') then
    MachineStorage.ReadStringList('Code Templates', StringList)
  else if AppStorage.PathExists('Code Templates') then
    AppStorage.ReadStringList('Code Templates', StringList);
  if StringList.Text <> '' then
    ResourcesDataModule.CodeTemplatesCompletion.AutoCompleteList.Assign
      (StringList);
  FreeAndNil(StringList);
  AppStorage.StorageOptions.PreserveLeadingTrailingBlanks := False;

  AppStorage.ReadStringList('Custom Params', CustomParams);
  if MachineStorage.PathExists('Custom Params') then
    MachineStorage.ReadPersistent('Custom Params', CustomParams);
  RegisterCustomParams;

  if MachineStorage.PathExists('Tools') then
    MachineStorage.ReadCollection('Tools', ToolsCollection, True, 'Tool')
  else
    AppStorage.ReadCollection('Tools', ToolsCollection, True, 'Tool');

  if MachineStorage.PathExists('SSH') then
    MachineStorage.ReadCollection('SSH', SSHServers, True, 'Server')
  else
    AppStorage.ReadCollection('SSH', SSHServers, True, 'Server');

  AppStorage.ReadPersistent('Tools\External Run', ExternalPython);
  if MachineStorage.PathExists('Tools\External Run') then
    MachineStorage.ReadPersistent('Tools\External Run', ExternalPython);

  StatusBar.Visible := AppStorage.ReadBoolean('Status Bar');
  if MachineStorage.ValueStored('Status Bar') then
    StatusBar.Visible := MachineStorage.ReadBoolean('Status Bar');

  // GuiPy
  AppStorage.ReadPersistent('Class Editor Options', FClassEditor);
  if MachineStorage.PathExists('Class Editor Options') then
    MachineStorage.ReadPersistent('Class Editor Options', FClassEditor);

  AppStorage.ReadPersistent('Object Generator Options', FObjectGenerator);
  if MachineStorage.PathExists('Object Generator Options') then
    MachineStorage.ReadPersistent('Object Generator Options', FObjectGenerator);

  AppStorage.ReadPersistent('Object Inspector Options', FObjectInspector);
  if MachineStorage.PathExists('Object Inspector Options') then
    MachineStorage.ReadPersistent('Object Inspector Options', FObjectInspector);

  AppStorage.ReadPersistent('UMLInteractive Options', FUMLInteractive);
  if MachineStorage.PathExists('UMLInteractive Options') then
    MachineStorage.ReadPersistent('UMLInteractive Options', FUMLInteractive);
  // end of GuiPy

  // Load Style Name
  var
  Stylename := AppStorage.ReadString('Style Name', 'Windows11 MineShaft');
  if MachineStorage.ValueStored('Style Name') then
    Stylename := MachineStorage.ReadString('Style Name', 'Windows11 MineShaft');
  FConfiguration.SetStyle(Stylename);

  // Load IDE Shortcuts
  var
  ActionProxyCollection := TActionProxyCollection.Create(apcctEmpty);
  try
    if MachineStorage.PathExists('IDE Shorcuts') then
      MachineStorage.ReadCollection('IDE Shortcuts', ActionProxyCollection,
        True, 'Action')
    else
      AppStorage.ReadCollection('IDE Shortcuts', ActionProxyCollection, True,
        'Action');
    ActionProxyCollection.ApplyShortCuts;
  finally
    ActionProxyCollection.Free;
  end;

  // Project Filename
  if (CmdLineReader.ReadString('PROJECT') = '') and PyIDEOptions.RestoreOpenProject
  then
  begin
    var
    FName := AppStorage.ReadString('Active Project');
    if FName <> '' then
      ProjectExplorerWindow.DoOpenProjectFile(FName);
  end;

  if MachineStorage.PathExists('Restricted') then
  begin
    GuiPyOptions.LockedDOSWindow := MachineStorage.ReadBoolean
      ('Restricted\LockedDOSWindow', False);
    GuiPyOptions.LockedInternet := MachineStorage.ReadBoolean
      ('Restricted\LockedInternet', False);
    GuiPyOptions.LockedPaths := MachineStorage.ReadBoolean
      ('Restricted\LockedPaths', False);
    GuiPyOptions.LockedStructogram := MachineStorage.ReadBoolean
      ('Restricted\LockedStructogram', False);
    GuiPyOptions.UsePredefinedLayouts := MachineStorage.ReadBoolean
      ('Restricted\UsePredefinedLayouts', False);
  end;

  // Load MRU Lists
  var
  Filenames := TStringList.Create;
  tbiRecentFileList.LoadFromIni(AppStorage.IniFile, 'MRU File List');
  tbiRecentFileList.GetMRUFilenames(Filenames);
  for var I := 0 to Filenames.Count - 1 do
    if not FileExists(Filenames[I]) then
      tbiRecentFileList.MRURemove(Filenames[I]);
  tbiRecentProjects.LoadFromIni(AppStorage.IniFile, 'MRU Project List');
  tbiRecentProjects.GetMRUFilenames(Filenames);
  for var I := 0 to Filenames.Count - 1 do
    if not FileExists(Filenames[I]) then
      tbiRecentProjects.MRURemove(Filenames[I]);
  FreeAndNil(Filenames);
end;

procedure TPyIDEMainForm.RestoreLocalApplicationData;
begin
  FOldMonitorProfile := LocalAppStorage.ReadString('Monitor profile');

  LocalAppStorage.ReadStringList('Layouts', FLayouts, True);
  if FOldMonitorProfile <> MonitorProfile then
  begin
    LocalAppStorage.DeleteSubTree('Layouts\Default');
    if FLayouts.IndexOf('Default') >= 0 then
      FLayouts.Delete(FLayouts.IndexOf('Default'));
    LocalAppStorage.DeleteSubTree('Layouts\Current');
  end;
end;

function TPyIDEMainForm.FileFromTab(Tab: TSpTBXTabItem): IFile;
var
  Sheet: TSpTBXTabSheet;
begin
  Result := nil;
  if Assigned(Tab) then
  begin
    Sheet := (Tab.Owner as TSpTBXTabControl).GetPage(Tab);
    if Assigned(Sheet) and (Sheet.ControlCount > 0) then
      Result := (Sheet.Controls[0] as TFileForm).GetFile;
  end;
end;

procedure TPyIDEMainForm.TabControlActiveTabChange(Sender: TObject;
TabIndex: Integer);
var
  Index: Integer;
  TabCtrl: TSpTBXTabControl;
begin
  LockWindow(Handle);
  EditorSearchOptions.InitSearch;
  UpdateCaption;
  TabCtrl := Sender as TSpTBXTabControl;
  if Assigned(TabCtrl.ActivePage) and not(csDestroying in ComponentState) then
    // FZOrder
    with TabCtrl do
      if not FZOrderProcessing then
      begin
        Index := FZOrder.IndexOf(TabCtrl.ActivePage.Item);
        if Index < 0 then
          FZOrder.Insert(0, TabCtrl.ActivePage.Item)
        else
          FZOrder.Move(Index, 0);
        FZOrderPos := 0;
      end;
  var
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) then
  begin
    if AFile.FileKind = fkUML then
      TFUMLForm(AFile.Form).Enter(Self)
    else if AFile.FileKind = fkEditor then
      TEditorForm(AFile.Form).Enter(Self);
  end;
  UnLockWindow;
end;

procedure TPyIDEMainForm.TabControlMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AFile: IFile;
  ItemViewer: TTBItemViewer;
  TabItem: TSpTBXTabItem;
begin
  TabItem := nil;
  ItemViewer := (Sender as TSpTBXTabToolbar).View.ViewerFromPoint(Point(X, Y));
  if Assigned(ItemViewer) and (ItemViewer.Item is TSpTBXTabItem) then
    TabItem := TSpTBXTabItem(ItemViewer.Item);

  if Assigned(TabItem) and (Button = mbMiddle) then
  begin
    if Assigned(AFile) then
      (AFile as IFileCommands).ExecClose;
  end
  else if (not Assigned(ItemViewer) or
    (ItemViewer.Item is TSpTBXRightAlignSpacerItem)) and
    (Shift = [ssLeft, ssDouble]) then
  begin
    if LocalAppStorage.PathExists('Layouts\BeforeZoom\Forms') then
      actRestoreEditorExecute(Sender)
    else
      actMaximizeEditorExecute(Sender);
  end;
end;

procedure TPyIDEMainForm.TabControlTabClosing(Sender: TObject;
var Allow, CloseAndFree: Boolean);
begin
  Allow := False;
  TThread.ForceQueue(nil,
    procedure
    begin
      var
      AFile := FileFromTab(Sender as TSpTBXTabItem);
      if Assigned(AFile) then
        (AFile as IFileCommands).ExecClose;
    end);
end;

procedure TPyIDEMainForm.TabToolbarlDragDrop(Sender, Source: TObject;
X, Y: Integer);
var
  Tab: TSpTBXTabItem;
  TargetTabControl: TSpTBXTabControl;
  ItemViewer: TTBItemViewer;
  Index: Integer;
begin
  if (Source is TSpTBXTabItemDragObject) and
    (TSpTBXTabItemDragObject(Source).SouceItem is TSpTBXTabItem) and
    (Sender is TSpTBXTabToolbar) and
    (TSpTBXTabItemDragObject(Source).SourceControl <> Sender) then
  begin
    Tab := TSpTBXTabItemDragObject(Source).SouceItem as TSpTBXTabItem;
    TargetTabControl := TSpTBXTabToolbar(Sender).Owner as TSpTBXTabControl;
    ItemViewer := TSpTBXTabToolbar(Sender).View.ViewerFromPoint(Point(X, Y));
    if Assigned(ItemViewer) and (ItemViewer is TSpTBXTabItemViewer) then
      Index := TargetTabControl.Toolbar.Items.IndexOf
        (TSpTBXTabItemViewer(ItemViewer).Item)
    else
      Index := -1;
    MoveTab(Tab, TargetTabControl, Index);
  end;
end;

procedure TPyIDEMainForm.TabToolbarDragOver(Sender, Source: TObject;
X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (Source is TSpTBXTabItemDragObject) then
  begin
    if TSpTBXTabItemDragObject(Source).DragCursorAccept <> crDrag then
    begin
      TSpTBXTabItemDragObject(Source).DragCursorAccept := crDrag;
      TSpTBXTabItemDragObject(Source).DragCursorCancel := crNo;
    end;
    Accept := True;
  end;
end;

procedure TPyIDEMainForm.UpdateStandardActions;
var
  Left, Right: Boolean;
begin
  actBreakPointsWin.Checked := BreakPointsWindow.Visible;
  actCallStackWin.Checked := CallStackWindow.Visible;
  actMessagesWin.Checked := MessagesWindow.Visible;
  actVariablesWin.Checked := VariablesWindow.Visible;
  actViewCodeExplorer.Checked := CodeExplorerWindow.Visible;
  actViewFileExplorer.Checked := FileExplorerWindow.Visible;
  actViewToDoList.Checked := ToDoWindow.Visible;
  actViewRegExpTester.Checked := RegExpTesterWindow.Visible;
  actViewUnitTests.Checked := UnitTestWindow.Visible;
  actViewOutput.Checked := OutputWindow.Visible;
  actViewFindResults.Checked := FindResultsWindow.Visible;
  actViewII.Checked := PythonIIForm.Visible;
  actViewProjectExplorer.Checked := ProjectExplorerWindow.Visible;
  actViewSplitEditorHor.Enabled := Assigned(GI_ActiveEditor);
  actViewSplitEditorVer.Enabled := Assigned(GI_ActiveEditor);
  actViewHideSecondEditor.Enabled := Assigned(GI_ActiveEditor) and
    Assigned(GI_ActiveEditor.SynEdit2) and GI_ActiveEditor.SynEdit2.Visible;
  actViewHideSecondaryWorkspace.Enabled := TabControl2.Visible;

  actWatchesWin.Checked := WatchesWindow.Visible;

  actViewStatusBar.Checked := StatusBar.Visible;
  actViewMainMenu.Checked := MainMenu.Visible;

  actFileNewModule.Enabled := Assigned(GI_EditorFactory);
  actFileOpen.Enabled := Assigned(GI_FileFactory);
  actFileCloseAll.Enabled := Assigned(GI_FileFactory) and
    (GI_FileFactory.GetFileCount > 0);

  var
  AFile := GI_PyIDEServices.GetActiveFile;
  Right := Assigned(AFile) and (AFile.FileKind = fkUML);
  actUMLEditClass.Enabled := Right or Assigned(AFile) and
    (AFile.FileKind = fkEditor);
  actUMLNewComment.Enabled := Right;
  actUMLNewLayout.Enabled := Right;
  actUMLRefresh.Enabled := Right;
  actUMLRecognizeAssociations.Enabled := Right;
  actUMLSaveAsPicture.Enabled := Right;

  actUMLDiagramFromOpenFiles.Enabled := Assigned(GI_EditorFactory) and
    (GI_EditorFactory.GetEditorCount > 0);

  actCommandLine.Checked := PyIDEOptions.UseCommandLine and
    (PyIDEOptions.CommandLine <> '');

  // Refactoring
  actFindDefinition.Enabled := Assigned(GI_ActiveEditor) and
    GI_ActiveEditor.HasPythonFile;
  actFindReferences.Enabled := actFindDefinition.Enabled;
  actBrowseBack.Enabled := mnPreviousList.Count > 0;
  actBrowseForward.Enabled := mnNextList.Count > 0;

  // Python Engines
  case PyIDEOptions.PythonEngineType of
    peInternal:
      actPythonInternal.Checked := True;
    peRemote:
      actPythonRemote.Checked := True;
    peRemoteTk:
      actPythonRemoteTk.Checked := True;
    peRemoteWx:
      actPythonRemoteWx.Checked := True;
    peSSH:
      actPythonSSH.Checked := True;
  end;

  actPythonFreeThreaded.Enabled := GI_PyControl.PythonLoaded and
    (PyIDEOptions.PythonEngineType = peRemote) and
    (PyControl.PythonVersion.PythonFreeThreadedExecutable <> '');
  actPythonFreeThreaded.Checked := PyIDEOptions.PreferFreeThreaded;

  // Scroll Buttons
  TabControl1.ScrollState(Left, Right);
  tbiScrollLeft.Enabled := Left;
  tbiScrollRight.Enabled := Right;
  TabControl2.ScrollState(Left, Right);
  tbiScrollLeft2.Enabled := Left;
  tbiScrollRight2.Enabled := Right;
end;

procedure TPyIDEMainForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  Handled := CommandsDataModule.actlMain.IsShortCut(Msg);
  if not Handled and FGUIDesigner.ELDesigner.Active then
    Handled:= FGUIDesigner.ActionList.IsShortCut(Msg);
end;

procedure TPyIDEMainForm.ChangeLanguage(const LangCode: string);
begin
  if CompareText(GetCurrentLanguage, LangCode) <> 0 then
  begin
    UseLanguage(LangCode);
    RetranslateComponent(Self);
    RetranslateComponent(CommandsDataModule);
    RegisterCustomParams; // To get translations of descriptions
    SetupLanguageMenu;
    GI_EditorFactory.SetupEditorViewsMenu(EditorViewsMenu, vilImages);
    GI_FileFactory.ApplyToFiles(
      procedure(AFile: IFile)
      begin
        AFile.Retranslate;
      end);
    // after some of these retranslations some icons in the main menu
    // changed to ImageIndex = 0
    // after renaming the icons with appendix 13 this error was fixed
    RetranslateComponent(FConfiguration);
    FConfiguration.Retranslate;
    RetranslateComponent(FGUIDesigner);
    RetranslateComponent(FUMLInteractive);
    RetranslateComponent(FClassEditor);
    RetranslateComponent(FFileStructure);
    RetranslateComponent(FObjectInspector);
    RetranslateComponent(FObjectGenerator);
    if FConfiguration.GitOK and Assigned(FGit) then
      RetranslateComponent(FGit);
    if FConfiguration.SubversionOK and Assigned(FSubversion) then
      RetranslateComponent(FSubversion);
  end;
end;

function TPyIDEMainForm.GetLanguageCode(Index: Integer): string;
begin
  Result := FLanguageList[Index];
end;

procedure TPyIDEMainForm.LoadToolbarItems(const Path: string);
{ We only want to load the Toolbar items and not the shortcuts
  which are stored separately. The reason is that
  ToolbarLayout contains text representations of the shortcuts
  which are not reliable, since they depend on the keyboard language
  layout at the time of saving. }
begin
  if AppStorage.PathExists(Path) then
  begin
    var
    MemIni := TSmartPtr.Make(TMemIniFile.Create(''))();
    var
    StringList := TSmartPtr.Make(TStringList.Create)();

    // We save the shortcuts
    var
    ActionProxyCollection :=
      TSmartPtr.Make(TActionProxyCollection.Create(apcctAll));
    AppStorage.ReadStringList(Path, StringList);
    MemIni.SetStrings(StringList);
    SpLoadItems(Self, MemIni);
    // and then restore them
    ActionProxyCollection.ApplyShortCuts;
  end;
end;

procedure TPyIDEMainForm.SaveToolbarItems(const Path: string);
begin
  AppStorage.DeleteSubTree(Path);
  var
  MemIni := TSmartPtr.Make(TMemIniFile.Create(''))();
  var
  StringList := TSmartPtr.Make(TStringList.Create)();
  SpSaveItems(Self, MemIni);
  MemIni.GetStrings(StringList);
  AppStorage.WriteStringList(Path, StringList);
end;

procedure TPyIDEMainForm.SaveToolbarLayout(const Layout: string);
begin
  var
  ToolbarLayout := TSmartPtr.Make(TStringList.Create)();
  SpTBXCustomizer.SaveLayout(ToolbarLayout, Layout);
  LocalAppStorage.WriteStringList('Layouts\' + Layout + '\Toolbars',
    ToolbarLayout);
end;

procedure TPyIDEMainForm.LoadToolbarLayout(const Layout: string);
begin
  var
  Path := 'Layouts\' + Layout;
  if LocalAppStorage.PathExists(Path + '\Toolbars') then
  begin
    var
    ToolbarLayout := TSmartPtr.Make(TStringList.Create)();
    LocalAppStorage.ReadStringList(Path + '\Toolbars', ToolbarLayout);
    SpTBXCustomizer.LoadLayout(ToolbarLayout, Layout);
  end;
end;

procedure TPyIDEMainForm.SetupToolsMenu;
var
  I: Integer;
  MenuItem: TSpTBXItem;
  Action: TAction;
  Tool: TExternalTool;
begin
  if ToolsMenu.IndexOf(mnConfigureTools) > 0 then // first run
    ToolsMenu.Remove(mnConfigureTools)
  else
  begin
    mnTools.Remove(mnConfigureTools);
    ToolsMenu.Delete(12); // Python Interpreter
    ToolsMenu.Delete(11); // Command Prompt
  end;
  // delete actions and menus added in previous calls
  mnTools.Clear;
  for I := actlStandard.ActionCount - 1 downto 0 do
    if actlStandard[I].Category = 'External Tools' then
      actlStandard[I].Free;
  for I := 0 to ToolsCollection.Count - 1 do
  begin
    Tool := (ToolsCollection.Items[I] as TToolItem).ExternalTool;
    if Tool.Caption <> '' then
    begin
      MenuItem := TSpTBXItem.Create(Self);
      Action := TExternalToolAction.CreateExtToolAction(Self, Tool);
      Action.ActionList := actlStandard;
      if ((Tool.ApplicationName = '$[PythonExe]') or
        (Tool.ApplicationName = '$[PythonExe-Short]')) and
        (Tool.Parameters = '') or (Tool.ApplicationName = '%COMSPEC%') and
        not GuiPyOptions.LockedDOSWindow then
        ToolsMenu.Insert(11, MenuItem)
      else
        mnTools.Add(MenuItem);
      MenuItem.Action := Action;
      MenuItem.Images := FShellImages;
    end;
  end;

  mnTools.Add(TSpTBXSeparatorItem.Create(Self));
  mnTools.Add(mnConfigureTools);
end;

procedure TPyIDEMainForm.SetupLanguageMenu;
var
  MenuItem: TSpTBXItem;
  I: Integer;
  CurrentLanguage, English: string;
  HaveLang: Boolean;
begin
  mnLanguage.Clear;
  FConfiguration.RGLanguages.Items.Clear;
  CurrentLanguage := GetCurrentLanguage;
  DefaultInstance.bindtextdomainToFile('languagecodes',
    ExtractFilePath(Application.ExeName) + 'locale\languagecodes.mo');
  DefaultInstance.GetListOfLanguages('default', FLanguageList);
  FLanguageList.Insert(0, 'en');
  HaveLang := False;
  for I := 0 to FLanguageList.Count - 1 do
  begin
    MenuItem := TSpTBXItem.Create(Self);
    // Translate the language code to English language name and then to a localized language name
    English := dgettext('languagecodes', FLanguageList[I]);
    MenuItem.Caption := dgettext('languages', English);
    if (I = 0) and (Pos('Englis', MenuItem.Caption) = 0) then
      MenuItem.Caption := MenuItem.Caption + ' (English)';
    FConfiguration.RGLanguages.Items.Add(MenuItem.Caption);
    MenuItem.Tag := I;
    if FLanguageList[I] = CurrentLanguage then
    begin
      MenuItem.Checked := True;
      HaveLang := True;
      FConfiguration.RGLanguages.ItemIndex := I;
    end;
    MenuItem.OnClick := mnLanguageClick;
    MenuItem.HelpContext := 360;
    mnLanguage.Add(MenuItem);
  end;
  if not HaveLang then
  begin
    mnLanguage[0].Checked := True;
    FConfiguration.RGLanguages.ItemIndex := 0;
  end;
end;

procedure TPyIDEMainForm.SetupLayoutsMenu;
var
  I: Integer;
  MenuItem: TSpTBXItem;
begin
  // delete previous FLayouts
  while mnLayouts[0] <> mnLayOutSeparator do
    mnLayouts[0].Free;

  for I := FLayouts.Count - 1 downto 0 do
  begin
    MenuItem := TSpTBXItem.Create(Self);
    mnLayouts.Insert(0, MenuItem);
    MenuItem.Caption := FLayouts[I];
    MenuItem.GroupIndex := 2;
    MenuItem.OnClick := LayoutClick;
    MenuItem.Hint := Format(_(SApplyLayout), [FLayouts[I]]);
  end;
end;

procedure TPyIDEMainForm.mnSyntaxPopup(Sender: TTBCustomItem;
FromLink: Boolean);
var
  I: Integer;
  Editor: IEditor;
begin
  Editor := GetActiveEditor;
  for I := 0 to mnSyntax.Count - 3 do
  begin
    mnSyntax[I].Enabled := Assigned(Editor);
    mnSyntax[I].Checked := Assigned(Editor) and
      Assigned(Editor.SynEdit.Highlighter) and
      (Editor.SynEdit.Highlighter.FriendlyLanguageName = mnSyntax[I].Caption);
  end;
  mnNoSyntax.Enabled := Assigned(Editor);
  mnNoSyntax.Checked := Assigned(Editor) and
    not Assigned(Editor.SynEdit.Highlighter);
end;

procedure TPyIDEMainForm.mnToolsBrowserClick(Sender: TObject);
begin
  NewBrowser('about:blank');
end;

procedure TPyIDEMainForm.mnToolsGitClick(Sender: TObject);
begin
  FGit.Execute(TSpTBXItem(Sender).Tag, GetActiveEditor);
end;

procedure TPyIDEMainForm.mnToolsSVNClick(Sender: TObject);
begin
  FSubversion.Execute(TSpTBXItem(Sender).Tag, GetActiveEditor);
end;

procedure TPyIDEMainForm.LoadLayout(const Layout: string);
var
  Path, CheckLayout: string;
  I: Integer;
  SaveActiveControl: TWinControl;
  TempCursor: IInterface;
begin
  if GuiPyOptions.UsePredefinedLayouts then
  begin
    if Layout = 'Default' then
    begin
      LoadPredefinedDefaultLayout;
      Exit;
    end
    else if Layout = 'Debug' then
    begin
      LoadPredefinedDebugLayout;
      Exit;
    end
    else if Layout = 'Current' then
      mnViewDefaultLayout.Checked := True;
  end;

  Path := 'Layouts\' + Layout;
  if LocalAppStorage.PathExists(Path + '\Forms') then
  begin
    TempCursor := WaitCursor;
    SaveActiveControl := ActiveControl;
    try
      LoadDockTreeFromAppStorage(LocalAppStorage, Path);
    finally
      for I := 0 to Screen.FormCount - 1 do
      begin
        if Screen.Forms[I] is TIDEDockWindow then
          TIDEDockWindow(Screen.Forms[I]).FormDeactivate(Self);
      end;
    end;
    if CanActuallyFocus(SaveActiveControl) then
      try
        SaveActiveControl.SetFocus;
      except
      end;
  end;
  LoadToolbarLayout(Layout);
  LocalAppStorage.ReadPersistent('Layouts\' + Layout + '\Second Workspace',
    TabsPersistsInfo);

  if Layout = 'Current' then
    CheckLayout := FLastLayout
  else
    CheckLayout := Layout;
  I := 0;
  while mnLayouts[I] <> mnLayOutSeparator do
  begin
    mnLayouts[I].Checked := False;
    if mnLayouts[I].Caption = CheckLayout then
      mnLayouts[I].Checked := True;
    Inc(I);
  end;
end;

procedure TPyIDEMainForm.LoadCurrentLayout;
begin
  if LocalAppStorage.PathExists('Layouts\Current\Forms') then
  begin
    try
      LoadLayout('Current');
    except
      StyledMessageDlg(Format(_(SErrorLoadLayout),
        [LocalAppStorage.IniFile.FileName]), mtError, [mbOK], 0);
    end;
    LocalAppStorage.DeleteSubTree('Layouts\Current');
  end
  else
    LoadDefaultLayout;
end;

procedure TPyIDEMainForm.LoadDefaultLayout;
begin
  if LocalAppStorage.PathExists('Layouts\Default\Forms') then
  begin
    try
      LoadLayout('Default');
    except
      LocalAppStorage.DeleteSubTree('Layouts\Default');
      if FLayouts.IndexOf('Default') >= 0 then
        FLayouts.Delete(FLayouts.IndexOf('Default'));
      StyledMessageDlg(Format(_(SErrorLoadLayout),
        [LocalAppStorage.IniFile.FileName]), mtError, [mbOK], 0);
    end;
  end
  else
    CreateDefaultLayout;
end;

procedure TPyIDEMainForm.LoadDebugLayout;
begin
  if LocalAppStorage.PathExists('Layouts\Debug\Forms') then
  begin
    try
      LoadLayout('Debug');
    except
      LocalAppStorage.DeleteSubTree('Layouts\Debug');
      if FLayouts.IndexOf('Default') >= 0 then
        FLayouts.Delete(FLayouts.IndexOf('Default'));
      StyledMessageDlg(Format(_(SErrorLoadLayout),
        [LocalAppStorage.IniFile.FileName]), mtError, [mbOK], 0);
    end;
  end;
end;

procedure TPyIDEMainForm.LoadPredefinedDefaultLayout;
var
  StrListLocal, StrListPredefined: TStringList;
  FileName: string;
begin
  if not LocalAppStorage.PathExists('Layouts\PredefinedDefault\Forms') then
  begin
    FileName := TPath.Combine(ExtractFilePath(Application.ExeName),
      'DefaultLayout.ini');
    if FileExists(FileName) then
      try
        try
          StrListLocal := TStringList.Create;
          StrListLocal.LoadFromFile(LocalAppStorage.FileName);
          StrListPredefined := TStringList.Create;
          StrListPredefined.LoadFromFile(FileName);
          StrListLocal.AddStrings(StrListPredefined);
          StrListLocal.SaveToFile(LocalAppStorage.FileName);
          LocalAppStorage.Reload;
        except
          StyledMessageDlg(Format(_(SErrorLoadLayout), [FileName]), mtError,
            [mbOK], 0);
        end;
      finally
        FreeAndNil(StrListPredefined);
        FreeAndNil(StrListLocal);
      end
    else
      StyledMessageDlg(Format(_(SNotFound), [FileName]), mtError, [mbOK], 0);
  end;
  if LocalAppStorage.PathExists('Layouts\PredefinedDefault\Forms') then
  begin
    try
      LoadLayout('PredefinedDefault');
      mnViewDefaultLayout.Checked := True;
    except
      LocalAppStorage.DeleteSubTree('Layouts\PredefinedDefault');
      StyledMessageDlg(Format(_(SErrorLoadLayout),
        [LocalAppStorage.IniFile.FileName]), mtError, [mbOK], 0);
    end;
  end
  else
    LoadDefaultLayout;
end;

procedure TPyIDEMainForm.LoadPredefinedDebugLayout;
var
  StrListLocal, StrListPredefined: TStringList;
  FileName: string;
begin
  if not LocalAppStorage.PathExists('Layouts\PredefinedDebug\Forms') then
  begin
    FileName := TPath.Combine(ExtractFilePath(Application.ExeName),
      'DebugLayout.ini');
    if FileExists(FileName) then
      try
        try
          StrListLocal := TStringList.Create;
          StrListLocal.LoadFromFile(LocalAppStorage.FileName);
          StrListPredefined := TStringList.Create;
          StrListPredefined.LoadFromFile(FileName);
          StrListLocal.AddStrings(StrListPredefined);
          StrListLocal.SaveToFile(LocalAppStorage.FileName);
          LocalAppStorage.Reload;
        except
          StyledMessageDlg(Format(_(SErrorLoadLayout), [FileName]), mtError,
            [mbOK], 0);
        end;
      finally
        FreeAndNil(StrListPredefined);
        FreeAndNil(StrListLocal);
      end
    else
      StyledMessageDlg(Format(_(SNotFound), [FileName]), mtError, [mbOK], 0);
  end;
  if LocalAppStorage.PathExists('Layouts\PredefinedDebug\Forms') then
  begin
    try
      LoadLayout('PredefinedDebug');
      mnViewDebugLayout.Checked := True;
    except
      LocalAppStorage.DeleteSubTree('Layouts\PredefinedDebug');
      StyledMessageDlg(Format(_(SErrorLoadLayout),
        [LocalAppStorage.IniFile.FileName]), mtError, [mbOK], 0);
    end;
  end
  else
    LoadDebugLayout;
end;

procedure TPyIDEMainForm.mnViewDefaultLayoutClick(Sender: TObject);
begin
  if GuiPyOptions.UsePredefinedLayouts then
    LoadPredefinedDefaultLayout
  else
    LoadDefaultLayout;
end;

procedure TPyIDEMainForm.mnViewDebugLayoutClick(Sender: TObject);
begin
  if GuiPyOptions.UsePredefinedLayouts then
    LoadPredefinedDebugLayout
  else
    LoadDebugLayout;
end;

procedure TPyIDEMainForm.MoveTab(Tab: TSpTBXTabItem;
TabControl: TSpTBXCustomTabControl; Index: Integer = -1);
var
  NewTab: TSpTBXTabItem;
  Sheet, NewSheet: TSpTBXTabSheet;
  FileForm: TFileForm;
begin
  if (Tab.Owner = TabControl) or not Assigned(Tab) then
    Exit;

  if Index >= 0 then
    NewTab := TabControl.Insert(Index, Tab.Caption)
  else
    NewTab := TabControl.Add(Tab.Caption);
  Sheet := (Tab.Owner as TSpTBXTabControl).GetPage(Tab);
  if Assigned(Sheet) and (Sheet.ControlCount > 0) and
    (Sheet.Controls[0] is TFileForm) then
  begin
    FileForm := Sheet.Controls[0] as TFileForm;
    FileForm.Visible := False;
    NewSheet := (NewTab.Owner as TSpTBXTabControl).GetPage(NewTab);
    FileForm.ParentTabItem := NewTab;
    FileForm.ParentTabControl := TabControl;
    FileForm.Parent := NewSheet;
    FileForm.Align := alClient;
    NewSheet.InsertComponent(FileForm); // changes ownership
    NewTab.OnTabClosing := TabControlTabClosing;
    NewTab.OnDrawTabCloseButton := DrawCloseButton;
    FileForm.Visible := True;
  end;
  Tab.Free;
  NewTab.Click;
end;

procedure TPyIDEMainForm.MRUAddFile(AFile: IFile);
begin
  if (AFile.FileName <> '') and (AFile.FileName <> _('Compare text')) then
    tbiRecentFileList.MRUAdd(AFile.FileName)
  else if (AFile.RemoteFileName <> '') then
    tbiRecentFileList.MRUAdd(TSSHFileName.Format(AFile.SSHServer,
      AFile.RemoteFileName));
end;

procedure TPyIDEMainForm.SyntaxClick(Sender: TObject);
begin
  // Change Syntax sheme
  var
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    var
    Highlighter := TSynCustomHighlighter((Sender as TTBCustomItem).Tag);
    if Assigned(Highlighter) then
      Editor.SetHighlighter(Highlighter.FriendlyLanguageName)
    else
      Editor.SetHighlighter('None');
  end;
end;

procedure TPyIDEMainForm.DdeServerConvExecuteMacro(Sender: TObject;
Msg: TStrings);
var
  FileName: string;
begin
  // loads selected files from windows explorer if GuiPy is already running
  // onExecuteMacro of System: TDdeServerConv component
  LockFormUpdate(Self);
  for var I := 0 to Msg.Count - 1 do
  begin
    FileName := Msg[I];
    if LeftStr(FileName, 11) = '[FileOpen("' then
    begin
      FileName := Copy(FileName, 12, Length(FileName) - 14);
      GI_EditorFactory.OpenFile(FileName, '',
        TabControlIndex(ActiveTabControl));
      if TPath.GetExtension(FileName) = '.pyw' then
      begin
        var
        PfmFile := TPath.ChangeExtension(FileName, '.pfm');
        GI_EditorFactory.OpenFile(PfmFile, '',
          TabControlIndex(ActiveTabControl));
      end;
      GuiPyOptions.Sourcepath := ExtractFilePath(FileName);
    end;
  end;
  UnlockFormUpdate(Self);
end;

procedure TPyIDEMainForm.mnNoSyntaxClick(Sender: TObject);
begin
  var
  Editor := GetActiveEditor;
  if Assigned(Editor) then
  begin
    Editor.SynEdit.Highlighter := nil;
    Editor.SynEdit2.Highlighter := nil;
  end;
end;

procedure TPyIDEMainForm.PythonVersionsClick(Sender: TObject);
begin
  PyControl.PythonVersionIndex := (Sender as TTBCustomItem).Tag;
end;

procedure TPyIDEMainForm.mnPythonVersionsPopup(Sender: TTBCustomItem;
FromLink: Boolean);
begin
  for var I := 0 to mnPythonVersions.Count - 3 do
  begin
    mnPythonVersions[I].Enabled := GI_PyControl.DebuggerState = dsInactive;
    mnPythonVersions[I].Checked := GI_PyControl.PythonLoaded and
      (PyControl.PythonVersionIndex = mnPythonVersions[I].Tag);
  end;
end;

procedure TPyIDEMainForm.SetupSyntaxMenu;
begin
  while mnSyntax.Count > 2 do
    mnSyntax.Delete(0);
  for var I := ResourcesDataModule.Highlighters.Count - 1 downto 0 do
  begin
    var
    MenuItem := TSpTBXItem.Create(Self);
    mnSyntax.Insert(0, MenuItem);
    MenuItem.Caption :=
      _(ResourcesDataModule.Highlighters[I].FriendlyLanguageName);
    MenuItem.Tag := Integer(ResourcesDataModule.Highlighters[I]);
    MenuItem.GroupIndex := 3;
    MenuItem.OnClick := SyntaxClick;
    MenuItem.Hint := Format(_(SUseSyntax), [MenuItem.Caption]);
  end;
end;

procedure TPyIDEMainForm.SetupPythonVersionsMenu;
var
  MenuItem: TTBCustomItem;
  I: Integer;
begin
  // remove previous versions
  while mnPythonVersions.Count > 2 do
    mnPythonVersions[0].Free;
  // Add versions in reverse order
  for I := Length(PyControl.CustomPythonVersions) - 1 downto 0 do
  begin
    MenuItem := TSpTBXItem.Create(Self);
    mnPythonVersions.Insert(0, MenuItem);
    MenuItem.Caption := PyControl.CustomPythonVersions[I].DisplayName;
    MenuItem.GroupIndex := 3;
    MenuItem.Tag := -(I + 1);
    MenuItem.OnClick := PythonVersionsClick;
    MenuItem.Hint := Format(_(SSwitchtoVersion), [MenuItem.Caption]);
  end;
  if Length(PyControl.CustomPythonVersions) > 0 then
  begin
    MenuItem := TSpTBXSeparatorItem.Create(Self);
    MenuItem.Tag := MenuItem.Tag.MaxValue;
    mnPythonVersions.Insert(0, MenuItem);
  end;
  for I := Length(PyControl.RegPythonVersions) - 1 downto 0 do
  begin
    MenuItem := TSpTBXItem.Create(Self);
    mnPythonVersions.Insert(0, MenuItem);
    MenuItem.Caption := PyControl.RegPythonVersions[I].DisplayName;
    MenuItem.GroupIndex := 3;
    MenuItem.Tag := I;
    MenuItem.OnClick := PythonVersionsClick;
    MenuItem.Hint := Format(_(SSwitchtoVersion), [MenuItem.Caption]);
  end;
end;

procedure TPyIDEMainForm.SplitWorkspace(SecondTabsVisible: Boolean;
Alignment: TAlign; Size: Integer);

  procedure MoveTabs;
  var
    ItemViewer: TTBItemViewer;
    List: TObjectList;
  begin
    // Move all tabs to TabControl1
    // Note that the Pages property may have a different order than the
    // physical order of the tabs
    TabControl1.Toolbar.BeginUpdate;
    TabControl2.Toolbar.BeginUpdate;
    List := TObjectList.Create(False);
    try
      for var I := 0 to TabControl2.View.ViewerCount - 1 do
      begin
        ItemViewer := TabControl2.View.Viewers[I];
        if ItemViewer.Item is TSpTBXTabItem then
          List.Add(ItemViewer.Item);
      end;

      for var TabItem in List do
        MoveTab(TSpTBXTabItem(TabItem), TabControl1);
    finally
      TabControl1.Toolbar.EndUpdate;
      TabControl2.Toolbar.EndUpdate;
      List.Free;
    end;
  end;

begin
  if not TabControl2.Visible and not SecondTabsVisible then
    Exit;
  if TabControl2.Visible and not SecondTabsVisible then
    MoveTabs;

  TabSplitter.Visible := False;
  TabControl2.Visible := False;
  FActiveTabControlIndex := 1;
  if SecondTabsVisible then
  begin
    TabControl2.Align := Alignment;
    if Alignment = alRight then
      TabControl2.Width := IfThen(Size >= 0, Size,
        (BGPanel.ClientWidth - 5) div 2)
    else
      TabControl2.Height := IfThen(Size >= 0, Size,
        (BGPanel.ClientHeight - 5) div 2);
    TabSplitter.Align := Alignment;
    TabControl2.Visible := True;
    TabSplitter.Visible := True;
    FActiveTabControlIndex := 2;
  end;
end;

procedure TPyIDEMainForm.SetupCustomizer;
var
  ItemStyle: TTBItemStyle;
  ItemsList: TList;
  ParentItem: TTBCustomItem;
  Item: TTBCustomItem;
begin
  SpTBXCustomizer.Items.Clear;
  ItemsList := TList.Create;
  try
    // Add to ItemList all suitable items on customizable toolbars
    for var Comp in Self do
    begin
      ParentItem := nil;
      if Comp is TSpTBXToolbar and TSpTBXToolbar(Comp).Customizable then
        ParentItem := TSpTBXToolbar(Comp).Items;
      if Assigned(ParentItem) then
      begin
        for var I := 0 to ParentItem.Count - 1 do
        begin
          Item := ParentItem[I];
          ItemStyle := TTBCustomItemAccess(Item).ItemStyle;
          // Exclude the submenus, separators, labels, groups and edit items
          if (ItemStyle * [tbisSubmenu, tbisSeparator, tbisEmbeddedGroup,
            tbisClicksTransparent] = []) and not(Item is TTBEditItem) then
            ItemsList.Add(Item);
        end;
      end;
    end;
    for var ActionList in TActionProxyCollection.ActionLists do
    begin
      for var Action in ActionList do
      begin
        var
        IsOnToolbar := False;
        for var I := 0 to ItemsList.Count - 1 do
          if TTBCustomItem(ItemsList[I]).Action = Action then
          begin
            IsOnToolbar := True;
            Break;
          end;
        if not IsOnToolbar then
        begin
          // Find toolbar items of External actions
          Item := FindComponent('tb' + Action.Name) as TTBCustomItem;
          if not Assigned(Item) then
          begin
            Item := TSpTBXItem.Create(Self);
            Item.Name := 'tb' + Action.Name;
            if Action is TExternalToolAction then
              Item.Images := FShellImages;
            SpTBXCustomizer.Items.Add(Item);
          end;
          Item.Action := Action;
        end;
      end;
    end;
  finally
    ItemsList.Free;
  end;
end;

procedure TPyIDEMainForm.CreateDefaultLayout;
begin
  ManualConjoinDock(DockServer.RightDockPanel, FObjectInspector,
    FFileStructure);
  DockServer.RightDockPanel.Width := PPIScale(250);

  var
  TabHost := ManualTabDock(DockServer.BottomDockPanel, PythonIIForm,
    MessagesWindow);
  DockServer.BottomDockPanel.Height := PPIScale(200);
  ManualTabDockAddPage(TabHost, OutputWindow);
  ManualTabDockAddPage(TabHost, VariablesWindow);
  ShowDockForm(PythonIIForm);

  ManualConjoinDock(DockServer.BottomDockPanel, TabHost,
    FUMLInteractive, alRight);

  mnViewDebugLayout.Checked := False;
  mnViewDefaultLayout.Checked := True;
  Application.ProcessMessages;
end;

{
  procedure TPyIDEMainForm.CreateDebugLayout;
  begin
  ManualConjoinDock(DockServer.RightDockPanel, FObjectInspector, FFileStructure);
  DockServer.RightDockPanel.Width := PPIScale(250);
  ManualConjoinDock(DockServer.BottomDockPanel, PythonIIForm, FFileStructure);

  var ConjoinHost := ManualConjoinDock(DockServer.BottomDockPanel, PythonIIForm, VariablesWindow);
  DockServer.BottomDockPanel.Height := PPIScale(200);
  ConjoinHost.ManualDock(WatchesWindow);
  ConjoinHost.ManualDock(CallStackWindow);

  mnViewDebugLayout.Checked:= False;
  mnViewDefaultLayout.Checked:= True;
  Application.ProcessMessages;
  end;
}

procedure TPyIDEMainForm.SaveLayout(const Layout: string);
begin
  LocalAppStorage.DeleteSubTree('Layouts\' + Layout);
  SaveDockTreeToAppStorage(LocalAppStorage, 'Layouts\' + Layout);
  SaveToolbarLayout(Layout);
  // Save secondary workspace info
  LocalAppStorage.WritePersistent('Layouts\' + Layout + '\Second Workspace',
    TabsPersistsInfo);
end;

procedure TPyIDEMainForm.LayoutClick(Sender: TObject);
begin
  LoadLayout(TSpTBXItem(Sender).Caption);
  TSpTBXItem(Sender).Checked := True;
  FLastLayout := TSpTBXItem(Sender).Caption;
end;

function TPyIDEMainForm.LayoutExists(const Layout: string): Boolean;
begin
  Result := FLayouts.IndexOf(Layout) >= 0;
end;

procedure TPyIDEMainForm.lbPythonEngineClick(Sender: TObject);
var
  MousePos: TPoint;
begin
  GetCursorPos(MousePos);
  MousePos := ScreenToClient(MousePos);
  mnPythonEngines.Popup(MousePos.X, MousePos.Y, True);
end;

procedure TPyIDEMainForm.lbPythonVersionClick(Sender: TObject);
begin
  actPythonSetup.Execute;
end;

procedure TPyIDEMainForm.lbStatusCaretClick(Sender: TObject);
begin
  CommandsDataModule.actSearchGoToLineExecute(Self);
end;

procedure TPyIDEMainForm.actLayoutSaveExecute(Sender: TObject);
var
  LayoutName: string;
  TempCursor: IInterface;
begin
  if InputQuery(_(SSaveCurrentLayout), _(SLayoutName), LayoutName) then
  begin
    TempCursor := WaitCursor;
    if FLayouts.IndexOf(LayoutName) < 0 then
    begin
      FLayouts.Add(LayoutName);
      SetupLayoutsMenu;
    end;
    SaveLayout(LayoutName);
  end;
end;

procedure TPyIDEMainForm.actLayoutsDeleteExecute(Sender: TObject);
var
  LayoutName: string;
  I: Integer;
begin
  with TPickListDialog.Create(Self) do
  begin
    Caption := _(SDeleteLayouts);
    lbMessage.Caption := _(SSelectLayouts);
    CheckListBox.Items.Assign(FLayouts);
    if ShowModal = idOK then
    begin
      for I := CheckListBox.Count - 1 downto 0 do
      begin
        if CheckListBox.Checked[I] then
        begin
          LayoutName := FLayouts[I];
          LocalAppStorage.DeleteSubTree('Layouts\' + LayoutName);
          FLayouts.Delete(I);
          SetupLayoutsMenu;
        end;
      end;
    end;
    Free;
  end;
end;

procedure TPyIDEMainForm.actLayoutDebugExecute(Sender: TObject);
begin
  if FLayouts.IndexOf('Debug') < 0 then
    FLayouts.Add('Debug');
  SaveLayout('Debug');
  SetupLayoutsMenu;
end;

procedure TPyIDEMainForm.actExternalRunExecute(Sender: TObject);
var
  ActiveEditor: IEditor;
  RunConfig: TRunConfiguration;
begin
  ActiveEditor := GetActiveEditor;
  if Assigned(ActiveEditor) then
  begin
    ActiveEditor.Activate;
    RunConfig := TRunConfiguration.Create;
    try
      SetupRunConfiguration(RunConfig, ActiveEditor);
      PyControl.ExternalRun(RunConfig);
    finally
      RunConfig.Free;
    end;
  end;
end;

procedure TPyIDEMainForm.actExecSelectionExecute(Sender: TObject);
begin
  if Assigned(GI_ActiveEditor) and GI_ActiveEditor.HasPythonFile then
    GI_ActiveEditor.ExecuteSelection;
end;

procedure TPyIDEMainForm.actExternalRunConfigureExecute(Sender: TObject);
begin
  EditTool(ExternalPython, True);
end;

procedure TPyIDEMainForm.WriteStatusMsg(const Msg: string);
begin
  lbStatusMessage.Caption := Msg;
end;

function TPyIDEMainForm.GuiDesignerOpen: Boolean;
var
  EditorForm: TEditorForm;
  AEditor: IEditor;
begin
  Result := True;
  EditorForm := nil;
  AEditor := GI_PyIDEServices.GetActiveEditor;
  if Assigned(AEditor) then
    EditorForm := TEditorForm(AEditor.Form)
  else if Assigned(FGUIDesigner.DesignForm) then
    EditorForm := FGUIDesigner.DesignForm.Partner;
  if Assigned(EditorForm) and EditorForm.IsPython then
  begin
    if not Assigned(EditorForm.Partner) then
    begin
      EditorForm.SBDesignformClick(nil);
      if not Assigned(EditorForm.Partner) then
      begin
        ErrorMsg(Format(_('File \"%s\" not found.'),
          [ChangeFileExt(EditorForm.Pathname, '.pfm')]));
        Result := False;
      end;
    end;
  end
  else
    Result := False;
end;

procedure TPyIDEMainForm.ToolButtonMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FGUIDesigner.DesignForm) and (Button = mbLeft) then
    (Sender as TToolButton).BeginDrag(False, 10);
end;

type
  TControlEx = class(TControl)
  protected
    FFont: TFont;
  end;

procedure TPyIDEMainForm.ToolButtonStartDrag(Sender: TObject;
var DragObject: TDragObject);
begin
  var
  ControlClass := FGUIDesigner.Tag2Class((Sender as TToolButton).Tag);
  var
  FDragRectangle := ControlClass.Create(FGUIDesigner.DesignForm);
  FDragRectangle.Parent := FGUIDesigner;
  FDragRectangle.ScaleForPPI(FGUIDesigner.DesignForm.PixelsPerInch);
  TControlEx(FDragRectangle).Font.Size := FGUIDesigner.DesignForm.FontSize;
  DragObject := TMyDragObject.Create(FDragRectangle);
end;

procedure TPyIDEMainForm.ToolButtonClick(Sender: TObject);
begin
  if GuiDesignerOpen then
  begin
    FGUIDesigner.SetToolButton(TToolButton(Sender).Tag);
    if not FObjectInspector.Visible then
      ShowDockForm(FObjectInspector);
  end;
end;

procedure TPyIDEMainForm.ThemeEditorGutter(Gutter: TSynGutter);
var
  GradColor: TColor;
begin
  // Delphi Styles
  if not StyleServices.GetElementColor
    (StyleServices.GetElementDetails(ttTabItemNormal), ecFillColor, GradColor)
    or (GradColor = clNone) then
    GradColor := StyleServices.GetSystemColor(clBtnFace);
  Gutter.Font.Color := StyleServices.GetSystemColor(clGrayText);

  with Gutter do
  begin
    BorderStyle := gbsNone;
    GradientStartColor := LightenColor(GradColor, 40);
    GradientEndColor := DarkenColor(GradColor, 20);
    Color := DarkenColor(GradColor, 4);
  end;
end;

procedure TPyIDEMainForm.FormKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  with ActiveTabControl as TSpTBXTabControl do
    if (Key = VK_CONTROL) and FZOrderProcessing then
    begin
      FZOrderProcessing := False;
      KeyPreview := False;
      if (FZOrderPos > 0) and (FZOrderPos < FZOrder.Count) then
      begin
        FZOrder.Move(FZOrderPos, 0);
        FZOrderPos := 0;
      end;
    end;
end;

procedure TPyIDEMainForm.AdjustBrowserLists(const FileName: string; Line: Integer;
Col: Integer; const FilePosInfo: string);
begin
  if FilePosInfo <> '' then
  begin
    // Adjust previous/next menus
    if FCurrentBrowseInfo <> '' then
      PrevMRUAdd(FCurrentBrowseInfo);

    PrevMRUAdd(Format(FilePosInfoFormat, [FileName, Line, Col]));
    mnNextList.Clear;
    FCurrentBrowseInfo := FilePosInfo;
  end;
end;

procedure TPyIDEMainForm.actFindDefinitionExecute(Sender: TObject);
var
  FilePosInfo: string;
  FileName: string;
  CaretXY: TBufferCoord;
begin
  Application.ProcessMessages;
  if Assigned(GI_ActiveEditor) then
  begin
    FileName := GI_ActiveEditor.FileId;
    CaretXY := GI_ActiveEditor.ActiveSynEdit.CaretXY;
    FindDefinition(GI_ActiveEditor, CaretXY, True, False, True, FilePosInfo);
    AdjustBrowserLists(FileName, CaretXY.Line, CaretXY.Char, FilePosInfo);
  end;
end;

function TPyIDEMainForm.FileIsPythonSource(const FileName: string): Boolean;
var
  Ext: string;
begin
  Ext := ExtractFileExt(FileName);
  if Ext = '' then
    Exit(False);
  Result := FileExtInFileFilter(Ext, PyIDEOptions.PythonFileFilter);
end;

procedure TPyIDEMainForm.FindDefinition(Editor: IEditor;
TextCoord: TBufferCoord; ShowMessages, Silent, JumpToFirstMatch: Boolean;
var FilePosInfo: string);
var
  Defs: Variant;
  Token: string;
  FName, FileName: string;
  TokenType, Start: Integer;
  Attri: TSynHighlighterAttributes;
  TempCursor: IInterface;
  BufferCord: TBufferCoord;
begin
  FilePosInfo := '';
  VarClear(Defs);
  if Assigned(Editor) and Editor.HasPythonFile then
    with Editor.ActiveSynEdit do
    begin
      if TextCoord.Line > Lines.Count then
        Exit;

      // Adjust TextCoord if we are at the end of an identifier (#1151)
      var
      Line := Lines[TextCoord.Line - 1];
      TextCoord.Char := Min(TextCoord.Char, Line.Length);
      if (TextCoord.Char > 1) and not IsIdentChar(Line[TextCoord.Char]) then
        Dec(TextCoord.Char);

      if GetHighlighterAttriAtRowColEx(TextCoord, Token, TokenType, Start, Attri)
      then
      begin
        case TokenType of
          Ord(tkFunctionName), Ord(tkClassName):
            begin
              if not Silent then
                StyledMessageDlg(Format(_(SFindDefinitionWarning), [Token]),
                  mtInformation, [mbOK], 0);
              Exit;
            end;
          Ord(tkIdentifier), Ord(tkSystemDefined), Ord(tkNonKeyword):
            begin
              TempCursor := WaitCursor;

              FName := Editor.FileId;

              if ShowMessages then
              begin
                GI_PyIDEServices.Messages.ClearMessages;
                GI_PyIDEServices.Messages.AddMessage
                  (_(SDefinitionsOf) + Token + '"');
              end;

              FileName := '';
              TPyLspClient.FindDefinitionByCoordinates(FName, TextCoord, FileName,
                BufferCord);

              if (FileName <> '') and ShowMessages then
                GI_PyIDEServices.Messages.AddMessage(_(SDefinitionFound),
                  FileName, BufferCord.Line, BufferCord.Char);

              if ShowMessages then
                ShowDockForm(MessagesWindow);

              if FileName <> '' then
              begin
                FilePosInfo := Format(FilePosInfoFormat,
                  [FileName, BufferCord.Line, BufferCord.Char]);
                if JumpToFirstMatch then
                  ShowFilePosition(FileName, BufferCord.Line, BufferCord.Char);
              end
              else
              begin
                if ShowMessages then
                  GI_PyIDEServices.Messages.AddMessage(_(SDefinitionNotFound));
                MessageBeep(MB_ICONASTERISK);
              end;
            end;
        else
          if not Silent then
            StyledMessageDlg(_(SPlaceCursorOnName), mtError, [mbOK], 0);
        end;
      end;
    end;
end;

procedure TPyIDEMainForm.FindToolbarVisibleChanged(Sender: TObject);
var
  SearchCommands: ISearchCommands;
begin
  if not FindToolbar.Visible then
  begin
    ClearAllHighlightedTerms;
    SearchCommands := CommandsDataModule.FindSearchTarget;
    if Assigned(SearchCommands) and CanActuallyFocus(SearchCommands.SearchTarget)
    then
      SearchCommands.SearchTarget.SetFocus;
  end;
  SetDockTopPanel;
end;

procedure TPyIDEMainForm.SetDockTopPanel;
var
  ATopToolbars, ATopFindToolbar, AHeight: Integer;
begin
  var
  HasMenuBar := False;
  for var I := 0 to VisMenusLen - 1 do
    HasMenuBar := HasMenuBar or FConfiguration.VisMenus[I];
  if HasMenuBar then
  begin
    AHeight := 23;
    ATopToolbars := AHeight;
  end
  else
  begin
    AHeight := 0;
    ATopToolbars := 0;
  end;

  var
  AllTabsClosed := True;
  for var I := 0 to High(FConfiguration.VisTabs) do
    if FConfiguration.VisTabs[I] then
      AllTabsClosed := False;
  if AllTabsClosed then
    TabControlWidgets.Visible := False;

  if not AllTabsClosed then
    AHeight := AHeight + 57
  else if FConfiguration.VisToolbars[0] or FConfiguration.VisToolbars[1] then
    AHeight := AHeight + 28;
  ATopFindToolbar := AHeight;

  if FindToolbar.Visible then
    AHeight := AHeight + 26;

  DebugToolbar.Left := MainToolBar.Left;
  MainToolBar.Top := PPIScale(ATopToolbars + 1);
  if MainToolBar.Visible then
  begin
    if TabControlWidgets.Visible then
    begin
      DebugToolbar.Top := PPIScale(ATopToolbars + 26 + 3);
    end
    else
    begin
      DebugToolbar.Top := PPIScale(ATopToolbars + 1);
      DebugToolbar.Left := MainToolBar.Left + MainToolBar.Width + 3;
    end;
  end
  else
    DebugToolbar.Top := PPIScale(ATopToolbars + 1);

  TabControlWidgets.Top := PPIScale(ATopToolbars);
  FindToolbar.Top := PPIScale(ATopFindToolbar);
  TBXDockTop.Height := PPIScale(AHeight);
end;

procedure TPyIDEMainForm.actFindReferencesExecute(Sender: TObject);
var
  Token: string;
  FName: string;
  TokenType, Start: Integer;
  Attri: TSynHighlighterAttributes;
  TempCursor: IInterface;
  FoundReferences: Boolean;
  Line: string;
  References: TArray<TDocPosition>;
begin
  Application.ProcessMessages;
  TempCursor := WaitCursor;

  if Assigned(GI_ActiveEditor) and GI_ActiveEditor.HasPythonFile then
    with GI_ActiveEditor.ActiveSynEdit do
    begin
      if GetHighlighterAttriAtRowColEx(CaretXY, Token, TokenType, Start, Attri)
      then
      begin
        case TokenType of
          Ord(tkFunctionName), Ord(tkClassName), Ord(tkIdentifier):
            begin
              FName := GI_ActiveEditor.FileName;
              if FName = '' then
                FName := GI_ActiveEditor.FileTitle;

              GI_PyIDEServices.Messages.ClearMessages;
              GI_PyIDEServices.Messages.AddMessage
                (_(SReferencesOf) + Token + '"');

              References := TPyLspClient.FindReferencesByCoordinates(FName, CaretXY);
              FoundReferences := Length(References) > 0;
              for var DocPosition in References do
              begin
                Line := GetNthSourceLine(DocPosition.FileId, DocPosition.Line);
                GI_PyIDEServices.Messages.AddMessage(Line, DocPosition.FileId,
                  DocPosition.Line, DocPosition.Char, Token.Length);
              end;

              ShowDockForm(MessagesWindow);
              if not FoundReferences then
              begin
                GI_PyIDEServices.Messages.AddMessage(_(SReferencesNotFound));
                MessageBeep(MB_ICONASTERISK);
              end;
            end;
        else
          StyledMessageDlg(_(SPlaceCursorOnName), mtError, [mbOK], 0);
        end;
      end;
    end;
end;

procedure TPyIDEMainForm.WMSpSkinChange(var Message: WinApi.Messages.TMessage);
begin
  // Update EditorOptions
  ThemeEditorGutter(GEditorOptions.Gutter);
  PyIDEOptions.CodeFolding.FolderBarLinesColor :=
    GEditorOptions.Gutter.Font.Color;

  // After updating to D11.3 Toolbar flicker was very visible on Style change
  // BeginUpdate/EndUpdate solved the problem
  MainToolBar.BeginUpdate;
  DebugToolbar.BeginUpdate;
  EditorToolbar.BeginUpdate;
  FindToolbar.BeginUpdate;
  try
    ResourcesDataModule.UpdateImageCollections;
  finally
    MainToolBar.EndUpdate;
    DebugToolbar.EndUpdate;
    EditorToolbar.EndUpdate;
    FindToolbar.EndUpdate;
  end;
{$IF CompilerVersion >= 36}
  ActivityIndicator.IndicatorColor := aicCustom;
  ActivityIndicator.IndicatorCustomColor := StyleServices.GetSystemColor
    (clWindowText);
{$ENDIF}
  // BGPanel.Color := CurrentTheme.GetItemColor(GetItemInfo('inactive'));
  // Application.HintColor := CurrentTheme.GetViewColor(VT_DOCKPANEL);
end;

procedure TPyIDEMainForm.WMWTSSessionChange(var Message: WinApi.Messages.TMessage);
begin
  case Message.WParam of
    WTS_SESSION_LOCK, WTS_REMOTE_DISCONNECT:
      Application.UpdateMetricSettings := False;
    WTS_REMOTE_CONNECT, WTS_SESSION_UNLOCK:
      TThread.ForceQueue(nil,
        procedure
        begin
          Application.UpdateMetricSettings := True;
        end, 30000);
  end;
end;

procedure TPyIDEMainForm.CMStyleChanged(var Message: WinApi.Messages.TMessage);
begin
  SkinManager.BroadcastSkinNotification;
  FFileStructure.ChangeStyle;
  FUMLInteractive.ChangeStyle;
  FObjectInspector.ChangeStyle;
  FClassEditor.ChangeStyle;
  FGUIDesigner.ChangeStyle;
  FUMLInteractive.ChangeStyle;
  ChangeStyle;
end;

procedure TPyIDEMainForm.WMFindDefinition(var Msg: WinApi.Messages.TMessage);
var
  FilePosInfo: string;
  FileName: string;
  Line, Col: Integer;
begin
  if Assigned(GI_ActiveEditor) then
  begin
    FileName := GI_ActiveEditor.FileId;
    Line := Msg.LParam;
    Col := Msg.WParam;
    FindDefinition(GI_ActiveEditor, BufferCoord(Col, Line), False, True, True,
      FilePosInfo);
    AdjustBrowserLists(FileName, Line, Col, FilePosInfo);
  end;
end;

procedure TPyIDEMainForm.WMSearchReplaceAction(var Msg: WinApi.Messages.TMessage);
var
  Action: TCustomAction;
begin
  if Msg.LParam <> 0 then
  begin
    Action := TCustomAction(Msg.LParam);
    Action.Execute;
  end
  else
  begin
    if Msg.WParam = 2 then
    begin
      // incremental search
      CommandsDataModule.IncrementalSearch;
    end;
  end;
end;

function TPyIDEMainForm.JumpToFilePosInfo(const FilePosInfo: string): Boolean;
var
  FileName: string;
  Line, Col: Integer;
begin
  Result := False;
  with TRegEx.Match(FilePosInfo, FilePosInfoRegExpr) do
    if Success then
    begin
      FileName := GroupValue(1);
      Line := StrToInt(GroupValue(2));
      Col := StrToInt(GroupValue(3));

      Exit(ShowFilePosition(FileName, Line, Col));
    end;
end;

procedure TPyIDEMainForm.DrawCloseButton(Sender: TObject; ACanvas: TCanvas;
State: TSpTBXSkinStatesType; const PaintStage: TSpTBXPaintStage;
var AImageList: TCustomImageList; var AImageIndex: Integer; var ARect: TRect;
var PaintDefault: Boolean);
var
  AFile: IFile;
  PatternColor: TColor;
  Rect: TRect;
begin
  AFile := FileFromTab(TSpTBXTabItem(Sender));
  if not Assigned(AFile) then
    Exit;

  PaintDefault := False;
  AImageIndex := -1;

  if State = sknsHotTrack then
  begin
    Rect := ARect;
    InflateRect(Rect, -1, -1);
    SpDrawXPButton(nil, ACanvas, Rect, True, False, True, False, False, False,
      FCurrentPPI);
  end;
  PatternColor := CurrentSkin.GetTextColor(nil, skncToolbarItem, State);
  if AFile.Modified then
  begin
    Rect := SpCenterRect(ARect, PPIScale(3), PPIScale(3));
    ExcludeClipRect(ACanvas.Handle, Rect.Left, Rect.Top, Rect.Right,
      Rect.Bottom);
  end;
  SpDrawGlyphPattern(ACanvas, ARect, gptClose, PatternColor, FCurrentPPI);
  if AFile.Modified then
    SelectClipRgn(ACanvas.Handle, 0);
end;

procedure TPyIDEMainForm.PrevClickHandler(Sender: TObject);
begin
  if Sender is TSpTBXMRUItem then
  begin
    var
    MRUItem := TSpTBXMRUItem(Sender);
    PreviousListClick(mnPreviousList, MRUItem.MRUString);
  end;
end;

procedure TPyIDEMainForm.PreviousListClick(Sender: TObject; Str: string);
begin
  var
  Index := mnPreviousList.IndexOfMRU(Str);
  if Index >= 0 then
  begin
    JumpToFilePosInfo(Str);
    NextMRUAdd(FCurrentBrowseInfo);
    FCurrentBrowseInfo := Str;
    for var I := 0 to Index - 1 do
      NextMRUAdd(TSpTBXMRUItem(mnPreviousList[I]).MRUString);
    for var I := 0 to Index do
      mnPreviousList.MRURemove(TSpTBXMRUItem(mnPreviousList[0]).MRUString);
  end;
end;

procedure TPyIDEMainForm.PrevMRUAdd(const Str: string);
begin
  mnPreviousList.MRUAdd(Str);
  mnPreviousList[0].OnClick := PrevClickHandler;
end;

procedure TPyIDEMainForm.tbiBrowsePreviousClick(Sender: TObject);
begin
  if mnPreviousList.Count > 0 then
    PreviousListClick(Sender, TSpTBXMRUItem(mnPreviousList[0]).MRUString);
end;

procedure TPyIDEMainForm.tbiFindCloseClick(Sender: TObject);
begin
  FindToolbar.Visible := False;
end;

function TPyIDEMainForm.NewFileFromTemplate(FileTemplate: TFileTemplate;
TabControlIndex: Integer; FileName: string): IEditor;
var
  I, J: Integer;
  TabCtrl: TSpTBXCustomTabControl;
  Editor: IEditor;
  EditorView: IEditorView;
begin
  // create a new editor, add it to the editor list
  TabCtrl := TabControl(TabControlIndex);
  TabCtrl.Toolbar.BeginUpdate;
  try
    Result := GI_EditorFactory.NewEditor(TabControlIndex);
    if Assigned(Result) then
    begin
      try
        Result.FromTemplate := True;
        if FileName = '' then
          FileName := GetFilename('.' + FileTemplate.Extension);
        Result.OpenLocalFile(FileName, FileTemplate.Highlighter);
        Result.Activate;
      except
        Result.Close;
        raise;
      end;
      Result.SynEdit.Text := Parameters.ReplaceInText(FileTemplate.Template);
      if (FileTemplate.Name = SClassTemplateName) and GuiPyOptions.FromFutureImport
      then
        TEditorForm(Result.Form).InsertImport
          ('from __future__ import annotations');

      // Locate the caret symbol |
      for I := 0 to Result.SynEdit.Lines.Count - 1 do
      begin
        J := Result.SynEdit.Lines[I].IndexOf('|');
        if J >= 0 then
        begin
          Result.SynEdit.CaretXY := BufferCoord(J + 1, I + 1);
          Result.SynEdit.ExecuteCommand(ecDeleteChar, ' ', nil);
          Break;
        end;
      end;

      Result.SynEdit.ClearUndo;
      Result.SynEdit.Modified := False;

      TEditorForm(Result.Form).DefaultExtension := FileTemplate.Extension;
      // Jupyter support
      if (LowerCase(FileTemplate.Extension) = 'ipynb') and not OutputWindow.IsRunning
      then
      begin
        Editor := Result;
        (Editor as IFileCommands).ExecSave;
        TThread.ForceQueue(nil,
          procedure
          begin
            EditorView := Editor.ActivateView(GI_EditorFactory.ViewFactory
              [WebPreviewFactoryIndex]);
            if Assigned(EditorView) then
              EditorView.UpdateView(Editor);
          end);
      end;
    end;
  finally
    TabCtrl.Toolbar.EndUpdate;
    if Assigned(TabCtrl.ActiveTab) then
      TabCtrl.MakeVisible(TabCtrl.ActiveTab);
    UpdateCaption;
  end;
end;

procedure TPyIDEMainForm.NextClickHandler(Sender: TObject);
begin
  if Sender is TSpTBXMRUItem then
  begin
    var
    MRUItem := TSpTBXMRUItem(Sender);
    NextListClick(mnNextList, MRUItem.MRUString);
  end;
end;

procedure TPyIDEMainForm.NextListClick(Sender: TObject; Str: string);
begin
  var
  Index := mnNextList.IndexOfMRU(Str);
  if Index >= 0 then
  begin
    JumpToFilePosInfo(Str);
    PrevMRUAdd(FCurrentBrowseInfo);
    FCurrentBrowseInfo := Str;
    for var I := 0 to Index - 1 do
      PrevMRUAdd(TSpTBXMRUItem(mnNextList[I]).MRUString);
    for var I := 0 to Index do
      mnNextList.MRURemove(TSpTBXMRUItem(mnNextList[0]).MRUString);
  end;
end;

procedure TPyIDEMainForm.NextMRUAdd(const Str: string);
begin
  mnNextList.MRUAdd(Str);
  mnNextList[0].OnClick := NextClickHandler;
end;

function TPyIDEMainForm.OpenCmdLineFile(const FileName: string): Boolean;
begin
  // Try to see whether it contains line/char info
  Result := JumpToFilePosInfo(FileName);
  if not Result and FileExists(FileName) then
    Result := Assigned(GI_EditorFactory.OpenFile(FileName, ''));
end;

procedure TPyIDEMainForm.tbiBrowseNextClick(Sender: TObject);
begin
  if mnNextList.Count > 0 then
  begin
    NextListClick(Sender, TSpTBXMRUItem(mnNextList[0]).MRUString);
  end;
end;

procedure TPyIDEMainForm.ApplicationActionExecute(Action: TBasicAction;
var Handled: Boolean);
var
  Msg: Cardinal;
begin
  if (Action is TEditAction) and Assigned(Screen.ActiveControl) and
    (Screen.ActiveControl is TComboBox) and not TComboBox(Screen.ActiveControl).DroppedDown
  then
  begin
    Msg := 0;
    if Action is TEditCopy then
      Msg := WM_COPY
    else if Action is TEditCut then
      Msg := WM_CUT
    else if Action is TEditPaste then
      Msg := WM_PASTE;
    if Msg <> 0 then
    begin
      PostMessage(Screen.ActiveControl.Handle, Msg, 0, 0);
      Handled := True;
    end;
  end;
end;

procedure TPyIDEMainForm.ApplicationActionUpdate(Action: TBasicAction;
var Handled: Boolean);
begin
  if (Action is TEditAction) then
  begin
    if Assigned(Screen.ActiveControl) and (Screen.ActiveControl is TComboBox)
      and not TComboBox(Screen.ActiveControl).DroppedDown then
    begin
      TEditAction(Action).Enabled := (Action is TEditCut) and
        (TComboBox(Screen.ActiveControl).SelLength > 0) or (Action is TEditCopy)
        and (TComboBox(Screen.ActiveControl).SelLength > 0) or
        (Action is TEditPaste) and Clipboard.HasFormat(CF_UNICODETEXT);
      Handled := (Action is TEditCut) or (Action is TEditCopy) or
        (Action is TEditPaste);
    end;
  end;
end;

function TPyIDEMainForm.ApplicationHelp(Command: Word; Data: THelpEventData;
var CallHelp: Boolean): Boolean;
var
  KeyWord: string;
begin
  CallHelp := True;
  Result := False;
  // We are not going to show popup help
  // if Command = HELP_SETPOPUP_POS then exit;
  if not FPythonKeywordHelpRequested and not FMenuHelpRequested and Active and
    (ActiveControl is TSynEdit) and
    (TSynEdit(ActiveControl).Highlighter = ResourcesDataModule.SynPythonSyn)
  then
  begin
    KeyWord := TSynEdit(ActiveControl).WordAtCursor;
    if KeyWord <> '' then
    begin
      CallHelp := not CommandsDataModule.ShowPythonKeywordHelp(KeyWord);
      Result := True;
    end;
  end;
end;

procedure TPyIDEMainForm.WMCheckForUpdates(var Msg: WinApi.Messages.TMessage);
begin
  try
    CommandsDataModule.actCheckForUpdatesExecute(nil);
    // nil so that we get no confirmation
  except
    // fail silently
  end;
end;

procedure TPyIDEMainForm.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  WTSUnRegisterSessionNotification(Handle);
end;

procedure TPyIDEMainForm.WMEndSession(var Msg: TWMEndSession);
begin
  if Msg.EndSession then
    GI_EditorFactory.CreateRecoveryFiles;
  Msg.Result := 0;
end;

procedure TPyIDEMainForm.FormShow(Sender: TObject);
begin
  // OutputDebugString(PWideChar(Format('%s ElapsedTime %d ms', ['FormShow start', StopWatch.ElapsedMilliseconds])));
  // Do not execute again
  OnShow := nil;

  // fix for staturbar appearing above interpreter
  if StatusBar.Visible then
    StatusBar.Top := MaxInt;

  // Update Syntax and FLayouts menu
  SetupLayoutsMenu;
  SetupSyntaxMenu;

  // Start accepting files
  DragAcceptFiles(TabControl1.Handle, True);
  DragAcceptFiles(TabControl2.Handle, True);

  TThread.ForceQueue(nil, FormShowDelayedActions, 1000);
  // OutputDebugString(PWideChar(Format('%s ElapsedTime %d ms', ['FormShow end', StopWatch.ElapsedMilliseconds])));
end;

procedure TPyIDEMainForm.FormShowDelayedActions;
begin
  // Activate File Explorer
  FileExplorerWindow.FileExplorerTree.Active := True;
  // Application.ProcessMessages;

  // Load Python Engine and Assign Debugger Events
  PyControl.LoadPythonEngine;
  SetupPythonVersionsMenu;

  if Length(PyControl.CustomPythonVersions) +
    Length(PyControl.RegPythonVersions) > 0 then
    FConfiguration.AddScriptsPath;

  // Update External Tools
  SetupToolsMenu; // After creating internal interpreter
  FConfiguration.RestoreApplicationData; // After last change of main menu

  SetupCustomizer; // After setting up the Tools menu
  // Load Toolbar Items after setting up the Tools menu
  if FileExists(AppStorage.IniFile.FileName) then
    LoadToolbarItems('Toolbar Items');

  PyControl.OnStateChange := DebuggerStateChange;

  DebuggerStateChange(PyControl);

  // Open initial files after loading Python (#879)
  OpenInitialFiles;

  if FLayouts.IndexOf('Default') < 0 then
  begin
    SaveLayout('Default');
    FLayouts.Add('Default');
  end;

  with TFUpdate.Create(Self) do
  begin
    CheckAutomatically;
    Free;
  end;

  if not GI_PyControl.PythonLoaded then
    actPythonSetupExecute(Self);
end;

procedure TPyIDEMainForm.JvAppInstancesCmdLineReceived(Sender: TObject;
CmdLine: TStrings);
begin
  if JvAppInstances.AppInstances.InstanceIndex[GetCurrentProcessId] <> 0 then
    Exit;
  for var FName in CmdLine do
    if (FName[1] <> '-') then
      FShellExtensionFiles.Add(FName);
end;

procedure TPyIDEMainForm.SaveEnvironment;
begin
  // Save the list of open files
  AppStorage.DeleteSubTree('Open Files');
  TPersistFileInfo.WriteToAppStorage(AppStorage, 'Open Files');
  // Delete BeforeZoom layout if it exists
  if LocalAppStorage.PathExists('Layouts\BeforeZoom\Forms') then
    LocalAppStorage.DeleteSubTree('Layouts\BeforeZoom');
  // Save Layout
  SaveLayout('Current');
  // Store other application data and flush AppStorage
  StoreApplicationData;
  StoreLocalApplicationData;
end;

procedure TPyIDEMainForm.actMaximizeEditorExecute(Sender: TObject);
var
  I: TJvDockPosition;
  Panel: TJvDockPanel;
begin
  if LocalAppStorage.PathExists('Layouts\BeforeZoom\Forms') then
    actRestoreEditorExecute(Sender)
  else
  begin
    SaveLayout('BeforeZoom');
    for I := Low(TJvDockPosition) to High(TJvDockPosition) do
    begin
      Panel := DockServer.DockPanel[I];
      if not(Panel is TJvDockVSNETPanel) then
        Continue;
      while Panel.DockClientCount > 0 do
        TJvDockVSNETPanel(Panel).DoAutoHideControl
          (Panel.DockClients[Panel.DockClientCount - 1] as TWinControl);
    end;
  end;
end;

procedure TPyIDEMainForm.actUMLRecognizeAssociationsExecute(Sender: TObject);
begin
  var
  AFile := GI_PyIDEServices.GetActiveFile;
  if Assigned(AFile) and (AFile.FileKind = fkUML) then
    TFUMLForm(AFile.Form).TBRecognizeAssociationsClick(Self);
end;

procedure TPyIDEMainForm.actRemoteFileOpenExecute(Sender: TObject);
var
  FileName, Server: string;
begin
  if ExecuteRemoteFileDialog(FileName, Server, rfdOpen) then
    GI_EditorFactory.OpenFile(TSSHFileName.Format(Server, FileName), '');
end;

procedure TPyIDEMainForm.actRestoreEditorExecute(Sender: TObject);
begin
  if LocalAppStorage.PathExists('Layouts\BeforeZoom\Forms') then
  begin
    LoadLayout('BeforeZoom');
    LocalAppStorage.DeleteSubTree('Layouts\BeforeZoom');
  end;
end;

procedure TPyIDEMainForm.actEditorZoomOutExecute(Sender: TObject);
begin
  if ActiveControl is TSynEdit then
    TSynEdit(ActiveControl).Zoom(-1);
end;

procedure TPyIDEMainForm.actEditorZoomResetExecute(Sender: TObject);
begin
  if ActiveControl is TSynEdit then
    TSynEdit(ActiveControl).ZoomReset;
end;

procedure TPyIDEMainForm.actEditorZoomInExecute(Sender: TObject);
begin
  if ActiveControl is TSynEdit then
    TSynEdit(ActiveControl).Zoom(1);
end;

procedure TPyIDEMainForm.mnFilesClick(Sender: TObject);
// Fill in the Files submenu of the Tabs popup menu
var
  AFile, ActiveFile: IFile;
  List: TStringList;
  MenuItem: TSpTBXItem;
  ModifiedImageIndex: Integer;
begin
  mnFiles.Clear;
  ActiveFile := GetActiveFile;
  List := TStringList.Create;
  List.Duplicates := dupAccept;
  List.Sorted := True;
  try
    GI_FileFactory.ApplyToFiles(
      procedure(AFile: IFile)
      begin
        List.AddObject(AFile.FileId, TObject(AFile.Form));
      end);
    ModifiedImageIndex := vilImages.GetIndexByName('Edit');
    for var I := 0 to List.Count - 1 do
    begin
      AFile := TFileForm(List.Objects[I]).GetFile;
      MenuItem := TSpTBXItem.Create(Self);
      mnFiles.Add(MenuItem);
      MenuItem.Caption := List[I];
      MenuItem.GroupIndex := 3;
      MenuItem.Hint := AFile.FileId;
      MenuItem.Checked := AFile = ActiveFile;
      if AFile.Modified then
        MenuItem.ImageIndex := ModifiedImageIndex;
      MenuItem.OnClick := SelectEditor;
    end;
  finally
    List.Free;
  end;
end;

procedure TPyIDEMainForm.mnLanguageClick(Sender: TObject);
begin
  ChangeLanguage(FLanguageList[(Sender as TSpTBXItem).Tag]);
  SetupSyntaxMenu;
  SetupToolsMenu;
end;

procedure TPyIDEMainForm.tbiScrollLeftClick(Sender: TObject);
begin
  TabControl((Sender as TSpTBXItem).Tag).ScrollLeft;
end;

procedure TPyIDEMainForm.tbiScrollRightClick(Sender: TObject);
begin
  TabControl((Sender as TSpTBXItem).Tag).ScrollRight;
end;

procedure TPyIDEMainForm.tbiSearchOptionsPopup(Sender: TTBCustomItem;
FromLink: Boolean);
begin
  with EditorSearchOptions do
  begin
    tbiSearchFromCaret.Checked := SearchFromCaret;
    tbiSearchInSelection.Checked := SearchSelectionOnly;
    tbiWholeWords.Checked := SearchWholeWords;
    tbiRegExp.Checked := UseRegExp;
    tbiAutoCaseSensitive.Checked := SearchCaseSensitiveType = scsAuto;
    tbiCaseSensitive.Checked := SearchCaseSensitiveType = scsCaseSensitive;
    tbiCaseSensitive.Enabled := not tbiAutoCaseSensitive.Checked;
    tbiIncrementalSearch.Checked := IncrementalSearch;
  end;
end;

procedure TPyIDEMainForm.TbiSearchTextAcceptText(const NewText: string);
var
  Str: string;
  Int: Integer;
begin
  if NewText <> '' then
  begin
    // update Items
    Int := tbiSearchText.Items.IndexOf(NewText);
    if Int > -1 then
      tbiSearchText.Items.Delete(Int);
    tbiSearchText.Items.Insert(0, NewText);
    tbiSearchText.Text := NewText;
    tbiSearchText.Perform(WM_KEYDOWN, VK_END, 0);

    // Update History
    Str := '';
    for Int := 0 to tbiSearchText.Items.Count - 1 do
    begin
      if Int >= 10 then
        Break;
      if Int > 0 then
        Str := Str + ',';
      Str := Str + AnsiQuotedStr(tbiSearchText.Items[Int], '"');
    end;
    EditorSearchOptions.SearchTextHistory := Str;
  end;
end;

procedure TPyIDEMainForm.tbiSearchTextKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(VK_ESCAPE)) and not tbiSearchText.DroppedDown then
  begin
    Key := #0;
    FindToolbar.Visible := False;
  end
  else if (Key = Char(VK_RETURN)) and not tbiSearchText.DroppedDown then
  begin
    Key := #0;
    TbiSearchTextAcceptText(tbiSearchText.Text);
    CommandsDataModule.actSearchFindNext.Execute;
  end;
end;

procedure TPyIDEMainForm.tbiSearchTextChange(Sender: TObject);
begin
  if EditorSearchOptions.SearchText <> tbiSearchText.Text then
  begin
    EditorSearchOptions.SearchText := tbiSearchText.Text;
    EditorSearchOptions.InitSearch;
    CommandsDataModule.UpdateMainActions;

    ClearAllHighlightedTerms;
    if CommandsDataModule.actSearchHighlight.Enabled and
      CommandsDataModule.actSearchHighlight.Checked then
      CommandsDataModule.actSearchHighlightExecute(Sender);

    if EditorSearchOptions.IncrementalSearch then
      PostMessage(Handle, WM_SEARCHREPLACEACTION, 2, 0);
  end;
end;

procedure TPyIDEMainForm.tbiSearchTextExit(Sender: TObject);
begin
  TbiSearchTextAcceptText(tbiSearchText.Text);
end;

procedure TPyIDEMainForm.tbiRecentFileListClick(Sender: TObject;
const FileName: string);
begin
  GI_EditorFactory.OpenFile(FileName, '');
  TThread.ForceQueue(nil,
    procedure
    begin
      tbiRecentFileList.MRURemove(FileName);
    end);
  if ExtractFileExt(FileName) = '.pyw' then
  begin
    var
    AFilename := ChangeFileExt(FileName, '.pfm');
    GI_EditorFactory.OpenFile(AFilename, '');
  end;
end;

procedure TPyIDEMainForm.tbiRecentProjectsClick(Sender: TObject;
const FileName: string);
begin
  ProjectExplorerWindow.DoOpenProjectFile(FileName);
  tbiRecentProjects.MRURemove(FileName);
end;

procedure TPyIDEMainForm.TbiReplaceTextAcceptText(const NewText: string);
var
  Str: string;
  Int: Integer;
begin
  if NewText <> '' then
  begin
    // update Items
    Int := tbiReplaceText.Items.IndexOf(NewText);
    if Int > -1 then
      tbiReplaceText.Items.Delete(Int);
    tbiReplaceText.Items.Insert(0, NewText);
    tbiReplaceText.Text := NewText;
    tbiReplaceText.Perform(WM_KEYDOWN, VK_END, 0);

    // Update History
    Str := '';
    for Int := 0 to tbiReplaceText.Items.Count - 1 do
    begin
      if Int >= 10 then
        Break;
      if Int > 0 then
        Str := Str + ',';
      Str := Str + tbiReplaceText.Items[Int].QuotedString('"');
    end;
    EditorSearchOptions.ReplaceTextHistory := Str;
  end;
end;

procedure TPyIDEMainForm.tbiReplaceTextChange(Sender: TObject);
begin
  EditorSearchOptions.ReplaceText := tbiReplaceText.Text;
  EditorSearchOptions.InitSearch;
  CommandsDataModule.UpdateMainActions;
end;

procedure TPyIDEMainForm.tbiReplaceTextExit(Sender: TObject);
begin
  TbiReplaceTextAcceptText(tbiReplaceText.Text);
end;

procedure TPyIDEMainForm.tbiReplaceTextKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(VK_ESCAPE)) and not tbiReplaceText.DroppedDown then
  begin
    Key := #0;
    FindToolbar.Visible := False;
  end
  else if (Key = Char(VK_RETURN)) and not tbiReplaceText.DroppedDown then
  begin
    Key := #0;
    TbiReplaceTextAcceptText(tbiReplaceText.Text);
    CommandsDataModule.actSearchReplaceNow.Execute;
  end;
end;

procedure TPyIDEMainForm.SearchOptionsChanged(Sender: TObject);
begin
  with EditorSearchOptions do
  begin
    SearchFromCaret := tbiSearchFromCaret.Checked;
    SearchSelectionOnly := tbiSearchInSelection.Checked;
    SearchWholeWords := tbiWholeWords.Checked;
    UseRegExp := tbiRegExp.Checked;
    if tbiAutoCaseSensitive.Checked then
      SearchCaseSensitiveType := scsAuto
    else if tbiCaseSensitive.Checked then
      SearchCaseSensitiveType := scsCaseSensitive
    else
      SearchCaseSensitiveType := scsNotCaseSenitive;
    IncrementalSearch := tbiIncrementalSearch.Checked and not SearchWholeWords;
    InitSearch;
  end;
  ClearAllHighlightedTerms;
  if CommandsDataModule.actSearchHighlight.Enabled and
    CommandsDataModule.actSearchHighlight.Checked then
    CommandsDataModule.actSearchHighlightExecute(Sender);
end;

procedure TPyIDEMainForm.SelectEditor(Sender: TObject);
begin
  ShowFilePosition((Sender as TTBCustomItem).Hint, -1, -1);
end;

procedure TPyIDEMainForm.ChangeStyle;
begin
  if IsStyledWindowsColorDark then
  begin
    ToolbarProgram.Images := vilProgramDark;
    ToolbarTkinter.Images := vilTkInterDark;
    ToolbarTTK.Images := vilTTKDark;
    ToolbarQtBase.Images := vilQtBaseDark;
    ToolbarQtControls.Images := vilQtControls;
  end
  else
  begin
    ToolbarProgram.Images := vilProgramLight;
    ToolbarTkinter.Images := vilTkInterLight;
    ToolbarTTK.Images := vilTTKLight;
    ToolbarQtBase.Images := vilQtBaseLight;
    ToolbarQtControls.Images := vilQtControls;
  end;
end;

procedure TPyIDEMainForm.DropFiles(Sender: TObject; X, Y: Integer;
AFiles: TStrings);
var
  FileName: string;
begin
  LockFormUpdate(Self);
  try
    for FileName in AFiles do
      GI_EditorFactory.OpenFile(FileName, '', FActiveTabControlIndex);
    GuiPyOptions.Sourcepath := ExtractFilePath(FileName);
  finally
    UnlockFormUpdate(Self);
  end;
end;

procedure TPyIDEMainForm.mnRefactorClosePopup(Sender: TObject);
begin
  CleanUpRefactoringMenu(mnRefactor);
end;

procedure TPyIDEMainForm.mnRefactorInitPopup(Sender: TObject; PopupView:
    TTBView);
begin
  var Editor := GI_ActiveEditor;
  if Assigned(Editor) then
    SetupRefactoringMenu(Editor.FileId, Editor.ActiveSynEdit.BlockBegin,
      Editor.ActiveSynEdit.BlockEnd, mnRefactor);
end;

procedure TPyIDEMainForm.RemoveDefunctEditorOptions;
// since 5.11 to avoid an exception
const
  DefunctOptions: array [0 .. 8] of string = ('eoAltSetsColumnMode',
    'eoDisableScrollArrows', 'eoHalfPageScroll', 'eoHideShowScrollbars',
    'eoScrollByOneLess', 'eoScrollHintFollows', 'eoScrollPastEof',
    'eoScrollPastEol', 'eoShowScrollHint');
begin
  var
  StringList := TSmartPtr.Make(TStringList.Create)();
  StringList.LoadFromFile(TPyScripterSettings.OptionsFileName);
  var
  Settings := StringList.Text;
  for var DefunctOption in DefunctOptions do
    Settings := StringReplace(Settings, DefunctOption + ', ', '',
      [rfReplaceAll, rfIgnoreCase]);
  StringList.Text := Settings;
  StringList.SaveToFile(TPyScripterSettings.OptionsFileName);
end;

procedure TPyIDEMainForm.ShowTkOrQt(FrameType: Integer);
begin
  var
  PageControl := PyIDEMainForm.TabControlWidgets;
  if (FrameType in [0, 1]) and (FTabControlsShowing <> 1) then
  begin
    PageControl.Items[1].Visible := FConfiguration.VisTabs[1];
    PageControl.Items[2].Visible := FConfiguration.VisTabs[2];
    PageControl.Items[3].Visible := FConfiguration.VisTabs[3];
    PageControl.Items[4].Visible := FConfiguration.VisTabs[4];
    FTabControlsShowing := 1;
    PageControl.TabClick(TSpTBXTabItem(PageControl.Items[0]));
  end
  else if (FrameType = 2) and (FTabControlsShowing <> 2) then
  begin
    PageControl.Items[1].Visible := FConfiguration.VisTabs[1];
    PageControl.Items[2].Visible := FConfiguration.VisTabs[2];
    PageControl.Items[3].Visible := False;
    PageControl.Items[4].Visible := False;
    FTabControlsShowing := 2;
    PageControl.TabClick(TSpTBXTabItem(PageControl.Items[1]));
  end
  else if (FrameType = 3) and (FTabControlsShowing <> 3) then
  begin
    PageControl.Items[1].Visible := False;
    PageControl.Items[2].Visible := False;
    PageControl.Items[3].Visible := FConfiguration.VisTabs[3];
    PageControl.Items[4].Visible := FConfiguration.VisTabs[4];
    FTabControlsShowing := 3;
    PageControl.TabClick(TSpTBXTabItem(PageControl.Items[3]));
  end;
  case FrameType of
    2:
      CreateTkCursors;
    3:
      CreateQtCursors;
  end;
end;

{ TTSpTBXTabControl }

procedure TSpTBXTabControl.WMDropFiles(var Msg: winApi.Messages.TMessage);
var
  NumberDropped: Integer;
  FileName: array [0 .. MAX_PATH - 1] of Char;
begin
  try
    NumberDropped := DragQueryFile(Msg.WParam, Cardinal(-1), nil, 0);

    for var I := 0 to NumberDropped - 1 do
    begin
      DragQueryFile(Msg.WParam, I, FileName, MAX_PATH);
      GI_EditorFactory.OpenFile(FileName, '',
        PyIDEMainForm.TabControlIndex(Self));
    end;
  finally
    Msg.Result := 0;
    DragFinish(Msg.WParam);
  end;
end;

constructor TSpTBXTabControl.Create(AOwner: TComponent);
begin
  inherited;
  FZOrder := TList.Create;
end;

destructor TSpTBXTabControl.Destroy;
begin
  FreeAndNil(FZOrder);
  inherited;
end;

end.
