{ -------------------------------------------------------------------------------
  Unit:     UConfiguration
  Author:   Gerhard Röhner
  Date:     July 2000
  Purpose:  configuration
  ------------------------------------------------------------------------------- }

unit UConfiguration;

{

  We have configuration-values
  a) in ini files
  AppStorage.FileName := ChangeFileExt(Application.ExeName, '.ini');
  MachineStorage.FileName:= ExtractFilePath(Application.ExeName) + 'GuiPyMachine.INI';
  b) in variables (Model)
  c) in form (View)

  #           RestoreApplicationData              ModelToView
  INI files  ----------------------->  model   -------------> view

  INI files <----------------------- variables <------------- gui-elements
  #            StoreApplicationData                ViewToModel


  http://dxgettext.po.dk/documentation/how-to
}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Dialogs,
  StdCtrls,
  Buttons,
  ComCtrls,
  ExtCtrls,
  UITypes,
  System.Actions,
  System.ImageList,
  VCL.Styles.PyScripter,
  VCL.BaseImageCollection,
  VCL.ActnList,
  VCL.ImgList,
  VCL.VirtualImageList,
  VCL.WinXPanels,
  Generics.Collections,
  VirtualTrees,
  VirtualTrees.Types,
  VirtualTrees.BaseAncestorVCL,
  VirtualTrees.BaseTree,
  VirtualTrees.AncestorVCL,
  SVGIconImageCollection,
  TB2Item,
  TB2Dock,
  TB2Toolbar,
  SpTBXItem,
  SpTBXEditors,
  SpTBXExtEditors,
  dlgSynEditOptions,
  dlgCustomShortcuts,
  dlgPyIDEBase,
  SynEdit,
  SynEditHighlighter,
  SynEditPrintHeaderFooter,
  SynEditPrint,
  SynEditKeyCmds,
  SynEditMiscClasses,
  SynEditPrintMargins,
  cFileTemplates,
  uLLMSupport;

const CrLf = #13#10; Homepage = 'https://www.guipy.Deu'; VisTabsLen = 5;
  // Program, Tkinter, TTK, QtBase, QtControls
  VisMenusLen = 9; // all menus
  VisToolbarsLen = 6; // Main, Debug, Editor, UML, Structogram, Sequencediagram
  MaxVisLen = VisTabsLen + VisMenusLen + VisToolbarsLen; MaxTabItem = 28;

type
  TBoolArray = array of Boolean;

  TEditStyleHookColor = class(TEditStyleHook) // TEditStyleHook in StdCtrls
  private
    procedure UpdateColors;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TWinControlH = class(TWinControl);

  TGuiPyOptions = class(TInterfacedPersistent)
  private
    // Color themes
    FColorTheme: string;

    // Class modeler
    FShowGetSetMethods: Boolean;
    FGetSetMethodsAsProperty: Boolean;
    FGetMethodChecked: Boolean;
    FSetMethodChecked: Boolean;
    FShowAttributeTypeSelection: Boolean;
    FShowWithWithoutReturnValue: Boolean;
    FShowMethodTypeSelection: Boolean;
    FShowParameterTypeSelection: Boolean;
    FFromFutureImport: Boolean;

    // GUI designer
    FNameFromText: Boolean;
    FGuiDesignerHints: Boolean;
    FSnapToGrid: Boolean;
    FGridSize: Integer;
    FZoomSteps: Integer;
    FGUIFontSize: Integer;
    FGUIFontName: string;
    FFrameWidth: Integer;
    FFrameHeight: Integer;

    // Structogram
    FStructoDatatype: string;
    FSwitchWithCaseLine: Boolean;
    FCaseCount: Integer;
    FStructogramShadowWidth: Integer;
    FStructogramShadowIntensity: Integer;

    // Sequencediagram
    FSDFillingColor: TColor;
    FSDNoFilling: Boolean;
    FSDShowMainCall: Boolean;
    FSDShowParameter: Boolean;
    FSDShowReturn: Boolean;

    // UML design
    FValidClassColor: TColor;
    FInvalidClassColor: TColor;
    FClassHead: Integer;
    FShadowWidth: Integer;
    FShadowIntensity: Integer;
    FObjectColor: TColor;
    FObjectHead: Integer;
    FObjectFooter: Integer;
    FObjectCaption: Integer;
    FObjectUnderline: Boolean;
    FCommentColor: TColor;
    FDiVisibilityFilter: Integer;
    FDiSortOrder: Integer;
    FDiShowParameter: Integer;
    FDiShowIcons: Integer;

    // UML options
    FShowEmptyRects: Boolean;
    FIntegerInsteadofInt: Boolean;
    FConstructorWithVisibility: Boolean;
    FRelationshipAttributesBold: Boolean;
    FShowClassparameterSeparately: Boolean;
    FRoleHidesAttribute: Boolean;
    FClassnameInUppercase: Boolean;
    FUseAbstractForClass: Boolean;
    FUseAbstractForMethods: Boolean;
    FDefaultModifiers: Boolean;
    FShowPublicOnly: Boolean;
    FShowObjectsWithInheritedPrivateAttributes: Boolean;
    FShowObjectsWithMethods: Boolean;
    FObjectLowerCaseLetter: Boolean;
    FShowAllNewObjects: Boolean;
    FObjectsWithoutVisibility: Boolean;
    FPrivateAttributEditable: Boolean;
    FOpenFolderFormItems: string;

    // Restrictions
    FLockedDOSWindow: Boolean;
    FLockedInternet: Boolean;
    FLockedPaths: Boolean;
    FLockedStructogram: Boolean;
    FUsePredefinedLayouts: Boolean;

    // Associations
    FAdditionalAssociations: string;

    // LLM assistant & chat
    FProviders: TLLMProvidersClass;
    FChatProviders: TLLMProvidersClass;

    // Visibility
    FVisProgram: string;
    FVisTkinter: string;
    FVisTTK: string;
    FVisQtBase: string;
    FVisQtControls: string;
    FVisTabs: string;
    FVisMenus: string;
    FVisToolbars: string;
    FVisFileMenu: string;
    FVisEditMenu: string;
    FVisSearchMenu: string;
    FVisViewMenu: string;
    FVisProjectMenu: string;
    FVisRunMenu: string;
    FVisUMLMenu: string;
    FVisToolsMenu: string;
    FVisHelpMenu: string;
    FVisMainToolbar: string;
    FVisDebugToolbar: string;
    FVisEditToolbar: string;
    FVisUMLToolbar: string;
    FVisStructoToolbar: string;
    FVisSequenceToolbar: string;

    // Git
    FGitFolder: string;
    FGitLocalRepository: string;
    FGitRemoteRepository: string;
    FGitUserName: string;
    FGitUserEMail: string;

    // Subversion
    FSVNFolder: string;
    FSVNRepository: string;

    // TextDiff
    FTextDiffState: string;
    FTextDiffIgnoreCase: Boolean;
    FTextDiffIgnoreBlanks: Boolean;

    // Browser
    FBrowserURLs: string;
    FCBWidth: Integer;
    FUseIEinternForDocuments: Boolean;
    FOnlyOneBrowserWindow: Boolean;
    FBrowserTitle: string;
    FOpenBrowserShortcut: string;
    FBrowserProgram: string;

    // comment
    FLicence: string;
    FAuthor: string;

    // others
    FSourcepath: string;
    FTempDir: string;

    // Fonts
    FUMLFont: TFont;
    FStructogramFont: TFont;
    FSequenceFont: TFont;
    FInspectorFont: TFont;
    FStructureFont: TFont;

    procedure SetUMLFont(Value: TFont);
    procedure SetStructogramFont(Value: TFont);
    procedure SetSequenceFont(Value: TFont);
    procedure SetInspectorFont(Value: TFont);
    procedure SetStructureFont(Value: TFont);
  public
    constructor Create;
    destructor Destroy; override;
    procedure RemovePortableDrives;
    procedure AddPortableDrives;
  published
    // Color themes
    property ColorTheme: string read FColorTheme write FColorTheme;

    // Class modeler
    property ShowGetSetMethods: Boolean read FShowGetSetMethods
      write FShowGetSetMethods;
    property GetSetMethodsAsProperty: Boolean read FGetSetMethodsAsProperty
      write FGetSetMethodsAsProperty;
    property SetMethodChecked: Boolean read FSetMethodChecked
      write FSetMethodChecked;
    property GetMethodChecked: Boolean read FGetMethodChecked
      write FGetMethodChecked;
    property ShowAttributeTypeSelection: Boolean read FShowAttributeTypeSelection
      write FShowAttributeTypeSelection;
    property ShowWithWithoutReturnValue: Boolean
      read FShowWithWithoutReturnValue write FShowWithWithoutReturnValue;
    property ShowMethodTypeSelection: Boolean read FShowMethodTypeSelection
      write FShowMethodTypeSelection;
    property ShowParameterTypeSelection: Boolean
      read FShowParameterTypeSelection write FShowParameterTypeSelection;
    property FromFutureImport: Boolean read FFromFutureImport
      write FFromFutureImport;

    // GUI designer
    property NameFromText: Boolean read FNameFromText write FNameFromText;
    property GuiDesignerHints: Boolean read FGuiDesignerHints
      write FGuiDesignerHints;
    property SnapToGrid: Boolean read FSnapToGrid write FSnapToGrid;
    property GridSize: Integer read FGridSize write FGridSize;
    property ZoomSteps: Integer read FZoomSteps write FZoomSteps;
    property GuiFontSize: Integer read FGUIFontSize write FGUIFontSize;
    property GuiFontName: string read FGUIFontName write FGUIFontName;
    property FrameWidth: Integer read FFrameWidth write FFrameWidth;
    property FrameHeight: Integer read FFrameHeight write FFrameHeight;

    // structogram
    property StructoDatatype: string read FStructoDatatype
      write FStructoDatatype;
    property SwitchWithCaseLine: Boolean read FSwitchWithCaseLine
      write FSwitchWithCaseLine;
    property CaseCount: Integer read FCaseCount write FCaseCount;
    property StructogramShadowWidth: Integer read FStructogramShadowWidth
      write FStructogramShadowWidth;
    property StructogramShadowIntensity: Integer
      read FStructogramShadowIntensity write FStructogramShadowIntensity;

    // sequence diagram
    property SDFillingColor: TColor read FSDFillingColor write FSDFillingColor;
    property SDNoFilling: Boolean read FSDNoFilling write FSDNoFilling;
    property SDShowMainCall: Boolean read FSDShowMainCall write FSDShowMainCall;
    property SDShowParameter: Boolean read FSDShowParameter
      write FSDShowParameter;
    property SDShowReturn: Boolean read FSDShowReturn write FSDShowReturn;

    // UML design
    property ValidClassColor: TColor read FValidClassColor
      write FValidClassColor;
    property InvalidClassColor: TColor read FInvalidClassColor
      write FInvalidClassColor;
    property ClassHead: Integer read FClassHead write FClassHead;
    property ShadowWidth: Integer read FShadowWidth write FShadowWidth;
    property ShadowIntensity: Integer read FShadowIntensity
      write FShadowIntensity;
    property ObjectColor: TColor read FObjectColor write FObjectColor;
    property ObjectHead: Integer read FObjectHead write FObjectHead;
    property ObjectFooter: Integer read FObjectFooter write FObjectFooter;
    property ObjectCaption: Integer read FObjectCaption write FObjectCaption;
    property ObjectUnderline: Boolean read FObjectUnderline
      write FObjectUnderline;
    property CommentColor: TColor read FCommentColor write FCommentColor;
    property DiVisibilityFilter: Integer read FDiVisibilityFilter
      write FDiVisibilityFilter;
    property DiSortOrder: Integer read FDiSortOrder write FDiSortOrder;
    property DiShowParameter: Integer read FDiShowParameter
      write FDiShowParameter;
    property DiShowIcons: Integer read FDiShowIcons write FDiShowIcons;

    // UML options
    property ShowEmptyRects: Boolean read FShowEmptyRects write FShowEmptyRects;
    property IntegerInsteadofInt: Boolean read FIntegerInsteadofInt
      write FIntegerInsteadofInt;
    property ConstructorWithVisibility: Boolean read FConstructorWithVisibility
      write FConstructorWithVisibility;
    property RelationshipAttributesBold: Boolean
      read FRelationshipAttributesBold write FRelationshipAttributesBold;
    property ShowClassparameterSeparately: Boolean
      read FShowClassparameterSeparately write FShowClassparameterSeparately;
    property RoleHidesAttribute: Boolean read FRoleHidesAttribute
      write FRoleHidesAttribute;
    property ClassnameInUppercase: Boolean read FClassnameInUppercase
      write FClassnameInUppercase;
    property UseAbstractForClass: Boolean read FUseAbstractForClass
      write FUseAbstractForClass;
    property UseAbstractForMethods: Boolean read FUseAbstractForMethods
      write FUseAbstractForMethods;
    property DefaultModifiers: Boolean read FDefaultModifiers
      write FDefaultModifiers;
    property ShowPublicOnly: Boolean read FShowPublicOnly write FShowPublicOnly;
    property ShowObjectsWithInheritedPrivateAttributes: Boolean
      read FShowObjectsWithInheritedPrivateAttributes
      write FShowObjectsWithInheritedPrivateAttributes;
    property ShowObjectsWithMethods: Boolean read FShowObjectsWithMethods
      write FShowObjectsWithMethods;
    property ObjectLowerCaseLetter: Boolean read FObjectLowerCaseLetter
      write FObjectLowerCaseLetter;
    property ShowAllNewObjects: Boolean read FShowAllNewObjects
      write FShowAllNewObjects;
    property ObjectsWithoutVisibility: Boolean read FObjectsWithoutVisibility
      write FObjectsWithoutVisibility;
    property PrivateAttributEditable: Boolean read FPrivateAttributEditable
      write FPrivateAttributEditable;
    property OpenFolderFormItems: string read FOpenFolderFormItems
      write FOpenFolderFormItems;

    // restrictions
    property LockedDOSWindow: Boolean read FLockedDOSWindow
      write FLockedDOSWindow;
    property LockedInternet: Boolean read FLockedInternet write FLockedInternet;
    property LockedPaths: Boolean read FLockedPaths write FLockedPaths;
    property LockedStructogram: Boolean read FLockedStructogram
      write FLockedStructogram;
    property UsePredefinedLayouts: Boolean read FUsePredefinedLayouts
      write FUsePredefinedLayouts;

    // Associations
    property AdditionalAssociations: string read FAdditionalAssociations
      write FAdditionalAssociations;

    // Providers
    property Providers: TLLMProvidersClass read FProviders write FProviders;
    property ChatProviders: TLLMProvidersClass read FChatProviders
      write FChatProviders;

    // Visibility
    property VisTabs: string read FVisTabs write FVisTabs;
    property VisMenus: string read FVisMenus write FVisMenus;
    property VisToolbars: string read FVisToolbars write FVisToolbars;

    property VisProgram: string read FVisProgram write FVisProgram;
    property VisTkinter: string read FVisTkinter write FVisTkinter;
    property VisTTK: string read FVisTTK write FVisTTK;
    property VisQtBase: string read FVisQtBase write FVisQtBase;
    property VisQtControls: string read FVisQtControls write FVisQtControls;

    property VisFileMenu: string read FVisFileMenu write FVisFileMenu;
    property VisEditMenu: string read FVisEditMenu write FVisEditMenu;
    property VisSearchMenu: string read FVisSearchMenu write FVisSearchMenu;
    property VisViewMenu: string read FVisViewMenu write FVisViewMenu;
    property VisProjectMenu: string read FVisProjectMenu write FVisProjectMenu;
    property VisRunMenu: string read FVisRunMenu write FVisRunMenu;
    property VisUMLMenu: string read FVisUMLMenu write FVisUMLMenu;
    property VisToolsMenu: string read FVisToolsMenu write FVisToolsMenu;
    property VisHelpMenu: string read FVisHelpMenu write FVisHelpMenu;

    property VisMainToolbar: string read FVisMainToolbar write FVisMainToolbar;
    property VisDebugToolbar: string read FVisDebugToolbar
      write FVisDebugToolbar;
    property VisEditToolbar: string read FVisEditToolbar write FVisEditToolbar;
    property VisUMLToolbar: string read FVisUMLToolbar write FVisUMLToolbar;
    property VisStructoToolbar: string read FVisStructoToolbar
      write FVisStructoToolbar;
    property VisSequenceToolbar: string read FVisSequenceToolbar
      write FVisSequenceToolbar;

    // Git
    property GitFolder: string read FGitFolder write FGitFolder;
    property GitLocalRepository: string read FGitLocalRepository
      write FGitLocalRepository;
    property GitRemoteRepository: string read FGitRemoteRepository
      write FGitRemoteRepository;
    property GitUserName: string read FGitUserName write FGitUserName;
    property GitUserEMail: string read FGitUserEMail write FGitUserEMail;

    // Subversion
    property SVNFolder: string read FSVNFolder write FSVNFolder;
    property SVNRepository: string read FSVNRepository write FSVNRepository;

    // TextDiff
    property TextDiffState: string read FTextDiffState write FTextDiffState;
    property TextDiffIgnoreCase: Boolean read FTextDiffIgnoreCase
      write FTextDiffIgnoreCase;
    property TextDiffIgnoreBlanks: Boolean read FTextDiffIgnoreBlanks
      write FTextDiffIgnoreBlanks;

    // Browser
    property UseIEinternForDocuments: Boolean read FUseIEinternForDocuments
      write FUseIEinternForDocuments;
    property OnlyOneBrowserWindow: Boolean read FOnlyOneBrowserWindow
      write FOnlyOneBrowserWindow;
    property BrowserTitle: string read FBrowserTitle write FBrowserTitle;
    property OpenBrowserShortcut: string read FOpenBrowserShortcut
      write FOpenBrowserShortcut;
    property BrowserProgram: string read FBrowserProgram write FBrowserProgram;

    // Comment
    property Author: string read FAuthor write FAuthor;
    property Licence: string read FLicence write FLicence;

    // Others
    property Sourcepath: string read FSourcepath write FSourcepath;
    property TempDir: string read FTempDir write FTempDir;

    // Fonts
    property UMLFont: TFont read FUMLFont write SetUMLFont;
    property StructogramFont: TFont read FStructogramFont
      write SetStructogramFont;
    property SequenceFont: TFont read FSequenceFont write SetSequenceFont;
    property InspectorFont: TFont read FInspectorFont write SetInspectorFont;
    property StructureFont: TFont read FStructureFont write SetStructureFont;
  end;

  TGuiPyLanguageOptions = class(TInterfacedPersistent)
  private
    // Structogram
    FAlgorithm: string;
    FInput: string;
    FOutput: string;
    FWhile: string;
    FFor: string;
    FYes: string;
    FNo: string;
    FOther: string;
    // Sequencediagram
    FSDObject: string;
    FSDNew: string;
    FSDClose: string;
  public
    procedure GetInLanguage(const Language: string);
  published
    property Algorithm: string read FAlgorithm write FAlgorithm;
    property Input: string read FInput write FInput;
    property Output: string read FOutput write FOutput;
    property _While: string read FWhile write FWhile;
    property _For: string read FFor write FFor;
    property Yes: string read FYes write FYes;
    property No: string read FNo write FNo;
    property Other: string read FOther write FOther;

    property SDObject: string read FSDObject write FSDObject;
    property SDNew: string read FSDNew write FSDNew;
    property SDClose: string read FSDClose write FSDClose;
  end;

  { TFConfiguration }

  TArr21StringList = array [1 .. 21] of TStringList;

  TFConfiguration = class(TPyIDEDlgBase)
    PMain: TPanel;
    PButtons: TPanel;
    BSave: TButton;
    BCancel: TButton;
    BDump: TButton;
    BCheck: TButton;
    BHelp: TButton;
    PTitle: TPanel;
    LTitle: TLabel;
    FolderDialog: TFileOpenDialog;
    TVConfiguration: TTreeView;
    PanelRight: TPanel;
    vilTreeImages: TVirtualImageList;
    FontDialog: TFontDialog;
    IDEShortcutsActionList1: TActionList;
    actAssignShortcut: TAction;
    actRemoveShortcut: TAction;
    PTemplatesActionList: TActionList;
    actCodeAddItem: TAction;
    actCodeDeleteItem: TAction;
    actCodeMoveUp: TAction;
    actCodeMoveDown: TAction;
    actCodeUpdateItem: TAction;
    TemplatesVirtualImageList: TVirtualImageList;
    actFileAddItem: TAction;
    actFileDeleteItem: TAction;
    actFileMoveUp: TAction;
    actFileMoveDown: TAction;
    actFileUpdateItem: TAction;
    ColorDialog: TColorDialog;
    actlPythonVersions: TActionList;
    actPVActivate: TAction;
    actPVAdd: TAction;
    actPVRemove: TAction;
    actPVTest: TAction;
    actPVShow: TAction;
    actPVCommandShell: TAction;
    actPVHelp: TAction;
    actPVRename: TAction;
    vilPageSetup: TVirtualImageList;
    icPageSetup: TSVGIconImageCollection;
    ActionListPageSetup: TActionList;
    PageNumCmd: TAction;
    PagesCmd: TAction;
    TimeCmd: TAction;
    DateCmd: TAction;
    TitleCmd: TAction;
    FontCmd: TAction;
    BoldCmd: TAction;
    ItalicCmd: TAction;
    UnderlineCmd: TAction;
    PageList: TPageControl;
    PPython: TTabSheet;
    vtPythonVersions: TVirtualStringTree;
    BPythonActivate: TButton;
    BPythonAdd: TButton;
    BPythonRemove: TButton;
    RGEngineTypes: TRadioGroup;
    PInterpreter: TTabSheet;
    LInterpreterHistorySize: TLabel;
    LTimeOut: TLabel;
    CBAlwaysUseSockets: TCheckBox;
    CBClearOutputBeforeRun: TCheckBox;
    CBInternalInterpreterHidden: TCheckBox;
    CBJumpToErrorOnException: TCheckBox;
    CBMaskFPUExceptions: TCheckBox;
    CBPostMortemOnException: TCheckBox;
    CBPrettyPrintOutput: TCheckBox;
    CBReinitializeBeforeRun: TCheckBox;
    CBSaveEnvironmentBeforeRun: TCheckBox;
    CBSaveFilesBeforeRun: TCheckBox;
    CBSaveInterpreterHistory: TCheckBox;
    CBTraceOnlyIntoOpenFiles: TCheckBox;
    UDInterpreterHistorySize: TUpDown;
    EInterpreterHistorySize: TEdit;
    UDTimeOut: TUpDown;
    ETimeOut: TEdit;
    PEditor: TTabSheet;
    PDisplay: TTabSheet;
    gbGutter: TGroupBox;
    lGutterColor: TLabel;
    pnlGutterFontDisplay: TPanel;
    lblGutterFont: TLabel;
    CBGutterColor: TSpTBXColorEdit;
    ckGutterAutosize: TCheckBox;
    ckGutterShowLineNumbers: TCheckBox;
    ckGutterShowLeaderZeros: TCheckBox;
    ckGutterVisible: TCheckBox;
    ckGutterStartAtZero: TCheckBox;
    CBGutterFont: TCheckBox;
    ckGutterGradient: TCheckBox;
    btnGutterFont: TButton;
    gbLineSpacing: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    eLineSpacing: TEdit;
    eTabWidth: TEdit;
    gbRightEdge: TGroupBox;
    Label3: TLabel;
    Label10: TLabel;
    eRightEdge: TEdit;
    cbRightEdgeColor: TSpTBXColorEdit;
    gbBookmarks: TGroupBox;
    ckBookmarkKeys: TCheckBox;
    ckBookmarkVisible: TCheckBox;
    gbActiveLineColor: TGroupBox;
    CBActiveLineColor: TSpTBXColorEdit;
    gbEditorFont: TGroupBox;
    Panel3: TPanel;
    labFont: TLabel;
    btnFont: TButton;
    POptions1: TTabSheet;
    CBAutoCompleteBrackets: TCheckBox;
    CBAutoHideFindToolbar: TCheckBox;
    CBAutoReloadChangedFiles: TCheckBox;
    CBCheckSyntaxAsYouType: TCheckBox;
    CBCodeFoldingEnabled: TCheckBox;
    CBCompactLineNumbers: TCheckBox;
    CBCreateBackupFiles: TCheckBox;
    CBDetectUTF8Encoding: TCheckBox;
    CBDisplayPackageNames: TCheckBox;
    CBHighlightSelectedWord: TCheckBox;
    CBMarkExecutableLines: TCheckBox;
    CBSearchTextAtCaret: TCheckBox;
    CBShowCodeHints: TCheckBox;
    CBShowDebuggerHints: TCheckBox;
    CBTrimTrailingSpacesOnSave: TCheckBox;
    CBUndoAfterSave: TCheckBox;
    CBHighlightSelectedWordColor: TColorBox;
    RGNewFileEncoding: TRadioGroup;
    RGNewFileLineBreaks: TRadioGroup;
    POptions2: TTabSheet;
    LAuthor: TLabel;
    gbOptions: TGroupBox;
    GridPanel1: TGridPanel;
    StackPanel1: TStackPanel;
    ckAutoIndent: TCheckBox;
    ckRightMouseMoves: TCheckBox;
    ckDragAndDropEditing: TCheckBox;
    ckEnhanceEndKey: TCheckBox;
    ckEnhanceHomeKey: TCheckBox;
    ckTabsToSpaces: TCheckBox;
    ckKeepCaretX: TCheckBox;
    ckSmartTabDelete: TCheckBox;
    ckTabIndent: TCheckBox;
    ckSmartTabs: TCheckBox;
    StackPanel2: TStackPanel;
    ckHalfPageScroll: TCheckBox;
    ckScrollByOneLess: TCheckBox;
    ckShowSpecialChars: TCheckBox;
    ckScrollPastEOF: TCheckBox;
    ckDisableScrollArrows: TCheckBox;
    ckScrollPastEOL: TCheckBox;
    ckShowScrollHint: TCheckBox;
    ckHideShowScrollbars: TCheckBox;
    ckScrollHintFollows: TCheckBox;
    ckShowLigatures: TCheckBox;
    EAuthor: TEdit;
    PCodeCompletion: TTabSheet;
    LCodeCompletionListSize: TLabel;
    LSpecialPackages: TLabel;
    CBCompletionCaseSensitive: TCheckBox;
    CBCompleteAsYouType: TCheckBox;
    CBCompleteKeywords: TCheckBox;
    CBCompleteWithOneEntry: TCheckBox;
    CBCompleteWithWordBreakChars: TCheckBox;
    CBEditorCodeCompletion: TCheckBox;
    CBInterpreterCodeCompletion: TCheckBox;
    ECodeCompletionListSize: TEdit;
    ESpecialPackages: TEdit;
    BCodeCompletionFont: TButton;
    UDCodeComletionListSize: TUpDown;
    PKeystrokes: TTabSheet;
    gbKeyStrokes: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    cKeyCommand: TComboBox;
    btnRemKey: TButton;
    btnAddKey: TButton;
    btnUpdateKey: TButton;
    Panel2: TPanel;
    KeyList: TListView;
    PSyntaxColors: TTabSheet;
    Label13: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    CBHighlighters: TComboBox;
    GroupBox1: TGroupBox;
    cbxElementBold: TCheckBox;
    cbxElementItalic: TCheckBox;
    cbxElementUnderline: TCheckBox;
    cbxElementStrikeout: TCheckBox;
    CBElementBackground: TSpTBXColorEdit;
    CBElementForeground: TSpTBXColorEdit;
    SynSyntaxSample: TSynEdit;
    lbElements: TSpTBXListBox;
    PColorTheme: TTabSheet;
    SpTBXLabel1: TLabel;
    SpTBXLabel2: TLabel;
    lbColorThemes: TListBox;
    SynThemeSample: TSynEdit;
    PCodeTemplates: TTabSheet;
    GroupBox: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    CodeSynTemplate: TSynEdit;
    edDescription: TEdit;
    edShortcut: TEdit;
    CodeTemplatesLvItems: TListView;
    btnAdd: TButton;
    btnDelete: TButton;
    btnMoveDown: TButton;
    btnMoveup: TButton;
    btnUpdate: TButton;
    PFileTemplates: TTabSheet;
    FileTemplatesLvItems: TListView;
    GroupBox3: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    FileSynTemplate: TSynEdit;
    CBFileTemplatesHighlighter: TComboBox;
    edName: TEdit;
    edCategory: TEdit;
    edExtension: TEdit;
    btnFileAdd: TButton;
    btnFileDelete: TButton;
    btnFileDown: TButton;
    btnFileUp: TButton;
    btnFileUpdate: TButton;
    PGUIDesigner: TTabSheet;
    LGridSize: TLabel;
    LFrameheight: TLabel;
    LFrameWidth: TLabel;
    CBNameFromText: TCheckBox;
    CBGuiDesignerHints: TCheckBox;
    CBSnapToGrid: TCheckBox;
    EGridSize: TEdit;
    UDGridSize: TUpDown;
    EFrameHeight: TEdit;
    EFrameWidth: TEdit;
    PStructogram: TTabSheet;
    LInput: TLabel;
    LOutput: TLabel;
    LAlgorithm: TLabel;
    LWhile: TLabel;
    LFor: TLabel;
    LYes: TLabel;
    LNo: TLabel;
    LDatatype: TLabel;
    LCaseCount: TLabel;
    LOther: TLabel;
    LStructogramShadow: TLabel;
    LStructogramShadowWidth: TLabel;
    LStructogramShadowIntensity: TLabel;
    LIf: TLabel;
    EInput: TEdit;
    EOutput: TEdit;
    EAlgorithm: TEdit;
    EWhile: TEdit;
    EFor: TEdit;
    EYes: TEdit;
    ENo: TEdit;
    CBDataType: TComboBox;
    CBSwitchWithCaseLine: TCheckBox;
    UpDowncaseCount: TUpDown;
    ECaseCount: TEdit;
    EOther: TEdit;
    EStructogramShadowWidth: TEdit;
    UDStructogramShadowWidth: TUpDown;
    EStructogramShadowIntensity: TEdit;
    UDStructogramShadowIntensity: TUpDown;
    PSequencediagram: TTabSheet;
    LSDObject: TLabel;
    LSDNew: TLabel;
    LSDClose: TLabel;
    LSDFilling: TLabel;
    ESDObject: TEdit;
    ESDNew: TEdit;
    ESDClose: TEdit;
    CBSDFillingColor: TColorBox;
    CBSDShowMainCall: TCheckBox;
    CBSDShowParameter: TCheckBox;
    CBSDShowReturn: TCheckBox;
    CBSDNoFilling: TCheckBox;
    PUML: TTabSheet;
    LObjectDesign: TLabel;
    LClassDesign: TLabel;
    LValidClassColor: TLabel;
    LShadowWidth: TLabel;
    LShadowIntensity: TLabel;
    LInvalidClassColor: TLabel;
    LShadow: TLabel;
    LObjectColor: TLabel;
    LCommentDesign: TLabel;
    LAttributesAndMethods: TLabel;
    RGObjectHead: TRadioGroup;
    CBObjectColor: TColorBox;
    RGObjectCaption: TRadioGroup;
    CBObjectUnderline: TCheckBox;
    RGClassHead: TRadioGroup;
    CBValidClassColor: TColorBox;
    EShadowWidth: TEdit;
    UDShadowWidth: TUpDown;
    UDShadowIntensity: TUpDown;
    EShadowIntensity: TEdit;
    CBInvalidClassColor: TColorBox;
    RGObjectFooter: TRadioGroup;
    CBCommentColor: TColorBox;
    RGAttributsMethodsDisplay: TRadioGroup;
    RGSequenceAttributsMethods: TRadioGroup;
    RGParameterDisplay: TRadioGroup;
    RGVisibilityDisplay: TRadioGroup;
    PUML2: TTabSheet;
    GBClassPresentation: TGroupBox;
    CBShowEmptyRects: TCheckBox;
    CBIntegerInsteadofInt: TCheckBox;
    CBShowClassparameterSeparately: TCheckBox;
    CBRoleHidesAttribute: TCheckBox;
    CBConstructorWithVisibility: TCheckBox;
    CBRelationshipAttributesBold: TCheckBox;
    GBObjectPresentation: TGroupBox;
    CBShowObjectsWithMethods: TCheckBox;
    CBShowObjectsWithInheritedPrivateAttributes: TCheckBox;
    CBShowAllNewObjects: TCheckBox;
    CBLowerCaseLetter: TCheckBox;
    CBObjectsWithoutVisibility: TCheckBox;
    GBClassEditing: TGroupBox;
    CBOpenPublicClasses: TCheckBox;
    CBDefaultModifiers: TCheckBox;
    GBObjectEditing: TGroupBox;
    CBUMLEdit: TCheckBox;
    PIDEShortcuts: TTabSheet;
    lblAssignedTo: TLabel;
    lblCurrent: TLabel;
    lblCurrentKeys: TLabel;
    lblNewShortcutKey: TLabel;
    lblCommands: TLabel;
    lblCategories: TLabel;
    btnRemove: TButton;
    btnAssign: TButton;
    lbCurrentKeys: TListBox;
    lbCategories: TListBox;
    lbCommands: TListBox;
    gbDescription: TGroupBox;
    lblDescription: TLabel;
    PBrowser: TTabSheet;
    LBrowser: TLabel;
    LBrowserTitle: TLabel;
    LAltKeysBrowser: TLabel;
    CBUseIEinternForDocuments: TCheckBox;
    CBOnlyOneBrowserWindow: TCheckBox;
    EBrowserProgram: TEdit;
    EBrowserTitle: TEdit;
    CBOpenBrowserShortcut: TComboBox;
    BSelectBrowser: TButton;
    BBrowserTitle: TButton;
    PLanguage: TTabSheet;
    RGLanguages: TRadioGroup;
    PGeneralOptions: TTabSheet;
    LTempFolder: TLabel;
    SBTempSelect: TSpeedButton;
    LNoOfRecentFiles: TLabel;
    LDaysBetweenUpdateChecks: TLabel;
    LDockAnimationInterval: TLabel;
    LDockAnimationMoveWidth: TLabel;
    ETempFolder: TEdit;
    BTempFolder: TButton;
    ENoOfRecentFiles: TEdit;
    UDNoOfRecentFiles: TUpDown;
    CBRestoreOpenFiles: TCheckBox;
    CBRestoreOpenProject: TCheckBox;
    CBShowTabCloseButton: TCheckBox;
    CBSmartNextPrevPage: TCheckBox;
    CBStyleMainWindowBorder: TCheckBox;
    CBAutoCheckForUpdates: TCheckBox;
    EDaysBetweenChecks: TEdit;
    UDDaysBetweenChecks: TUpDown;
    EDockAnimationInterval: TEdit;
    UDDockAnimationInterval: TUpDown;
    UDDockAnimationMoveWidth: TUpDown;
    EDockAnimationMoveWidth: TEdit;
    RGEditorTabPosition: TRadioGroup;
    CBExporerInitiallyExpanded: TCheckBox;
    CBProjectExporerInitiallyExpanded: TCheckBox;
    CBFileExplorerContextMenu: TCheckBox;
    CBFileExplorerBackgroundProcessing: TCheckBox;
    RGFileChangeNotification: TRadioGroup;
    CBMethodsWithComment: TCheckBox;
    CBSaveFilesAutomatically: TCheckBox;
    PStyles: TTabSheet;
    Label43: TLabel;
    Label44: TLabel;
    StylesPreviewPanel: TPanel;
    LBStyleNames: TListBox;
    PPrinter: TTabSheet;
    Image1: TImage;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    CBUnits: TSpTBXComboBox;
    EditLeft: TEdit;
    EditRight: TEdit;
    EditTop: TEdit;
    EditBottom: TEdit;
    EditHeader: TEdit;
    EditGutter: TEdit;
    EditFooter: TEdit;
    EditHFInternalMargin: TEdit;
    EditLeftHFTextIndent: TEdit;
    EditRightHFTextIndent: TEdit;
    CBWrap: TCheckBox;
    CBColors: TCheckBox;
    CBHighlight: TCheckBox;
    CBLineNumbersInMargin: TCheckBox;
    CBLineNumbers: TCheckBox;
    CBMirrorMargins: TCheckBox;
    PHeaderFooter: TTabSheet;
    GroupBox4: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    GroupBox5: TGroupBox;
    PBHeaderLine: TPaintBox;
    PBHeaderShadow: TPaintBox;
    HeaderLineColorBtn: TButton;
    HeaderShadowColorBtn: TButton;
    CBHeaderLine: TCheckBox;
    CBHeaderBox: TCheckBox;
    CBHeaderShadow: TCheckBox;
    CBHeaderMirror: TCheckBox;
    REHeaderLeft: TRichEdit;
    REHeaderCenter: TRichEdit;
    REHeaderRight: TRichEdit;
    GroupBox6: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    GroupBox7: TGroupBox;
    PBFooterLine: TPaintBox;
    PBFooterShadow: TPaintBox;
    FooterLineColorBtn: TButton;
    FooterShadowColorBtn: TButton;
    CBFooterLine: TCheckBox;
    CBFooterBox: TCheckBox;
    CBFooterShadow: TCheckBox;
    CBFooterMirror: TCheckBox;
    REFooterLeft: TRichEdit;
    REFooterCenter: TRichEdit;
    REFooterRight: TRichEdit;
    ToolbarDock: TSpTBXDock;
    Toolbar: TSpTBXToolbar;
    tbiPgNumber: TSpTBXItem;
    tbiPages: TSpTBXItem;
    tbiTime: TSpTBXItem;
    tbiDate: TSpTBXItem;
    tbiTitle: TSpTBXItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    tbiFont: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    tbiBold: TSpTBXItem;
    tbiItalic: TSpTBXItem;
    tbiUdnerline: TSpTBXItem;
    PRestrictions: TTabSheet;
    LRestrictions: TLabel;
    CBLockedInternet: TCheckBox;
    CBLockedPaths: TCheckBox;
    CBLockedDosWindow: TCheckBox;
    CBLockedStructogram: TCheckBox;
    CBUsePredefinedLayouts: TCheckBox;
    PAssociations: TTabSheet;
    LAssociations: TLabel;
    LAdditionalAssociations: TLabel;
    LAssociationsExample: TLabel;
    LJEAssociation: TLabel;
    CBAssociationPython: TCheckBox;
    CBAssociationPfm: TCheckBox;
    CBAssociationHtml: TCheckBox;
    CBAssociationPuml: TCheckBox;
    CBAssociationTxt: TCheckBox;
    CBAssociationJsp: TCheckBox;
    CBAssociationPhp: TCheckBox;
    CBAssociationCss: TCheckBox;
    EAdditionalAssociations: TEdit;
    CBAssociationInc: TCheckBox;
    BFileExtensions: TButton;
    EGuiPyAssociation: TEdit;
    BJEAssociation: TButton;
    CBAssociationPsg: TCheckBox;
    CBAssociationPsd: TCheckBox;
    CBAssociationPyw: TCheckBox;
    PSSH: TTabSheet;
    LScpCommand: TLabel;
    LScpOptions: TLabel;
    LSSHCommand: TLabel;
    LSSHOptions: TLabel;
    CBSSHDisableVariablesWin: TCheckBox;
    EScpCommand: TEdit;
    EScpOptions: TEdit;
    ESSHCommand: TEdit;
    ESSHOptions: TEdit;
    PTools: TTabSheet;
    PGit: TTabSheet;
    LGitFolder: TLabel;
    LLocalRepository: TLabel;
    LUserName: TLabel;
    LRemoteRepository: TLabel;
    LUserEMail: TLabel;
    EGitFolder: TEdit;
    CBLocalRepository: TComboBox;
    BGitFolder: TButton;
    BGitRepository: TButton;
    CBRemoteRepository: TComboBox;
    EUserName: TEdit;
    EUserEMail: TEdit;
    BGitClone: TButton;
    PSubversion: TTabSheet;
    LRepository: TLabel;
    LSVN: TLabel;
    CBRepository: TComboBox;
    BRepository: TButton;
    BSVN: TButton;
    ESVNFolder: TEdit;
    BApplyStyle: TButton;
    CBGUICodeFolding: TCheckBox;
    PClassModeler: TTabSheet;
    GBAttribuesOptions: TGroupBox;
    CBShowGetSetMethods: TCheckBox;
    CBGetSetMethodsAsProperty: TCheckBox;
    CBShowAttributeTypeSelection: TCheckBox;
    GBMethodsOptions: TGroupBox;
    CBShowWithWithoutReturnValue: TCheckBox;
    CBShowParameterTypeSelection: TCheckBox;
    btnResetKeys: TButton;
    LLicence: TLabel;
    ELicence: TEdit;
    btnFileDefaultItem: TButton;
    actFileDefaultItem: TAction;
    btnFileDefaultAll: TButton;
    actFileDefaultAll: TAction;
    CBClassnameInUppercase: TCheckBox;
    GBClassOptions: TGroupBox;
    CBFromFutureImport: TCheckBox;
    PVisibility: TTabSheet;
    LVisTabs: TLabel;
    LVVisibilityTabs: TListView;
    LVVisibilityElements: TListView;
    LVisMenus: TLabel;
    LVVisibilityMenus: TListView;
    LVisToolbars: TLabel;
    LVVisibilityToolbars: TListView;
    BVisDefault: TButton;
    UDIDEFontSize: TUpDown;
    LIDEFontSize: TLabel;
    EIDEFontSize: TEdit;
    lDigits: TLabel;
    EDigits: TEdit;
    BGuiFont: TButton;
    CBGetMethodChecked: TCheckBox;
    CBSetMethodChecked: TCheckBox;
    CBDisplayFlowControl: TCheckBox;
    CBDisplayFlowControlColor: TColorBox;
    ckScrollbarAnnotation: TCheckBox;
    ckTrimTrailingSpaces: TCheckBox;
    CBIndentationGuide: TCheckBox;
    ckGroupUndo: TCheckBox;
    ckWordWrap: TCheckBox;
    EZoomSteps: TEdit;
    UDZoomSteps: TUpDown;
    LZoomsteps: TLabel;
    BGuiFontDefault: TButton;
    LDefault: TLabel;
    PLLMAssistant: TTabSheet;
    PLLMChat: TTabSheet;
    LProvider: TLabel;
    CBProvider: TComboBox;
    LEndpoint: TLabel;
    LModel: TLabel;
    LLLMTimeout: TLabel;
    LAPIKey: TLabel;
    LMaxTokens: TLabel;
    LSystemPrompt: TLabel;
    EEndPoint: TEdit;
    EModel: TEdit;
    EAPIKey: TEdit;
    ELLMTimeout: TEdit;
    EMaxTokens: TEdit;
    ESystemPrompt: TEdit;
    LChatProvider: TLabel;
    CBChatProvider: TComboBox;
    LChatEndPoint: TLabel;
    EChatEndPoint: TEdit;
    LChatModel: TLabel;
    EChatModel: TEdit;
    LChatApiKey: TLabel;
    EChatApiKey: TEdit;
    LChatSystemPrompt: TLabel;
    EChatSystemPrompt: TEdit;
    LChatMaxTokens: TLabel;
    EChatMaxTokens: TEdit;
    LChatTimeout: TLabel;
    EChatTimeout: TEdit;
    CBReinitializeWhenClosing: TCheckBox;
    LLLMTemperature: TLabel;
    ELLMTemperature: TEdit;
    LChatTemperature: TLabel;
    EChatTemperature: TEdit;
    CBAccessibilitySupport: TCheckBox;
    CBLspDebug: TCheckBox;
    CBUseAbstractForClass: TCheckBox;
    CBUseAbstractForMethods: TCheckBox;
    CBShowMethodTypeSelection: TCheckBox;
{$WARNINGS ON}
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BTempFolderClick(Sender: TObject);
    procedure BHelpClick(Sender: TObject);
    procedure BCheckClick(Sender: TObject);
    procedure BDumpClick(Sender: TObject);
    procedure LMouseEnter(Sender: TObject);
    procedure LMouseLeave(Sender: TObject);
    procedure BSVNClick(Sender: TObject);
    procedure BRepositoryClick(Sender: TObject);
    procedure LSVNClick(Sender: TObject);
    procedure SBTempSelectClick(Sender: TObject);
    procedure BFileExtensionsClick(Sender: TObject);
    procedure BJEAssociationClick(Sender: TObject);
    procedure LGitFolderClick(Sender: TObject);
    procedure BGitFolderClick(Sender: TObject);
    procedure BGitRepositoryClick(Sender: TObject);
    procedure BGitCloneClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TVConfigurationChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vtPythonVersionsGetCellText(Sender: TCustomVirtualStringTree;
      var E: TVSTGetCellTextEventArgs);
    procedure vtPythonVersionsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: UITypes.TImageIndex);
    procedure vtPythonVersionsInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vtPythonVersionsInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure actPVActivateExecute(Sender: TObject);
    procedure actPVAddExecute(Sender: TObject);
    procedure actPVRemoveExecute(Sender: TObject);
    procedure actlPythonVersionsUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure actPVCommandShellExecute(Sender: TObject);
    procedure BCodeCompletionFontClick(Sender: TObject);
    procedure CBHighlightersChange(Sender: TObject);
    procedure cbFileTemplatesHighlightersChange(Sender: TObject);
    procedure lbElementsClick(Sender: TObject);
    procedure SynSyntaxSampleClick(Sender: TObject);
    procedure CBElementForegroundSelectedColorChanged(Sender: TObject);
    procedure CBElementBackgroundSelectedColorChanged(Sender: TObject);
    procedure cbxElementBoldClick(Sender: TObject);
    procedure lbColorThemesClick(Sender: TObject);
    procedure btnUpdateKeyClick(Sender: TObject);
    procedure btnAddKeyClick(Sender: TObject);
    procedure btnRemKeyClick(Sender: TObject);
    procedure cKeyCommandKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFontClick(Sender: TObject);
    procedure btnGutterFontClick(Sender: TObject);
    procedure CBGutterFontClick(Sender: TObject);
    procedure actAssignShortcutExecute(Sender: TObject);
    procedure actAssignShortcutUpdate(Sender: TObject);
    procedure actRemoveShortcutExecute(Sender: TObject);
    procedure actRemoveShortcutUpdate(Sender: TObject);
    procedure lbCategoriesClick(Sender: TObject);
    procedure lbCommandsClick(Sender: TObject);
    procedure CodeTemplatesLvItemsDeletion(Sender: TObject; Item: TListItem);
    procedure CodeTemplatesLvItemsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PTemplatesActionListUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure edShortcutKeyPress(Sender: TObject; var Key: Char);
    procedure FileTemplatesLvItemsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure CBFileTemplatesHighlighterChange(Sender: TObject);
    procedure actCodeAddItemExecute(Sender: TObject);
    procedure actCodeDeleteItemExecute(Sender: TObject);
    procedure actCodeMoveUpExecute(Sender: TObject);
    procedure actCodeMoveDownExecute(Sender: TObject);
    procedure actCodeUpdateItemExecute(Sender: TObject);
    procedure actFileAddItemExecute(Sender: TObject);
    procedure actFileDeleteItemExecute(Sender: TObject);
    procedure actFileMoveUpExecute(Sender: TObject);
    procedure actFileMoveDownExecute(Sender: TObject);
    procedure actFileUpdateItemExecute(Sender: TObject);
    procedure CBUnitsChange(Sender: TObject);
    procedure PageNumCmdExecute(Sender: TObject);
    procedure PagesCmdExecute(Sender: TObject);
    procedure TimeCmdExecute(Sender: TObject);
    procedure DateCmdExecute(Sender: TObject);
    procedure TitleCmdExecute(Sender: TObject);
    procedure FontCmdExecute(Sender: TObject);
    procedure BoldCmdExecute(Sender: TObject);
    procedure ItalicCmdExecute(Sender: TObject);
    procedure UnderlineCmdExecute(Sender: TObject);
    procedure REHeaderLeftEnter(Sender: TObject);
    procedure REHeaderLeftSelectionChange(Sender: TObject);
    procedure PBHeaderLinePaint(Sender: TObject);
    procedure HeaderLineColorBtnClick(Sender: TObject);
    procedure HeaderShadowColorBtnClick(Sender: TObject);
    procedure FooterLineColorBtnClick(Sender: TObject);
    procedure FooterShadowColorBtnClick(Sender: TObject);
    procedure LBStyleNamesClick(Sender: TObject);
    procedure ActionApplyStyleExecute(Sender: TObject);
    procedure actPVTestExecute(Sender: TObject);
    procedure actPVShowExecute(Sender: TObject);
    procedure actPVHelpExecute(Sender: TObject);
    procedure actPVRenameExecute(Sender: TObject);
    procedure BSelectBrowserClick(Sender: TObject);
    procedure BBrowserTitleClick(Sender: TObject);
    procedure BApplyStyleClick(Sender: TObject);
    procedure RGLanguagesClick(Sender: TObject);
    procedure btnResetKeysClick(Sender: TObject);
    procedure actFileDefaultItemExecute(Sender: TObject);
    procedure actFileDefaultAllExecute(Sender: TObject);
    procedure BVisDefaultClick(Sender: TObject);
    procedure LVVisibilityElementsItemChecked(Sender: TObject; Item: TListItem);
    procedure LVVisibilityMenusClick(Sender: TObject);
    procedure LVVisibilityTabsClick(Sender: TObject);
    procedure LVVisibilityToolbarsClick(Sender: TObject);
    procedure ckGutterAutosizeClick(Sender: TObject);
    procedure BGuiFontClick(Sender: TObject);
    procedure BGuiFontDefaultClick(Sender: TObject);
    procedure CBProviderSelect(Sender: TObject);
    procedure CBProviderDropDown(Sender: TObject);
    procedure CBChatProviderDropDown(Sender: TObject);
    procedure CBChatProviderSelect(Sender: TObject);
  private const
    DefaultVisFileMenu = '11100111011101011'; // len = 17
    DefaultVisEditMenu = '111110011110001'; // len = 15
    DefaultVisSearchMenu = '100101111111011'; // len = 15
    DefaultVisViewMenu = '110011000111111111111111'; // len = 22 + 2
    DefaultVisProjectMenu = '111111'; // len = 6
    DefaultVisRunMenu = '01111011111111111'; // len = 17
    DefaultVisUMLMenu = '11111111111'; // len = 11
    DefaultVisToolsMenu = '11101111111110001'; // len = 17
    DefaultVisHelpMenu = '11111'; // len = 5

  var
    FVisSelectedTabMenuToolbar: Integer;
    FHighlighters: TList;
    FColorThemeHighlighter: TSynCustomHighlighter;
    FHighlighterFileDir: string;
    FSynEdit: TSynEditorOptionsContainer;
    FEKeyShort1: TSynHotKey;
    FEKeyShort2: TSynHotKey;
    FUserCommand: TSynEditorOptionsUserCommand;
    FAllUserCommands: TSynEditorOptionsAllUserCommands;
    FExtended: Boolean;
    FEdNewShortcut: TSynHotKey;
    FInternalCall: Boolean;
    FMargins: TSynEditPrintMargins;
    FEditor: TCustomRichEdit;
    FHeaderFooterCharPos: TPoint;
    FHeaderFooterOldStart: Integer;

    FFunctionList: TStringList;
    FIDEKeyList: TStringList;
    FActionProxyCollection: TActionProxyCollection;
    FCodeTemplateText: string;
    FControlStructureTemplates: TArr21StringList;
    FTempFileTemplates: TFileTemplates;

    FLoading: Boolean;
    FStylesPath: string;
    FPreview: TVclStylesPreview;
    FExternalStyleFilesDict: TDictionary<string, string>;
    FLoadedStylesDict: TDictionary<string, string>;

    FHandleChanges: Boolean;
    // Normally true, can prevent unwanted execution of event handlers
    FIndentWidth: Integer;
    FCurrentLanguage: string;
    FEditorFolder: string;
    FGitOK: Boolean;

    // tab LLM assistant
    FTempProviders: TLLMProviders;
    FTempChatProviders: TLLMProviders;

    // tab Visibility
    FVis1: array [0 .. MaxVisLen - 1, 0 .. MaxTabItem - 1] of Boolean;
    FVis2: array [0 .. MaxVisLen - 1, 0 .. MaxTabItem - 1] of Boolean;
    FTabsMenusToolbars: Integer;
    FIndent1: string;
    FIndent2: string;
    FIndent3: string;
    FKeyStrokesReset: Boolean;
    FSubversionOK: Boolean;
    FVisMenus: TBoolArray;
    FVisTabs: TBoolArray;
    FVisToolbars: TBoolArray;

    function DirectoryFilesExists(Str: string): Boolean;
    procedure CheckFolder(Edit: TEdit; EmptyAllowed: Boolean);
    procedure CheckFolderCB(ComboBox: TComboBox);
    procedure CheckUserFolder(Edit: TEdit);
    procedure CheckFile(WinControl: TWinControl; EmptyAllowed: Boolean);
    function GetCheckColor(const Filename: string;
      EmptyAllowed: Boolean): TColor;
    procedure ShortenPath(WinControl: TWinControl; const Path: string);
    function ExtendPath(WinControl: TWinControl): string;
    function BrowserProgToName(const Browsername: string): string;

    function SelectedHighlighter: TSynCustomHighlighter;
    procedure UpdateColorFontStyle;
    procedure PrepareHighlighters;
    procedure UpdateHighlighters;
    procedure UpdateKey(AKey: TSynEditKeyStroke);
    procedure FillInKeystrokeInfo(AKey: TSynEditKeyStroke; AItem: TListItem);
    procedure PrepareKeyStrokes;
    procedure KeyListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure EditStrCallback(const Str: string);
    procedure SynEditOptionsShow;
    function GetCurrentAction: TActionProxyItem;
    procedure AssignKeysToActionProxy(var CurAction: TActionProxyItem);
    procedure SelectItem(Idx: Integer);
    procedure CustomShortcutsCreate;
    procedure CustomShortcutsShow;
    procedure SetCategories;
    procedure DoneItems;
    procedure PrepActions;
    procedure FillFunctionList;
    procedure CodeTemplatesInit;
    procedure CodeTemplatesSetItems;
    procedure CodeTemplatesGetItems;
    procedure PageListClose;
    procedure FileTemplatesInit;
    procedure FileTemplatesSetItems;
    procedure FileTemplatesGetItems;
    procedure StoreFieldsToFileTemplate(FileTemplate: TFileTemplate);
    procedure SetMargins(SynEditMargins: TSynEditPrintMargins);
    procedure GetMargins(SynEditMargins: TSynEditPrintMargins);
    procedure SelectLine(LineNum: Integer);
    function CurrText: TTextAttributes;
    procedure SelectNone;
    procedure SetHeaderFooterOptions;
    procedure UpdateHeaderFooterCursorPos;
    procedure PageSetupShow;
    procedure AddLines(HeadFoot: THeaderFooter; AEdit: TCustomRichEdit;
      Alig: TAlignment);
    procedure GetValues(SynEditPrint: TSynEditPrint);
    procedure SetValues(SynEditPrint: TSynEditPrint);
    procedure StyleSelectorFormCreate;
    procedure StyleSelectorFormShow;
    procedure FillVclStylesList;

    procedure ModelToView;
    procedure ViewToModel;
    procedure CheckAllFilesAndFolders;
    procedure LockButtons;

    procedure MakeAssociations;
    procedure RegisterGuiPy;
    procedure ShowPage(Page: Integer);
    function FolderSelect(Edit: TEdit; const Foldername: string): string;
    function GetConfigurationAddress(const Str: string): string;
    function GetDumpText: string;

    procedure CallUpdater(const Target, Source1: string;
      Source2: string); overload;
    procedure SetElevationRequiredState(Control: TWinControl);
    procedure MakeControlStructureTemplates;
    procedure EnableColorItems(Enable: Boolean);
    procedure StoreApplicationData;

    procedure LoadVisibility;
    procedure SaveVisibility;
    procedure SetVisibility;
    procedure PrepareVisibilityPage;
    procedure VisibilityViewToModel;
    procedure VisibilityModelToView;
    function CountMenuItems(Menu: TTBCustomItem): Integer;
    procedure SetSpTBXToolbarVisibility(Toolbar: TSpTBXToolbar; Num: Integer);
    procedure LLMAssistantModelToView;
    procedure LLMAssistantViewToModel;
    procedure LLMChatModelToView;
    procedure LLMChatViewToModel;
  public
    class var CurrentSkinName: string;

    procedure Changed;
    procedure RestoreApplicationData;
    procedure SetToolbarVisibility(Toolbar: TToolBar; Num: Integer);
    function GetEncoding(const Pathname: string): TEncoding;
    procedure PrepareShow;
    function GetMultiLineComment(const Indent: string): string;
    function GetClassCodeTemplate: string;
    function GetTVConfigurationItem(const Text: string): TTreeNode;
    function GetFileFilters: string;
    procedure OpenAndShowPage(const Page: string);
    function RunAsAdmin(AHWnd: HWND; const AFile, Parameters: string): Boolean;
    procedure AddScriptsPath;
    procedure PatchConfiguration;
    procedure LanguageOptionsToView;
    procedure LanguageOptionsToModel;
    procedure DoHelp(Adresse: string);
    function GetClassesAndFilename(const Pathname: string): TStringList;
    procedure SetStyle(const StyleName: string);
    procedure ApplyColorTheme;
    procedure Retranslate;
    class function IsDark: Boolean;

    property ControlStructureTemplates: TArr21StringList
      read FControlStructureTemplates;
    property GetUserCommandNames: TSynEditorOptionsUserCommand read FUserCommand
      write FUserCommand;
    property GetAllUserCommands: TSynEditorOptionsAllUserCommands
      read FAllUserCommands write FAllUserCommands;
    property CurrentAction: TActionProxyItem read GetCurrentAction;
    property EditorFolder: string read FEditorFolder;
    property GitOK: Boolean read FGitOK;
    property Indent1: string read FIndent1;
    property Indent2: string read FIndent2;
    property Indent3: string read FIndent3;
    property KeyStrokesReset: Boolean read FKeyStrokesReset;
    property SubversionOK: Boolean read FSubversionOK;
    property VisMenus: TBoolArray read FVisMenus;
    property VisTabs: TBoolArray read FVisTabs;
    property VisToolbars: TBoolArray read FVisToolbars;
  end;

var
  FConfiguration: TFConfiguration = nil;
  GuiPyOptions: TGuiPyOptions = nil;
  GuiPyLanguageOptions: TGuiPyLanguageOptions = nil;

implementation

{$R *.DFM}

uses
  Forms,
  Math,
  Menus,
  ShlObj,
  Themes,
  ShellAPI,
  FileCtrl,
  Contnrs,
  Registry,
  IOUtils,
  Winapi.RichEdit,
  System.RegularExpressions,
  JvJCLUtils,
  JvGnugettext,
  JvAppStorage,
  JvAppIniStorage,
  SynUnicode,
  SynEditTypes,
  SynEditPrintTypes,
  SynEditKeyConst,
  SpTBXTabs,
  dmResources,
  dmCommands,
  cPyScripterSettings,
  cPyControl,
  JediLspClient,
  uEditAppIntfs,
  PythonVersions,
  StringResources,
  uCommonFunctions,
  cPySupportTypes,
  frmPyIDEMain,
  frmFile,
  frmEditor,
  frmPythonII,
  frmLLMChat,
  UUtils,
  UUMLForm,
  UStructogram,
  USequenceForm,
  UGit,
  USubversion;

const MaxPages = 33; CMachine = 0; CAllUsers = 1; CUser = 2;

  { --- TEditStyleHook ----------------------------------------------------------- }

constructor TEditStyleHookColor.Create(AControl: TWinControl);
begin
  inherited;
  // call the UpdateColors method to use the custom colors
  UpdateColors;
end;

// Here you set the colors of the style hook
procedure TEditStyleHookColor.UpdateColors;
begin
  if Control.Enabled then
  begin
    if TWinControlH(Control).Color = clRed then
    begin
      Brush.Color := clRed;
      FontColor := StyleServices.GetStyleFontColor(sfEditBoxTextDisabled);
      // use the Control font color
    end
    else
      Brush.Color := StyleServices.GetStyleColor(scEdit);
    // use the Control color
    // FontColor := StyleServices.GetStyleFontColor(sfEditBoxTextDisabled); // use the Control font color
  end
  else
  begin
    // if the control is disabled use the colors of the style
    Brush.Color := StyleServices.GetStyleColor(scEditDisabled);
    // scEditDisabled
    FontColor := StyleServices.GetStyleFontColor(sfEditBoxTextDisabled);
  end;
end;

// handle the messages
procedure TEditStyleHookColor.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX .. CN_CTLCOLORSTATIC:
      begin
        // get the colors
        UpdateColors;
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_COLORCHANGED, CM_ENABLEDCHANGED:
      begin
        // get the colors
        UpdateColors;
        Handled := False;
      end;
  else
    inherited WndProc(Message);
  end;
end;

{ --- Configuration ------------------------------------------------------------ }

procedure TFConfiguration.FormCreate(Sender: TObject);
begin
  inherited;
  Width := PPIScale(860);
  Height := PPIScale(540);
  FTempFileTemplates := TFileTemplates.Create;
  GuiPyOptions := TGuiPyOptions.Create;
  GuiPyLanguageOptions := TGuiPyLanguageOptions.Create;
  CBValidClassColor.Style := [cbStandardColors, cbExtendedColors, cbCustomColor,
    cbPrettyNames];
  CBInvalidClassColor.Style := [cbStandardColors, cbExtendedColors,
    cbCustomColor, cbPrettyNames];
  CBObjectColor.Style := [cbStandardColors, cbExtendedColors, cbCustomColor,
    cbPrettyNames];
  CBCommentColor.Style := [cbStandardColors, cbExtendedColors, cbCustomColor,
    cbPrettyNames];
  for var I := 1 to 21 do
    FControlStructureTemplates[I] := nil;
  for var I := 0 to PageList.PageCount - 1 do
    PageList.Pages[I].TabVisible := False;
  TVConfiguration.FullExpand;
  ShowPage(0);
  TVConfiguration.TopItem := TVConfiguration.Items[0];
  if VistaOrBetter then
  begin
    SetElevationRequiredState(BFileExtensions);
    SetElevationRequiredState(BJEAssociation);
  end;
  FVisSelectedTabMenuToolbar := 0;
  FHighlighters := TList.Create;
  PrepareHighlighters;
  FSynEdit := TSynEditorOptionsContainer.Create(Self);
  FInternalCall := False;
  CustomShortcutsCreate;
  FInternalCall := False;
  FMargins := TSynEditPrintMargins.Create;
  FEditor := nil;
  FEditorFolder := ExtractFilePath(ParamStr(0));
  StyleSelectorFormCreate;
  FKeyStrokesReset := False;
  SetLength(FVisTabs, VisTabsLen);
  SetLength(FVisMenus, VisMenusLen);
  SetLength(FVisToolbars, VisToolbarsLen);
  FTabsMenusToolbars := 1;
  FIndentWidth := GEditorOptions.TabWidth;
  FIndent1 := StringOfChar(' ', 1 * FIndentWidth);
  FIndent2 := StringOfChar(' ', 2 * FIndentWidth);
  FIndent3 := StringOfChar(' ', 3 * FIndentWidth);
  ckGutterGradient.Left := 24;
  CBGutterFont.Left := 24;
  CBDisplayFlowControlColor.DefaultColorColor := $0045FF;
end;

procedure TFConfiguration.FormDestroy(Sender: TObject);
begin
  for var I := 1 to 21 do
    FreeAndNil(FControlStructureTemplates[I]);
  for var I := FHighlighters.Count - 1 downto 0 do
    FreeAndNil(FHighlighters.Items[I]);
  FreeAndNil(FHighlighters);
  FreeAndNil(FColorThemeHighlighter);
  FreeAndNil(FSynEdit);

  FActionProxyCollection.Free;
  FMargins.Free;
  FExternalStyleFilesDict.Free;
  FPreview.Free;
  FLoadedStylesDict.Free;
  FreeAndNil(GuiPyOptions);
  FreeAndNil(GuiPyLanguageOptions);

  FreeAndNil(KeyList);
  FreeAndNil(FFunctionList);
  FreeAndNil(FIDEKeyList);
  FTempFileTemplates.Clear;
  FreeAndNil(FTempFileTemplates);
  FConfiguration := nil;
end;

procedure TFConfiguration.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PageListClose;
  DoneItems;
  FreeAndNil(FActionProxyCollection);
end;

procedure TFConfiguration.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
end;

procedure TFConfiguration.FormShow(Sender: TObject);
begin
  vtPythonVersions.DefaultText := '';
  vtPythonVersions.RootNodeCount := 2;
  vtPythonVersions.Header.Columns[1].Text := _('Folder');

  SynEditOptionsShow;
  CustomShortcutsShow;
  PageSetupShow;
  StyleSelectorFormShow;
  OnShow := nil;
end;

procedure TFConfiguration.Retranslate;
begin
  for var I := 0 to PageList.PageCount - 1 do
    TVConfiguration.Items[I].Text := PageList.Pages[I].Caption;
end;

procedure TFConfiguration.PageSetupShow;
begin
  FEditor := REHeaderLeft;
  SetHeaderFooterOptions;
  UpdateHeaderFooterCursorPos;
end;

function TFConfiguration.DirectoryFilesExists(Str: string): Boolean;
var Posi: Integer; Dir: string;
begin
  Result := True;
  if Str <> '' then
  begin
    Str := Str + ';';
    Posi := Pos(';', Str);
    while Posi > 0 do
    begin
      Dir := Trim(Copy(Str, 1, Posi - 1));
      Delete(Str, 1, Posi);
      if Dir.EndsWith('*') then
        Delete(Dir, Length(Dir), 1);
      if ((Copy(Dir, 2, 1) = ':') or (Copy(Dir, 1, 2) = '\\')) and
        not(SysUtils.DirectoryExists(Dir) or FileExists(Dir)) then
        Result := False;
      Posi := Pos(';', Str);
    end;
  end;
end;

procedure TFConfiguration.CheckFolder(Edit: TEdit; EmptyAllowed: Boolean);
var Str: string;
begin
  Str := ExtendPath(Edit);
  ShortenPath(Edit, Str);
  if SysUtils.DirectoryExists(Edit.Hint) or (Str = '') and EmptyAllowed then
    Edit.Color := clWindow
  else
    Edit.Color := clRed;
  Edit.Enabled := not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.CheckFolderCB(ComboBox: TComboBox);
var Str: string;
begin
  Str := ExtendPath(ComboBox);
  ShortenPath(ComboBox, Str);
  if DirectoryFilesExists(Str) then
    ComboBox.Color := clWindow
  else
    ComboBox.Color := clRed;
  ComboBox.Enabled := not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.CheckUserFolder(Edit: TEdit);
var Str: string;
begin
  Str := ExtendPath(Edit);
  ShortenPath(Edit, Str);
  if DirectoryFilesExists(DissolveUsername(Edit.Hint)) then
    Edit.Color := clWindow
  else
    Edit.Color := clRed;
end;

procedure TFConfiguration.CheckAllFilesAndFolders;
begin
  CheckUserFolder(ETempFolder);
  CheckFolder(ESVNFolder, True);
  CheckFolderCB(CBRepository);
  CheckFolder(ETempFolder, False);
  CheckFolder(EGitFolder, True);
  CheckFolderCB(CBLocalRepository);
  CheckFolderCB(CBRemoteRepository);
  LockButtons;
end;

procedure TFConfiguration.LockButtons;
begin
  SBTempSelect.Enabled := not GuiPyOptions.LockedPaths;
  BTempFolder.Enabled := not GuiPyOptions.LockedPaths;
  BGitFolder.Enabled := not GuiPyOptions.LockedPaths;
  BGitRepository.Enabled := not GuiPyOptions.LockedPaths;
  BGitClone.Enabled := not GuiPyOptions.LockedPaths;
  BSVN.Enabled := not GuiPyOptions.LockedPaths;
  BRepository.Enabled := not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.BSaveClick(Sender: TObject);
begin
  Close;
  Screen.Cursor := crHourGlass;
  try
    ViewToModel;
    StoreApplicationData;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TFConfiguration.GetCheckColor(const Filename: string;
  EmptyAllowed: Boolean): TColor;
begin
  Result := clRed;
  if (Filename = '') and EmptyAllowed then
    Result := StyleServices.GetSystemColor(clWindow)
  else if FileExists(DissolveUsername(Filename)) then
    Result := StyleServices.GetSystemColor(clWindow);
end;

procedure TFConfiguration.CheckFile(WinControl: TWinControl;
  EmptyAllowed: Boolean);
var Str: string; Edit: TEdit;
begin
  Str := ExtendPath(WinControl);
  ShortenPath(WinControl, Str);
  if WinControl is TEdit then
  begin
    Edit := (WinControl as TEdit);
    Edit.Color := GetCheckColor(Str, EmptyAllowed);
  end
  else
    (WinControl as TComboBox).Color := GetCheckColor(Str, EmptyAllowed);
  WinControl.Enabled := not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.BSelectBrowserClick(Sender: TObject);
var ODSelect: TOpenDialog;
begin
  ODSelect := TOpenDialog.Create(Self);
  ODSelect.Options := [ofPathMustExist, ofFileMustExist, ofEnableSizing];
  with ODSelect do
  begin
    InitialDir := GetEnvironmentVariable('PROGRAMFILES');
    Filename := '*.exe';
    Filter := '*.exe|*.exe';
    if not SysUtils.DirectoryExists(InitialDir) then
      InitialDir := 'C:\';
    if Execute then
      ShortenPath(EBrowserProgram, Filename);
    CheckFile(EBrowserProgram, True);
  end;
  FreeAndNil(ODSelect);
end;

function TFConfiguration.BrowserProgToName(const Browsername: string): string;
var Browser: string;
begin
  Browser := UpperCase(Browsername);
  if Pos('NETSCAPE', Browser) > 0 then
    Result := 'Netscape'
  else if Pos('IEXPLORE', Browser) > 0 then
    Result := 'Internet Explorer'
  else if Pos('OPERA', Browser) > 0 then
    Result := 'Opera'
  else if Pos('FIREFOX', Browser) > 0 then
    Result := 'Mozilla Firefox'
  else if Pos('MOZILLA', Browser) > 0 then
    Result := 'Mozilla'
  else
    Result := 'unknown';
end;

procedure TFConfiguration.BBrowserTitleClick(Sender: TObject);
begin
  ShortenPath(EBrowserTitle, BrowserProgToName(EBrowserProgram.Hint));
end;

procedure TFConfiguration.BCancelClick(Sender: TObject);
begin
  Close;
end;

function TFConfiguration.FolderSelect(Edit: TEdit;
  const Foldername: string): string;
begin
  Result := Foldername;
  FolderDialog.DefaultFolder := Foldername;
  if FolderDialog.Execute then
  begin
    Result := ExcludeTrailingPathDelimiter(FolderDialog.Filename);
    ShortenPath(Edit, Result);
  end;
end;

procedure TFConfiguration.Changed;
begin
  ResourcesDataModule.dlgFileOpen.Filter := GetFileFilters;
  SetVisibility;

  // tab Editor
  FIndentWidth := GEditorOptions.TabWidth;
  FIndent1 := StringOfChar(' ', 1 * FIndentWidth);
  FIndent2 := StringOfChar(' ', 2 * FIndentWidth);
  FIndent3 := StringOfChar(' ', 3 * FIndentWidth);
  MakeControlStructureTemplates;

  // tab LLM
  GuiPyOptions.Providers.setToProviders(LLMAssistant.Providers);
  GuiPyOptions.ChatProviders.setToProviders(LLMChatForm.LLMChat.Providers);

  // tab Git
  FGitOK := FileExists(TPath.Combine(GuiPyOptions.GitFolder, 'bin\git.exe'));
  PyIDEMainForm.mnToolsGit.Visible := FGitOK and FVis1[VisTabsLen + 7, 4];
  if FGitOK and not Assigned(FGit) then
    FGit := TFGit.Create(Self);

  // tab Subversion
  FSubversionOK := FileExists(TPath.Combine(GuiPyOptions.SVNFolder, 'svn.exe'));
  PyIDEMainForm.mnToolsSVN.Visible := FSubversionOK and
    FVis1[VisTabsLen + 7, 5];
  if FSubversionOK and not Assigned(FSubversion) then
    FSubversion := TFSubversion.Create(Self);

  PyIDEMainForm.SetLayoutMenus(GuiPyOptions.UsePredefinedLayouts);

  GI_FileFactory.ApplyToFiles(
    procedure(AFile: IFile)
    begin
      (AFile as TFile).Form.SetOptions;
    end);
end;

procedure TFConfiguration.ModelToView;
begin
  if Assigned(GI_ActiveEditor) then
    FSynEdit.Assign(GI_ActiveEditor.ActiveSynEdit)
  else
    FSynEdit.Assign(GEditorOptions);
  PrepareKeyStrokes;
  DoneItems;
  PrepActions; // IDE commands
  FCodeTemplateText := ResourcesDataModule.CodeTemplatesCompletion.
    AutoCompleteList.Text;
  SetValues(CommandsDataModule.SynEditPrint);
  CodeTemplatesInit;
  FileTemplatesInit;

  // tab Python
  RGEngineTypes.ItemIndex := Ord(PyControl.PythonEngineType) - 1;

  // Gutter
  ckGutterVisible.Checked := FSynEdit.Gutter.Visible;
  ckGutterAutosize.Checked := FSynEdit.Gutter.AutoSize;
  // fixed by KF Orig: FSynEdit.Gutter.Visible;
  ckGutterShowLineNumbers.Checked := FSynEdit.Gutter.ShowLineNumbers;
  ckGutterShowLeaderZeros.Checked := FSynEdit.Gutter.LeadingZeros;
  ckGutterStartAtZero.Checked := FSynEdit.Gutter.ZeroStart;
  CBGutterFont.Checked := FSynEdit.Gutter.UseFontStyle;
  CBGutterColor.SelectedColor := FSynEdit.Gutter.Color;
  lblGutterFont.Font.Assign(FSynEdit.Gutter.Font);
  lblGutterFont.Caption := lblGutterFont.Font.Name + ' ' +
    IntToStr(lblGutterFont.Font.Size) + 'pt';
  ckGutterGradient.Checked := FSynEdit.Gutter.Gradient;
  EDigits.Text := IntToStr(FSynEdit.Gutter.DigitCount);
  EDigits.Enabled := not ckGutterAutosize.Checked;

  // Right Edge
  eRightEdge.Text := IntToStr(FSynEdit.RightEdge);
  cbRightEdgeColor.SelectedColor := FSynEdit.RightEdgeColor;
  CBActiveLineColor.SelectedColor := FSynEdit.ActiveLineColor;
  // Line Spacing
  eLineSpacing.Text := IntToStr(FSynEdit.ExtraLineSpacing);
  eTabWidth.Text := IntToStr(FSynEdit.TabWidth);
  // Bookmarks
  ckBookmarkKeys.Checked := FSynEdit.BookMarkOptions.EnableKeys;
  ckBookmarkVisible.Checked := FSynEdit.BookMarkOptions.GlyphsVisible;
  // Font
  labFont.Font.Assign(FSynEdit.Font);
  labFont.Caption := labFont.Font.Name + ' ' +
    IntToStr(labFont.Font.Size) + 'pt';

  // tab Options2
  ckAutoIndent.Checked := eoAutoIndent in FSynEdit.Options;
  ckRightMouseMoves.Checked := eoRightMouseMovesCursor in FSynEdit.Options;
  ckDragAndDropEditing.Checked := eoDragDropEditing in FSynEdit.Options;
  ckEnhanceEndKey.Checked := eoEnhanceEndKey in FSynEdit.Options;
  ckWordWrap.Checked := FSynEdit.WordWrap;
  ckEnhanceHomeKey.Checked := eoEnhanceHomeKey in FSynEdit.Options;
  ckTabsToSpaces.Checked := eoTabsToSpaces in FSynEdit.Options;
  ckKeepCaretX.Checked := eoKeepCaretX in FSynEdit.Options;
  ckSmartTabDelete.Checked := eoSmartTabDelete in FSynEdit.Options;
  ckTabIndent.Checked := eoTabIndent in FSynEdit.Options;
  ckSmartTabs.Checked := eoSmartTabs in FSynEdit.Options;

  ckHalfPageScroll.Checked := eoHalfPageScroll in FSynEdit.ScrollOptions;
  ckScrollByOneLess.Checked := eoScrollByOneLess in FSynEdit.ScrollOptions;
  ckScrollPastEOF.Checked := eoScrollPastEof in FSynEdit.ScrollOptions;
  ckDisableScrollArrows.Checked := eoDisableScrollArrows
    in FSynEdit.ScrollOptions;
  ckScrollPastEOL.Checked := eoScrollPastEol in FSynEdit.ScrollOptions;
  ckShowScrollHint.Checked := eoShowScrollHint in FSynEdit.ScrollOptions;
  ckHideShowScrollbars.Checked := eoHideShowScrollbars
    in FSynEdit.ScrollOptions;
  ckScrollHintFollows.Checked := eoScrollHintFollows in FSynEdit.ScrollOptions;

  ckTrimTrailingSpaces.Checked := eoTrimTrailingSpaces in FSynEdit.Options;
  ckShowSpecialChars.Checked := FSynEdit.VisibleSpecialChars <> [];
  ckGroupUndo.Checked := eoGroupUndo in FSynEdit.Options;
  ckShowLigatures.Checked := eoShowLigatures in FSynEdit.Options;

  with PyIDEOptions do
  begin
    // interpreter
    CBAlwaysUseSockets.Checked := AlwaysUseSockets;
    CBClearOutputBeforeRun.Checked := ClearOutputBeforeRun;
    CBInternalInterpreterHidden.Checked := InternalInterpreterHidden;
    CBJumpToErrorOnException.Checked := JumpToErrorOnException;
    CBMaskFPUExceptions.Checked := MaskFPUExceptions;
    CBPostMortemOnException.Checked := PostMortemOnException;
    CBPrettyPrintOutput.Checked := PrettyPrintOutput;
    CBReinitializeBeforeRun.Checked := ReinitializeBeforeRun;
    CBSaveEnvironmentBeforeRun.Checked := SaveEnvironmentBeforeRun;
    CBSaveFilesBeforeRun.Checked := SaveFilesBeforeRun;
    CBSaveInterpreterHistory.Checked := SaveInterpreterHistory;
    CBTraceOnlyIntoOpenFiles.Checked := TraceOnlyIntoOpenFiles;
    CBReinitializeWhenClosing.Checked := ReinitializeWhenClosing;
    UDTimeOut.Position := TimeOut;
    UDInterpreterHistorySize.Position := InterpreterHistorySize;

    // tab Editor, Options 1
    CBCheckSyntaxAsYouType.Checked := CheckSyntaxAsYouType;
    CBHighlightSelectedWord.Checked := HighlightSelectedWord;
    CBDisplayFlowControl.Checked := DisplayFlowControl.Enabled;
    CBDisplayFlowControlColor.Selected := DisplayFlowControl.Color;
    CBIndentationGuide.Checked := IndentGuides.Visible;
    CBAccessibilitySupport.Checked := AccessibilitySupport;
    CBAutoCompleteBrackets.Checked := AutoCompleteBrackets;
    CBAutoHideFindToolbar.Checked := AutoHideFindToolbar;
    CBAutoReloadChangedFiles.Checked := AutoReloadChangedFiles;
    CBCodeFoldingEnabled.Checked := CodeFoldingEnabled;
    CBGUICodeFolding.Checked := CodeFoldingForGuiElements;
    CBCompactLineNumbers.Checked := CompactLineNumbers;
    CBCreateBackupFiles.Checked := CreateBackupFiles;
    CBDetectUTF8Encoding.Checked := DetectUTF8Encoding;
    CBDisplayPackageNames.Checked := DisplayPackageNames;
    CBMarkExecutableLines.Checked := MarkExecutableLines;
    CBSearchTextAtCaret.Checked := SearchTextAtCaret;
    CBShowCodeHints.Checked := ShowCodeHints;
    CBShowDebuggerHints.Checked := ShowDebuggerHints;
    CBTrimTrailingSpacesOnSave.Checked := TrimTrailingSpacesOnSave;
    CBUndoAfterSave.Checked := UndoAfterSave;
    CBHighlightSelectedWordColor.Color := HighlightSelectedWordColor;
    RGNewFileEncoding.ItemIndex := Ord(NewFileEncoding);
    RGNewFileLineBreaks.ItemIndex := Ord(NewFileLineBreaks);

    // tab options 2
    ckScrollbarAnnotation.Checked := ScrollbarAnnotation;

    // tab code completion
    CBCompletionCaseSensitive.Checked := CodeCompletionCaseSensitive;
    CBCompleteAsYouType.Checked := CompleteAsYouType;
    CBCompleteKeywords.Checked := CompleteKeywords;
    CBCompleteWithOneEntry.Checked := CompleteWithOneEntry;
    CBCompleteWithWordBreakChars.Checked := CompleteWithWordBreakChars;
    CBEditorCodeCompletion.Checked := EditorCodeCompletion;
    CBInterpreterCodeCompletion.Checked := InterpreterCodeCompletion;
    CBLspDebug.Checked := LspDebug;
    CBLspDebug.Caption := 'Debug LSP-Server to ' +
      TPath.Combine(TPyScripterSettings.UserDataPath, 'LspDebug.log');
    UDCodeComletionListSize.Position := CodeCompletionListSize;
    ESpecialPackages.Text := SpecialPackages;

    // tab general options
    CBSaveFilesAutomatically.Checked := SaveFilesAutomatically;
    CBRestoreOpenFiles.Checked := RestoreOpenFiles;
    CBRestoreOpenProject.Checked := RestoreOpenProject;
    CBShowTabCloseButton.Checked := ShowTabCloseButton;
    CBSmartNextPrevPage.Checked := SmartNextPrevPage;
    CBStyleMainWindowBorder.Checked := StyleMainWindowBorder;
    CBExporerInitiallyExpanded.Checked := ExplorerInitiallyExpanded;
    CBFileExplorerContextMenu.Checked := FileExplorerContextMenu;
    CBProjectExporerInitiallyExpanded.Checked :=
      ProjectExplorerInitiallyExpanded;
    CBFileExplorerBackgroundProcessing.Checked :=
      FileExplorerBackgroundProcessing;
    CBMethodsWithComment.Checked := MethodsWithComment;
    CBAutoCheckForUpdates.Checked := AutoCheckForUpdates;

    UDDaysBetweenChecks.Position := DaysBetweenChecks;
    UDNoOfRecentFiles.Position := NoOfRecentFiles;
    UDDockAnimationInterval.Position := DockAnimationInterval;
    UDDockAnimationMoveWidth.Position := DockAnimationMoveWidth;
    UDIDEFontSize.Position := UIContentFontSize;
    RGEditorTabPosition.ItemIndex := Ord(EditorsTabPosition);
    RGFileChangeNotification.ItemIndex := Ord(FileChangeNotification);

    // tab ssh
    EScpCommand.Text := ScpCommand;
    EScpOptions.Text := ScpOptions;
    ESSHCommand.Text := SSHCommand;
    ESSHOptions.Text := SSHOptions;
    CBSSHDisableVariablesWin.Checked := SSHDisableVariablesWin;
  end;

  with GuiPyOptions do
  begin
    // Color themes
    lbColorThemes.ItemIndex := lbColorThemes.Items.IndexOf(FColorTheme);
    lbColorThemesClick(Self);

    // Class modeler
    CBShowGetSetMethods.Checked := ShowGetSetMethods;
    CBGetSetMethodsAsProperty.Checked := GetSetMethodsAsProperty;
    CBGetMethodChecked.Checked := GetMethodChecked;
    CBSetMethodChecked.Checked := SetMethodChecked;
    CBShowAttributeTypeSelection.Checked := ShowAttributeTypeSelection;
    CBShowWithWithoutReturnValue.Checked := ShowWithWithoutReturnValue;
    CBShowMethodTypeSelection.Checked := ShowMethodTypeSelection;
    CBShowParameterTypeSelection.Checked := ShowParameterTypeSelection;
    CBFromFutureImport.Checked := FromFutureImport;

    // GUI design
    CBNameFromText.Checked := NameFromText;
    CBGuiDesignerHints.Checked := GuiDesignerHints;
    UDGridSize.Position := GridSize;
    UDZoomSteps.Position := ZoomSteps;
    CBSnapToGrid.Checked := SnapToGrid;
    EFrameWidth.Text := IntToStr(FrameWidth);
    EFrameHeight.Text := IntToStr(FrameHeight);

    // tab structograms
    CBDataType.Text := StructoDatatype;
    CBSwitchWithCaseLine.Checked := SwitchWithCaseLine;
    ECaseCount.Text := IntToStr(CaseCount);
    UDStructogramShadowWidth.Position := StructogramShadowWidth;
    UDStructogramShadowIntensity.Position := StructogramShadowIntensity;

    // tab sequence diagrams
    CBSDFillingColor.Selected := SDFillingColor;
    CBSDNoFilling.Checked := SDNoFilling;
    CBSDShowMainCall.Checked := SDShowMainCall;
    CBSDShowParameter.Checked := SDShowParameter;
    CBSDShowReturn.Checked := SDShowReturn;

    // tab UML design
    CBValidClassColor.Selected := ValidClassColor;
    CBInvalidClassColor.Selected := InvalidClassColor;
    RGClassHead.ItemIndex := ClassHead;
    CBObjectColor.Selected := ObjectColor;
    RGObjectHead.ItemIndex := ObjectHead;
    RGObjectFooter.ItemIndex := ObjectFooter;
    RGObjectCaption.ItemIndex := ObjectCaption;
    CBObjectUnderline.Checked := ObjectUnderline;
    CBCommentColor.Selected := CommentColor;
    RGAttributsMethodsDisplay.ItemIndex := 3 - DiVisibilityFilter;
    RGSequenceAttributsMethods.ItemIndex := DiSortOrder;
    RGParameterDisplay.ItemIndex := DiShowParameter;
    RGVisibilityDisplay.ItemIndex := 2 - DiShowIcons;
    UDShadowWidth.Position := ShadowWidth;
    UDShadowIntensity.Position := ShadowIntensity;

    // tab uml options
    CBUMLEdit.Checked := PrivateAttributEditable;
    CBShowEmptyRects.Checked := ShowEmptyRects;
    CBConstructorWithVisibility.Checked := ConstructorWithVisibility;
    CBLowerCaseLetter.Checked := ObjectLowerCaseLetter;
    CBOpenPublicClasses.Checked := ShowPublicOnly;
    CBDefaultModifiers.Checked := DefaultModifiers;
    CBShowObjectsWithMethods.Checked := ShowObjectsWithMethods;
    CBShowObjectsWithInheritedPrivateAttributes.Checked :=
      ShowObjectsWithInheritedPrivateAttributes;
    CBIntegerInsteadofInt.Checked := IntegerInsteadofInt;
    CBShowAllNewObjects.Checked := ShowAllNewObjects;
    CBObjectsWithoutVisibility.Checked := ObjectsWithoutVisibility;
    CBRelationshipAttributesBold.Checked := RelationshipAttributesBold;
    CBShowClassparameterSeparately.Checked := ShowClassparameterSeparately;
    CBRoleHidesAttribute.Checked := RoleHidesAttribute;
    CBClassnameInUppercase.Checked := ClassnameInUppercase;
    CBUseAbstractForClass.Checked := UseAbstractForClass;
    CBUseAbstractForMethods.Checked := UseAbstractForMethods;

    // tab restrictions
    CBLockedDosWindow.Checked := LockedDOSWindow;
    CBLockedInternet.Checked := LockedInternet;
    CBLockedPaths.Checked := LockedPaths;
    CBLockedStructogram.Checked := LockedStructogram;
    CBUsePredefinedLayouts.Checked := UsePredefinedLayouts;
    if not IsAdministrator then
    begin
      CBLockedDosWindow.Enabled := False;
      CBLockedInternet.Enabled := False;
      CBLockedPaths.Enabled := False;
      CBLockedStructogram.Enabled := False;
      CBUsePredefinedLayouts.Enabled := False;
    end;

    // tab associations
    CBAssociationPython.Checked := HasAssociationWithGuiPy('.py');
    CBAssociationPfm.Checked := HasAssociationWithGuiPy('.pfm');
    CBAssociationPuml.Checked := HasAssociationWithGuiPy('.puml');
    CBAssociationHtml.Checked := HasAssociationWithGuiPy('.html');
    CBAssociationTxt.Checked := HasAssociationWithGuiPy('.txt');
    CBAssociationJsp.Checked := HasAssociationWithGuiPy('.jsp');
    CBAssociationPhp.Checked := HasAssociationWithGuiPy('.php');
    CBAssociationCss.Checked := HasAssociationWithGuiPy('.css');
    CBAssociationInc.Checked := HasAssociationWithGuiPy('.inc');
    CBAssociationPsg.Checked := HasAssociationWithGuiPy('.psg');
    CBAssociationPsd.Checked := HasAssociationWithGuiPy('.psd');
    EGuiPyAssociation.Text := GetRegisteredGuiPy;
    EAdditionalAssociations.Text := AdditionalAssociations;

    // tab LLM Assistant
    Providers.setToProviders(FTempProviders);
    CBProvider.ItemIndex := Integer(FTempProviders.Provider);
    LLMAssistantModelToView;
    ChatProviders.setToProviders(FTempChatProviders);
    CBChatProvider.ItemIndex := Integer(FTempChatProviders.Provider);
    LLMChatModelToView;

    // tab Visibility
    VisibilityModelToView;

    // tab Git
    ShortenPath(EGitFolder, GitFolder);
    ShortenPath(CBLocalRepository, GitLocalRepository);
    ShortenPath(CBRemoteRepository, GitRemoteRepository);
    EUserName.Text := GitUserName;
    EUserEMail.Text := GitUserEMail;

    // tab SVN
    ShortenPath(ESVNFolder, SVNFolder);
    ShortenPath(CBRepository, SVNRepository);

    // tab Browser
    CBUseIEinternForDocuments.Checked := UseIEinternForDocuments;
    CBOnlyOneBrowserWindow.Checked := OnlyOneBrowserWindow;
    EBrowserTitle.Text := BrowserTitle;
    CBOpenBrowserShortcut.Text := OpenBrowserShortcut;
    ShortenPath(EBrowserProgram, BrowserProgram);

    // others
    EAuthor.Text := Author;
    ELicence.Text := Licence;
    ShortenPath(ETempFolder, TempDir);
  end;
  LanguageOptionsToView;
  FCurrentLanguage := GetCurrentLanguage;
  RGLanguages.OnClick := RGLanguagesClick;
end;

procedure TFConfiguration.LanguageOptionsToView;
begin
  with GuiPyLanguageOptions do
  begin
    // tab structograms
    EAlgorithm.Text := Algorithm;
    EInput.Text := Input;
    EOutput.Text := Output;
    EWhile.Text := _While;
    EFor.Text := _For;
    EYes.Text := Yes;
    ENo.Text := No;
    EOther.Text := Other;

    // tab sequence diagram
    ESDObject.Text := SDObject;
    ESDNew.Text := SDNew;
    ESDClose.Text := SDClose;
  end;
end;

procedure TFConfiguration.LanguageOptionsToModel;
begin
  with GuiPyLanguageOptions do
  begin
    // tab structogram
    Algorithm := EAlgorithm.Text;
    Input := EInput.Text;
    Output := EOutput.Text;
    _While := EWhile.Text;
    _For := EFor.Text;
    Yes := EYes.Text;
    No := ENo.Text;
    Other := EOther.Text;

    // tab sequencediagram
    SDObject := ESDObject.Text;
    SDNew := ESDNew.Text;
    SDClose := ESDClose.Text;
  end;
end;

procedure TFConfiguration.StoreApplicationData;
begin
  SaveVisibility;
  Changed;
  PyIDEOptions.Changed;
  PyIDEMainForm.StoreApplicationData;
end;

procedure TFConfiguration.RestoreApplicationData;
begin
  LoadVisibility;
  Changed;
end;

procedure TFConfiguration.PrepareShow;
begin
  if LVVisibilityTabs.Items.Count = 0 then
    PrepareVisibilityPage;
  ModelToView;
  CheckAllFilesAndFolders;
end;

procedure TFConfiguration.ViewToModel;
var LanguageNr: Integer; VOptions: TSynEditorOptions;
  VScrollOptions: TSynEditorScrollOptions; Digits: Integer;

  procedure SetFlag(Option: TSynEditorOption; Value: Boolean);
  begin
    if Value then
      Include(VOptions, Option)
    else
      Exclude(VOptions, Option);
  end;

  procedure SetScrollFlag(Option: TSynEditorScrollOption; Value: Boolean);
  begin
    if Value then
      Include(VScrollOptions, Option)
    else
      Exclude(VScrollOptions, Option);
  end;

begin
  RGLanguages.OnClick := nil;
  // tab Python
  if RGEngineTypes.ItemIndex <> Ord(PyControl.PythonEngineType) - 1 then
  begin
    case RGEngineTypes.ItemIndex of
      0:
        PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemote);
      1:
        PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemoteTk);
      2:
        PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemoteWx);
    else
      PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonSSH);
    end;
    if PyControl.PythonEngineType = peInternal then
      PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemote);
  end;

  // Gutter
  FSynEdit.Gutter.Visible := ckGutterVisible.Checked;
  FSynEdit.Gutter.AutoSize := ckGutterAutosize.Checked;
  FSynEdit.Gutter.ShowLineNumbers := ckGutterShowLineNumbers.Checked;
  FSynEdit.Gutter.LeadingZeros := ckGutterShowLeaderZeros.Checked;
  FSynEdit.Gutter.ZeroStart := ckGutterStartAtZero.Checked;
  FSynEdit.Gutter.Color := CBGutterColor.SelectedColor;
  FSynEdit.Gutter.UseFontStyle := CBGutterFont.Checked;
  FSynEdit.Gutter.Font.Assign(lblGutterFont.Font);
  FSynEdit.Gutter.Gradient := ckGutterGradient.Checked;
  if not ckGutterAutosize.Checked and TryStrToInt(EDigits.Text, Digits) and
    (2 <= Digits) and (Digits <= 10) then
    FSynEdit.Gutter.DigitCount := Digits;

  // Right Edge
  FSynEdit.RightEdge := StrToIntDef(eRightEdge.Text, 80);
  FSynEdit.RightEdgeColor := cbRightEdgeColor.SelectedColor;
  FSynEdit.ActiveLineColor := CBActiveLineColor.SelectedColor;
  // Line Spacing
  FSynEdit.ExtraLineSpacing := StrToIntDef(eLineSpacing.Text, 0);
  FSynEdit.TabWidth := StrToIntDef(eTabWidth.Text, 8);
  // Bookmarks
  FSynEdit.BookMarkOptions.EnableKeys := ckBookmarkKeys.Checked;
  FSynEdit.BookMarkOptions.GlyphsVisible := ckBookmarkVisible.Checked;
  // Font
  FSynEdit.Font.Assign(labFont.Font);

  // tab options2
  FSynEdit.WordWrap := ckWordWrap.Checked;
  VOptions := FSynEdit.Options; // Keep old values for unsupported options
  SetFlag(eoAutoIndent, ckAutoIndent.Checked);
  SetFlag(eoDragDropEditing, ckDragAndDropEditing.Checked);
  SetFlag(eoTabIndent, ckTabIndent.Checked);
  SetFlag(eoSmartTabs, ckSmartTabs.Checked);
  SetFlag(eoTabsToSpaces, ckTabsToSpaces.Checked);
  SetFlag(eoTrimTrailingSpaces, ckTrimTrailingSpaces.Checked);
  SetFlag(eoKeepCaretX, ckKeepCaretX.Checked);
  SetFlag(eoSmartTabDelete, ckSmartTabDelete.Checked);
  SetFlag(eoRightMouseMovesCursor, ckRightMouseMoves.Checked);
  SetFlag(eoEnhanceHomeKey, ckEnhanceHomeKey.Checked);
  SetFlag(eoEnhanceEndKey, ckEnhanceEndKey.Checked);
  SetFlag(eoGroupUndo, ckGroupUndo.Checked);
  SetFlag(eoShowLigatures, ckShowLigatures.Checked);
  FSynEdit.Options := VOptions;

  SetScrollFlag(eoHalfPageScroll, ckHalfPageScroll.Checked);
  SetScrollFlag(eoScrollByOneLess, ckScrollByOneLess.Checked);
  SetScrollFlag(eoScrollPastEof, ckScrollPastEOF.Checked);
  SetScrollFlag(eoScrollPastEol, ckScrollPastEOL.Checked);
  SetScrollFlag(eoShowScrollHint, ckShowScrollHint.Checked);
  SetScrollFlag(eoScrollHintFollows, ckScrollHintFollows.Checked);
  SetScrollFlag(eoDisableScrollArrows, ckDisableScrollArrows.Checked);
  SetScrollFlag(eoHideShowScrollbars, ckHideShowScrollbars.Checked);
  FSynEdit.ScrollOptions := VScrollOptions;
  if ckShowSpecialChars.Checked then
    FSynEdit.VisibleSpecialChars := [scWhitespace, scControlChars, scEOL]
  else
    FSynEdit.VisibleSpecialChars := [];

  with PyIDEOptions do
  begin
    // tab interpreter
    AlwaysUseSockets := CBAlwaysUseSockets.Checked;
    ClearOutputBeforeRun := CBClearOutputBeforeRun.Checked;
    InternalInterpreterHidden := CBInternalInterpreterHidden.Checked;
    JumpToErrorOnException := CBJumpToErrorOnException.Checked;
    MaskFPUExceptions := CBMaskFPUExceptions.Checked;
    PostMortemOnException := CBPostMortemOnException.Checked;
    PrettyPrintOutput := CBPrettyPrintOutput.Checked;
    ReinitializeBeforeRun := CBReinitializeBeforeRun.Checked;
    SaveEnvironmentBeforeRun := CBSaveEnvironmentBeforeRun.Checked;
    SaveFilesBeforeRun := CBSaveFilesBeforeRun.Checked;
    SaveInterpreterHistory := CBSaveInterpreterHistory.Checked;
    TraceOnlyIntoOpenFiles := CBTraceOnlyIntoOpenFiles.Checked;
    ReinitializeWhenClosing := CBReinitializeWhenClosing.Checked;
    TimeOut := UDTimeOut.Position;
    InterpreterHistorySize := UDInterpreterHistorySize.Position;

    // tab Editor
    CheckSyntaxAsYouType := CBCheckSyntaxAsYouType.Checked;
    HighlightSelectedWord := CBHighlightSelectedWord.Checked;
    DisplayFlowControl.Enabled := CBDisplayFlowControl.Checked;
    DisplayFlowControl.Color := CBDisplayFlowControlColor.Selected;
    IndentGuides.Visible := CBIndentationGuide.Checked;
    AccessibilitySupport := CBAccessibilitySupport.Checked;
    AutoCompleteBrackets := CBAutoCompleteBrackets.Checked;
    AutoHideFindToolbar := CBAutoHideFindToolbar.Checked;
    AutoReloadChangedFiles := CBAutoReloadChangedFiles.Checked;
    CodeFoldingEnabled := CBCodeFoldingEnabled.Checked;
    CompactLineNumbers := CBCompactLineNumbers.Checked;
    CreateBackupFiles := CBCreateBackupFiles.Checked;
    DetectUTF8Encoding := CBDetectUTF8Encoding.Checked;
    DisplayPackageNames := CBDisplayPackageNames.Checked;
    MarkExecutableLines := CBMarkExecutableLines.Checked;
    SearchTextAtCaret := CBSearchTextAtCaret.Checked;
    ShowCodeHints := CBShowCodeHints.Checked;
    ShowDebuggerHints := CBShowDebuggerHints.Checked;
    TrimTrailingSpacesOnSave := CBTrimTrailingSpacesOnSave.Checked;
    UndoAfterSave := CBUndoAfterSave.Checked;
    HighlightSelectedWordColor := CBHighlightSelectedWordColor.Color;
    NewFileEncoding := TFileSaveFormat(RGNewFileEncoding.ItemIndex);
    NewFileLineBreaks := TSynEditFileFormat(RGNewFileLineBreaks.ItemIndex);

    // tab options 2
    ScrollbarAnnotation := ckScrollbarAnnotation.Checked;

    // tab code completion
    CodeCompletionCaseSensitive := CBCompletionCaseSensitive.Checked;
    CompleteAsYouType := CBCompleteAsYouType.Checked;
    CompleteKeywords := CBCompleteKeywords.Checked;
    CompleteWithOneEntry := CBCompleteWithOneEntry.Checked;
    CompleteWithWordBreakChars := CBCompleteWithWordBreakChars.Checked;
    EditorCodeCompletion := CBEditorCodeCompletion.Checked;
    InterpreterCodeCompletion := CBInterpreterCodeCompletion.Checked;
    LspDebug := CBLspDebug.Checked;
    CodeCompletionListSize := UDCodeComletionListSize.Position;
    SpecialPackages := ESpecialPackages.Text;

    // tab general options
    AutoCheckForUpdates := CBAutoCheckForUpdates.Checked;
    SaveFilesAutomatically := CBSaveFilesAutomatically.Checked;
    RestoreOpenFiles := CBRestoreOpenFiles.Checked;
    RestoreOpenProject := CBRestoreOpenProject.Checked;
    ShowTabCloseButton := CBShowTabCloseButton.Checked;
    SmartNextPrevPage := CBSmartNextPrevPage.Checked;
    StyleMainWindowBorder := CBStyleMainWindowBorder.Checked;
    ExplorerInitiallyExpanded := CBExporerInitiallyExpanded.Checked;
    FileExplorerContextMenu := CBFileExplorerContextMenu.Checked;
    ProjectExplorerInitiallyExpanded :=
      CBProjectExporerInitiallyExpanded.Checked;
    FileExplorerBackgroundProcessing :=
      CBFileExplorerBackgroundProcessing.Checked;
    MethodsWithComment := CBMethodsWithComment.Checked;

    DaysBetweenChecks := UDDaysBetweenChecks.Position;
    NoOfRecentFiles := UDNoOfRecentFiles.Position;
    DockAnimationInterval := UDDockAnimationInterval.Position;
    DockAnimationMoveWidth := UDDockAnimationMoveWidth.Position;
    UIContentFontSize := UDIDEFontSize.Position;
    EditorsTabPosition := TSpTBXTabPosition(RGEditorTabPosition.ItemIndex);
    FileChangeNotification := TFileChangeNotificationType
      (RGFileChangeNotification.ItemIndex);

    // tab ssh
    ScpCommand := EScpCommand.Text;
    ScpOptions := EScpOptions.Text;
    SSHCommand := ESSHCommand.Text;
    SSHOptions := ESSHOptions.Text;
    SSHDisableVariablesWin := CBSSHDisableVariablesWin.Checked;

    GetValues(CommandsDataModule.SynEditPrint);
  end;

  with GuiPyOptions do
  begin
    // Color themes
    if lbColorThemes.ItemIndex > -1 then
      FColorTheme := lbColorThemes.Items[lbColorThemes.ItemIndex];

    // Class modeler
    ShowGetSetMethods := CBShowGetSetMethods.Checked;
    GetSetMethodsAsProperty := CBGetSetMethodsAsProperty.Checked;
    GetMethodChecked := CBGetMethodChecked.Checked;
    SetMethodChecked := CBSetMethodChecked.Checked;
    ShowAttributeTypeSelection := CBShowAttributeTypeSelection.Checked;
    ShowWithWithoutReturnValue := CBShowWithWithoutReturnValue.Checked;
    ShowMethodTypeSelection := CBShowMethodTypeSelection.Checked;
    ShowParameterTypeSelection := CBShowParameterTypeSelection.Checked;
    FromFutureImport := CBFromFutureImport.Checked;

    // tab GUI designer
    NameFromText := CBNameFromText.Checked;
    GuiDesignerHints := CBGuiDesignerHints.Checked;
    GridSize := UDGridSize.Position;
    ZoomSteps := UDZoomSteps.Position;
    SnapToGrid := CBSnapToGrid.Checked;
    FrameWidth := StrToInt(EFrameWidth.Text);
    FrameHeight := StrToInt(EFrameHeight.Text);

    // tab Structograms
    StructoDatatype := CBDataType.Text;
    SwitchWithCaseLine := CBSwitchWithCaseLine.Checked;
    CaseCount := StrToInt(ECaseCount.Text);
    StructogramShadowWidth := UDStructogramShadowWidth.Position;
    StructogramShadowIntensity := UDStructogramShadowIntensity.Position;

    // tab Sequencediagram
    SDFillingColor := CBSDFillingColor.Selected;
    SDNoFilling := CBSDNoFilling.Checked;
    SDShowMainCall := CBSDShowMainCall.Checked;
    SDShowParameter := CBSDShowParameter.Checked;
    SDShowReturn := CBSDShowReturn.Checked;

    // tab UML design
    ValidClassColor := CBValidClassColor.Selected;
    InvalidClassColor := CBInvalidClassColor.Selected;
    ClassHead := RGClassHead.ItemIndex;
    ShadowWidth := UDShadowWidth.Position;
    ShadowIntensity := UDShadowIntensity.Position;
    ObjectColor := CBObjectColor.Selected;
    ObjectHead := RGObjectHead.ItemIndex;
    ObjectFooter := RGObjectFooter.ItemIndex;
    ObjectCaption := RGObjectCaption.ItemIndex;
    ObjectUnderline := CBObjectUnderline.Checked;
    CommentColor := CBCommentColor.Selected;
    DiVisibilityFilter := 3 - RGAttributsMethodsDisplay.ItemIndex;
    DiSortOrder := RGSequenceAttributsMethods.ItemIndex;
    DiShowParameter := RGParameterDisplay.ItemIndex;
    DiShowIcons := 2 - RGVisibilityDisplay.ItemIndex;

    // tab uml options
    PrivateAttributEditable := CBUMLEdit.Checked;
    ShowEmptyRects := CBShowEmptyRects.Checked;
    ConstructorWithVisibility := CBConstructorWithVisibility.Checked;
    ObjectLowerCaseLetter := CBLowerCaseLetter.Checked;
    ShowPublicOnly := CBOpenPublicClasses.Checked;
    DefaultModifiers := CBDefaultModifiers.Checked;
    ShowObjectsWithMethods := CBShowObjectsWithMethods.Checked;
    ShowObjectsWithInheritedPrivateAttributes :=
      CBShowObjectsWithInheritedPrivateAttributes.Checked;
    IntegerInsteadofInt := CBIntegerInsteadofInt.Checked;
    ShowAllNewObjects := CBShowAllNewObjects.Checked;
    ObjectsWithoutVisibility := CBObjectsWithoutVisibility.Checked;
    RelationshipAttributesBold := CBRelationshipAttributesBold.Checked;
    ShowClassparameterSeparately := CBShowClassparameterSeparately.Checked;
    RoleHidesAttribute := CBRoleHidesAttribute.Checked;
    ClassnameInUppercase := CBClassnameInUppercase.Checked;
    UseAbstractForClass := CBUseAbstractForClass.Checked;
    UseAbstractForMethods := CBUseAbstractForMethods.Checked;

    // tab restrictions
    LockedDOSWindow := CBLockedDosWindow.Checked;
    LockedInternet := CBLockedInternet.Checked;
    LockedPaths := CBLockedPaths.Checked;
    LockedStructogram := CBLockedStructogram.Checked;
    UsePredefinedLayouts := CBUsePredefinedLayouts.Checked;

    // tab Associations
    AdditionalAssociations := EAdditionalAssociations.Text;

    // tab LLM Assistant
    LLMAssistantViewToModel;
    Providers.setFromProviders(FTempProviders);
    LLMAssistant.Providers := FTempProviders;

    LLMChatViewToModel;
    ChatProviders.setFromProviders(FTempChatProviders);
    LLMChatForm.LLMChat.Providers := FTempChatProviders;

    // Visibility
    VisibilityViewToModel;

    // tab Git
    GitFolder := ExtendPath(EGitFolder);
    GitLocalRepository := ExtendPath(CBLocalRepository);
    GitRemoteRepository := ExtendPath(CBRemoteRepository);
    if Assigned(FGit) and (EUserName.Text <> GuiPyOptions.GitUserName) then
    begin
      FGit.GitCall('config --global CUser.name="' + EUserName.Text + '"', '.');
      GitUserName := EUserName.Text;
    end;
    if Assigned(FGit) and (EUserEMail.Text <> GuiPyOptions.GitUserEMail) then
    begin
      FGit.GitCall('config --global CUser.email="' + EUserEMail.Text +
        '"', '.');
      GitUserEMail := EUserEMail.Text;
    end;

    // tab SVN
    SVNFolder := ExtendPath(ESVNFolder);
    SVNRepository := ExtendPath(CBRepository);

    // tab TextDiff - implicit

    // tab Browser
    UseIEinternForDocuments := CBUseIEinternForDocuments.Checked;
    OnlyOneBrowserWindow := CBOnlyOneBrowserWindow.Checked;
    BrowserTitle := EBrowserTitle.Text;
    OpenBrowserShortcut := CBOpenBrowserShortcut.Text;
    BrowserProgram := ExtendPath(EBrowserProgram);

    // others
    Author := EAuthor.Text;
    Licence := ELicence.Text;
    TempDir := ExtendPath(ETempFolder);
  end;
  LanguageOptionsToModel;
  ApplyColorTheme;

  // tab languages
  LanguageNr := RGLanguages.ItemIndex;
  if not PyIDEMainForm.mnLanguage[LanguageNr].Checked then
    PyIDEMainForm.mnLanguageClick(PyIDEMainForm.mnLanguage[LanguageNr]);

  UpdateHighlighters;
  FActionProxyCollection.ApplyShortCuts;
  FileTemplatesGetItems;
  CodeTemplatesGetItems;
  GEditorOptions.Assign(FSynEdit);
  for var I := 0 to CBHighlighters.Items.Count - 1 do
    CommandsDataModule.SynEditOptionsDialogSetHighlighter(Self, I,
      TSynCustomHighlighter(CBHighlighters.Items.Objects[I]));

  CommandsDataModule.ApplyEditorOptions;
  PythonIIForm.ApplyEditorOptions;
  TJedi.CreateServer;
end;

procedure TFConfiguration.BTempFolderClick(Sender: TObject);
var Path: string;
begin
  if TPyScripterSettings.IsPortable then
    Path := TPath.Combine(ExtractFilePath(Application.ExeName), 'Temp')
  else
    Path := TPath.GetTempPath;
  SysUtils.ForceDirectories(Path);
  ShortenPath(ETempFolder, Path);
end;

procedure TFConfiguration.SBTempSelectClick(Sender: TObject);
var Path: string;
begin
  if TPyScripterSettings.IsPortable then
    Path := TPath.Combine(ExtractFilePath(Application.ExeName), 'Temp')
  else
    Path := TPath.GetTempPath;
  Path := FolderSelect(ETempFolder, Path);
  SysUtils.ForceDirectories(Path);
  ShortenPath(ETempFolder, Path);
end;

procedure TFConfiguration.DoHelp(Adresse: string);
begin
  if IsHttp(Adresse) and GuiPyOptions.LockedInternet then
    Adresse := 'about:' + _('Internet locked!');
  OpenObject(Adresse);
end;

var Eng: array [0 .. MaxPages] of string = (
    'python',
    'interpreter',
    'editor',
    'display',
    'options_1',
    'options_2',
    'code_completion',
    'keystrokes',
    'syntax_colors',
    'color_themes',
    'code_templates',
    'file_templates',
    'class_modeler',
    'gui_designer',
    'structogram',
    'sequence_diagram',
    'uml_design',
    'uml_options',
    'ide_shortcuts',
    'browser',
    'language',
    'options',
    'styles',
    'printer',
    'header_footer',
    'restrictions',
    'associations',
    'llm_assistant',
    'llm_chat',
    'visibility',
    'ssh',
    'tools',
    'git',
    'subversion'
  ); Deu: array [0 .. MaxPages] of string = (
    'python',
    'interpreter',
    'editor',
    'anzeige',
    'optionen_1',
    'optionen_2',
    'codevervollstaendigung',
    'tastenkuerzel',
    'syntaxfarben',
    'farbschemen',
    'codevorlagen',
    'dateivorlagen',
    'klassenmodellierer',
    'gui_designer',
    'struktogramm',
    'sequenzdiagramm',
    'uml_design',
    'uml_optionen',
    'ide_tastenkuerzel',
    'browser',
    'sprache_language',
    'optionen',
    'stile',
    'drucker',
    'kopf-_und_fusszeile',
    'beschraenkungen',
    'verknuepfungen',
    'llm_assistent',
    'llm_chat',
    'sichtbarkeit',
    'ssh',
    'tools',
    'git',
    'subversion'
  );

procedure TFConfiguration.BHelpClick(Sender: TObject);
var Count: Integer; ANode: TTreeNode;
begin
  ANode := TVConfiguration.Items.GetFirstNode;
  Count := 0;
  while (Count < TVConfiguration.Items.Count) and
    (ANode <> TVConfiguration.Selected) do
  begin
    ANode := ANode.GetNext;
    Inc(Count);
  end;
  if GetCurrentLanguage = 'Deu' then
    DoHelp(GetConfigurationAddress(Deu[Count]))
  else
    DoHelp(GetConfigurationAddress(Eng[Count]));
end;

procedure TFConfiguration.BCheckClick(Sender: TObject);
begin
  CheckAllFilesAndFolders;
end;

function TFConfiguration.GetDumpText: string;
var Pathname, CMachine, App, Str, Str1, WinPlatform: string;
  StringList: TStringList; AFile: IFile;
begin
{$IFDEF WIN64}
  WinPlatform := 'x64';
{$ELSE}
  WinPlatform := 'x86';
{$ENDIF}
  Result := '';
  Pathname := TPath.Combine(GuiPyOptions.TempDir, 'Configuration.ini');
  AFile := GI_FileFactory.GetFileByFileId(Pathname);
  if Assigned(AFile) then
    AFile.Close;
  Application.ProcessMessages;
  if FileExists(Pathname) then
    DeleteFile(Pathname);
  CMachine := PyIDEMainForm.MachineStorage.Filename;
  App := PyIDEMainForm.AppStorage.Filename;
  try
    Str := 'Installation ' + CrLf;
    Str1 := Format('Version %s %s', [ApplicationVersion, WinPlatform]);
    Str := Str + '  GuiPy-Version: ' + Str1 + CrLf;
    if GI_PyControl.PythonLoaded then
      Str1 := PyControl.PythonVersion.DisplayName +
        _(EngineTypeName[PyControl.PythonEngineType])
    else
      Str1 := '<not loaded>';
    Str := Str + '  Python-Version: ' + Str1 + CrLf;
    Str := Str + '  Windows-Version: ' + TOSVersion.ToString + CrLf;
    Str := Str + '  CmdLine: ' + CmdLine + CrLf;
    Str := Str + CrLf;
    Str := Str + '  MachineStorage: ' + CMachine + CrLf;
    Str := Str + '  AppStorage: ' + App + CrLf;
    Str := Str + CrLf;
    Str := Str + '  PublicPath: ' + TPath.Combine(TPath.GetPublicPath,
      'GuiPy') + CrLf;
    Str := Str + '  LspServerPath: ' +
      TPath.Combine(TPyScripterSettings.LspServerPath, 'jls') + CrLf;
    Str := Str + '  StylesFilesDir: ' +
      TPyScripterSettings.StylesFilesDir + CrLf;
    Str := Str + '  ColorThemesFilesDir: ' +
      TPyScripterSettings.ColorThemesFilesDir + CrLf;
    Str := Str + '  AppDebugInspectorsDir: ' +
      TPyScripterSettings.AppDebugInspectorsDir + CrLf;
    Str := Str + CrLf;
    Str := Str + '  UserDataPath: ' + TPyScripterSettings.UserDataPath + CrLf;
    Str := Str + '  UserDebugInspectorsDir: ' +
      TPyScripterSettings.UserDebugInspectorsDir + CrLf;
    Str := Str + CrLf;
    Str := Str + '  OptionsFileName: ' +
      TPyScripterSettings.OptionsFileName + CrLf;
    Str := Str + '  EngineInitFile: ' +
      TPyScripterSettings.EngineInitFile + CrLf;
    Str := Str + '  LspDebugLogFile: ' +
      TPath.Combine(TPyScripterSettings.UserDataPath, 'LspDebug.log') + CrLf;
    Str := Str + '  LspServerFile: ' +
      TPath.Combine(TPyScripterSettings.LspServerPath,
      'jls\run-jedi-language-server.py') + CrLf;

    Str := Str + StringOfChar('-', 80) + CrLf;
    Str := Str + '--- ' + CMachine + CrLf + CrLf;
    StringList := TStringList.Create;
    StringList.LoadFromFile(CMachine);
    Str := Str + StringList.Text + CrLf;
    Str := Str + StringOfChar('-', 80) + CrLf;
    Str := Str + '--- ' + App + CrLf + CrLf;
    StringList.Clear;
    StringList.LoadFromFile(App);
    Str := Str + StringList.Text;
    Str := Str + StringOfChar('-', 80) + CrLf;
    FreeAndNil(StringList);
    Result := Str + CrLf;
  except
    on E: Exception do
      ErrorMsg(E.Message + ' ' + 'The configuration could not be generated.');
  end;
end;

procedure TFConfiguration.BDumpClick(Sender: TObject);
var Pathname: string; StringList: TStringList;
begin
  StringList := TStringList.Create;
  StringList.Text := GetDumpText;
  if SysUtils.ForceDirectories(GuiPyOptions.TempDir) then
  begin
    Pathname := TPath.Combine(GuiPyOptions.TempDir, 'Configuration.ini');
    StringList.SaveToFile(Pathname);
    GI_EditorFactory.OpenFile(Pathname);
  end;
  FreeAndNil(StringList);
end;

procedure TFConfiguration.LMouseEnter(Sender: TObject);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TFConfiguration.LMouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TFConfiguration.CallUpdater(const Target, Source1: string;
Source2: string);
begin
  var
  Updater := FEditorFolder + 'setup.exe';
  if not FileExists(Updater) then
  begin
    ErrorMsg(Format(_(SFileNotFound), [Updater]));
    Exit;
  end;
  if Source2 = '' then
    Source2 := '-xxx';
  var
  Params := '-Update ' + HideBlanks(Target) + ' ' + HideBlanks(Source1) + ' ' +
    HideBlanks(Source2);
  Params := Params + ' -INI ' +
    HideBlanks(PyIDEMainForm.MachineStorage.Filename);
  if not RunAsAdmin(Handle, Updater, Params) then
    ErrorMsg(_('Can not execute file ') + Updater);
end;

function TFConfiguration.GetConfigurationAddress(const Str: string): string;
begin
  if GetCurrentLanguage = 'Deu' then
    Result := Homepage + '/doku.php?id=Deu:konfiguration#' + Str
  else
    Result := Homepage + '/doku.php?id=Eng:configuration#' + Str;
end;

procedure TFConfiguration.TVConfigurationChange(Sender: TObject;
Node: TTreeNode);
var ANode: TTreeNode; Count: Integer;
begin
  ANode := TVConfiguration.Items.GetFirstNode;
  Count := 0;
  while (Count < TVConfiguration.Items.Count) and (ANode <> Node) do
  begin
    ANode := ANode.GetNext;
    Inc(Count);
  end;
  if ANode.HasChildren then
    Inc(Count);

  ShowPage(Count);
  CheckAllFilesAndFolders;
end;

function TFConfiguration.GetTVConfigurationItem(const Text: string): TTreeNode;
begin
  for var I := 0 to TVConfiguration.Items.Count - 1 do
    if TVConfiguration.Items[I].Text = Text then
      Exit(TVConfiguration.Items[I]);
  Result := TVConfiguration.Items[0];
end;

procedure TFConfiguration.ShowPage(Page: Integer);
begin
  PageList.ActivePageIndex := Page;
  TVConfiguration.Selected := TVConfiguration.Items[Page];
  LTitle.Caption := PageList.ActivePage.Caption;
  PageListClose;
  if PageList.ActivePage.Caption = _('File templates') then
  begin
    ResourcesDataModule.ParameterCompletion.Editor := CodeSynTemplate;
    ResourcesDataModule.ModifierCompletion.Editor := CodeSynTemplate;
    CodeSynTemplate.Highlighter := ResourcesDataModule.SynPythonSyn;
  end;
  if PageList.ActivePage.Caption = _('Code templates') then
  begin
    ResourcesDataModule.ParameterCompletion.Editor := CodeSynTemplate;
    ResourcesDataModule.ModifierCompletion.Editor := CodeSynTemplate;
    CodeSynTemplate.Highlighter := ResourcesDataModule.SynPythonSyn;
  end;
end;

procedure TFConfiguration.PageListClose;
begin
  ResourcesDataModule.ParameterCompletion.Editor := nil;
  ResourcesDataModule.ModifierCompletion.Editor := nil;
  CodeSynTemplate.Highlighter := nil;
  FileSynTemplate.Highlighter := nil;
end;

function TFConfiguration.GetEncoding(const Pathname: string): TEncoding;
var Stream: TStream; WithBOM: Boolean;
begin
  Result := TEncoding.ANSI;
  if FileExists(Pathname) then
  begin
    Stream := TFileStream.Create(Pathname, fmOpenRead or fmShareDenyWrite);
    try
      Result := SynUnicode.GetEncoding(Stream, WithBOM);
    finally
      FreeAndNil(Stream);
    end;
  end;
end;

function TFConfiguration.GetFileFilters: string;
begin
  Result := 'GuiPy|*.py;*.pyw;*.pyi;*.pfm;*.puml;*.psg;*.psd' +
    '|Python (*.py;*.pyw;*.pyi)|*.py;*.pyw;*.pyi' + '|' + _('Form') +
    ' (*.pfm)|*.pfm' + '|UML (*.puml)|*.puml' + '|' + _('Structogram') +
    ' (*.psg)|*.psg' + '|' + _('Sequence diagram') + ' (*.psd)|*.psd' +
    '|Cython (*.pyx*.pxd;*.pxi)|*.pyx;*.pxd;*.pxi' +
    '|HTML (*.html)|*.html;*.htm' + '|XML (*.xml)|*.xml|' + _('Text') +
    ' (*.txt)|*.txt' +
    '|PHP (*.php;*.php3;*.phtml;*.inc)|*.php;*.php3;*.phtml;*.inc' + '|' +
    _('All') + ' (*.*)|*.*';
end;

procedure TFConfiguration.SetElevationRequiredState(Control: TWinControl);
const BCM_FIRST = $1600; BCM_SETSHIELD = BCM_FIRST + $000C;
begin
  SendMessage(Control.Handle, BCM_SETSHIELD, 0, Integer(True));
end;

function TFConfiguration.RunAsAdmin(AHWnd: HWND;
const AFile, Parameters: string): Boolean;
var Sei: TShellExecuteInfoA;
begin
  FillChar(Sei, SizeOf(Sei), 0);
  Sei.cbSize := SizeOf(Sei);
  Sei.Wnd := AHWnd;
  Sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  // left side is pAnsiChar
  Sei.lpVerb := 'runas';
  Sei.lpFile := PAnsiChar(AnsiString(AFile));
  Sei.lpParameters := PAnsiChar(AnsiString(Parameters));
  Sei.nShow := SW_SHOWNORMAL;
  Result := ShellExecuteExA(@Sei);
end;

procedure TFConfiguration.MakeControlStructureTemplates;
const ControlStructure: array [1 .. 10] of string = ('#if', '#while', '#for',
    '#do', '#switch', '#try', 'else', '} else', '#ifelse', '{ }');
begin
  for var I := 1 to 21 do
  begin
    FreeAndNil(FControlStructureTemplates[I]);
    FControlStructureTemplates[I] := TStringList.Create;
  end;
  FControlStructureTemplates[1].Text := 'if |:' + CrLf + FIndent1 + CrLf;
  FControlStructureTemplates[2].Text := 'while |:' + CrLf + FIndent1;
  FControlStructureTemplates[3].Text := 'for | in range(n):' + CrLf +
    FIndent1 + CrLf;
  FControlStructureTemplates[4].Text := ''; // 'do:';
  FControlStructureTemplates[5].Text := 'if |:' + CrLf + FIndent2 + CrLf +
    'elif : ' + CrLf + FIndent2 + CrLf + 'elif : ' + CrLf + FIndent2 + CrLf +
    'else: ' + CrLf + FIndent2 + CrLf;
  FControlStructureTemplates[6].Text := 'try:' + CrLf + FIndent1 + '|' + CrLf +
    'except:' + CrLf + FIndent1 + CrLf + 'finally:' + CrLf + FIndent1 + CrLf;
  FControlStructureTemplates[7].Text := 'else: ' + CrLf + FIndent1 + '|' + CrLf;
  FControlStructureTemplates[8].Text := 'else: ' + CrLf + FIndent1 + '|' + CrLf;
  FControlStructureTemplates[9].Text := 'if |:' + CrLf + FIndent1 + CrLf +
    'else:' + CrLf + FIndent1 + CrLf;
  FControlStructureTemplates[10].Text := CrLf + FIndent1 + '|' + CrLf;

  FControlStructureTemplates[11].Text := 'else if |:' + CrLf + FIndent1 + CrLf;
  FControlStructureTemplates[12].Text := 'for I in range(10):' + CrLf +
    FIndent1 + CrLf;
  FControlStructureTemplates[13].Text := 'catch (Exception e):' + CrLf +
    FIndent1 + '|' + CrLf;
  FControlStructureTemplates[14].Text := 'finally:' + CrLf + FIndent1 +
    '|' + CrLf;
  FControlStructureTemplates[15].Text := 'def private |void name():' + CrLf +
    FIndent1 + CrLf;
  FControlStructureTemplates[16].Text := 'def |void name():' + CrLf +
    FIndent1 + CrLf;
  FControlStructureTemplates[17].Text := 'println(|)' + CrLf;
  FControlStructureTemplates[18].Text := '|type name = new type()' + CrLf;
  FControlStructureTemplates[19].Text :=
    'public static void main(String[] args) {' + CrLf + FIndent1 + '|' + CrLf;
  FControlStructureTemplates[20].Text := 'def |void name():' + CrLf +
    FIndent1 + CrLf;
  FControlStructureTemplates[21].Text := 'def |void name():' + CrLf +
    FIndent1 + CrLf;
end;

class function TFConfiguration.IsDark: Boolean;
var BGColor, FGColor: TColor;
begin
  if StyleServices.IsSystemStyle then
  begin
    BGColor := clWhite;
    FGColor := clBlack;
  end
  else
  begin
    BGColor := StyleServices.GetStyleColor(scPanel);
    FGColor := StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  if GetRValue(BGColor) + GetGValue(BGColor) + GetBValue(BGColor) >
    GetRValue(FGColor) + GetGValue(FGColor) + GetBValue(FGColor) then
    Result := False
  else
    Result := True;
end;

// style
// https://stackoverflow.com/questions/9130945/delphi-xe2-disabling-vcl-style-on-a-component
// https://theroadtodelphi.com/2012/02/06/changing-the-color-of-edit-controls-with-vcl-styles-enabled/

procedure TFConfiguration.ShortenPath(WinControl: TWinControl;
const Path: string);
var Str1, Str2, Str3: string; Posi { , w } : Integer;
begin
  WinControl.Hint := Path;
  WinControl.ShowHint := True;
  { if WinControl is TEdit
    then w:= WinControl.Width
    else w:= WinControl.Width - 16;
  }
  Str1 := Path;
  if WinControl is TEdit then
    (WinControl as TEdit).Text := Str1
  else
    (WinControl as TComboBox).Text := Str1;
  Posi := Pos('...', Str1);
  if Posi > 0 then
  begin
    Str2 := Path;
    Delete(Str2, 1, Posi - 1);
    Str3 := Copy(Str1, Posi + 3, Length(Str1));
    Posi := Pos(Str3, Str2);
    Delete(Str2, Posi, Length(Str1));
    WinControl.HelpKeyword := Str2;
  end
  else
    WinControl.HelpKeyword := '';
end;

function TFConfiguration.ExtendPath(WinControl: TWinControl): string;
var Str: string; Posi: Integer;
begin
  if WinControl is TEdit then
    Str := (WinControl as TEdit).Text
  else
    Str := (WinControl as TComboBox).Text;
  Posi := Pos('...', Str);
  if Posi > 0 then
  begin
    Delete(Str, Posi, 3);
    insert(WinControl.HelpKeyword, Str, Posi);
  end;
  Result := Str;
end;

function TFConfiguration.GetMultiLineComment(const Indent: string): string;
begin
  if PyIDEOptions.MethodsWithComment then
    Result := Indent + '"""' + CrLf + Indent + CrLf + Indent + '"""' + CrLf
  else
    Result := '';
end;

{ --- Python ------------------------------------------------------------------- }

procedure TFConfiguration.actPVActivateExecute(Sender: TObject);
var Node: PVirtualNode; Level: Integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then
  begin
    Level := vtPythonVersions.GetNodeLevel(Node);
    if Level = 1 then
    begin
      if Node.Parent.Index = 0 then
        PyControl.PythonVersionIndex := Node.Index
      else if Node.Parent.Index = 1 then
        PyControl.PythonVersionIndex := -(Node.Index + 1);
      vtPythonVersions.InvalidateChildren(nil, True);
      AddScriptsPath;
    end;
  end;
end;

procedure TFConfiguration.actPVAddExecute(Sender: TObject);
var PythonVersion: TPythonVersion; Directories: TArray<string>; Err: string;
begin
  if SelectDirectory('', Directories, [],
    _('Select folder with Python installation (including virtualenv and venv)'))
  then
  begin
    if PythonVersionFromPath(Directories[0], PythonVersion, True,
      PyControl.MinPyVersion, PyControl.MaxPyVersion) then
    begin
      SetLength(PyControl.CustomPythonVersions,
        Length(PyControl.CustomPythonVersions) + 1);
      PyControl.CustomPythonVersions[Length(PyControl.CustomPythonVersions) - 1]
        := PythonVersion;
      vtPythonVersions.ReinitChildren(nil, True);
      vtPythonVersions.Selected[vtPythonVersions.GetLast] := True;
    end
    else
    begin
{$IFDEF WIN32}
      Err := Format(_(SPythonFindError32), [PyControl.MinPyVersion,
        PyControl.MaxPyVersion]);
{$ELSE}
      Err := Format(_(SPythonFindError64), [PyControl.MinPyVersion,
        PyControl.MaxPyVersion]);
{$ENDIF}
      StyledMessageDlg(_(Err), mtError, [mbOK], 0);
    end;
  end;
end;

procedure TFConfiguration.actPVRemoveExecute(Sender: TObject);
var Node: PVirtualNode; Level: Integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then
  begin
    Level := vtPythonVersions.GetNodeLevel(Node);
    if (Level = 1) and (Node.Parent.Index = 1) and
      not(PyControl.PythonVersionIndex = -(Node.Index + 1)) then
    begin
      Delete(PyControl.CustomPythonVersions, Node.Index, 1);
      vtPythonVersions.ReinitNode(Node.Parent, True);
    end;
  end;
end;

procedure TFConfiguration.actPVTestExecute(Sender: TObject);
var Node: PVirtualNode; Level: Integer; Version: TPythonVersion;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then
  begin
    Level := vtPythonVersions.GetNodeLevel(Node);
    if (Level = 1) then
    begin
      if Node.Parent.Index = 0 then
        Version := PyControl.RegPythonVersions[Node.Index]
      else
        Version := PyControl.CustomPythonVersions[Node.Index];
      ShellExecute(0, nil, PWideChar(Version.PythonExecutable), nil,
        PWideChar(Version.InstallPath), SW_SHOWNORMAL);
    end;
  end;
end;

procedure TFConfiguration.actPVShowExecute(Sender: TObject);
var Node: PVirtualNode; Level: Integer; Version: TPythonVersion;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then
  begin
    Level := vtPythonVersions.GetNodeLevel(Node);
    if (Level = 1) then
    begin
      if Node.Parent.Index = 0 then
        Version := PyControl.RegPythonVersions[Node.Index]
      else
        Version := PyControl.CustomPythonVersions[Node.Index];
      ShellExecute(0, nil, PWideChar(Version.InstallPath), nil,
        PWideChar(Version.InstallPath), SW_SHOWNORMAL);
    end;
  end;
end;

procedure TFConfiguration.actPVCommandShellExecute(Sender: TObject);
begin
  ShellExecute(0, nil, 'cmd.exe', nil,
    PWideChar(PyControl.PythonVersion.InstallPath), SW_SHOWNORMAL);
end;

procedure TFConfiguration.actPVHelpExecute(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TFConfiguration.actPVRenameExecute(Sender: TObject);
var Node: PVirtualNode; Level: Integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then
  begin
    Level := vtPythonVersions.GetNodeLevel(Node);
    if (Level = 1) then
    begin
      if Node.Parent.Index = 1 then
      begin
        PyControl.CustomPythonVersions[Node.Index].DisplayName :=
          InputBox(_('Rename Python Version'), _('New name:'),
          PyControl.CustomPythonVersions[Node.Index].DisplayName);
        vtPythonVersions.ReinitNode(Node.Parent, True);
      end;
    end;
  end;
end;

procedure TFConfiguration.vtPythonVersionsGetCellText
  (Sender: TCustomVirtualStringTree; var E: TVSTGetCellTextEventArgs);
var Level: Integer;
begin
  Level := vtPythonVersions.GetNodeLevel(E.Node);
  case Level of
    0:
      if E.Column = 0 then
      begin
        if E.Node.Index = 0 then
          E.CellText := _(SRegisteredVersions)
        else
          E.CellText := _(SUnRegisteredVersions);
      end;
    1:
      if E.Column = 0 then
      begin
        if E.Node.Parent.Index = 0 then
          E.CellText := PyControl.RegPythonVersions[E.Node.Index].DisplayName
        else
          E.CellText := PyControl.CustomPythonVersions[E.Node.Index]
            .DisplayName;
      end
      else if E.Column = 1 then
      begin
        if E.Node.Parent.Index = 0 then
          E.CellText := PyControl.RegPythonVersions[E.Node.Index].InstallPath
        else
          E.CellText := PyControl.CustomPythonVersions[E.Node.Index]
            .InstallPath;
      end;
  end;
end;

procedure TFConfiguration.vtPythonVersionsGetImageIndex
  (Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
Column: TColumnIndex; var Ghosted: Boolean;
var ImageIndex: UITypes.TImageIndex);
var Level: Integer;
begin
  ImageIndex := -1;
  if not(Kind in [ikNormal, ikSelected]) or (Column <> 0) then
    Exit;
  Level := vtPythonVersions.GetNodeLevel(Node);
  if (Level = 1) and GI_PyControl.PythonLoaded and
    (((Node.Parent.Index = 0) and (PyControl.PythonVersionIndex = Integer(Node.
    Index))) or ((Node.Parent.Index = 1) and
    (PyControl.PythonVersionIndex = -(Node.Index + 1)))) then
    ImageIndex := 0;
end;

procedure TFConfiguration.vtPythonVersionsInitChildren(Sender: TBaseVirtualTree;
Node: PVirtualNode; var ChildCount: Cardinal);
begin
  var
  Level := vtPythonVersions.GetNodeLevel(Node);
  if Level = 0 then
  begin
    if Node.Index = 0 then
      ChildCount := Length(PyControl.RegPythonVersions)
    else if Node.Index = 1 then
      ChildCount := Length(PyControl.CustomPythonVersions);
  end;
end;

procedure TFConfiguration.vtPythonVersionsInitNode(Sender: TBaseVirtualTree;
ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  var
  Level := vtPythonVersions.GetNodeLevel(Node);
  if Level = 0 then
  begin
    if (Node.Index = 0) and (Length(PyControl.RegPythonVersions) > 0) then
      InitialStates := [ivsHasChildren, ivsExpanded]
    else if (Node.Index = 1) and (Length(PyControl.CustomPythonVersions) > 0)
    then
      InitialStates := [ivsHasChildren, ivsExpanded];
  end;
end;

{ --- Editor Options ----------------------------------------------------------- }

procedure TFConfiguration.EditStrCallback(const Str: string);
begin
  if FExtended then
    cKeyCommand.Items.AddObject(_(Str), TObject(ConvertExtendedToCommand(Str)))
  else
    cKeyCommand.Items.AddObject(Str, TObject(ConvertCodeStringToCommand(Str)));
end;

procedure TFConfiguration.SynEditOptionsShow;
var Commands: TStringList;
begin
  // We need to do this now because it will not have been assigned when create occurs
  cKeyCommand.Items.Clear;
  // Start the callback to Add the strings
  if FExtended then
    GetEditorCommandExtended(EditStrCallback)
  else
    GetEditorCommandValues(EditStrCallback);
  // Now Add in the CUser defined ones if they have any
  Commands := TStringList.Create;
  try
    CommandsDataModule.GetEditorAllUserCommands(Commands);
    for var I := 0 to Commands.Count - 1 do
      if Commands.Objects[I] <> nil then
        cKeyCommand.Items.AddObject(Commands[I], Commands.Objects[I]);
  finally
    Commands.Free;
  end;

  if (KeyList.Items.Count > 0) then
    KeyList.Items[0].Selected := True;

  if CBHighlighters.Items.Count > 0 then
    CBHighlighters.ItemIndex := 0;

  if CBHighlighters.ItemIndex = -1 then
    EnableColorItems(False)
    // If there is still no selected item then disable controls
  else
    CBHighlightersChange(CBHighlighters);
  // run OnChange handler (it wont be fired on setting the ItemIndex prop)
end;

{ --- Editor Options Display --------------------------------------------------- }

procedure TFConfiguration.btnFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(labFont.Font);
  if FontDialog.Execute then
  begin
    labFont.Font.Assign(FontDialog.Font);
    labFont.Caption := labFont.Font.Name;
    labFont.Caption := labFont.Font.Name + ' ' +
      IntToStr(labFont.Font.Size) + 'pt';
  end;
end;

procedure TFConfiguration.btnGutterFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(lblGutterFont.Font);
  if FontDialog.Execute then
  begin
    lblGutterFont.Font.Assign(FontDialog.Font);
    lblGutterFont.Caption := lblGutterFont.Font.Name + ' ' +
      IntToStr(lblGutterFont.Font.Size) + 'pt';
  end;
end;

procedure TFConfiguration.CBGutterFontClick(Sender: TObject);
begin
  lblGutterFont.Enabled := CBGutterFont.Checked;
  btnGutterFont.Enabled := CBGutterFont.Checked;
end;

{ --- Options ------------------------------------------------------------------ }

{ --- Code Completion ---------------------------------------------------------- }

procedure TFConfiguration.BCodeCompletionFontClick(Sender: TObject);
begin
  ResourcesDataModule.dlgFontDialog.Font.Assign
    (PyIDEOptions.AutoCompletionFont);
  if ResourcesDataModule.dlgFontDialog.Execute then
    PyIDEOptions.AutoCompletionFont.Assign
      (ResourcesDataModule.dlgFontDialog.Font);
end;

{ --- Keystrokes --------------------------------------------------------------- }

procedure TFConfiguration.btnUpdateKeyClick(Sender: TObject);

var OldShortcut: TShortCut; OldShortcut2: TShortCut; Key: TSynEditKeyStroke;
  Str: string;
begin
  if KeyList.Selected = nil then
    Exit;
  if cKeyCommand.ItemIndex < 0 then
    Exit;

  Key := TSynEditKeyStroke(KeyList.Selected.Data);
  OldShortcut := Key.ShortCut;
  OldShortcut2 := Key.ShortCut2;
  try
    UpdateKey(Key);
  except
    on E: ESynKeyError do
    begin
      Str := _(SDuplicateKey);
      Key.ShortCut := OldShortcut;
      Key.ShortCut2 := OldShortcut2;
      ErrorMsg(Str);
    end;
  end;
  FillInKeystrokeInfo(TSynEditKeyStroke(KeyList.Selected.Data),
    KeyList.Selected);
end;

procedure TFConfiguration.btnResetKeysClick(Sender: TObject);
begin
  FSynEdit.Keystrokes.ResetDefaults;
  PrepareKeyStrokes;
  FKeyStrokesReset := True;
end;

procedure TFConfiguration.btnAddKeyClick(Sender: TObject);
var Item: TListItem; Str: string;
begin
  if cKeyCommand.ItemIndex < 0 then
    Exit;
  Item := KeyList.Items.Add;
  try
    Item.Data := FSynEdit.Keystrokes.Add;
    UpdateKey(TSynEditKeyStroke(Item.Data));
    FillInKeystrokeInfo(TSynEditKeyStroke(Item.Data), Item);
    Item.Selected := True;
  except
    on E: ESynKeyError do
    begin
      Str := _(SDuplicateKey);
      ErrorMsg(Str);
      TSynEditKeyStroke(Item.Data).Free;
      Item.Delete;
    end;
  end;
  Item.MakeVisible(True);
end;

procedure TFConfiguration.btnRemKeyClick(Sender: TObject);
begin
  if KeyList.Selected = nil then
    Exit;
  TSynEditKeyStroke(KeyList.Selected.Data).Free;
  KeyList.Selected.Delete;
end;

procedure TFConfiguration.cKeyCommandKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  if Key = SYNEDIT_RETURN then
    btnUpdateKey.Click;
end;

procedure TFConfiguration.ckGutterAutosizeClick(Sender: TObject);
begin
  EDigits.Enabled := not ckGutterAutosize.Checked;
end;

procedure TFConfiguration.UpdateKey(AKey: TSynEditKeyStroke);
var Cmd: Integer;
begin
  Cmd := Integer(cKeyCommand.Items.Objects[cKeyCommand.ItemIndex]);
  AKey.Command := Cmd;
  AKey.ShortCut := FEKeyShort1.HotKey;
  AKey.ShortCut2 := FEKeyShort2.HotKey;
end;

procedure TFConfiguration.FillInKeystrokeInfo(AKey: TSynEditKeyStroke;
AItem: TListItem);
var TmpString: string;
begin
  with AKey do
  begin
    if Command >= ecUserFirst then
    begin
      TmpString := 'User Command';
      if Assigned(GetUserCommandNames) then
        GetUserCommandNames(Command, TmpString);
    end
    else
    begin
      if FExtended then
        TmpString :=
          _(ConvertCodeStringToExtended(EditorCommandToCodeString(Command)))
      else
        TmpString := EditorCommandToCodeString(Command);
    end;

    AItem.Caption := TmpString;
    AItem.SubItems.Clear;

    TmpString := '';
    if ShortCut <> 0 then
      TmpString := ShortCutToText(ShortCut);

    if (TmpString <> '') and (ShortCut2 <> 0) then
      TmpString := TmpString + ' ' + ShortCutToText(ShortCut2);

    AItem.SubItems.Add(TmpString);
  end;
end;

procedure TFConfiguration.PrepareKeyStrokes;
var I: Integer; Item: TListItem;
begin
  FHandleChanges := True;
  // Normally true, can prevent unwanted execution of event handlers

  KeyList.OnSelectItem := KeyListSelectItem;

  FEKeyShort1 := TSynHotKey.Create(Self);
  with FEKeyShort1 do
  begin
    Parent := gbKeyStrokes;
    Left := PPIScale(185);
    Top := PPIScale(55);
    Width := PPIScale(185);
    Height := PPIScale(21);
    InvalidKeys := [];
    Modifiers := [];
    HotKey := 0;
    TabOrder := 1;
    Font.Color := StyleServices.GetSystemColor(clWindowText);
    Color := StyleServices.GetSystemColor(clWindow);
  end;

  FEKeyShort2 := TSynHotKey.Create(Self);
  with FEKeyShort2 do
  begin
    Parent := gbKeyStrokes;
    Left := PPIScale(185);
    Top := PPIScale(87);
    Width := PPIScale(185);
    Height := PPIScale(21);
    InvalidKeys := [];
    Modifiers := [];
    HotKey := 0;
    TabOrder := 2;
    Font.Color := StyleServices.GetSystemColor(clWindowText);
    Color := StyleServices.GetSystemColor(clWindow);
  end;

  StackPanel1.Spacing := MulDiv(StackPanel1.Spacing, FCurrentPPI, 96);
  StackPanel2.Spacing := MulDiv(StackPanel2.Spacing, FCurrentPPI, 96);

  FExtended := True;
  KeyList.Items.BeginUpdate;
  try
    KeyList.Items.Clear;
    for I := 0 to FSynEdit.Keystrokes.Count - 1 do
    begin
      Item := KeyList.Items.Add;
      FillInKeystrokeInfo(FSynEdit.Keystrokes[I], Item);
      Item.Data := FSynEdit.Keystrokes[I];
    end;
  finally
    KeyList.Items.EndUpdate;
  end;
end;

procedure TFConfiguration.KeyListSelectItem(Sender: TObject; Item: TListItem;
Selected: Boolean);
begin
  if not(Selected and Assigned(Item)) then
    Exit;
  cKeyCommand.Text := Item.Caption;
  cKeyCommand.ItemIndex := cKeyCommand.Items.IndexOf(Item.Caption);
  FEKeyShort1.HotKey := TSynEditKeyStroke(Item.Data).ShortCut;
  FEKeyShort2.HotKey := TSynEditKeyStroke(Item.Data).ShortCut2;
end;

{ --- Syntax Colors ------------------------------------------------------------ }

procedure TFConfiguration.PrepareHighlighters;
type
  TSynHClass = class of TSynCustomHighlighter;
var WCount: Integer; WHighlighter: TSynCustomHighlighter;
  WInternalSynH: TSynCustomHighlighter; WSynHClass: TSynHClass;
  Filename: string;
begin
  CBHighlighters.Items.Clear;
  CommandsDataModule.SynEditOptionsDialogGetHighlighterCount(Self, WCount);
  for var I := 0 to WCount - 1 do
  begin
    CommandsDataModule.SynEditOptionsDialogGetHighlighter(Self, I,
      WHighlighter);
    if Assigned(WHighlighter) then
    begin
      WSynHClass := TSynHClass(WHighlighter.ClassType);
      WInternalSynH := WSynHClass.Create(nil);
      WInternalSynH.Assign(WHighlighter);
      FHighlighters.Add(WInternalSynH);
      CBHighlighters.Items.AddObject(_(WInternalSynH.FriendlyLanguageName),
        WInternalSynH);

      if (WInternalSynH.FriendlyLanguageName = 'Python') or
        ((WInternalSynH.FriendlyLanguageName = 'Python Interpreter') and
        not Assigned(FColorThemeHighlighter)) then
      begin
        FColorThemeHighlighter := WSynHClass.Create(nil);
        FColorThemeHighlighter.Assign(WHighlighter);
        SynThemeSample.Highlighter := FColorThemeHighlighter;
        SynThemeSample.Lines.Text := FColorThemeHighlighter.SampleSource;
      end;
    end;
  end;
  if CBHighlighters.Items.Count > 0 then
  begin
    CBHighlighters.ItemIndex := 0;
    CBHighlightersChange(CBHighlighters);
  end;

  lbColorThemes.Items.Clear;
  FHighlighterFileDir := TPyScripterSettings.ColorThemesFilesDir;

  if FHighlighterFileDir <> '' then
    for Filename in TDirectory.GetFiles(FHighlighterFileDir, '*.ini') do
      lbColorThemes.Items.Add(TPath.GetFileNameWithoutExtension(Filename));
end;

procedure TFConfiguration.UpdateHighlighters;
begin
  for var I := 0 to FHighlighters.Count - 1 do
    CommandsDataModule.SynEditOptionsDialogSetHighlighter(Self, I,
      FHighlighters[I]);
end;

procedure TFConfiguration.CBHighlightersChange(Sender: TObject);
var WSynH: TSynCustomHighlighter;
begin
  lbElements.Items.BeginUpdate;
  SynSyntaxSample.Lines.BeginUpdate;
  try
    lbElements.ItemIndex := -1;
    lbElements.Items.Clear;
    SynSyntaxSample.Lines.Clear;
    if CBHighlighters.ItemIndex > -1 then
    begin
      WSynH := SelectedHighlighter;
      for var I := 0 to WSynH.AttrCount - 1 do
        lbElements.Items.Add(WSynH.Attribute[I].FriendlyName);
      SynSyntaxSample.Highlighter := WSynH;
      SynSyntaxSample.Lines.Text := WSynH.SampleSource;
    end;

    // Select the first Element if avail to avoid exceptions
    if lbElements.Items.Count > 0 then // Added by KF 2005_JUL_15
    begin
      lbElements.ItemIndex := 0;
      lbElementsClick(lbElements);
      // We have to run it manually, as setting its Items prop won't fire the event.
      EnableColorItems(True);
      // Controls can be enabled now because there is active highlighter and element.
    end
    else
      EnableColorItems(False); // Else disable controls

  finally
    lbElements.Items.EndUpdate;
    SynSyntaxSample.Lines.EndUpdate;
  end;
end;

procedure TFConfiguration.lbElementsClick(Sender: TObject);
var WSynH: TSynCustomHighlighter; WSynAttr: TSynHighlighterAttributes;

begin
  if 0 <= lbElements.ItemIndex then
  begin
    WSynH := SelectedHighlighter;
    if lbElements.ItemIndex < WSynH.AttrCount then
    begin
      EnableColorItems(True);
      WSynAttr := WSynH.Attribute[lbElements.ItemIndex];

      FHandleChanges := False;
      try
        cbxElementBold.Checked := (fsBold in WSynAttr.Style);
        cbxElementItalic.Checked := (fsItalic in WSynAttr.Style);
        cbxElementUnderline.Checked := (fsUnderline in WSynAttr.Style);
        cbxElementStrikeout.Checked := (fsStrikeOut in WSynAttr.Style);
        CBElementForeground.SelectedColor := WSynAttr.Foreground;
        CBElementBackground.SelectedColor := WSynAttr.Background;
      finally
        FHandleChanges := True;
      end;
    end;
  end
  else
    EnableColorItems(False);
end;

procedure TFConfiguration.CBElementForegroundSelectedColorChanged
  (Sender: TObject);
var WSynH: TSynCustomHighlighter; WSynAttr: TSynHighlighterAttributes;
begin
  WSynH := SelectedHighlighter;
  WSynAttr := WSynH.Attribute[lbElements.ItemIndex];
  WSynAttr.Foreground := CBElementForeground.SelectedColor;
end;

procedure TFConfiguration.CBElementBackgroundSelectedColorChanged
  (Sender: TObject);
var WSynH: TSynCustomHighlighter; WSynAttr: TSynHighlighterAttributes;
begin
  WSynH := SelectedHighlighter;
  WSynAttr := WSynH.Attribute[lbElements.ItemIndex];
  WSynAttr.Background := CBElementBackground.SelectedColor;
end;

procedure TFConfiguration.cbxElementBoldClick(Sender: TObject);
begin
  if FHandleChanges then
    UpdateColorFontStyle;
end;

procedure TFConfiguration.UpdateColorFontStyle;
var Wfs: TFontStyles; WSynH: TSynCustomHighlighter;
  WSynAttr: TSynHighlighterAttributes;
begin
  Wfs := [];
  WSynH := SelectedHighlighter;
  WSynAttr := WSynH.Attribute[lbElements.ItemIndex];

  if cbxElementBold.Checked then
    Include(Wfs, fsBold);

  if cbxElementItalic.Checked then
    Include(Wfs, fsItalic);

  if cbxElementUnderline.Checked then
    Include(Wfs, fsUnderline);

  if cbxElementStrikeout.Checked then
    Include(Wfs, fsStrikeOut);

  WSynAttr.Style := Wfs;
end;

procedure TFConfiguration.SynSyntaxSampleClick(Sender: TObject);
var TokenType, Start: Integer; Token: string; Attri: TSynHighlighterAttributes;
begin
  SynSyntaxSample.GetHighlighterAttriAtRowColEx(SynSyntaxSample.CaretXY, Token,
    TokenType, Start, Attri);
  for var I := 0 to lbElements.Count - 1 do
    if Assigned(Attri) and (lbElements.Items[I] = Attri.FriendlyName) then
    begin
      lbElements.ItemIndex := I;
      lbElementsClick(Self);
      Break;
    end;
end;

procedure TFConfiguration.EnableColorItems(Enable: Boolean);
begin
  CBElementForeground.Enabled := Enable;
  CBElementBackground.Enabled := Enable;
  cbxElementBold.Enabled := Enable;
  cbxElementItalic.Enabled := Enable;
  cbxElementUnderline.Enabled := Enable;
  cbxElementStrikeout.Enabled := Enable;
  if Enable then
  begin
    CBElementForeground.HandleNeeded;
    CBElementBackground.HandleNeeded;
  end;
end;

// https://www.slant.co/topics/358/~best-color-themes-for-Text-editors#5

function TFConfiguration.SelectedHighlighter: TSynCustomHighlighter;
begin
  Result := nil;
  if CBHighlighters.ItemIndex > -1 then
    Result := CBHighlighters.Items.Objects[CBHighlighters.ItemIndex]
      as TSynCustomHighlighter;
end;

{ --- Color Themes ------------------------------------------------------------- }

procedure TFConfiguration.lbColorThemesClick(Sender: TObject);
var AppStorage: TJvAppIniFileStorage; Filename: string;
begin
  if lbColorThemes.ItemIndex >= 0 then
  begin
    GuiPyOptions.FColorTheme := lbColorThemes.Items[lbColorThemes.ItemIndex];
    Filename := IncludeTrailingPathDelimiter(FHighlighterFileDir) +
      GuiPyOptions.FColorTheme + '.ini';
    AppStorage := TJvAppIniFileStorage.Create(nil);
    try
      AppStorage.FlushOnDestroy := False;
      AppStorage.Location := flCustom;
      AppStorage.Filename := Filename;
      SynThemeSample.Highlighter.BeginUpdate;
      try
        AppStorage.ReadPersistent('Highlighters\' +
          SynThemeSample.Highlighter.FriendlyLanguageName,
          SynThemeSample.Highlighter);
      finally
        SynThemeSample.Highlighter.EndUpdate;
      end;
    finally
      AppStorage.Free;
    end;
  end;
end;

procedure TFConfiguration.ApplyColorTheme;
var AppStorage: TJvAppIniFileStorage; Filename: string;
begin
  Filename := TPath.Combine(FHighlighterFileDir, GuiPyOptions.ColorTheme
    + '.ini');
  if FileExists(Filename) then
  begin
    AppStorage := TJvAppIniFileStorage.Create(nil);
    try
      AppStorage.FlushOnDestroy := False;
      AppStorage.Location := flCustom;
      AppStorage.Filename := Filename;
      for var I := 0 to CBHighlighters.Items.Count - 1 do
      begin
        TSynCustomHighlighter(CBHighlighters.Items.Objects[I]).BeginUpdate;
        try
          AppStorage.ReadPersistent('Highlighters\' + TSynCustomHighlighter
            (CBHighlighters.Items.Objects[I]).FriendlyLanguageName,
            TPersistent(CBHighlighters.Items.Objects[I]));
        finally
          TSynCustomHighlighter(CBHighlighters.Items.Objects[I]).EndUpdate;
        end;
      end;

      for var I := 0 to CBHighlighters.Items.Count - 1 do
        CommandsDataModule.SynEditOptionsDialogSetHighlighter(Self, I,
          TSynCustomHighlighter(CBHighlighters.Items.Objects[I]));

    finally
      AppStorage.Free;
    end;
  end;
end;

{ --- Code Templates ----------------------------------------------------------- }

procedure TFConfiguration.CodeTemplatesInit;
begin
  CodeTemplatesSetItems;
  CodeSynTemplate.Color := StyleServices.GetSystemColor(clWindow);
  CodeSynTemplate.Font.Color := StyleServices.GetSystemColor(clWindowText);
end;

procedure TFConfiguration.edShortcutKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['a' .. 'z', 'A' .. 'Z', '0' .. '9', #8]) then
    Key := #0;
end;

procedure TFConfiguration.CodeTemplatesGetItems;
begin
  FCodeTemplateText := '';
  for var I := 0 to CodeTemplatesLvItems.Items.Count - 1 do
  begin
    FCodeTemplateText := FCodeTemplateText + CodeTemplatesLvItems.Items[I]
      .Caption + sLineBreak;
    if CodeTemplatesLvItems.Items[I].SubItems[0] <> '' then
      FCodeTemplateText := FCodeTemplateText + '|' + CodeTemplatesLvItems.Items
        [I].SubItems[0] + sLineBreak;
    for var J := 0 to TStringList(CodeTemplatesLvItems.Items[I].Data)
      .Count - 1 do
      FCodeTemplateText := FCodeTemplateText + '=' +
        TStringList(CodeTemplatesLvItems.Items[I].Data)[J] + sLineBreak;
  end;
  ResourcesDataModule.CodeTemplatesCompletion.AutoCompleteList.Text :=
    FCodeTemplateText;
end;

procedure TFConfiguration.CodeTemplatesSetItems;
var Int, Count: Integer; List: TStringList;
begin
  CodeTemplatesLvItems.Items.Clear;
  Int := 0;
  Count := 0;
  List := TStringList.Create;
  try
    List.Text := ResourcesDataModule.CodeTemplatesCompletion.
      AutoCompleteList.Text;
    while Int < List.Count do
    begin
      if Length(List[Int]) <= 0 then
        // Delphi'Str string list adds a blank line at the end
        Inc(Int)
      else if not CharInSet(List[Int][1], ['|', '=']) then
      begin
        Inc(Count);
        with CodeTemplatesLvItems.Items.Add do
        begin
          Caption := List[Int];
          Data := TStringList.Create;
          Inc(Int);
          if List[Int][1] = '|' then
          begin
            SubItems.Add(Copy(List[Int], 2, MaxInt));
            Inc(Int);
          end
          else
            SubItems.Add('');
        end;
      end
      else
      begin
        if (Count > 0) and (List[Int][1] = '=') then
          TStringList(CodeTemplatesLvItems.Items[Count - 1].Data)
            .Add(Copy(List[Int], 2, MaxInt));
        Inc(Int);
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure TFConfiguration.actCodeAddItemExecute(Sender: TObject);
var Item: TListItem;
begin
  if edShortcut.Text <> '' then
  begin
    CodeSynTemplate.Modified := False;
    for var I := 0 to CodeTemplatesLvItems.Items.Count - 1 do
      if CompareText(CodeTemplatesLvItems.Items[I].Caption, edShortcut.Text) = 0
      then
      begin
        Item := CodeTemplatesLvItems.Items[I];
        Item.Caption := edShortcut.Text;
        Item.SubItems[0] := edDescription.Text;
        TStringList(Item.Data).Assign(CodeSynTemplate.Lines);
        Item.Selected := True;
        Exit;
      end;

    with CodeTemplatesLvItems.Items.Add do
    begin
      Caption := edShortcut.Text;
      SubItems.Add(edDescription.Text);
      Data := Pointer(TStringList.Create);
      TStringList(Data).Assign(CodeSynTemplate.Lines);
      Selected := True;
      MakeVisible(False);
    end;
  end;
end;

procedure TFConfiguration.actCodeDeleteItemExecute(Sender: TObject);
begin
  if CodeTemplatesLvItems.ItemIndex >= 0 then
    CodeTemplatesLvItems.Items.Delete(CodeTemplatesLvItems.ItemIndex);
end;

procedure TFConfiguration.actCodeUpdateItemExecute(Sender: TObject);
begin
  if (edShortcut.Text <> '') and (CodeTemplatesLvItems.ItemIndex >= 0) then
  begin
    for var I := 0 to CodeTemplatesLvItems.Items.Count - 1 do
      if (CompareText(CodeTemplatesLvItems.Items[I].Caption, edShortcut.Text)
        = 0) and (I <> CodeTemplatesLvItems.ItemIndex) then
      begin
        StyledMessageDlg(_(SSameName), mtError, [mbOK], 0);
        Exit;
      end;
    with CodeTemplatesLvItems.Items[CodeTemplatesLvItems.ItemIndex] do
    begin
      Caption := edShortcut.Text;
      SubItems[0] := edDescription.Text;
      TStringList(Data).Assign(CodeSynTemplate.Lines);
      CodeSynTemplate.Modified := False;
    end;
  end;
end;

procedure TFConfiguration.actCodeMoveDownExecute(Sender: TObject);
var Name, Value: string; Posi: Pointer; Index: Integer;
begin
  if CodeTemplatesLvItems.ItemIndex < CodeTemplatesLvItems.Items.Count - 1 then
  begin
    Index := CodeTemplatesLvItems.ItemIndex;
    Name := CodeTemplatesLvItems.Items[Index].Caption;
    Value := CodeTemplatesLvItems.Items[Index].SubItems[0];
    Posi := CodeTemplatesLvItems.Items[Index].Data;
    CodeTemplatesLvItems.Items[Index].Data := nil;
    // so that it does not get freed
    CodeTemplatesLvItems.Items.Delete(Index);

    with CodeTemplatesLvItems.Items.insert(Index + 1) do
    begin
      Caption := Name;
      SubItems.Add(Value);
      Data := Posi;
      Selected := True;
      MakeVisible(True);
    end;
  end;
end;

procedure TFConfiguration.actCodeMoveUpExecute(Sender: TObject);
var Name, Value: string; Posi: Pointer; Index: Integer;
begin
  if CodeTemplatesLvItems.ItemIndex > 0 then
  begin
    Index := CodeTemplatesLvItems.ItemIndex;
    Name := CodeTemplatesLvItems.Items[Index].Caption;
    Value := CodeTemplatesLvItems.Items[Index].SubItems[0];
    Posi := CodeTemplatesLvItems.Items[Index].Data;
    CodeTemplatesLvItems.Items[Index].Data := nil;
    // so that it does not get freed
    CodeTemplatesLvItems.Items.Delete(Index);

    with CodeTemplatesLvItems.Items.insert(Index - 1) do
    begin
      Caption := Name;
      SubItems.Add(Value);
      Data := Posi;
      Selected := True;
      MakeVisible(True);
    end;
  end;
end;

procedure TFConfiguration.CodeTemplatesLvItemsDeletion(Sender: TObject;
Item: TListItem);
begin
  if Assigned(Item.Data) then
    TStringList(Item.Data).Free;
end;

procedure TFConfiguration.CodeTemplatesLvItemsSelectItem(Sender: TObject;
Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    edShortcut.Text := Item.Caption;
    edDescription.Text := Item.SubItems[0];
    CodeSynTemplate.Lines.Assign(TStringList(Item.Data));
    CodeSynTemplate.Modified := False;
  end
  else
  begin
    edShortcut.Text := '';
    edDescription.Text := '';
    CodeSynTemplate.Text := '';
  end;
end;

function TFConfiguration.GetClassCodeTemplate: string;
begin
  Result := '';
  CodeTemplatesSetItems;
  for var I := 0 to CodeTemplatesLvItems.Items.Count - 1 do
    if CodeTemplatesLvItems.Items[I].Caption = 'cls' then
    begin
      Result := TStringList(CodeTemplatesLvItems.Items[I].Data).Text;
      Exit;
    end;
end;

procedure TFConfiguration.PTemplatesActionListUpdate(Action: TBasicAction;
var Handled: Boolean);
begin
  actCodeDeleteItem.Enabled := CodeTemplatesLvItems.ItemIndex >= 0;
  actCodeMoveUp.Enabled := CodeTemplatesLvItems.ItemIndex >= 1;
  actCodeMoveDown.Enabled := (CodeTemplatesLvItems.ItemIndex >= 0) and
    (CodeTemplatesLvItems.ItemIndex < CodeTemplatesLvItems.Items.Count - 1);
  actCodeAddItem.Enabled := edShortcut.Text <> '';
  actCodeUpdateItem.Enabled := (edShortcut.Text <> '') and
    (CodeTemplatesLvItems.ItemIndex >= 0);

  actFileDeleteItem.Enabled := FileTemplatesLvItems.ItemIndex >= 0;
  actFileMoveUp.Enabled := FileTemplatesLvItems.ItemIndex >= 1;
  actFileMoveDown.Enabled := (FileTemplatesLvItems.ItemIndex >= 0) and
    (FileTemplatesLvItems.ItemIndex < FileTemplatesLvItems.Items.Count - 1);
  actFileAddItem.Enabled := (edName.Text <> '') and (edCategory.Text <> '');
  actFileUpdateItem.Enabled := (edName.Text <> '') and
    (FileTemplatesLvItems.ItemIndex >= 0);
  actFileDefaultItem.Enabled := FileTemplatesLvItems.ItemIndex >= 0;
  Handled := True;
end;

{ --- File Templates ----------------------------------------------------------- }

procedure TFConfiguration.FileTemplatesInit;
begin
  FTempFileTemplates.Clear;
  if CBFileTemplatesHighlighter.Items.Count = 0 then
    for var Highlighter in ResourcesDataModule.Highlighters do
      CBHighlighters.Items.AddObject(_(Highlighter.FriendlyLanguageName),
        Highlighter);
  FileTemplatesSetItems;
end;

procedure TFConfiguration.FileTemplatesGetItems;
begin
  FileTemplates.Assign(FTempFileTemplates);
end;

procedure TFConfiguration.StoreFieldsToFileTemplate(FileTemplate
  : TFileTemplate);
begin
  FileTemplate.Name := edName.Text;
  FileTemplate.Extension := edExtension.Text;
  FileTemplate.Category := edCategory.Text;
  FileTemplate.Highlighter := CBHighlighters.Text;
  FileTemplate.Template := FileSynTemplate.Text;
end;

procedure TFConfiguration.FileTemplatesSetItems;
begin
  FTempFileTemplates.Assign(FileTemplates);
  FileTemplatesLvItems.Items.BeginUpdate;
  try
    FileTemplatesLvItems.Items.Clear;
    for var I := 0 to FTempFileTemplates.Count - 1 do
      with FileTemplatesLvItems.Items.Add do
      begin
        Caption := _((FTempFileTemplates[I] as TFileTemplate).Name);
        Data := FTempFileTemplates[I];
        SubItems.Add(TFileTemplate(FTempFileTemplates[I]).Category);
      end;
  finally
    FileTemplatesLvItems.Items.EndUpdate;
  end;
end;

procedure TFConfiguration.FileTemplatesLvItemsSelectItem(Sender: TObject;
Item: TListItem; Selected: Boolean);
var FileTemplate: TFileTemplate;
begin
  if Selected then
  begin
    FileTemplate := TFileTemplate(Item.Data);
    edName.Text := _(FileTemplate.Name);
    // the names of these templates can't be changed, because we need access to them
    if (FileTemplate.Name = SPythonTemplateName) or
      (FileTemplate.Name = STkinterTemplateName) or
      (FileTemplate.Name = SQtTemplateName) or
      (FileTemplate.Name = SClassTemplateName) then
    begin
      edName.Enabled := False;
      edExtension.Enabled := False;
    end
    else
    begin
      edName.Enabled := True;
      edExtension.Enabled := True;
    end;
    edCategory.Text := FileTemplate.Category;
    edExtension.Text := FileTemplate.Extension;
    CBFileTemplatesHighlighter.ItemIndex :=
      CBFileTemplatesHighlighter.Items.IndexOf(FileTemplate.Highlighter);
    FileSynTemplate.Text := FileTemplate.Template;
    cbFileTemplatesHighlightersChange(Self);
  end
  else
  begin
    edName.Text := '';
    edCategory.Text := '';
    edExtension.Text := '';
    CBHighlighters.ItemIndex := -1;
    FileSynTemplate.Text := '';
  end;
end;

procedure TFConfiguration.actFileAddItemExecute(Sender: TObject);
var Item: TListItem; FileTemplate: TFileTemplate;
begin
  if (edName.Text <> '') and (edCategory.Text <> '') then
  begin
    for var I := 0 to FileTemplatesLvItems.Items.Count - 1 do
      if (CompareText(FileTemplatesLvItems.Items[I].Caption, edName.Text) = 0)
        and (CompareText(FileTemplatesLvItems.Items[I].SubItems[0],
        edCategory.Text) = 0) then
      begin
        Item := FileTemplatesLvItems.Items[I];
        FileTemplate := TFileTemplate(Item.Data);
        StoreFieldsToFileTemplate(FileTemplate);
        Item.Caption := edName.Text;
        Item.SubItems[0] := edCategory.Text;
        Item.Selected := True;
        Item.MakeVisible(False);
        Exit;
      end;

    FileTemplate := TFileTemplate.Create;
    FTempFileTemplates.Add(FileTemplate);
    StoreFieldsToFileTemplate(FileTemplate);
    with FileTemplatesLvItems.Items.Add do
    begin
      Caption := edName.Text;
      SubItems.Add(edCategory.Text);
      Data := FileTemplate;
      Selected := True;
      MakeVisible(False);
    end;
  end;
end;

procedure TFConfiguration.actFileDefaultAllExecute(Sender: TObject);
begin
  var
  Int := FileTemplatesLvItems.ItemIndex;
  FTempFileTemplates.Clear;
  FileTemplates.Clear;
  FileTemplates.AddDefaultTemplates(True);
  FileTemplatesInit;
  if Int > -1 then
    FileTemplatesLvItems.ItemIndex := Int;
end;

procedure TFConfiguration.actFileDefaultItemExecute(Sender: TObject);
begin
  if FileTemplatesLvItems.ItemIndex >= 0 then
  begin
    var
    Item := FileTemplatesLvItems.Items[FileTemplatesLvItems.ItemIndex];
    var
    FileTemplate := TFileTemplate(Item.Data);
    var
    DefaultFileTemplate := FileTemplates.getDefaultByName(FileTemplate.Name);
    if Assigned(DefaultFileTemplate) then
    begin
      edName.Text := DefaultFileTemplate.Name;
      edExtension.Text := DefaultFileTemplate.Extension;
      edCategory.Text := DefaultFileTemplate.Category;
      CBHighlighters.Text := DefaultFileTemplate.Highlighter;
      CBFileTemplatesHighlighter.ItemIndex :=
        CBFileTemplatesHighlighter.Items.IndexOf
        (DefaultFileTemplate.Highlighter);
      cbFileTemplatesHighlightersChange(Self);
      FileSynTemplate.Text := DefaultFileTemplate.Template;
      actFileUpdateItemExecute(nil);
    end;
    FreeAndNil(DefaultFileTemplate);
  end;
end;

procedure TFConfiguration.actFileDeleteItemExecute(Sender: TObject);
begin
  if FileTemplatesLvItems.ItemIndex >= 0 then
  begin
    FTempFileTemplates.Delete(FileTemplatesLvItems.ItemIndex);
    FileTemplatesLvItems.Items.Delete(FileTemplatesLvItems.ItemIndex);
  end;
end;

procedure TFConfiguration.actFileUpdateItemExecute(Sender: TObject);
begin
  if (edName.Text <> '') and (FileTemplatesLvItems.ItemIndex >= 0) then
  begin
    for var I := 0 to FileTemplatesLvItems.Items.Count - 1 do
      if (CompareText(FileTemplatesLvItems.Items[I].Caption, edName.Text) = 0)
        and (CompareText(FileTemplatesLvItems.Items[I].SubItems[0],
        edCategory.Text) = 0) and (I <> FileTemplatesLvItems.ItemIndex) then
      begin
        StyledMessageDlg(_(SSameName), mtError, [mbOK], 0);
        Exit;
      end;
    with FileTemplatesLvItems.Items[FileTemplatesLvItems.ItemIndex] do
    begin
      StoreFieldsToFileTemplate(TFileTemplate(Data));
      Caption := edName.Text;
      SubItems[0] := edCategory.Text;
    end;
  end;
end;

procedure TFConfiguration.cbFileTemplatesHighlightersChange(Sender: TObject);
begin
  if CBFileTemplatesHighlighter.ItemIndex < 0 then
    FileSynTemplate.Highlighter := nil
  else
    FileSynTemplate.Highlighter := CBFileTemplatesHighlighter.Items.Objects
      [CBFileTemplatesHighlighter.ItemIndex] as TSynCustomHighlighter;
end;

procedure TFConfiguration.actFileMoveUpExecute(Sender: TObject);
var Name, Value: string; Posi: Pointer; Index: Integer;
begin
  if FileTemplatesLvItems.ItemIndex > 0 then
  begin
    Index := FileTemplatesLvItems.ItemIndex;
    Name := FileTemplatesLvItems.Items[Index].Caption;
    Value := FileTemplatesLvItems.Items[Index].SubItems[0];
    Posi := FileTemplatesLvItems.Items[Index].Data;
    FileTemplatesLvItems.Items.Delete(Index);

    with FileTemplatesLvItems.Items.insert(Index - 1) do
    begin
      Caption := Name;
      SubItems.Add(Value);
      Data := Posi;
      Selected := True;
    end;
    FTempFileTemplates.Move(Index, Index - 1);
  end;
end;

procedure TFConfiguration.actFileMoveDownExecute(Sender: TObject);
var Name, Value: string; Posi: Pointer; Index: Integer;
begin
  if FileTemplatesLvItems.ItemIndex < FileTemplatesLvItems.Items.Count - 1 then
  begin
    Index := FileTemplatesLvItems.ItemIndex;
    Name := FileTemplatesLvItems.Items[Index].Caption;
    Value := FileTemplatesLvItems.Items[Index].SubItems[0];
    Posi := FileTemplatesLvItems.Items[Index].Data;
    FileTemplatesLvItems.Items.Delete(Index);

    with FileTemplatesLvItems.Items.insert(Index + 1) do
    begin
      Caption := Name;
      SubItems.Add(Value);
      Data := Posi;
      Selected := True;
    end;
    FTempFileTemplates.Move(Index, Index + 1);
  end;
end;

procedure TFConfiguration.CBFileTemplatesHighlighterChange(Sender: TObject);
begin
  if CBFileTemplatesHighlighter.ItemIndex < 0 then
    FileSynTemplate.Highlighter := nil
  else
    FileSynTemplate.Highlighter := CBFileTemplatesHighlighter.Items.Objects
      [CBFileTemplatesHighlighter.ItemIndex] as TSynCustomHighlighter;
end;

{ --- IDE Shortcuts ------------------------------------------------------------ }

procedure TFConfiguration.lbCategoriesClick(Sender: TObject);
begin
  SelectItem(lbCategories.ItemIndex);
end;

procedure TFConfiguration.lbCommandsClick(Sender: TObject);
var Action: TActionProxyItem;
begin
  if lbCommands.ItemIndex < 0 then
    Exit;

  Action := CurrentAction;

  FEdNewShortcut.HotKey := 0;
  lbCurrentKeys.Items.Clear;
  lblDescription.Caption := GetLongHint(Action.Hint);

  if Action.ShortCut <> 0 then
    lbCurrentKeys.Items.AddObject(ShortCutToText(Action.ShortCut),
      TObject(Action.ShortCut));

  lbCurrentKeys.Items.AddStrings(Action.SecondaryShortCuts);
end;

procedure TFConfiguration.actAssignShortcutExecute(Sender: TObject);
var ShortCut: TShortCut; CurAction: TActionProxyItem;
begin
  if lbCommands.ItemIndex < 0 then
    Exit;
  if FEdNewShortcut.HotKey <> 0 then
  begin
    try
      ShortCut := FEdNewShortcut.HotKey;

      CurAction := CurrentAction;

      if lbCurrentKeys.Items.IndexOf(ShortCutToText(FEdNewShortcut.HotKey)) < 0
      then
      begin
        { show the keystroke }
        lbCurrentKeys.Items.AddObject(ShortCutToText(FEdNewShortcut.HotKey),
          TObject(FEdNewShortcut.HotKey));

        AssignKeysToActionProxy(CurAction);

        { track the keystroke assignment }
        FIDEKeyList.Add(ShortCutToText(ShortCut) + '=' + CurAction.DisplayName);

      end
      else
      begin
        MessageBeep(MB_ICONEXCLAMATION);
      end;
    except
      MessageBeep(MB_ICONEXCLAMATION);
      FEdNewShortcut.SetFocus;
    end;
  end;
end;

procedure TFConfiguration.actRemoveShortcutExecute(Sender: TObject);
var CurAction: TActionProxyItem; Index: Integer;
begin
  if (lbCurrentKeys.ItemIndex < 0) or (lbCommands.ItemIndex < 0) then
    Exit;
  CurAction := CurrentAction;
  { Remove shortcut from keylist }
  Index := FIDEKeyList.IndexOf(lbCurrentKeys.Items[lbCurrentKeys.ItemIndex] +
    '=' + CurrentAction.DisplayName);
  if Index >= 0 then
    FIDEKeyList.Delete(Index);

  { Remove shortcut from lbCurrentKeys }
  lbCurrentKeys.Items.Delete(lbCurrentKeys.ItemIndex);

  AssignKeysToActionProxy(CurAction);
end;

procedure TFConfiguration.actAssignShortcutUpdate(Sender: TObject);
var Enabled: Boolean;
begin
  Enabled := False;
  if FEdNewShortcut.HotKey = 0 then
  begin
    lblAssignedTo.Visible := False;
    lblCurrent.Visible := False;
  end
  else
  begin
    lblAssignedTo.Visible := True;
    if FIDEKeyList.IndexOfName(ShortCutToText(FEdNewShortcut.HotKey)) > -1 then
    begin
      lblCurrent.Visible := True;
      lblAssignedTo.Caption := FIDEKeyList.Values
        [ShortCutToText(FEdNewShortcut.HotKey)];
    end
    else
    begin
      Enabled := lbCommands.ItemIndex >= 0;
      lblCurrent.Visible := False;
      lblAssignedTo.Caption := '[' + _('Unassigned') + ']';
    end;
  end;
  actAssignShortcut.Enabled := Enabled;
end;

procedure TFConfiguration.actRemoveShortcutUpdate(Sender: TObject);
begin
  actRemoveShortcut.Enabled := (lbCurrentKeys.ItemIndex >= 0) and
    (lbCommands.ItemIndex >= 0);
end;

procedure TFConfiguration.actlPythonVersionsUpdate(Action: TBasicAction;
var Handled: Boolean);
var Node: PVirtualNode; Level: Integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  Level := -1; // to avoid compiler warning
  if Assigned(Node) then
    Level := vtPythonVersions.GetNodeLevel(Node);
  actPVActivate.Enabled := Assigned(Node) and (Level = 1) and
    not(((Node.Parent.Index = 0) and
    (PyControl.PythonVersionIndex = Integer(Node.Index))) or
    ((Node.Parent.Index = 1) and (PyControl.PythonVersionIndex = -(Node.
    Index + 1))));

  actPVRemove.Enabled := Assigned(Node) and (Level = 1) and
    (Node.Parent.Index = 1) and
    not(PyControl.PythonVersionIndex = -(Node.Index + 1));
  actPVRename.Enabled := Assigned(Node) and (Level = 1) and
    (Node.Parent.Index = 1);
  actPVTest.Enabled := Assigned(Node) and (Level = 1);
  actPVShow.Enabled := Assigned(Node) and (Level = 1);
  Handled := True;
end;

function TFConfiguration.GetCurrentAction: TActionProxyItem;
begin
  if lbCommands.ItemIndex < 0 then
    Exit(nil);

  Result := lbCommands.Items.Objects[lbCommands.ItemIndex] as TActionProxyItem;
end;

procedure TFConfiguration.AssignKeysToActionProxy(var CurAction
  : TActionProxyItem);
var I: Integer;
begin
  if lbCurrentKeys.Count > 0 then
    CurAction.ShortCut := TShortCut(lbCurrentKeys.Items.Objects[0])
  else
    CurAction.ShortCut := 0;
  { Assign secondary shortcuts }
  CurAction.SecondaryShortCuts.Clear;
  for I := 1 to lbCurrentKeys.Count - 1 do
    CurAction.SecondaryShortCuts.AddObject(lbCurrentKeys.Items[I],
      lbCurrentKeys.Items.Objects[I]);
end;

procedure TFConfiguration.SelectItem(Idx: Integer);
begin
  FEdNewShortcut.HotKey := 0;
  lbCurrentKeys.Items.Clear;
  lbCommands.Items.Clear;
  lblDescription.Caption := '';
  lbCommands.Items.AddStrings(FFunctionList.Objects[Idx] as TStrings);
end;

procedure TFConfiguration.CustomShortcutsCreate;
begin
  FFunctionList := TStringList.Create;
  FFunctionList.Sorted := True;
  FFunctionList.Duplicates := dupIgnore;

  FIDEKeyList := TStringList.Create;
  FIDEKeyList.Sorted := True;
  FIDEKeyList.Duplicates := dupIgnore;

  FEdNewShortcut := TSynHotKey.Create(Self);
  with FEdNewShortcut do
  begin
    Name := 'FEdNewShortcut';
    Parent := PIDEShortcuts;
    Left := PPIScale(8);
    Top := PPIScale(224);
    Width := PPIScale(169);
    Height := PPIScale(21);
    TabOrder := 4;
    InvalidKeys := [];
    Modifiers := [];
    HotKey := 0;
    Font.Color := StyleServices.GetSystemColor(clWindowText);
    Color := StyleServices.GetSystemColor(clWindow);
  end;
end;

procedure TFConfiguration.CustomShortcutsShow;
begin
  lbCategories.Items.Clear;
  lbCommands.Items.Clear;
  lbCurrentKeys.Items.Clear;
  FEdNewShortcut.HotKey := 0;
  SetCategories;
  SelectItem(0);
  lbCategories.ItemIndex := 0;
end;

procedure TFConfiguration.SetCategories;
begin
  lbCategories.Items.Clear;
  lbCategories.Items.AddStrings(FFunctionList);
  SelectItem(0);
end;

procedure TFConfiguration.DoneItems;
begin
  for var I := Pred(FFunctionList.Count) downto 0 do
  begin
    FFunctionList.Objects[I].Free;
    FFunctionList.Delete(I);
  end;
  for var I := 0 to CodeTemplatesLvItems.Items.Count - 1 do
    if Assigned(CodeTemplatesLvItems.Items[I].Data) then
    begin
      var
      StringList := TStringList(CodeTemplatesLvItems.Items[I].Data);
      FreeAndNil(StringList);
      CodeTemplatesLvItems.Items[I].Data := nil;
    end;
end;

procedure TFConfiguration.PrepActions;
begin
  FActionProxyCollection := TActionProxyCollection.Create(apcctAll);
  FillFunctionList;
  SetCategories;
end;

procedure TFConfiguration.FillFunctionList;
var Idx: Integer; Action: TActionProxyItem;
begin
  for var I := 0 to FActionProxyCollection.Count - 1 do
  begin
    Action := TActionProxyItem(FActionProxyCollection.Items[I]);

    { get category index }
    Idx := FFunctionList.IndexOf(_(Action.Category));

    { if category doesn't already exist, Add it }
    if Idx < 0 then
      Idx := FFunctionList.AddObject(_(Action.Category), TStringList.Create);

    { Add keyboard function to list }
    (FFunctionList.Objects[Idx] as TStringList)
      .AddObject(Action.DisplayName, Action);

    { shortcut Value already assigned }
    if Action.ShortCut <> 0 then
    begin
      { track the keystroke }
      FIDEKeyList.Add(ShortCutToText(Action.ShortCut) + '=' +
        Action.DisplayName);
    end;
    { Deal with secondary shortcuts }
    if Assigned(Action.SecondaryShortCuts) and
      (Action.SecondaryShortCuts.Count > 0) then
      for var J := 0 to Action.SecondaryShortCuts.Count - 1 do
        FIDEKeyList.Add(ShortCutToText(Action.SecondaryShortCuts.ShortCuts[J]) +
          '=' + Action.DisplayName);
  end;
end;

{ --- Styles ------------------------------------------------------------------- }

type
  TVclStylesPreviewClass = class(TVclStylesPreview);

procedure TFConfiguration.LBStyleNamesClick(Sender: TObject);
var LStyle: TCustomStyleServices; Filename: string; StyleName: string;
begin
  LStyle := nil;
  if LBStyleNames.ItemIndex >= 0 then
  begin
    StyleName := LBStyleNames.Items[LBStyleNames.ItemIndex];
    if Integer(LBStyleNames.Items.Objects[LBStyleNames.ItemIndex]) = 1 then
    begin
      // FileName
      if not FLoading then
      begin
        Filename := FExternalStyleFilesDict[StyleName];
        TStyleManager.LoadFromFile(Filename);
        LStyle := TStyleManager.Style[StyleName];
        FLoadedStylesDict.Add(StyleName, Filename);
        // The Style is now loaded and registerd
        LBStyleNames.Items.Objects[LBStyleNames.ItemIndex] := nil;
      end;
    end
    else
    begin
      // Resource style
      LStyle := TStyleManager.Style[StyleName];
    end;
  end;

  if Assigned(LStyle) and not FLoading then
  begin
    FPreview.Caption := StyleName;
    FPreview.Style := LStyle;
    TVclStylesPreviewClass(FPreview).Paint;
  end;
end;

procedure TFConfiguration.ActionApplyStyleExecute(Sender: TObject);
var StyleName: string; Filename: string;
begin
  if LBStyleNames.ItemIndex >= 0 then
  begin
    StyleName := LBStyleNames.Items[LBStyleNames.ItemIndex];
    if Integer(LBStyleNames.Items.Objects[LBStyleNames.ItemIndex]) = 1 then
    begin
      // FileName
      Filename := FExternalStyleFilesDict[StyleName];
      SetStyle(Filename);
    end
    else
      // Resource style
      SetStyle(StyleName);
  end;
end;

procedure TFConfiguration.BApplyStyleClick(Sender: TObject);
  var Files: TStringList;
begin
  Files:= TStringList.Create;
  // gui form windows must temporarily been closed
  GI_EditorFactory.ApplyToEditors(
    procedure(AEditor: IEditor)
    begin
      var Editor := TEditorForm(AEditor.Form);
      if Assigned(Editor.Partner) then begin
        Files.Add(TPath.ChangeExtension(Editor.Pathname, '.pfm'));
        Editor.Partner.Close;
      end;
    end);
  ActionApplyStyleExecute(Self);
  TThread.ForceQueue(nil, procedure
  begin
    for var Filename in Files do
      PyIDEMainForm.DoOpen(Filename);
    Files.Free;
  end);
end;

procedure TFConfiguration.SetStyle(const StyleName: string);
// StyleName can be either a resource or a file name
var SName: string; StyleInfo: TStyleInfo;
begin
  if CompareText(StyleName, TStyleManager.ActiveStyle.Name) = 0 then
    Exit;
  if CompareText(StyleName, 'Windows') = 0 then
  begin
    TStyleManager.SetStyle(TStyleManager.SystemStyle);
    CurrentSkinName := 'Windows';
  end
  else if FileExists(StyleName) and TStyleManager.IsValidStyle(StyleName,
    StyleInfo) then
  begin
    if not TStyleManager.TrySetStyle(StyleInfo.Name, False) then
    begin
      TStyleManager.LoadFromFile(StyleName);
      FLoadedStylesDict.Add(StyleInfo.Name, StyleName);
    end;
    TStyleManager.SetStyle(StyleInfo.Name);
    CurrentSkinName := StyleName;
  end
  else
    for SName in TStyleManager.StyleNames do
      if SName = StyleName then
      begin
        // Resource style
        TStyleManager.SetStyle(StyleName);
        if FLoadedStylesDict.ContainsKey(StyleName) then
          CurrentSkinName := FLoadedStylesDict[StyleName]
        else
          CurrentSkinName := StyleName;
        Break;
      end;
  PyIDEMainForm.ThemeEditorGutter(FSynEdit.Gutter);
  CBGutterColor.SelectedColor := FSynEdit.Gutter.Color;
  lblGutterFont.Font.Color := FSynEdit.Gutter.Font.Color;
end;

procedure TFConfiguration.StyleSelectorFormCreate;
begin
  CurrentSkinName := TStyleManager.ActiveStyle.Name;
  FLoadedStylesDict := TDictionary<string, string>.Create;

  FLoading := False;
  LBStyleNames.Sorted := True;
  FExternalStyleFilesDict := TDictionary<string, string>.Create;
  FStylesPath := TPyScripterSettings.StylesFilesDir;
  FPreview := TVclStylesPreview.Create(Self);
  FPreview.Parent := StylesPreviewPanel;
  FPreview.Icon := Application.Icon.Handle;
  FPreview.BoundsRect := StylesPreviewPanel.ClientRect;
end;

procedure TFConfiguration.StyleSelectorFormShow;
// Todo Select active style
var Index: Integer;
begin
  if LBStyleNames.Items.Count = 0 then
    FillVclStylesList;
  if LBStyleNames.Items.Count > 0 then
  begin
    Index := LBStyleNames.Items.IndexOf(TStyleManager.ActiveStyle.Name);
    if Index >= 0 then
      LBStyleNames.Selected[Index] := True
    else
      LBStyleNames.Selected[0] := True;
  end;
  LBStyleNamesClick(Self);
end;

procedure TFConfiguration.FillVclStylesList;
var Filename: string; StyleInfo: TStyleInfo;
begin
  FLoading := True;

  // First Add resource styles
  LBStyleNames.Items.AddStrings(TStyleManager.StyleNames);
  // Remove Windows
  // LBStyleNames.Items.Delete(LBStyleNames.Items.IndexOf('Windows'));

  // Then styles in files
  try
    for Filename in TDirectory.GetFiles(FStylesPath, '*.vsf') do
    begin
      if TStyleManager.IsValidStyle(Filename, StyleInfo) and
        (LBStyleNames.Items.IndexOf(StyleInfo.Name) < 0) then
      begin
        // TObject(1) denotes external file
        LBStyleNames.Items.AddObject(StyleInfo.Name, TObject(1));
        FExternalStyleFilesDict.Add(StyleInfo.Name, Filename);
      end;
    end;
  except
    on E: Exception do
      OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
  end;
  FLoading := False;
end;

{ --- Printer Margins & Options ------------------------------------------------ }

procedure TFConfiguration.CBUnitsChange(Sender: TObject);
begin
  FInternalCall := True;
  GetMargins(FMargins);
  FInternalCall := False;
  FMargins.UnitSystem := TUnitSystem(CBUnits.ItemIndex);
  SetMargins(FMargins);
end;

procedure TFConfiguration.GetMargins(SynEditMargins: TSynEditPrintMargins);
var CurEdit: TEdit;
  function StringToFloat(Edit: TEdit): Double;
  begin
    CurEdit := Edit;
    Result := StrToFloat(Edit.Text);
  end;

begin
  with SynEditMargins do
  begin
    if not FInternalCall then
      UnitSystem := TUnitSystem(CBUnits.ItemIndex);
    try
      Left := StringToFloat(EditLeft);
      Right := StringToFloat(EditRight);
      Top := StringToFloat(EditTop);
      Bottom := StringToFloat(EditBottom);
      Gutter := StringToFloat(EditGutter);
      Header := StringToFloat(EditHeader);
      Footer := StringToFloat(EditFooter);
      LeftHFTextIndent := StringToFloat(EditLeftHFTextIndent);
      RightHFTextIndent := StringToFloat(EditRightHFTextIndent);
      HFInternalMargin := StringToFloat(EditHFInternalMargin);
    except
      StyledMessageDlg(_(SInvalidNumber), mtError, [mbOK], 0);
      CurEdit.SetFocus;
    end;
    MirrorMargins := CBMirrorMargins.Checked;
  end;
end;

procedure TFConfiguration.SetMargins(SynEditMargins: TSynEditPrintMargins);
begin
  with SynEditMargins do
  begin
    CBUnits.ItemIndex := Ord(UnitSystem);
    EditLeft.Text := FloatToStr(Left);
    EditRight.Text := FloatToStr(Right);
    EditTop.Text := FloatToStr(Top);
    EditBottom.Text := FloatToStr(Bottom);
    EditGutter.Text := FloatToStr(Gutter);
    EditHeader.Text := FloatToStr(Header);
    EditFooter.Text := FloatToStr(Footer);
    EditLeftHFTextIndent.Text := FloatToStr(LeftHFTextIndent);
    EditRightHFTextIndent.Text := FloatToStr(RightHFTextIndent);
    EditHFInternalMargin.Text := FloatToStr(HFInternalMargin);
    CBMirrorMargins.Checked := MirrorMargins;
  end;
end;

{ --- Printer Header & Footer -------------------------------------------------- }

procedure TFConfiguration.PageNumCmdExecute(Sender: TObject);
begin
  if Assigned(FEditor) then
    FEditor.SelText := '$PAGENUM$';
end;

procedure TFConfiguration.PagesCmdExecute(Sender: TObject);
begin
  if Assigned(FEditor) then
    FEditor.SelText := '$PAGECOUNT$';
end;

procedure TFConfiguration.TimeCmdExecute(Sender: TObject);
begin
  if Assigned(FEditor) then
    FEditor.SelText := '$TIME$';
end;

procedure TFConfiguration.TitleCmdExecute(Sender: TObject);
begin
  if Assigned(FEditor) then
    FEditor.SelText := '$TITLE$';
end;

procedure TFConfiguration.DateCmdExecute(Sender: TObject);
begin
  if Assigned(FEditor) then
    FEditor.SelText := '$DATE$';
end;

procedure TFConfiguration.FontCmdExecute(Sender: TObject);
begin
  if not Assigned(FEditor) then
    Exit;

  SelectLine(FHeaderFooterCharPos.Y);
  FontDialog.Font.Assign(CurrText);
  if FontDialog.Execute then
    CurrText.Assign(FontDialog.Font);
  SelectNone;
end;

procedure TFConfiguration.BoldCmdExecute(Sender: TObject);
begin
  if not Assigned(FEditor) then
    Exit;

  SelectLine(FHeaderFooterCharPos.Y);
  if fsBold in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsBold]
  else
    CurrText.Style := CurrText.Style + [fsBold];
  SelectNone;
end;

procedure TFConfiguration.ItalicCmdExecute(Sender: TObject);
begin
  if not Assigned(FEditor) then
    Exit;

  SelectLine(FHeaderFooterCharPos.Y);
  if fsItalic in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsItalic]
  else
    CurrText.Style := CurrText.Style + [fsItalic];
  SelectNone;
end;

procedure TFConfiguration.UnderlineCmdExecute(Sender: TObject);
begin
  if not Assigned(FEditor) then
    Exit;

  SelectLine(FHeaderFooterCharPos.Y);
  if fsUnderline in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsUnderline]
  else
    CurrText.Style := CurrText.Style + [fsUnderline];
  SelectNone;
end;

procedure TFConfiguration.REHeaderLeftEnter(Sender: TObject);
begin
  FEditor := Sender as TCustomRichEdit;
  SetHeaderFooterOptions;
end;

procedure TFConfiguration.REHeaderLeftSelectionChange(Sender: TObject);
begin
  UpdateHeaderFooterCursorPos;
end;

procedure TFConfiguration.RGLanguagesClick(Sender: TObject);
begin
  LanguageOptionsToModel;
  PyIDEMainForm.AppStorage.WritePersistent('GuiPy Language Options\' +
    FCurrentLanguage, GuiPyLanguageOptions);
  FCurrentLanguage := PyIDEMainForm.getLanguageCode(RGLanguages.ItemIndex);
  GuiPyLanguageOptions.GetInLanguage(FCurrentLanguage);
  PyIDEMainForm.AppStorage.ReadPersistent('GuiPy Language Options\' +
    FCurrentLanguage, GuiPyLanguageOptions);
  LanguageOptionsToView;
end;

procedure TFConfiguration.HeaderLineColorBtnClick(Sender: TObject);
begin
  ColorDialog.Color := PBHeaderLine.Color;
  if ColorDialog.Execute then
    PBHeaderLine.Color := ColorDialog.Color;
end;

procedure TFConfiguration.HeaderShadowColorBtnClick(Sender: TObject);
begin
  ColorDialog.Color := PBHeaderShadow.Color;
  if ColorDialog.Execute then
    PBHeaderShadow.Color := ColorDialog.Color;
end;

procedure TFConfiguration.PBHeaderLinePaint(Sender: TObject);
begin
  with (Sender as TPaintBox).Canvas do
  begin
    Brush.Color := (Sender as TPaintBox).Color;
    FillRect((Sender as TPaintBox).ClientRect);
    Pen.Style := psDot;
    Brush.Style := bsClear;
    Rectangle(0, 0, (Sender as TPaintBox).Width, (Sender as TPaintBox).Height);
  end;
end;

procedure TFConfiguration.FooterLineColorBtnClick(Sender: TObject);
begin
  ColorDialog.Color := PBFooterLine.Color;
  if ColorDialog.Execute then
    PBFooterLine.Color := ColorDialog.Color;
end;

procedure TFConfiguration.FooterShadowColorBtnClick(Sender: TObject);
begin
  ColorDialog.Color := PBFooterShadow.Color;
  if ColorDialog.Execute then
    PBFooterShadow.Color := ColorDialog.Color;
end;

procedure TFConfiguration.SelectLine(LineNum: Integer);
begin
  if Assigned(FEditor) then
  begin
    FHeaderFooterOldStart := FEditor.SelStart;
    FEditor.SelStart := SendMessage(FEditor.Handle, EM_LINEINDEX, LineNum, 0);
    FEditor.SelLength := Length(FEditor.Lines[LineNum]);
  end;
end;

procedure TFConfiguration.SetHeaderFooterOptions;
begin
  PageNumCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  PagesCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  TimeCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  DateCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  TitleCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  FontCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  BoldCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  ItalicCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
  UnderlineCmd.Enabled := Assigned(FEditor) and FEditor.Focused;
end;

function TFConfiguration.CurrText: TTextAttributes;
begin
  Assert(Assigned(FEditor), 'CurrText');
  Result := FEditor.SelAttributes;
end;

procedure TFConfiguration.SelectNone;
begin
  if Assigned(FEditor) then
  begin
    FEditor.SelStart := FHeaderFooterOldStart;
    FEditor.SelLength := 0;
  end;
end;

procedure TFConfiguration.UpdateHeaderFooterCursorPos;
begin
  if Assigned(FEditor) and FEditor.HandleAllocated then
  begin
    FHeaderFooterCharPos.Y := SendMessage(FEditor.Handle, EM_EXLINEFROMCHAR, 0,
      FEditor.SelStart);
    FHeaderFooterCharPos.X := (FEditor.SelStart - SendMessage(FEditor.Handle,
      EM_LINEINDEX, FHeaderFooterCharPos.Y, 0));
  end;
end;

procedure TFConfiguration.AddLines(HeadFoot: THeaderFooter;
AEdit: TCustomRichEdit; Alig: TAlignment);
var AFont: TFont;
begin
  FEditor := AEdit;
  AFont := TFont.Create;
  for var I := 0 to FEditor.Lines.Count - 1 do
  begin
    SelectLine(I);
    AFont.Assign(CurrText);
    if not CBColors.Checked then
      AFont.Color := HeadFoot.DefaultFont.Color;

    // TrimRight is used to fix a long standing bug occurring because
    // TntRichEdit ads #$D at the end of the string!
    HeadFoot.Add(TrimRight(FEditor.Lines[I]), AFont, Alig, I + 1);
  end;
  AFont.Free;
end;

procedure TFConfiguration.GetValues(SynEditPrint: TSynEditPrint);
begin
  GetMargins(SynEditPrint.Margins);
  SynEditPrint.LineNumbers := CBLineNumbers.Checked;
  SynEditPrint.LineNumbersInMargin := CBLineNumbersInMargin.Checked;
  SynEditPrint.Highlight := CBHighlight.Checked;
  SynEditPrint.Colors := CBColors.Checked;
  SynEditPrint.Wrap := CBWrap.Checked;

  SynEditPrint.Header.FrameTypes := [];
  if CBHeaderLine.Checked then
    SynEditPrint.Header.FrameTypes := SynEditPrint.Header.FrameTypes + [ftLine];
  if CBHeaderBox.Checked then
    SynEditPrint.Header.FrameTypes := SynEditPrint.Header.FrameTypes + [ftBox];
  if CBHeaderShadow.Checked then
    SynEditPrint.Header.FrameTypes := SynEditPrint.Header.FrameTypes +
      [ftShaded];
  SynEditPrint.Header.LineColor := PBHeaderLine.Color;
  SynEditPrint.Header.ShadedColor := PBHeaderShadow.Color;
  SynEditPrint.Header.MirrorPosition := CBHeaderMirror.Checked;

  SynEditPrint.Footer.FrameTypes := [];
  if CBFooterLine.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftLine];
  if CBFooterBox.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftBox];
  if CBFooterShadow.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes +
      [ftShaded];
  SynEditPrint.Footer.LineColor := PBFooterLine.Color;
  SynEditPrint.Footer.ShadedColor := PBFooterShadow.Color;
  SynEditPrint.Footer.MirrorPosition := CBFooterMirror.Checked;

  SynEditPrint.Header.Clear;
  AddLines(SynEditPrint.Header, REHeaderLeft, taLeftJustify);
  AddLines(SynEditPrint.Header, REHeaderCenter, taCenter);
  AddLines(SynEditPrint.Header, REHeaderRight, taRightJustify);

  SynEditPrint.Footer.Clear;
  AddLines(SynEditPrint.Footer, REFooterLeft, taLeftJustify);
  AddLines(SynEditPrint.Footer, REFooterCenter, taCenter);
  AddLines(SynEditPrint.Footer, REFooterRight, taRightJustify);
end;

procedure TFConfiguration.SetValues(SynEditPrint: TSynEditPrint);
var AItem: THeaderFooterItem; LNum: Integer;
begin
  REHeaderLeft.Lines.Clear;
  REHeaderCenter.Lines.Clear;
  REHeaderRight.Lines.Clear;
  REFooterLeft.Lines.Clear;
  REFooterCenter.Lines.Clear;
  REFooterRight.Lines.Clear;
  SetMargins(SynEditPrint.Margins);
  CBLineNumbers.Checked := SynEditPrint.LineNumbers;
  CBLineNumbersInMargin.Checked := SynEditPrint.LineNumbersInMargin;
  CBHighlight.Checked := SynEditPrint.Highlight;
  CBColors.Checked := SynEditPrint.Colors;
  CBWrap.Checked := SynEditPrint.Wrap;

  REHeaderLeft.Font := SynEditPrint.Header.DefaultFont;
  REHeaderCenter.Font := SynEditPrint.Header.DefaultFont;
  REHeaderRight.Font := SynEditPrint.Header.DefaultFont;
  REFooterLeft.Font := SynEditPrint.Footer.DefaultFont;
  REFooterCenter.Font := SynEditPrint.Footer.DefaultFont;
  REFooterRight.Font := SynEditPrint.Footer.DefaultFont;

  CBHeaderLine.Checked := ftLine in SynEditPrint.Header.FrameTypes;
  CBHeaderBox.Checked := ftBox in SynEditPrint.Header.FrameTypes;
  CBHeaderShadow.Checked := ftShaded in SynEditPrint.Header.FrameTypes;
  PBHeaderLine.Color := SynEditPrint.Header.LineColor;
  PBHeaderShadow.Color := SynEditPrint.Header.ShadedColor;
  CBHeaderMirror.Checked := SynEditPrint.Header.MirrorPosition;

  CBFooterLine.Checked := ftLine in SynEditPrint.Footer.FrameTypes;
  CBFooterBox.Checked := ftBox in SynEditPrint.Footer.FrameTypes;
  CBFooterShadow.Checked := ftShaded in SynEditPrint.Footer.FrameTypes;
  PBFooterLine.Color := SynEditPrint.Footer.LineColor;
  PBFooterShadow.Color := SynEditPrint.Footer.ShadedColor;
  CBFooterMirror.Checked := SynEditPrint.Footer.MirrorPosition;

  SynEditPrint.Header.FixLines;
  for var I := 0 to SynEditPrint.Header.Count - 1 do
  begin
    AItem := SynEditPrint.Header.Get(I);
    case AItem.Alignment of
      taLeftJustify:
        FEditor := REHeaderLeft;
      taCenter:
        FEditor := REHeaderCenter;
      taRightJustify:
        FEditor := REHeaderRight;
    end;
    LNum := FEditor.Lines.Add(AItem.Text);
    SelectLine(LNum);
    CurrText.Assign(AItem.Font);
    SelectNone;
  end;

  SynEditPrint.Footer.FixLines;
  for var I := 0 to SynEditPrint.Footer.Count - 1 do
  begin
    AItem := SynEditPrint.Footer.Get(I);
    case AItem.Alignment of
      taLeftJustify:
        FEditor := REFooterLeft;
      taCenter:
        FEditor := REFooterCenter;
      taRightJustify:
        FEditor := REFooterRight;
    end;
    LNum := FEditor.Lines.Add(AItem.Text);
    SelectLine(LNum);
    CurrText.Assign(AItem.Font);
    SelectNone;
  end;
end;

{ --- Associations ------------------------------------------------------------- }

procedure TFConfiguration.BFileExtensionsClick(Sender: TObject);
var Str, Str1, Str2: string; Posi: Integer; Len: Byte;
begin
  if VistaOrBetter then
  begin
    Str2 := CBAssociationPython.Caption + ' ' +
      BoolToStr(CBAssociationPython.Checked) + ' ';
    Str2 := Str2 + CBAssociationPfm.Caption + ' ' +
      BoolToStr(CBAssociationPfm.Checked) + ' ';
    Str2 := Str2 + CBAssociationPuml.Caption + ' ' +
      BoolToStr(CBAssociationPuml.Checked) + ' ';
    Str2 := Str2 + CBAssociationHtml.Caption + ' ' +
      BoolToStr(CBAssociationHtml.Checked) + ' ';
    Str2 := Str2 + CBAssociationTxt.Caption + ' ' +
      BoolToStr(CBAssociationTxt.Checked) + ' ';
    Str2 := Str2 + CBAssociationJsp.Caption + ' ' +
      BoolToStr(CBAssociationJsp.Checked) + ' ';
    Str2 := Str2 + CBAssociationPhp.Caption + ' ' +
      BoolToStr(CBAssociationPhp.Checked) + ' ';
    Str2 := Str2 + CBAssociationCss.Caption + ' ' +
      BoolToStr(CBAssociationCss.Checked) + ' ';
    Str2 := Str2 + CBAssociationInc.Caption + ' ' +
      BoolToStr(CBAssociationInc.Checked) + ' ';
    Str2 := Str2 + CBAssociationPsg.Caption + ' ' +
      BoolToStr(CBAssociationPsg.Checked) + ' ';
    Str2 := Str2 + CBAssociationPsd.Caption + ' ' +
      BoolToStr(CBAssociationPsd.Checked) + ' ';

    Str := GuiPyOptions.AdditionalAssociations + ';';
    Posi := Pos(';', Str);
    while Posi > 0 do
    begin
      Str1 := Copy(Str, 1, Posi - 1);
      Delete(Str, 1, Posi);
      Posi := Pos('.', Str1);
      if Posi > 0 then
        Delete(Str1, 1, Posi);
      Len := Length(Str1);
      if (Str1 <> '') and (Len in [2, 3, 4, 5]) then
        Str2 := Str2 + '.' + Str1 + ' ' + BoolToStr(True) + ' ';
      Posi := Pos(';', Str);
    end;
    CallUpdater(ParamStr(0), 'registry', Str2);
  end
  else
    MakeAssociations;
end;

procedure TFConfiguration.BJEAssociationClick(Sender: TObject);
begin
  CallUpdater(ParamStr(0), 'gpregistry',
    HideBlanks(EncodeQuotationMark(EGuiPyAssociation.Text)));
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TFConfiguration.MakeAssociations;
var Reg: TRegistry; Str, Str1: string; Posi: Integer;

  procedure EditAssociation(const Extension: string; DoCreate: Boolean);
  begin
    with Reg do
    begin
      try
        Access := KEY_ALL_ACCESS;
        // HKEY_LOCAL_MACHINE\Software\Classes
        RootKey := HKEY_LOCAL_MACHINE;
        if DoCreate then
        begin
          if OpenKey('SOFTWARE\Classes\' + Extension, True) then
            WriteString('', 'GuiPy');
        end
        else
        begin
          if OpenKey('SOFTWARE\Classes\' + Extension, False) then
            if ReadString('') = 'GuiPy' then
              WriteString('', '');
        end;
        CloseKey;

        // HKEY_CURRENT_USER\Software\Classes
        RootKey := HKEY_CURRENT_USER;
        if DoCreate then
        begin
          if OpenKey('SOFTWARE\Classes\' + Extension, True) then
            WriteString('', 'GuiPy');
        end
        else
        begin
          if OpenKey('SOFTWARE\Classes\' + Extension, False) then
            if ReadString('') = 'GuiPy' then
              WriteString('', '');
        end;
        CloseKey;
      except
        on E: Exception do
          ErrorMsg(E.Message);
      end;
    end;
  end;

begin
  RegisterGuiPy;
  Reg := TRegistry.Create;
  try
    with Reg do
    begin
      EditAssociation(CBAssociationPython.Caption, CBAssociationPython.Checked);
      EditAssociation(CBAssociationPfm.Caption, CBAssociationPfm.Checked);
      EditAssociation(CBAssociationPuml.Caption, CBAssociationPuml.Checked);
      EditAssociation(CBAssociationHtml.Caption, CBAssociationHtml.Checked);
      EditAssociation(CBAssociationTxt.Caption, CBAssociationTxt.Checked);
      EditAssociation(CBAssociationJsp.Caption, CBAssociationJsp.Checked);
      EditAssociation(CBAssociationPhp.Caption, CBAssociationPhp.Checked);
      EditAssociation(CBAssociationCss.Caption, CBAssociationCss.Checked);
      EditAssociation(CBAssociationInc.Caption, CBAssociationInc.Checked);
      EditAssociation(CBAssociationPsg.Caption, CBAssociationPsg.Checked);
      EditAssociation(CBAssociationPsd.Caption, CBAssociationPsd.Checked);
      Str := GuiPyOptions.AdditionalAssociations + ';';
      Posi := Pos(';', Str);
      while Posi > 0 do
      begin
        Str1 := Copy(Str, 1, Posi - 1);
        Delete(Str, 1, Posi);
        Posi := Pos('.', Str1);
        if Posi > 0 then
          Delete(Str1, 1, Posi);
        if (Str1 <> '') and (Pos(' ', Str1) = 0) then
          EditAssociation('.' + Str1, True);
        Posi := Pos(';', Str);
      end;
    end;
  finally
    FreeAndNil(Reg);
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TFConfiguration.RegisterGuiPy;
var GuiPy, Filename: string; Reg: TRegistry;

  procedure WriteToRegistry(const Key: string);
  begin
    with Reg do
    begin
      OpenKey(Key, True);
      WriteString('', 'GuiPy');
      CloseKey;
      OpenKey(Key + '\DefaultIcon', True);
      WriteString('', GuiPy + ',0');
      CloseKey;
      OpenKey(Key + '\Shell\Open\command', True);
      WriteString('', GuiPy);
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec', True);
      WriteString('', '[FileOpen("%1")]');
      OpenKey('Application', True);
      Filename := ExtractFileName(ParamStr(0));
      Filename := Copy(Filename, 1, Length(Filename) - 4);
      WriteString('', Filename);
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec\topic', True);
      WriteString('', 'DdeServerConv');
      CloseKey;
    end;
  end;

begin
  GuiPy := HideBlanks(ParamStr(0)) + ' "%1"';
  Reg := TRegistry.Create;
  try
    with Reg do
    begin
      Access := KEY_ALL_ACCESS;
      RootKey := HKEY_LOCAL_MACHINE;
      WriteToRegistry('SOFTWARE\Classes\GuiPy');
      RootKey := HKEY_CURRENT_USER;
      WriteToRegistry('\SOFTWARE\Classes\GuiPy');
    end;
  finally
    FreeAndNil(Reg);
  end;
end;

procedure TFConfiguration.PatchConfiguration;
// first used for version 3.2
var Str: string;
begin
  var
  Reg := TRegistry.Create;
  try
    with Reg do
    begin
      Access := KEY_ALL_ACCESS;
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\ddeexec\topic', False) then
        if ReadString('') = 'System' then
          WriteString('', 'DdeServerConv');
      if OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\command', False) then
      begin
        Str := ReadString('');
        if Pos(' "%1"', Str) = 0 then
          WriteString('', Str + ' "%1"');
      end;
      CloseKey;

      RootKey := HKEY_CURRENT_USER;
      if OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\ddeexec\topic', False) then
        if ReadString('') = 'System' then
          WriteString('', 'DdeServerConv');
      if OpenKey('\SOFTWARE\Classes\GuiPy\Shell\Open\command', False) then
      begin
        Str := ReadString('');
        if Pos(' "%1"', Str) = 0 then
          WriteString('', Str + ' "%1"');
      end;
      CloseKey;
    end;
  finally
    FreeAndNil(Reg);
  end;
end;

{ --- Git ---------------------------------------------------------------------- }

procedure TFConfiguration.BGitFolderClick(Sender: TObject);
var Dir: string;
begin
  Dir := EGitFolder.Hint;
  if not SysUtils.DirectoryExists(Dir) then
    Dir := GuiPyOptions.Sourcepath;
  FolderDialog.DefaultFolder := Dir;
  if FolderDialog.Execute then
    ShortenPath(EGitFolder, FolderDialog.Filename);
  CheckFolder(EGitFolder, True);
end;

procedure TFConfiguration.BGitRepositoryClick(Sender: TObject);
var Dir: string;
begin
  Dir := CBLocalRepository.Text;
  if not SysUtils.DirectoryExists(Dir) then
    Dir := GuiPyOptions.Sourcepath;
  FolderDialog.DefaultFolder := Dir;
  if FolderDialog.Execute then
  begin
    Dir := FolderDialog.Filename;
    SysUtils.ForceDirectories(Dir);
    if not FGit.IsRepository(Dir) then
      FGit.GitCall('init', Dir);
    if CBLocalRepository.Items.IndexOf(Dir) = -1 then
      CBLocalRepository.Items.insert(0, Dir);
    CBLocalRepository.Text := Dir;
  end;
  CheckFolderCB(CBLocalRepository);
end;

procedure TFConfiguration.BGuiFontClick(Sender: TObject);
begin
  FontDialog.Font.Size := GuiPyOptions.GuiFontSize;
  FontDialog.Font.Name := GuiPyOptions.GuiFontName;
  if FontDialog.Execute then
  begin
    GuiPyOptions.GuiFontSize := Max(FontDialog.Font.Size, 4);
    GuiPyOptions.GuiFontName := FontDialog.Font.Name;
  end;
end;

procedure TFConfiguration.BGuiFontDefaultClick(Sender: TObject);
begin
  GuiPyOptions.GuiFontSize := 9;
  GuiPyOptions.GuiFontName := 'Segoe UI';
end;

procedure TFConfiguration.BGitCloneClick(Sender: TObject);
var Dir, Remote, AName: string;
begin
  Screen.Cursor := crHourGlass;
  try
    Dir := CBLocalRepository.Text;
    Remote := CBRemoteRepository.Text;
    if not SysUtils.DirectoryExists(Dir) then
      SysUtils.ForceDirectories(Dir);
    FGit.GitCall('clone ' + Remote + ' ', Dir);
    AName := ExtractFileNameEx(Remote);
    AName := ChangeFileExt(AName, '');
    if not Dir.EndsWith('\' + AName) then
      CBLocalRepository.Text := Dir + '\' + AName;
    if CBRemoteRepository.Items.IndexOf(Remote) = -1 then
      CBRemoteRepository.Items.insert(0, Remote);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFConfiguration.LGitFolderClick(Sender: TObject);
begin
  DoHelp('https://git-scm.com/');
end;

{ --- SVN ---------------------------------------------------------------------- }

procedure TFConfiguration.BSVNClick(Sender: TObject);
var Dir: string;
begin
  Dir := ESVNFolder.Hint;
  if not SysUtils.DirectoryExists(Dir) then
    Dir := GuiPyOptions.Sourcepath;
  FolderDialog.DefaultFolder := Dir;
  if FolderDialog.Execute then
    ShortenPath(ESVNFolder, FolderDialog.Filename);
  CheckFolder(ESVNFolder, True);
end;

procedure TFConfiguration.BRepositoryClick(Sender: TObject);
var Dir: string;
begin
  Dir := CBRepository.Hint;
  if not SysUtils.DirectoryExists(Dir) then
    Dir := GuiPyOptions.Sourcepath;
  FolderDialog.DefaultFolder := Dir;
  if FolderDialog.Execute then
  begin
    Dir := FolderDialog.Filename;
    ShortenPath(CBRepository, Dir);
    SysUtils.ForceDirectories(Dir);
    if not FSubversion.IsRepository(Dir) then
      FSubversion.CallSVN('\svnadmin.exe', 'create ' + HideBlanks(Dir));
  end;
  CheckFolderCB(CBRepository);
end;

procedure TFConfiguration.LSVNClick(Sender: TObject);
begin
  DoHelp('https://subversion.apache.org/');
end;

procedure TFConfiguration.OpenAndShowPage(const Page: string);
begin
  // due to visible/modal-exception
  if not Visible then
  begin
    PrepareShow;
    TThread.ForceQueue(nil,
      procedure
      begin
        TVConfiguration.Selected := GetTVConfigurationItem(_(Page));
      end);
    ShowModal;
  end;
end;

procedure TFConfiguration.AddScriptsPath;
begin
  var
  ScriptsPath := PyControl.PythonVersion.InstallPath;
  var
  Path := GetEnvironmentVariable('Path');
  if Pos(ScriptsPath, Path) = 0 then
  begin
    Path := ScriptsPath + ';' + Path;
    SetEnvironmentVariable('Path', PChar(Path));
  end;

  ScriptsPath := TPath.Combine(PyControl.PythonVersion.InstallPath, 'Scripts');
  if Pos(ScriptsPath, Path) = 0 then
  begin
    Path := ScriptsPath + ';' + Path;
    SetEnvironmentVariable('Path', PChar(Path));
  end;

end;

function TFConfiguration.GetClassesAndFilename(const Pathname: string)
  : TStringList;
var Filename, Text, Path, Key: string; RegEx: TRegEx; Matches: TMatchCollection;
begin
  Result := TStringList.Create;
  RegEx := CompiledRegEx('\s*class\s+(\w*)(\(.*\))?\s*:');
  // classes in the active source file
  Text := IOUtils.TFile.ReadAllText(Pathname);
  Matches := RegEx.Matches(Text);
  for var I := 0 to Matches.Count - 1 do
    Result.Add(Matches[I].Groups[1].Value + '=' + ExtractFileName(Pathname));
  // classes in other files of the active directory
  Path := ExtractFilePath(Pathname);
  for Filename in TDirectory.GetFiles(Path, '*.py') do
  begin
    Text := IOUtils.TFile.ReadAllText(Filename);
    Matches := RegEx.Matches(Text);
    for var I := 0 to Matches.Count - 1 do
    begin
      Key := Matches[I].Groups[1].Value;
      if Result.IndexOfName(Key) = -1 then
        Result.Add(Key + '=' + ExtractFileName(Filename));
    end;
  end;
end;

procedure TFConfiguration.LoadVisibility;
var Num: Integer;

  procedure StringVisibilityToArr1(Str: string; var Arr: TBoolArray);
  begin
    for var I := 0 to High(Arr) do
      Arr[I] := (Str[I + 1] = '1');
  end;

  procedure StringVisibilityToArr2(Str: string; Count, Num: Integer);
  begin
    for var I := 0 to Count - 1 do
      FVis1[Num, I] := (Str[I + 1] = '1');
  end;

begin
  if Length(GuiPyOptions.FVisTabs) <> VisTabsLen then
    GuiPyOptions.FVisTabs := StringOfChar('1', VisTabsLen);
  StringVisibilityToArr1(GuiPyOptions.FVisTabs, FVisTabs);

  if Length(GuiPyOptions.FVisMenus) <> VisMenusLen then
    GuiPyOptions.FVisMenus := StringOfChar('1', VisMenusLen);
  StringVisibilityToArr1(GuiPyOptions.FVisMenus, FVisMenus);

  if Length(GuiPyOptions.FVisToolbars) <> VisToolbarsLen then
    GuiPyOptions.FVisToolbars := StringOfChar('1', VisToolbarsLen);
  StringVisibilityToArr1(GuiPyOptions.FVisToolbars, FVisToolbars);

  Num := PyIDEMainForm.ToolbarProgram.ButtonCount;
  if Length(GuiPyOptions.VisProgram) <> Num then
    GuiPyOptions.VisProgram := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisProgram, Num, 0);

  Num := PyIDEMainForm.ToolbarTkinter.ButtonCount;
  if Length(GuiPyOptions.VisTkinter) <> Num then
    GuiPyOptions.VisTkinter := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisTkinter, Num, 1);

  Num := PyIDEMainForm.ToolbarTTK.ButtonCount;
  if Length(GuiPyOptions.VisTTK) <> Num then
    GuiPyOptions.VisTTK := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisTTK, Num, 2);

  Num := PyIDEMainForm.ToolBarQtBase.ButtonCount;
  if Length(GuiPyOptions.VisQtBase) <> Num then
    GuiPyOptions.VisQtBase := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisQtBase, Num, 3);

  Num := PyIDEMainForm.ToolBarQtControls.ButtonCount;
  if Length(GuiPyOptions.VisQtControls) <> Num then
    GuiPyOptions.VisQtControls := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisQtControls, Num, 4);

  // --- Menus
  Num := Length(DefaultVisFileMenu);
  if Length(GuiPyOptions.VisFileMenu) <> Num then
    GuiPyOptions.VisFileMenu := DefaultVisFileMenu;
  StringVisibilityToArr2(GuiPyOptions.VisFileMenu, Num, 5);

  Num := Length(DefaultVisEditMenu);
  if Length(GuiPyOptions.VisEditMenu) <> Num then
    GuiPyOptions.VisEditMenu := DefaultVisEditMenu;
  StringVisibilityToArr2(GuiPyOptions.VisEditMenu, Num, 6);

  Num := Length(DefaultVisSearchMenu);
  if Length(GuiPyOptions.VisSearchMenu) <> Num then
    GuiPyOptions.VisSearchMenu := DefaultVisSearchMenu;
  StringVisibilityToArr2(GuiPyOptions.VisSearchMenu, Num, 7);

  Num := Length(DefaultVisViewMenu);
  if Length(GuiPyOptions.VisViewMenu) <> Num then
    GuiPyOptions.VisViewMenu := DefaultVisViewMenu
  else if Copy(GuiPyOptions.VisViewMenu, 23, 2) = '00' then
    // fix visibility since version 6.06
    GuiPyOptions.VisViewMenu := Copy(GuiPyOptions.VisViewMenu, 1, 22) + '11';

  StringVisibilityToArr2(GuiPyOptions.VisViewMenu, Num, 8);

  Num := Length(DefaultVisProjectMenu);
  if Length(GuiPyOptions.VisProjectMenu) <> Num then
    GuiPyOptions.VisProjectMenu := DefaultVisProjectMenu;
  StringVisibilityToArr2(GuiPyOptions.VisProjectMenu, Num, 9);

  Num := Length(DefaultVisRunMenu);
  if Length(GuiPyOptions.VisRunMenu) <> Num then
    GuiPyOptions.VisRunMenu := DefaultVisRunMenu;
  StringVisibilityToArr2(GuiPyOptions.VisRunMenu, Num, 10);

  Num := Length(DefaultVisUMLMenu);
  if Length(GuiPyOptions.VisUMLMenu) <> Num then
    GuiPyOptions.VisUMLMenu := DefaultVisUMLMenu;
  StringVisibilityToArr2(GuiPyOptions.VisUMLMenu, Num, 11);

  Num := Length(DefaultVisToolsMenu);
  if Length(GuiPyOptions.VisToolsMenu) <> Num then
    GuiPyOptions.VisToolsMenu := DefaultVisToolsMenu;
  StringVisibilityToArr2(GuiPyOptions.VisToolsMenu, Num, 12);

  Num := Length(DefaultVisHelpMenu);
  if Length(GuiPyOptions.VisHelpMenu) <> Num then
    GuiPyOptions.VisHelpMenu := DefaultVisHelpMenu;
  StringVisibilityToArr2(GuiPyOptions.VisHelpMenu, Num, 13);

  // --- Toolbars

  Num := PyIDEMainForm.MainToolBar.Items.Count;
  if Length(GuiPyOptions.VisMainToolbar) <> Num then
    GuiPyOptions.VisMainToolbar := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisMainToolbar, Num, 14);

  Num := PyIDEMainForm.DebugToolbar.Items.Count;
  if Length(GuiPyOptions.VisDebugToolbar) <> Num then
    GuiPyOptions.VisDebugToolbar := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisDebugToolbar, Num, 15);

  Num := TEditorForm.ToolbarCount;
  if Length(GuiPyOptions.VisEditToolbar) <> Num then
    GuiPyOptions.VisEditToolbar := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisEditToolbar, Num, 16);

  Num := TFUMLForm.ToolbarCount;
  if Length(GuiPyOptions.VisUMLToolbar) <> Num then
    GuiPyOptions.VisUMLToolbar := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisUMLToolbar, Num, 17);

  Num := TFStructogram.ToolbarCount;
  if Length(GuiPyOptions.VisStructoToolbar) <> Num then
    GuiPyOptions.VisStructoToolbar := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisStructoToolbar, Num, 18);

  Num := TFSequenceForm.ToolbarCount;
  if Length(GuiPyOptions.VisSequenceToolbar) <> Num then
    GuiPyOptions.VisSequenceToolbar := StringOfChar('1', Num);
  StringVisibilityToArr2(GuiPyOptions.VisSequenceToolbar, Num, 19);
end;

procedure TFConfiguration.SaveVisibility;

  function ArrVisibilityToString1(Arr: array of Boolean): string;
  begin
    var
    Str := '';
    for var I := 0 to High(Arr) do
      if Arr[I] then
        Str := Str + '1'
      else
        Str := Str + '0';
    Result := Str;
  end;

  function ArrVisibilityToString2(Tab, Count: Integer): string;
  begin
    var
    Str := '';
    for var I := 0 to Count - 1 do
      if FVis1[Tab, I] then
        Str := Str + '1'
      else
        Str := Str + '0';
    Result := Str;
  end;

begin
  GuiPyOptions.FVisTabs := ArrVisibilityToString1(FVisTabs);
  GuiPyOptions.FVisMenus := ArrVisibilityToString1(FVisMenus);
  GuiPyOptions.FVisToolbars := ArrVisibilityToString1(FVisToolbars);

  GuiPyOptions.VisProgram := ArrVisibilityToString2(0,
    PyIDEMainForm.ToolbarProgram.ButtonCount);
  GuiPyOptions.VisTkinter := ArrVisibilityToString2(1,
    PyIDEMainForm.ToolbarTkinter.ButtonCount);
  GuiPyOptions.VisTTK := ArrVisibilityToString2(2,
    PyIDEMainForm.ToolbarTTK.ButtonCount);
  GuiPyOptions.VisQtBase := ArrVisibilityToString2(3,
    PyIDEMainForm.ToolBarQtBase.ButtonCount);
  GuiPyOptions.VisQtControls := ArrVisibilityToString2(4,
    PyIDEMainForm.ToolBarQtControls.ButtonCount);

  GuiPyOptions.VisFileMenu := ArrVisibilityToString2(5,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[0]));
  GuiPyOptions.VisEditMenu := ArrVisibilityToString2(6,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[1]));
  GuiPyOptions.VisSearchMenu := ArrVisibilityToString2(7,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[2]));
  GuiPyOptions.VisViewMenu := ArrVisibilityToString2(8,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[3]));
  GuiPyOptions.VisProjectMenu := ArrVisibilityToString2(9,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[4]));
  GuiPyOptions.VisRunMenu := ArrVisibilityToString2(10,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[5]));
  GuiPyOptions.VisUMLMenu := ArrVisibilityToString2(11,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[6]));
  GuiPyOptions.VisToolsMenu := ArrVisibilityToString2(12,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[7]));
  GuiPyOptions.VisHelpMenu := ArrVisibilityToString2(13,
    CountMenuItems(PyIDEMainForm.MainMenu.Items[8]));

  GuiPyOptions.VisMainToolbar := ArrVisibilityToString2(14,
    PyIDEMainForm.MainToolBar.Items.Count);
  GuiPyOptions.VisDebugToolbar := ArrVisibilityToString2(15,
    PyIDEMainForm.DebugToolbar.Items.Count);
  GuiPyOptions.VisEditToolbar := ArrVisibilityToString2(16,
    TEditorForm.ToolbarCount);
  GuiPyOptions.VisUMLToolbar := ArrVisibilityToString2(17,
    TFUMLForm.ToolbarCount);
  GuiPyOptions.VisStructoToolbar := ArrVisibilityToString2(18,
    TFStructogram.ToolbarCount);
  GuiPyOptions.VisSequenceToolbar := ArrVisibilityToString2(19,
    TFSequenceForm.ToolbarCount);
end;

procedure TFConfiguration.SetVisibility;
var Menu: TTBCustomItem;

  function IndexItemsToPages(Index: Integer): Integer;
  begin
    var
    Lookup := PyIDEMainForm.TabControlWidgets.Items[Index].Caption;
    for var I := 0 to PyIDEMainForm.TabControlWidgets.Items.Count - 1 do
      if PyIDEMainForm.TabControlWidgets.Pages[I].Caption = Lookup then
        Exit(I);
    Result := -1;
  end;

begin
  var
  AllTabsClosed := True;
  for var I := 0 to High(FVisTabs) do
  begin
    AllTabsClosed := AllTabsClosed and not FVisTabs[I];
    var
    K := IndexItemsToPages(I);
    PyIDEMainForm.TabControlWidgets.Pages[K].TabVisible := FVisTabs[I];
    var
    AToolbar := TToolBar(PyIDEMainForm.TabControlWidgets.Pages[K].Controls[0]);
    for var J := 0 to AToolbar.ButtonCount - 1 do
      AToolbar.Buttons[J].Visible := FVis1[I, J];
  end;
  PyIDEMainForm.TabControlWidgets.Visible := not AllTabsClosed;

  PyIDEMainForm.FileMenu.Visible := FVisMenus[0];
  PyIDEMainForm.EditMenu.Visible := FVisMenus[1];
  PyIDEMainForm.SearchMenu.Visible := FVisMenus[2];
  PyIDEMainForm.ViewMenu.Visible := FVisMenus[3];
  PyIDEMainForm.ProjectMenu.Visible := FVisMenus[4];
  PyIDEMainForm.RunMenu.Visible := FVisMenus[5];
  PyIDEMainForm.UMLMenu.Visible := FVisMenus[6];
  PyIDEMainForm.ToolsMenu.Visible := FVisMenus[7];
  PyIDEMainForm.HelpMenu.Visible := FVisMenus[8];

  for var I := 0 to PyIDEMainForm.MainMenu.Items.Count - 1 do
  begin
    Menu := PyIDEMainForm.MainMenu.Items[I];
    var
    K := 0;
    for var J := 0 to Menu.Count - 1 do
      if Menu[J].Tag = -1 then // invalid menu item
        Menu[J].Visible := False
      else if Menu[J].Tag = -2 then
        Menu[J].Visible := True // Separator
      else
      begin // Tag = 0 means valid menu item
        Menu[J].Visible := FVis1[VisTabsLen + I, K];
        Inc(K);
      end;
  end;
  PyIDEMainForm.mnToolsGit.Visible :=
    PyIDEMainForm.mnToolsGit.Visible and FGitOK;
  PyIDEMainForm.mnToolsSVN.Visible := PyIDEMainForm.mnToolsSVN.Visible and
    FSubversionOK;

  PyIDEMainForm.MainToolBar.Visible := FVisToolbars[0];
  SetSpTBXToolbarVisibility(PyIDEMainForm.MainToolBar, 0);
  PyIDEMainForm.DebugToolbar.Visible := FVisToolbars[1];
  SetSpTBXToolbarVisibility(PyIDEMainForm.DebugToolbar, 1);

  PyIDEMainForm.SetDockTopPanel;

  GI_FileFactory.ApplyToFiles(
    procedure(AFile: IFile)
    begin
      (AFile as TFile).Form.SetOptions;
    end);
end;

procedure TFConfiguration.SetSpTBXToolbarVisibility(Toolbar: TSpTBXToolbar;
Num: Integer);
begin
  Toolbar.Visible := FVisToolbars[Num];
  for var I := 0 to Toolbar.Items.Count - 1 do
    Toolbar.Items[I].Visible := FVis1[VisTabsLen + VisMenusLen + Num, I];
end;

procedure TFConfiguration.PrepareVisibilityPage;
var TabControl: TSpTBXTabControl; AItem: TListItem;
begin
  LVVisibilityTabs.Items.BeginUpdate;
  TabControl := PyIDEMainForm.TabControlWidgets;
  for var I := 0 to TabControl.Items.Count - 1 do
  begin
    AItem := LVVisibilityTabs.Items.Add;
    AItem.Caption := _(TabControl.Items[I].Caption);
  end;
  LVVisibilityTabs.Items.EndUpdate;
  LVVisibilityMenus.Items.BeginUpdate;
  for var I := 0 to High(FVisMenus) do
  begin
    AItem := LVVisibilityMenus.Items.Add;
    AItem.Caption :=
      ReplaceStr(_(PyIDEMainForm.MainMenu.Items[I].Caption), '&', '');
  end;
  LVVisibilityMenus.Items.EndUpdate;
  LVVisibilityToolbars.Items.BeginUpdate;
  for var I := 0 to High(FVisToolbars) do
    LVVisibilityToolbars.Items.Add;
  LVVisibilityToolbars.Items[0].Caption :=
    ReplaceStr(_(PyIDEMainForm.MainMenu.Items[0].Caption), '&', '');
  LVVisibilityToolbars.Items[1].Caption :=
    ReplaceStr(_(PyIDEMainForm.MainMenu.Items[5].Caption), '&', '');
  LVVisibilityToolbars.Items[2].Caption := _('Editor');
  LVVisibilityToolbars.Items[3].Caption := _('UML');
  LVVisibilityToolbars.Items[4].Caption := _('Structogram');
  LVVisibilityToolbars.Items[5].Caption := _('Sequence diagram');
  LVVisibilityToolbars.Items.EndUpdate;
  LVVisibilityTabsClick(Self);
end;

procedure TFConfiguration.VisibilityModelToView;
begin
  for var I := 0 to LVVisibilityTabs.Items.Count - 1 do
    LVVisibilityTabs.Items[I].Checked := FVisTabs[I];

  for var I := 0 to LVVisibilityMenus.Items.Count - 1 do
    LVVisibilityMenus.Items[I].Checked := FVisMenus[I];

  for var I := 0 to LVVisibilityToolbars.Items.Count - 1 do
    LVVisibilityToolbars.Items[I].Checked := FVisToolbars[I];

  // save visibility settings in FVis2 for changing
  for var I := 0 to MaxVisLen - 1 do
    for var J := 0 to MaxTabItem - 1 do
      FVis2[I, J] := FVis1[I, J];

  LVVisibilityElements.OnItemChecked := nil;
  for var I := 0 to LVVisibilityElements.Items.Count - 1 do
    LVVisibilityElements.Items[I].Checked :=
      FVis2[FVisSelectedTabMenuToolbar, I];
  LVVisibilityElements.OnItemChecked := LVVisibilityElementsItemChecked;
end;

procedure TFConfiguration.VisibilityViewToModel;
begin
  for var I := 0 to High(FVisTabs) do
    FVisTabs[I] := LVVisibilityTabs.Items[I].Checked;

  if Assigned(LVVisibilityMenus.Items[0]) then // due to unknown problem
    for var I := 0 to High(FVisMenus) do
      FVisMenus[I] := LVVisibilityMenus.Items[I].Checked;

  if Assigned(LVVisibilityToolbars.Items[0]) then
    for var I := 0 to High(FVisToolbars) do
      FVisToolbars[I] := LVVisibilityToolbars.Items[I].Checked;

  // tab Visibility - view to model
  for var I := 0 to MaxVisLen - 1 do
    for var J := 0 to MaxTabItem - 1 do
      FVis1[I, J] := FVis2[I, J];
end;

procedure TFConfiguration.LVVisibilityTabsClick(Sender: TObject);
var Str: string; Posi, Tab: Integer; AToolbar: TToolBar; AItem: TListItem;
begin
  FTabsMenusToolbars := 1;
  Tab := Max(LVVisibilityTabs.ItemIndex, 0);
  LVVisibilityElements.Clear;
  case Tab of
    0:
      begin
        LVVisibilityElements.SmallImages := PyIDEMainForm.vilProgramLight;
        AToolbar := PyIDEMainForm.ToolbarProgram;
      end;
    1:
      begin
        LVVisibilityElements.SmallImages := PyIDEMainForm.vilTkInterLight;
        AToolbar := PyIDEMainForm.ToolbarTkinter;
      end;
    2:
      begin
        LVVisibilityElements.SmallImages := PyIDEMainForm.vilTTKLight;
        AToolbar := PyIDEMainForm.ToolbarTTK;
      end;
    3:
      begin
        LVVisibilityElements.SmallImages := PyIDEMainForm.vilQtBaseLight;
        AToolbar := PyIDEMainForm.ToolBarQtBase;
      end;
    4:
      begin
        LVVisibilityElements.SmallImages := PyIDEMainForm.vilQtControls;
        AToolbar := PyIDEMainForm.ToolBarQtControls;
      end;
  else
    Exit;
  end;

  LVVisibilityElements.OnItemChecked := nil;
  if Assigned(AToolbar) then
  begin
    for var I := 0 to AToolbar.ButtonCount - 1 do
    begin
      Str := AToolbar.Buttons[I].Hint;
      Posi := Pos('Tk ', Str);
      if Posi > 0 then
        Str := Copy(Str, Posi + 3, Length(Str));
      Posi := Pos('TTK ', Str);
      if Posi > 0 then
        Str := Copy(Str, Posi + 4, Length(Str));
      AItem := LVVisibilityElements.Items.Add;
      AItem.Caption := ' ' + Str;
      AItem.Checked := FVis2[Tab, I];
      AItem.ImageIndex := I;
    end;
  end;
  FVisSelectedTabMenuToolbar := Tab;
  LVVisibilityElements.OnItemChecked := LVVisibilityElementsItemChecked;
end;

procedure TFConfiguration.LVVisibilityMenusClick(Sender: TObject);
var Str: string; Tab: Integer; Menu: TTBCustomItem; AItem: TListItem;
begin
  FTabsMenusToolbars := 2;
  Tab := LVVisibilityMenus.ItemIndex;
  if Tab = -1 then
    Exit;
  LVVisibilityElements.Clear;
  LVVisibilityElements.SmallImages := PyIDEMainForm.vilImages;
  Menu := PyIDEMainForm.MainMenu.Items[Tab];
  var
  K := 0;
  LVVisibilityElements.OnItemChecked := nil;
  for var I := 0 to Menu.Count - 1 do
  begin
    Str := Menu[I].Caption;
    if Menu[I].Tag = 0 then
    begin
      Str := ReplaceStr(Str, '&', '');
      AItem := LVVisibilityElements.Items.Add;
      AItem.Caption := ' ' + _(Str);
      AItem.Checked := FVis2[VisTabsLen + Tab, K];
      AItem.ImageIndex := Menu[I].ImageIndex;
      Inc(K);
    end;
  end;
  FVisSelectedTabMenuToolbar := VisTabsLen + Tab;
  LVVisibilityElements.OnItemChecked := LVVisibilityElementsItemChecked;
end;

procedure TFConfiguration.LVVisibilityToolbarsClick(Sender: TObject);
var Str: string; Posi, Tab: Integer; TSpB: TSpTBXToolbar; AToolbar: TToolBar;
  AItem: TListItem; EditForm: TEditorForm; UMLForm: TFUMLForm;
  StructogramForm: TFStructogram; SequencediagramForm: TFSequenceForm;
begin
  FTabsMenusToolbars := 3;
  TSpB := nil;
  AToolbar := nil;
  EditForm := nil;
  UMLForm := nil;
  StructogramForm := nil;
  SequencediagramForm := nil;
  try
    Tab := LVVisibilityToolbars.ItemIndex;
    LVVisibilityElements.Clear;
    case Tab of
      0:
        begin
          LVVisibilityElements.SmallImages := PyIDEMainForm.vilImages;
          TSpB := PyIDEMainForm.MainToolBar;
        end;
      1:
        begin
          LVVisibilityElements.SmallImages := PyIDEMainForm.vilImages;
          TSpB := PyIDEMainForm.DebugToolbar;
        end;
      2:
        begin
          EditForm := TEditorForm.Create(nil);
          if IsDark then
            LVVisibilityElements.SmallImages := EditForm.vilEditorToolbarDark
          else
            LVVisibilityElements.SmallImages := EditForm.vilEditorToolbarLight;
          AToolbar := EditForm.EditformToolbar;
        end;
      3:
        begin
          UMLForm := TFUMLForm.Create(nil);
          if IsDark then
            LVVisibilityElements.SmallImages := UMLForm.vilToolbarDark
          else
            LVVisibilityElements.SmallImages := UMLForm.vilToolbarLight;
          AToolbar := UMLForm.UMLToolbar;
        end;
      4:
        begin
          StructogramForm := TFStructogram.Create(nil);
          if IsDark then
            LVVisibilityElements.SmallImages := StructogramForm.vilToolbarDark
          else
            LVVisibilityElements.SmallImages := StructogramForm.vilToolbarLight;
          AToolbar := StructogramForm.StructogramToolbar;
        end;
      5:
        begin
          SequencediagramForm := TFSequenceForm.Create(nil);
          if IsDark then
            LVVisibilityElements.SmallImages :=
              SequencediagramForm.vilToolbarDark
          else
            LVVisibilityElements.SmallImages :=
              SequencediagramForm.vilToolbarLight;
          AToolbar := SequencediagramForm.SequenceToolbar;
        end;
    else
      Exit;
    end;
    LVVisibilityElements.OnItemChecked := nil;
    if Tab <= 1 then
    begin
      for var I := 0 to TSpB.Items.Count - 1 do
      begin
        Str := TSpB.Items[I].Hint;
        Posi := Pos('|', Str);
        if Posi > 0 then
          Str := Copy(Str, 1, Posi - 1);
        AItem := LVVisibilityElements.Items.Add;
        AItem.Caption := ' ' + _(Str);
        AItem.Checked := FVis2[VisTabsLen + VisMenusLen + Tab, I];
        AItem.ImageIndex := TSpB.Items[I].ImageIndex;
      end;
    end;
    if Tab >= 2 then
    begin
      for var I := 0 to AToolbar.ButtonCount - 1 do
      begin
        Str := AToolbar.Buttons[I].Hint;
        Posi := Pos('|', Str);
        if Posi > 0 then
          Str := Copy(Str, 1, Posi - 1);
        AItem := LVVisibilityElements.Items.Add;
        AItem.Caption := ' ' + _(Str);
        AItem.Checked := FVis2[VisTabsLen + VisMenusLen + Tab, I];
        AItem.ImageIndex := I;
      end;
    end;
    FVisSelectedTabMenuToolbar := VisTabsLen + VisMenusLen + Tab;
    LVVisibilityElements.OnItemChecked := LVVisibilityElementsItemChecked;
  finally
    FreeAndNil(UMLForm);
    FreeAndNil(EditForm);
    FreeAndNil(StructogramForm);
    FreeAndNil(SequencediagramForm);
  end;
end;

procedure TFConfiguration.LVVisibilityElementsItemChecked(Sender: TObject;
Item: TListItem);
begin
  FVis2[FVisSelectedTabMenuToolbar, Item.Index] := Item.Checked;
end;

procedure TFConfiguration.BVisDefaultClick(Sender: TObject);
var Num: Integer;

  procedure DefaultVis(var Arr: array of Boolean);
  begin
    for var I := 0 to High(Arr) do
      Arr[I] := True;
  end;

  procedure StringVisibilityToArr2(Str: string; Count, Num: Integer);
  begin
    for var I := 0 to Count - 1 do
      FVis2[Num, I] := (Str[I + 1] = '1');
  end;

begin
  DefaultVis(FVisTabs);
  DefaultVis(FVisMenus);
  DefaultVis(FVisToolbars);

  for var I := 0 to High(FVisTabs) do
    LVVisibilityTabs.Items[I].Checked := True;
  for var I := 0 to High(FVisMenus) do
    LVVisibilityMenus.Items[I].Checked := True;
  for var I := 0 to High(FVisToolbars) do
    LVVisibilityToolbars.Items[I].Checked := True;

  // details of tabs, menus and toolbars
  for var I := 0 to MaxVisLen - 1 do
    for var J := 0 to MaxTabItem - 1 do
      FVis2[I, J] := True;

  // --- default menu visibility
  Num := Length(DefaultVisFileMenu);
  StringVisibilityToArr2(DefaultVisFileMenu, Num, 5);
  Num := Length(DefaultVisEditMenu);
  StringVisibilityToArr2(DefaultVisEditMenu, Num, 6);
  Num := Length(DefaultVisSearchMenu);
  StringVisibilityToArr2(DefaultVisSearchMenu, Num, 7);
  Num := Length(DefaultVisViewMenu);
  StringVisibilityToArr2(DefaultVisViewMenu, Num, 8);
  Num := Length(DefaultVisProjectMenu);
  StringVisibilityToArr2(DefaultVisProjectMenu, Num, 9);
  Num := Length(DefaultVisRunMenu);
  StringVisibilityToArr2(DefaultVisRunMenu, Num, 10);
  Num := Length(DefaultVisUMLMenu);
  StringVisibilityToArr2(DefaultVisUMLMenu, Num, 11);
  Num := Length(DefaultVisToolsMenu);
  StringVisibilityToArr2(DefaultVisToolsMenu, Num, 12);
  Num := Length(DefaultVisHelpMenu);
  StringVisibilityToArr2(DefaultVisHelpMenu, Num, 13);

  for var J := 0 to LVVisibilityElements.Items.Count - 1 do
    LVVisibilityElements.Items[J].Checked :=
      FVis2[FVisSelectedTabMenuToolbar, J];
end;

procedure TFConfiguration.SetToolbarVisibility(Toolbar: TToolBar; Num: Integer);
begin
  Toolbar.Visible := FVisToolbars[Num];
  for var I := 0 to Toolbar.ButtonCount - 1 do
    Toolbar.Buttons[I].Visible := FVis1[VisTabsLen + VisMenusLen + Num, I];
end;

function TFConfiguration.CountMenuItems(Menu: TTBCustomItem): Integer;
begin
  Result := 0;
  for var I := 0 to Menu.Count - 1 do
    if Menu[I].Tag = 0 then
      Inc(Result);
end;

procedure TFConfiguration.CBProviderDropDown(Sender: TObject);
begin
  LLMAssistantViewToModel;
end;

procedure TFConfiguration.CBProviderSelect(Sender: TObject);
begin
  LLMAssistantModelToView;
end;

procedure TFConfiguration.CBChatProviderDropDown(Sender: TObject);
begin
  LLMChatViewToModel;
end;

procedure TFConfiguration.CBChatProviderSelect(Sender: TObject);
begin
  LLMChatModelToView;
end;

procedure TFConfiguration.LLMAssistantModelToView;
var Settings: TLLMSettings;
begin
  case CBProvider.ItemIndex of
    0:
      Settings := FTempProviders.OpenAI;
    1:
      Settings := FTempProviders.Gemini;
    2:
      Settings := FTempProviders.Ollama;
    3:
      Settings := FTempProviders.DeepSeek;
    4:
      Settings := FTempProviders.Grok;
  end;
  EEndPoint.Text := Settings.EndPoint;
  EModel.Text := Settings.Model;
  EAPIKey.Text := Settings.ApiKey;
  ESystemPrompt.Text := Settings.SystemPrompt;
  EMaxTokens.Text := Settings.MaxTokens.ToString;
  ELLMTimeout.Text := (Settings.TimeOut div 1000).ToString;
end;

procedure TFConfiguration.LLMAssistantViewToModel;
var Settings: TLLMSettings; Value: Integer;
begin
  FTempProviders.Provider := TLLMProvider(CBProvider.ItemIndex);
  Settings.EndPoint := EEndPoint.Text;
  Settings.Model := EModel.Text;
  Settings.ApiKey := EAPIKey.Text;
  Settings.SystemPrompt := ESystemPrompt.Text;
  if not TryStrToInt(EMaxTokens.Text, Value) then
    Value := 1000;
  Settings.MaxTokens := Value;
  if not TryStrToInt(ELLMTimeout.Text, Value) then
    Value := 20;
  Settings.TimeOut := Value * 1000;
  case CBProvider.ItemIndex of
    0:
      FTempProviders.OpenAI := Settings;
    1:
      FTempProviders.Gemini := Settings;
    2:
      FTempProviders.Ollama := Settings;
    3:
      FTempProviders.DeepSeek := Settings;
    4:
      FTempProviders.Grok := Settings;
  end;
end;

procedure TFConfiguration.LLMChatModelToView;
var Settings: TLLMSettings;
begin
  case CBChatProvider.ItemIndex of
    0:
      Settings := FTempChatProviders.OpenAI;
    1:
      Settings := FTempChatProviders.Gemini;
    2:
      Settings := FTempChatProviders.Ollama;
    3:
      Settings := FTempChatProviders.DeepSeek;
    4:
      Settings := FTempChatProviders.Grok;
  end;
  EChatEndPoint.Text := Settings.EndPoint;
  EChatModel.Text := Settings.Model;
  EChatApiKey.Text := Settings.ApiKey;
  EChatSystemPrompt.Text := Settings.SystemPrompt;
  EChatMaxTokens.Text := Settings.MaxTokens.ToString;
  EChatTimeout.Text := (Settings.TimeOut div 1000).ToString;
end;

procedure TFConfiguration.LLMChatViewToModel;
var Settings: TLLMSettings; Value: Integer;
begin
  FTempChatProviders.Provider := TLLMProvider(CBChatProvider.ItemIndex);
  Settings.EndPoint := EChatEndPoint.Text;
  Settings.Model := EChatModel.Text;
  Settings.ApiKey := EChatApiKey.Text;
  Settings.SystemPrompt := EChatSystemPrompt.Text;
  if not TryStrToInt(EChatMaxTokens.Text, Value) then
    Value := 1000;
  Settings.MaxTokens := Value;
  if not TryStrToInt(EChatTimeout.Text, Value) then
    Value := 20;
  Settings.TimeOut := Value * 1000;
  case CBChatProvider.ItemIndex of
    0:
      FTempChatProviders.OpenAI := Settings;
    1:
      FTempChatProviders.Gemini := Settings;
    2:
      FTempChatProviders.Ollama := Settings;
    3:
      FTempChatProviders.DeepSeek := Settings;
    4:
      FTempChatProviders.Grok := Settings;
  end;
end;

{ --- end of Configuration ----------------------------------------------------- }

{ --- TGuiPyOptions --------------------------------------------------------- }

constructor TGuiPyOptions.Create;
begin
  inherited;
  FColorTheme := 'Obsidian';

  // Class modeler
  FShowGetSetMethods := True;
  FGetSetMethodsAsProperty := False;
  FGetMethodChecked := True;
  FSetMethodChecked := False;
  FShowAttributeTypeSelection := True;
  FShowWithWithoutReturnValue := True;
  FShowMethodTypeSelection := True;
  FShowParameterTypeSelection := True;
  FFromFutureImport := True;

  // GUI designer
  FNameFromText := True;
  FGuiDesignerHints := True;
  FSnapToGrid := True;
  FGridSize := 8;
  FZoomSteps := 1;
  FGUIFontSize := 9;
  FGUIFontName := 'Segoe UI';
  FFrameWidth := 300;
  FFrameHeight := 300;

  // Structogram
  FStructoDatatype := 'int';
  FSwitchWithCaseLine := False;
  FCaseCount := 4;
  FStructogramShadowWidth := 3;
  FStructogramShadowIntensity := 8;

  // Sequence diagram
  FSDFillingColor := clYellow;
  FSDNoFilling := False;
  FSDShowMainCall := False;
  FSDShowParameter := True;
  FSDShowReturn := True;

  // UML design
  FValidClassColor := clWhite;
  FInvalidClassColor := clFuchsia;
  FClassHead := 0;
  FShadowWidth := 3;
  FShadowIntensity := 8;
  FObjectColor := clYellow;
  FObjectHead := 1;
  FObjectFooter := 1;
  FObjectCaption := 0;
  FObjectUnderline := True;
  FCommentColor := clSkyBlue;
  FDiVisibilityFilter := 0;
  FDiSortOrder := 0;
  FDiShowParameter := 4;
  FDiShowIcons := 1;

  // uml options
  FShowEmptyRects := False;
  FIntegerInsteadofInt := False;
  FConstructorWithVisibility := False;
  FRelationshipAttributesBold := True;
  FShowClassparameterSeparately := False;
  FUseAbstractForClass := True;
  FUseAbstractForMethods := False;
  FRoleHidesAttribute := False;
  FDefaultModifiers := True;
  FShowPublicOnly := False;
  FShowObjectsWithInheritedPrivateAttributes := True;
  FShowObjectsWithMethods := False;
  FObjectLowerCaseLetter := True;
  FShowAllNewObjects := True;
  FObjectsWithoutVisibility := True;
  FPrivateAttributEditable := True;
  FOpenFolderFormItems := '';

  // restrictions
  FLockedDOSWindow := False;
  FLockedInternet := False;
  FLockedPaths := False;
  FLockedStructogram := False;
  FUsePredefinedLayouts := False;

  // Browser
  FBrowserURLs := '';
  FCBWidth := 200;
  FUseIEinternForDocuments := True;

  // Associations
  FAdditionalAssociations := '';

  // LLMAssistant
  FProviders := TLLMProvidersClass.Create;
  FProviders.setFromProviders(LLMAssistant.Providers);
  FChatProviders := TLLMProvidersClass.Create;
  FChatProviders.setFromProviders(LLMChatForm.LLMChat.Providers);

  // Git
  FGitFolder := '';
  FGitLocalRepository := '';
  FGitRemoteRepository := '';
  FGitUserName := '';
  FGitUserEMail := '';

  // Subversion
  FSVNFolder := '';
  FSVNRepository := '';

  // Others
  FLicence := '';
  FAuthor := '';

  // Others
  FTextDiffState := '';
  FTextDiffIgnoreCase := False;
  FTextDiffIgnoreBlanks := False;
  FSourcepath := GetDocumentsPath;
  FTempDir := IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP'));

  FUMLFont := TFont.Create;
  FUMLFont.Name := 'Segoe UI';
  FUMLFont.Size := 12;
  FStructogramFont := TFont.Create;
  FStructogramFont.Name := 'Segoe UI';
  FStructogramFont.Size := 12;
  FSequenceFont := TFont.Create;
  FSequenceFont.Name := 'Segoe UI';
  FSequenceFont.Size := 12;
  FInspectorFont := TFont.Create;
  FInspectorFont.Name := 'Segoe UI';
  FInspectorFont.Size := 12;
  FStructureFont := TFont.Create;
  FStructureFont.Name := 'Segoe UI';
  FStructureFont.Size := 12;
end;

destructor TGuiPyOptions.Destroy;
begin
  FreeAndNil(FUMLFont);
  FreeAndNil(FStructogramFont);
  FreeAndNil(FSequenceFont);
  FreeAndNil(FInspectorFont);
  FreeAndNil(FStructureFont);
  FreeAndNil(FProviders);
  FreeAndNil(FChatProviders);
  inherited;
end;

procedure TGuiPyOptions.SetUMLFont(Value: TFont);
begin
  FUMLFont.Assign(Value);
end;

procedure TGuiPyOptions.SetStructogramFont(Value: TFont);
begin
  FStructogramFont.Assign(Value);
end;

procedure TGuiPyOptions.SetSequenceFont(Value: TFont);
begin
  FSequenceFont.Assign(Value);
end;

procedure TGuiPyOptions.SetInspectorFont(Value: TFont);
begin
  FInspectorFont.Assign(Value);
end;

procedure TGuiPyOptions.SetStructureFont(Value: TFont);
begin
  FStructureFont.Assign(Value);
end;

procedure TGuiPyOptions.AddPortableDrives;
begin
  FTempDir := AddPortableDrive(FTempDir);
  FGitFolder := AddPortableDrive(FGitFolder);
  FGitLocalRepository := AddPortableDrive(FGitLocalRepository);
  FSVNFolder := AddPortableDrive(FSVNFolder);
  FSVNRepository := AddPortableDrive(FSVNRepository);
  FSourcepath := AddPortableDrive(FSourcepath);
  if not SysUtils.DirectoryExists(FSourcepath) then
    FSourcepath := GetDocumentsPath;
end;

procedure TGuiPyOptions.RemovePortableDrives;
begin
  FTempDir := RemovePortableDrive(FTempDir);
  FGitFolder := RemovePortableDrive(FGitFolder);
  FGitLocalRepository := RemovePortableDrive(FGitLocalRepository);
  FSVNFolder := RemovePortableDrive(FSVNFolder);
  FSVNRepository := RemovePortableDrive(FSVNRepository);
  FSourcepath := RemovePortableDrive(FSourcepath);
end;

{ --- TGuiPyLanguageOptions ---------------------------------------------------- }

procedure TGuiPyLanguageOptions.GetInLanguage(const Language: string);
var FCurrentLanguage: string;
begin
  FCurrentLanguage := GetCurrentLanguage;
  UseLanguage(Language);

  // Structogram
  FAlgorithm := _('Algorithm');
  FInput := _('Input:');
  FOutput := _('Output:');
  FWhile := _('repeat while');
  FFor := _('repeat for item in list');
  FYes := _('yes');
  FNo := _('no');
  FOther := _('else');

  // Sequencediagram
  FSDObject := _('Object');
  FSDNew := _('new');
  FSDClose := _('close');
  UseLanguage(FCurrentLanguage);
end;

end.
