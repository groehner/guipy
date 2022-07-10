{-------------------------------------------------------------------------------
 Unit:     UConfiguration
 Author:   Gerhard Röhner
 Date:     July 2000
 Purpose:  utility functions
-------------------------------------------------------------------------------}

unit UConfiguration;

{

We have configuration-values
a) in ini-files
     AppStorage.FileName := ChangeFileExt(Application.ExeName, '.ini');
     MachineStorage.FileName:= ExtractFilePath(Application.ExeName) + 'GuiPyMachine.INI';
b) in variables (Model)
c) in form (View)

           RestoreApplicationData              ModelToView
registry  ------------------------>  model   -------------> view
INI-files <----------------------- variables <------------- gui-elements
           StoreApplicationData                ViewToModel


http://dxgettext.po.dk/documentation/how-to
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, IniFiles, Generics.Collections,
  UITypes, SynEditHighlighter, SynEditPrintHeaderFooter, SynEditPrint,
  VirtualTrees, System.Actions, VCL.Styles.PyScripter, Vcl.BaseImageCollection,
  SVGIconImageCollection, Vcl.ActnList, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, TB2Item, SpTBXItem, TB2Dock, TB2Toolbar, SpTBXEditors,
  SynEdit, Vcl.WinXPanels, SpTBXExtEditors,
  cPyScripterSettings, dlgSynEditOptions, dlgCustomShortcuts, SynEditKeyCmds,
  SynEditMiscClasses, SynEditPrintMargins, cFileTemplates, dlgPyIDEBase;

Const
  CrLf = #13#10;
  Homepage = 'https://www.guipy.de';
  MaxTab = 1;
  MaxTabItem = 22;

type
  TBoolArray = array of boolean;

  TEditStyleHookColor = class(TEditStyleHook)  // TEditStyleHook in StdCtrls
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
    fColorTheme: string;

    // Class modeler
    fShowGetSetMethods: boolean;
    fShowTypeSelection: boolean;
    fShowKindProcedure: boolean;
    fShowParameterTypeSelection: boolean;

    // GUI designer
    fNameFromText: boolean;
    fGuiDesignerHints: Boolean;
    fSnapToGrid: boolean;
    fGridSize: Integer;
    fFrameWidth: Integer;
    fFrameHeight: Integer;

    // Structogram
    fStructoDatatype: string;
    fSwitchWithCaseLine: boolean;
    fCaseCount: integer;
    fStructogramShadowWidth: integer;
    fStructogramShadowIntensity: integer;

    // Sequencediagram
    fSDFillingcolor: TColor;
    fSDNoFilling: boolean;
    fSDShowMainCall: boolean;
    fSDShowParameter: boolean;
    fSDShowReturn: boolean;

    // UML design
    fValidClassColor: TColor;
    fInvalidClassColor: TColor;
    fClassHead: integer;
    fShadowWidth: integer;
    fShadowIntensity: integer;
    fObjectColor: TColor;
    fObjectHead: integer;
    fObjectFooter: integer;
    fObjectCaption: integer;
    fObjectUnderline: boolean;
    fCommentColor: TColor;
    fDiVisibilityFilter: integer;
    fDiSortOrder: integer;
    fDIShowParameter: integer;
    fDiShowIcons: integer;

    // UML options
    fShowEmptyRects: Boolean;
    fIntegerInsteadofInt: boolean;
    fConstructorWithVisibility: Boolean;
    fRelationshipAttributesBold: boolean;
    fShowClassparameterSeparately: boolean;
    fRoleHidesAttribute: boolean;
    fDefaultModifiers: boolean;
    fShowPublicOnly: boolean;
    fShowObjectsWithInheritedPrivateAttributes: boolean;
    fShowObjectsWithMethods: boolean;
    fObjectLowerCaseLetter: Boolean;
    fShowAllNewObjects: boolean;
    fObjectsWithoutVisibility: boolean;
    fPrivateAttributEditable: Boolean;

    // Restrictions
    fLockedDOSWindow: Boolean;
    fLockedInternet: Boolean;
    fLockedPaths: boolean;
    fLockedStructogram: boolean;
    fUsePredefinedLayouts: boolean;

    // Associations
    fAdditionalAssociations: string;

    // Git
    fGitFolder: string;
    fGitLocalRepository: string;
    fGitRemoteRepository: string;
    fGitUserName: string;
    fGitUserEMail: string;

    // Subversion
    fSVNFolder: string;
    fSVNRepository: string;

    // TextDiff
    fTextDiffState: String;
    fTextDiffIgnoreCase: boolean;
    fTextDiffIgnoreBlanks: boolean;

    // Browser
    fBrowserURLs: string;
    fCBWidth: integer;
    fUseIEinternForDocuments: boolean;
    fOnlyOneBrowserWindow: boolean;
    fBrowserTitle: string;
    fOpenBrowserShortcut: string;
    fBrowserProgram: string;

    // comment
    fMethodComment: TStringList;
    fAuthor: String;

    // others
    fSourcepath: String;
    fTempDir: String;

    // Fonts
    fUMLFont: TFont;
    fStructogramFont: TFont;
    fSequenceFont: TFont;

    procedure setMethodComment(Value: TStringList);
    procedure setUMLFont(Value: TFont);
    procedure setStructogramFont(Value: TFont);
    procedure setSequenceFont(Value: TFont);
    function getGitFolder: string;
    procedure setGitFolder(aValue: string);
    function getGitLocalRepository: string;
    procedure setGitLocalRepository(aValue: string);

    function getSVNFolder: string;
    procedure setSVNFolder(aValue: string);
    function getSVNRepository: string;
    procedure setSVNRepository(aValue: string);

    function getSourcePath: string;
    procedure setSourcePath(aValue: string);
    function getTempDir: string;
    procedure setTempDir(aValue: string);
  public
    constructor create;
    destructor Destroy; override;
  published
    // Color themes
    property ColorTheme: string read fColorTheme write fColorTheme;

    // Class modeler
    property ShowGetSetMethods: boolean read FShowGetSetMethods write FShowGetSetMethods;
    property ShowTypeSelection: boolean read FShowTypeSelection write FShowTypeSelection;
    property ShowKindProcedure: boolean read FShowKindProcedure write FShowKindProcedure;
    property ShowParameterTypeSelection: boolean read FShowParameterTypeSelection write FShowParameterTypeSelection;

    // GUI designer
    property NameFromText : boolean read fNameFromText
      write FNameFromText default true;
    property GuiDesignerHints : boolean read fGuiDesignerHints
      write fGuiDesignerHints default true;
    property SnapToGrid : boolean read fSnapToGrid
      write fSnapToGrid default true;
    property GridSize : Integer read fGridSize
      write fGridSize default 8;
    property FrameWidth : Integer read fFrameWidth
      write fFrameWidth default 300;
    property FrameHeight : Integer read fFrameHeight
      write fFrameHeight default 300;

    // structogram
    property StructoDatatype : string read fStructoDatatype
      write fStructoDatatype;
    property SwitchWithCaseLine : boolean read fSwitchWithCaseLine
      write fSwitchWithCaseLine default true;
    property CaseCount : Integer read fCaseCount write fCaseCount default 4;
    property StructogramShadowWidth : Integer read fStructogramShadowWidth
      write fStructogramShadowWidth default 3;
    property StructogramShadowIntensity : Integer read fStructogramShadowIntensity
      write fStructogramShadowIntensity default 8;

    // sequence diagram
    property SDFillingColor : TColor read fSDFillingcolor
      write fSDFillingColor default clYellow;
    property SDNoFilling : boolean read fSDNoFilling
      write fSDNoFilling default false;
    property SDShowMainCall : boolean read fSDShowMainCall
      write fSDShowMainCall default false;
    property SDShowParameter : boolean read fSDShowParameter
      write fSDShowParameter default true;
    property SDShowReturn : boolean read fSDShowReturn
      write fSDShowReturn default true;

    // UML design
    property ValidClassColor : TColor read fValidClassColor
      write fValidClassColor default clWhite;
    property InvalidClassColor : TColor read fInvalidClassColor
      write fInvalidClassColor default clFuchsia;
    property ClassHead : integer read fClassHead
      write fClassHead default 0;
    property ShadowWidth : integer read fShadowWidth
      write fShadowWidth default 3;
    property ShadowIntensity : integer read fShadowIntensity
      write fShadowIntensity default 8;
    property ObjectColor : TColor read fObjectColor
      write fObjectColor default clYellow;
    property ObjectHead : integer read fObjectHead
      write fObjectHead default 1;
    property ObjectFooter : integer read fObjectFooter
      write fObjectFooter default 1;
    property ObjectCaption : integer read fObjectCaption
      write fObjectCaption default 0;
    property ObjectUnderline : boolean read fObjectUnderline
      write fObjectUnderline default true;
    property CommentColor : TColor read fCommentColor
      write fCommentColor default clSkyBlue;
    property DiVisibilityFilter : integer read fDiVisibilityFilter
      write fDiVisibilityFilter default 0;
    property DiSortOrder : integer read fDiSortOrder
      write fDiSortOrder default 0;
    property DIShowParameter : integer read fDIShowParameter
      write fDIShowParameter default 4;
    property DiShowIcons : integer read fDiShowIcons
      write fDiShowIcons default 1;

    // UML options
    property ShowEmptyRects : boolean read fShowEmptyRects
      write fShowEmptyRects default false;
    property IntegerInsteadofInt : boolean read fIntegerInsteadofInt
      write fIntegerInsteadofInt default false;
    property ConstructorWithVisibility : boolean read fConstructorWithVisibility
      write fConstructorWithVisibility default false;
    property RelationshipAttributesBold : boolean read fRelationshipAttributesBold
      write fRelationshipAttributesBold default true;
    property ShowClassparameterSeparately : boolean read fShowClassparameterSeparately
      write fShowClassparameterSeparately default false;
    property RoleHidesAttribute : boolean read fRoleHidesAttribute
      write fRoleHidesAttribute default false;
    property DefaultModifiers : boolean read fDefaultModifiers
      write fDefaultModifiers default true;
    property ShowPublicOnly : boolean read fShowPublicOnly
      write fShowPublicOnly default false;
    property ShowObjectsWithInheritedPrivateAttributes : boolean read fShowObjectsWithInheritedPrivateAttributes
      write fShowObjectsWithInheritedPrivateAttributes default true;
    property ShowObjectsWithMethods : boolean read fShowObjectsWithMethods
      write fShowObjectsWithMethods default false;
    property ObjectLowerCaseLetter : boolean read fObjectLowerCaseLetter
      write fObjectLowerCaseLetter default true;
    property ShowAllNewObjects : boolean read fShowAllNewObjects
      write fShowAllNewObjects default true;
    property ObjectsWithoutVisibility : boolean read fObjectsWithoutVisibility
      write fObjectsWithoutVisibility default true;
    property PrivateAttributEditable : boolean read fPrivateAttributEditable
      write fPrivateAttributEditable default true;

    // restrictions
    property LockedDOSWindow : boolean read fLockedDOSWindow
      write fLockedDOSWindow default false;
    property LockedInternet : boolean read fLockedInternet
      write fLockedInternet default false;
    property LockedPaths : boolean read fLockedPaths
      write fLockedPaths default false;
    property LockedStructogram : boolean read fLockedStructogram
      write fLockedStructogram default false;
    property UsePredefinedLayouts : boolean read FUsePredefinedLayouts
      write fUsePredefinedLayouts;

    // Associations
    property AdditionalAssociations: string read fAdditionalAssociations
      write fAdditionalAssociations;

    // Git
    property GitFolder: string read getGitFolder
      write setGitFolder;
    property GitLocalRepository: string read getGitLocalRepository
      write setGitLocalRepository;
    property GitRemoteRepository: string read fGitRemoteRepository
      write fGitRemoteRepository;
    property GitUserName: string read fGitUserName
      write fGitUserName;
    property GitUserEMail: string read fGitUserEMail
      write fGitUserEMail;

    // Subversion
    property SVNFolder: string read getSVNFolder
      write setSVNFolder;
    property SVNRepository: string read getSVNRepository
      write setSVNRepository;

    // TextDiff
    property TextDiffState: string read fTextDiffState
      write fTextDiffState;
    property TextDiffIgnoreCase: boolean read fTextDiffIgnoreCase
      write fTextDiffIgnoreCase default false;
    property TextDiffIgnoreBlanks: boolean read fTextDiffIgnoreBlanks
      write fTextDiffIgnoreBlanks default false;

    // Browser
    property UseIEinternForDocuments: boolean read fUseIEinternForDocuments write fUseIEinternForDocuments;
    property OnlyOneBrowserWindow: boolean read fOnlyOneBrowserWindow write fOnlyOneBrowserWindow;
    property BrowserTitle: string read fBrowserTitle write fBrowserTitle;
    property OpenBrowserShortcut: string read fOpenBrowserShortcut write fOpenBrowserShortcut;
    property BrowserProgram: string read fBrowserProgram write fBrowserProgram;

    // Comment
    property MethodComment: TStringList read fMethodComment
      write setMethodComment;
    property Author: string read fAuthor
      write fAuthor;

    // Others
    property SourcePath: string read getSourcePath
      write setSourcePath;
    property TempDir: string read getTempDir
      write setTempDir;

    // Fonts
    property UMLFont: TFont read fUMLFont write setUMLFont;
    property StructogramFont: TFont read fStructogramFont write setStructogramFont;
    property SequenceFont: TFont read fSequenceFont write setSequenceFont;
  end;

  TGuiPyLanguageOptions = class(TInterfacedPersistent)
  private
    // Structogram
    fAlgorithm: string;
    fInput: string;
    fOutput: string;
    fWhile: string;
    fFor: string;
    fYes: string;
    fNo: string;
    fOther: string;
    // Sequencediagram
    fSDObject: string;
    fSDNew: string;
    fSDClose: string;
  public
    procedure getInLanguage(Language: string);
  published
    property Algorithm : string read fAlgorithm write fAlgorithm;
    property Input : string read fInput write fInput;
    property Output : string read fOutput write fOutput;
    property _While : string read fWhile write fWhile;
    property _For : string read fFor write fFor;
    property Yes : string read fYes write fYes;
    property No : string read fNo write fNo;
    property Other : string read fOther write fOther;

    property SDObject : string read fSDObject write fSDObject;
    property SDNew : string read fSDNew write fSDNew;
    property SDClose : string read fSDClose write fSDClose;
  end;

  { TFConfiguration }

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
    {$WARNINGS OFF}
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
    Label1: TLabel;
    pnlGutterFontDisplay: TPanel;
    lblGutterFont: TLabel;
    cbGutterColor: TSpTBXColorEdit;
    ckGutterAutosize: TCheckBox;
    ckGutterShowLineNumbers: TCheckBox;
    ckGutterShowLeaderZeros: TCheckBox;
    ckGutterVisible: TCheckBox;
    ckGutterStartAtZero: TCheckBox;
    cbGutterFont: TCheckBox;
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
    GroupBox2: TGroupBox;
    cbActiveLineColor: TSpTBXColorEdit;
    gbEditorFont: TGroupBox;
    Panel3: TPanel;
    labFont: TLabel;
    btnFont: TButton;
    POptions1: TTabSheet;
    LHighlightSelectedWordColor: TLabel;
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
    ckWordWrap: TCheckBox;
    ckEnhanceHomeKey: TCheckBox;
    ckAltSetsColumnMode: TCheckBox;
    ckTabsToSpaces: TCheckBox;
    ckKeepCaretX: TCheckBox;
    ckSmartTabDelete: TCheckBox;
    ckTabIndent: TCheckBox;
    ckSmartTabs: TCheckBox;
    StackPanel2: TStackPanel;
    ckHalfPageScroll: TCheckBox;
    ckTrimTrailingSpaces: TCheckBox;
    ckScrollByOneLess: TCheckBox;
    ckShowSpecialChars: TCheckBox;
    ckScrollPastEOF: TCheckBox;
    ckDisableScrollArrows: TCheckBox;
    ckScrollPastEOL: TCheckBox;
    ckGroupUndo: TCheckBox;
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
    cbHighlighters: TComboBox;
    GroupBox1: TGroupBox;
    cbxElementBold: TCheckBox;
    cbxElementItalic: TCheckBox;
    cbxElementUnderline: TCheckBox;
    cbxElementStrikeout: TCheckBox;
    cbElementBackground: TSpTBXColorEdit;
    cbElementForeground: TSpTBXColorEdit;
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
    EFrameheight: TEdit;
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
    LFileTemplateForNewPythonScripts: TLabel;
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
    EFileTemplateForNewScripts: TEdit;
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
    CBAssociationJfm: TCheckBox;
    CBAssociationHtml: TCheckBox;
    CBAssociationUml: TCheckBox;
    CBAssociationTxt: TCheckBox;
    CBAssociationJsp: TCheckBox;
    CBAssociationPhp: TCheckBox;
    CBAssociationCss: TCheckBox;
    EAdditionalAssociations: TEdit;
    CBAssociationInc: TCheckBox;
    BFileExtensions: TButton;
    EJEAssociation: TEdit;
    BJEAssociation: TButton;
    CBAssociationJsg: TCheckBox;
    CBAssociationJSD: TCheckBox;
    CheckBox1: TCheckBox;
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
    CBShowTypeSelection: TCheckBox;
    GBMethodsOptions: TGroupBox;
    CBShowKindProcedure: TCheckBox;
    CBShowParameterTypeSelection: TCheckBox;
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
    procedure FormClose(Sender: TObject; var aAction: TCloseAction);
    procedure vtPythonVersionsGetCellText(Sender: TCustomVirtualStringTree;
      var E: TVSTGetCellTextEventArgs);
    procedure vtPythonVersionsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: UITypes.TImageIndex);
    procedure vtPythonVersionsInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure vtPythonVersionsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure actPVActivateExecute(Sender: TObject);
    procedure actPVAddExecute(Sender: TObject);
    procedure actPVRemoveExecute(Sender: TObject);
    procedure actlPythonVersionsUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure actPVCommandShellExecute(Sender: TObject);
    procedure BCodeCompletionFontClick(Sender: TObject);
    procedure cbHighlightersChange(Sender: TObject);
    procedure cbFileTemplatesHighlightersChange(Sender: TObject);
    procedure lbElementsClick(Sender: TObject);
    procedure SynSyntaxSampleClick(Sender: TObject);
    procedure cbElementForegroundSelectedColorChanged(Sender: TObject);
    procedure cbElementBackgroundSelectedColorChanged(Sender: TObject);
    procedure cbxElementBoldClick(Sender: TObject);
    procedure lbColorThemesClick(Sender: TObject);
    procedure btnUpdateKeyClick(Sender: TObject);
    procedure btnAddKeyClick(Sender: TObject);
    procedure btnRemKeyClick(Sender: TObject);
    procedure cKeyCommandKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFontClick(Sender: TObject);
    procedure btnGutterFontClick(Sender: TObject);
    procedure cbGutterFontClick(Sender: TObject);
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
  private
    fHighlighters : TList;
    fColorThemeHighlighter : TSynCustomHighlighter;
    HighlighterFileDir: string;
    FSynEdit: TSynEditorOptionsContainer;
    eKeyShort2: TSynHotKey;
    eKeyShort1: TSynHotKey;
    FUserCommand: TSynEditorOptionsUserCommand;
    FAllUserCommands: TSynEditorOptionsAllUserCommands;
    FExtended: Boolean;
    edNewShortcut: TSynHotKey;
    FInternalCall: Boolean;
    FMargins: TSynEditPrintMargins;
    Editor: TCustomRichEdit;
    HeaderFooterCharPos: TPoint;
    HeaderFooterOldStart: Integer;

    FunctionList : TStringList;
    IDEKeyList   : TStringList;
    ActionProxyCollection   : TActionProxyCollection;
    CodeTemplateText : string;
    TempFileTemplates : TFileTemplates;

    Loading : Boolean;
    FStylesPath : string;
    FPreview: TVclStylesPreview;
    ExternalStyleFilesDict :  TDictionary<string, string>;
    LoadedStylesDict :  TDictionary<string, string>;

    FHandleChanges : Boolean;  //Normally true, can prevent unwanted execution of event handlers
    IndentWidth: Integer;
    CurrentLanguage: string;

    function DirectoryFilesExists(s: String): boolean;
    procedure CheckFolder(Edit: TEdit; emptyAllowed: boolean);
    procedure CheckFolderCB(ComboBox: TComboBox);
    procedure CheckUserFolder(Edit: TEdit);
    procedure CheckFile(WinControl: TWinControl; emptyAllowed: boolean);
    function getCheckColor(s: string; LeerErlaubt: boolean): TColor;
    procedure ShortenPath(WinControl: TWinControl; const s: string);
    function ExtendPath(WinControl: TWinControl): string;
    function BrowserProgToName(const s: String): String;

    function SelectedHighlighter : TSynCustomHighlighter;
    procedure UpdateColorFontStyle;
    procedure PrepareHighlighters;
    procedure UpdateHighlighters;
    procedure UpdateKey(AKey: TSynEditKeystroke);
    procedure FillInKeystrokeInfo(AKey: TSynEditKeystroke; AItem: TListItem);
    procedure PrepareKeyStrokes;
    procedure KeyListSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure EditStrCallback(const S: string);
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
    procedure AddLines(HeadFoot: THeaderFooter; AEdit: TCustomRichEdit; Al: TALignment);
    procedure GetValues(SynEditPrint: TSynEditPrint);
    procedure SetValues(SynEditPrint: TSynEditPrint);
    procedure StyleSelectorFormCreate;
    procedure StyleSelectorFormShow;
    procedure FillVclStylesList;
    procedure SetStyle(StyleName: string);
    procedure ApplyColorTheme;

    procedure ModelToView;
    procedure ViewToModel;
    procedure CheckAllFilesAndFolders;
    procedure LockButtons;

    procedure MakeAssociations;
    procedure RegisterGuiPy;
    procedure ShowPage(i: integer);
    procedure FolderSelect(Edit: TEdit; const aFoldername: string);
    function GetConfigurationAddress(const s: string): string;
    function getDumpText: string;

    procedure CallUpdater(const Target, Source1: string; Source2: string); overload;
    procedure SetElevationRequiredState(aControl: TWinControl);
    procedure MakeControlStructureTemplates;
    procedure EnableColorItems(aEnable:boolean);
    procedure StoreApplicationData;
  public
    ShowAlways: boolean;
    CurrentSkinName : string;
    Indent1, Indent2, Indent3: string;
    ControlStructureTemplates: array[1..21] of TStringList;
    GitOK: boolean;
    SubversionOK: boolean;
    EditorFolder: String;

    procedure Changed;
    function getEncoding(const Pathname: string): TEncoding;
    procedure PrepareShow;
    function getMultiLineComment(Indent: string): string;
    function getClassCodeTemplate: string;
    function getTVConfigurationItem(text: string): TTreeNode;
    function getFileFilters: String;
    procedure OpenAndShowPage(Page: string);
    function RunAsAdmin(hWnd: HWND; const aFile, aParameters: string): THandle;

    procedure LanguageOptionsToView;
    procedure LanguageOptionsToModel;

    procedure DoHelp(Adresse: string);
    class function isDark: boolean;

    property GetUserCommandNames: TSynEditorOptionsUserCommand read FUserCommand
      write FUserCommand;
    property GetAllUserCommands: TSynEditorOptionsAllUserCommands
      read FAllUserCommands
      write FAllUserCommands;
    property CurrentAction : TActionProxyItem
      read GetCurrentAction;
  end;

 var
   FConfiguration: TFConfiguration = nil;
   GuiPyOptions: TGuiPyOptions = nil;
   GuiPyLanguageOptions: TGuiPyLanguageOptions = nil;

implementation

{$R *.DFM}

uses SynUnicode, StringResources, JvGnugettext, FileCtrl,
     StrUtils, Menus, Printers, ValEdit, ShlObj, Math, Themes, Styles,
     ShellAPI, Winapi.RichEdit, SynEditTypes, UUtils, UHtmlHelp, Contnrs,
     Registry, SynEditPrintTypes, dmCommands, cPyControl, uEditAppIntfs,
     PythonVersions, uCommonFunctions, cPySupportTypes, frmPyIDEMain, SpTBXTabs,
     IOUtils, JvAppStorage, JvAppIniStorage, SynEditKeyConst, JvJCLUtils,
     frmFile, frmEditor, UGit, USubversion;

const
  MaxPages = 34;

  machine = 0;
  allusers = 1;
  user = 2;


{--- TEditStyleHook -----------------------------------------------------------}

constructor TEditStyleHookColor.Create(AControl: TWinControl);
begin
  inherited;
  //call the UpdateColors method to use the custom colors
  UpdateColors;
end;

//Here you set the colors of the style hook
procedure TEditStyleHookColor.UpdateColors;
begin
  if Control.Enabled then begin
    if TWinControlH(Control).Color = clRed then begin
      Brush.Color:= clRed;
      FontColor:= StyleServices.GetStyleFontColor(sfEditBoxTextDisabled); // use the Control font color
    end else
      Brush.Color:= StyleServices.GetStyleColor(scEdit); // use the Control color
    //FontColor := StyleServices.GetStyleFontColor(sfEditBoxTextDisabled); // use the Control font color
  end else begin
    // if the control is disabled use the colors of the style
    Brush.Color:= StyleServices.GetStyleColor(scEditDisabled); // scEditDisabled
    FontColor  := StyleServices.GetStyleFontColor(sfEditBoxTextDisabled);
  end;
end;

//handle the messages
procedure TEditStyleHookColor.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        //get the colors
        UpdateColors;
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled:= true;
      end;
    CM_COLORCHANGED,
    CM_ENABLEDCHANGED:
      begin
        //get the colors
        UpdateColors;
        Handled:= false;
      end
  else
    inherited WndProc(Message);
  end;
end;

{--- Configuration ------------------------------------------------------------}

procedure TFConfiguration.FormCreate(Sender: TObject);
  var i: integer;
begin
  inherited;
  TempFileTemplates := TFileTemplates.Create;
  GuiPyOptions:= TGuiPyOptions.Create;
  GuiPyLanguageOptions:= TGuiPyLanguageOptions.Create;
  CBValidClassColor.Style:= [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames];
  CBInvalidClassColor.Style:= [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames];
  CBObjectColor.Style:= [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames];
  CBCommentColor.Style:= [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames];
  for i:= 1 to 21 do
    ControlStructureTemplates[i]:= nil;
  for i:= 0 to PageList.PageCount - 1 do
    PageList.Pages[i].TabVisible := false;
  TVConfiguration.FullExpand;
  ShowPage(0);
  TVConfiguration.TopItem:= TVConfiguration.Items[0];
  if VistaOrBetter then begin
    SetElevationRequiredState(BFileExtensions);
    SetElevationRequiredState(BJEAssociation);
  end;
  vtPythonVersions.DefaultText := '';
  vtPythonVersions.RootNodeCount := 2;
  fHighlighters := TList.create;
  PrepareHighlighters;
  FSynEdit:= TSynEditorOptionsContainer.Create(Self);
  FInternalCall:= false;
  CustomShortcutsCreate;
  FInternalCall := False;
  FMargins := TSynEditPrintMargins.Create;
  Editor := nil;
  EditorFolder:= ExtractFilePath(ParamStr(0));
  StyleSelectorFormCreate;
  Changed;
end;

procedure TFConfiguration.FormDestroy(Sender: TObject);
  var i: integer;
begin
  for i:= 1 to 21 do
    FreeAndNil(ControlStructureTemplates[i]);

  for i:= fHighlighters.Count - 1 downto 0 do
    FreeAndNil(fHighlighters.Items[i]);

  FreeAndNil(fHighlighters);
  FreeAndNil(fColorThemeHighlighter);
  FreeandNil(FSynEdit);

  ActionProxyCollection.Free;
  FMargins.Free;
  ExternalStyleFilesDict.Free;
  FPreview.Free;
  LoadedStylesDict.Free;
  FreeAndNil(GuiPyOptions);
  FreeAndNil(GuiPyLanguageOptions);

  FreeAndNil(KeyList);
  FreeAndNil(FunctionList);
  FreeAndNil(IDEKeyList);
  TempFileTemplates.Clear;
  FreeAndNil(TempFileTemplates);
  FConfiguration:= nil;
end;

procedure TFConfiguration.FormClose(Sender: TObject; var aAction: TCloseAction);
begin
  PageListClose;
  DoneItems;
  FreeAndNil(ActionProxyCollection);
end;

procedure TFConfiguration.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= true;
end;

procedure TFConfiguration.FormShow(Sender: TObject);
  var i: integer;
begin
  for i:= 0 to PageList.PageCount - 1 do
    TVConfiguration.Items[i].Text:= PageList.Pages[i].Caption;
  vtPythonVersions.Header.Columns.Items[1].Text:= _('Folder');

  SynEditOptionsShow;
  CustomShortcutsShow;
  PageSetupShow;
  StyleSelectorFormShow;
end;

procedure TFConfiguration.PageSetupShow;
begin
  Editor := REHeaderLeft;
  SetHeaderFooterOptions;
  UpdateHeaderFooterCursorPos;
end;

function TFConfiguration.DirectoryFilesExists(s: String): boolean;
  var p: integer; dir: string;
begin
  Result:= true;
  if s <> '' then begin
    s:= s + ';';
    p:= Pos(';', s);
    while p > 0 do begin
      dir:= Trim(Copy(s, 1, p-1));
      delete(s, 1, p);
      if endsWith(dir, '*') then delete(dir, length(dir), 1);
      if ((Copy(dir, 2, 1) = ':') or (Copy(dir, 1, 2) = '\\')) and
         not (SysUtils.DirectoryExists(dir) or FileExists(dir)) then
          Result:= false;
      p:= Pos(';', s);
    end;
  end;
end;

procedure TFConfiguration.CheckFolder(Edit: TEdit; emptyAllowed: boolean);
  var s: string;
begin
  s:= ExtendPath(Edit);
  ShortenPath(Edit, s);
  if Sysutils.DirectoryExists(Edit.Hint) or (s = '') and emptyAllowed
    then Edit.Color:= clWindow
    else Edit.Color:= clRed;
  Edit.Enabled:= not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.CheckFolderCB(ComboBox: TComboBox);
  var s: string;
begin
  s:= ExtendPath(ComboBox);
  ShortenPath(ComboBox, s);
  if DirectoryFilesExists(s)
    then ComboBox.Color:= clWindow
    else ComboBox.Color:= clRed;
  ComboBox.Enabled:= not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.CheckUserFolder(Edit: TEdit);
  var s: string;
begin
  s:= ExtendPath(Edit);
  ShortenPath(Edit, s);
  if DirectoryFilesExists(dissolveUsername(Edit.Hint))
    then Edit.Color:= clWindow
    else Edit.Color:= clRed;
end;

procedure TFConfiguration.CheckAllFilesAndFolders;
begin
  CheckUserFolder(ETempFolder);
  CheckFolder(ESVNFolder, true);
  CheckFolderCB(CBRepository);
  CheckFolder(ETempFolder, false);
  CheckFolder(EGitFolder, true);
  CheckFolderCB(CBLocalRepository);
  CheckFolderCB(CBRemoteRepository);
  LockButtons;
end;

procedure TFConfiguration.LockButtons;
begin
  SBTempSelect.Enabled:= not GuiPyOptions.LockedPaths;
  BTempFolder.Enabled:= not GuiPyOptions.LockedPaths;
  BGitFolder.Enabled:= not GuiPyOptions.LockedPaths;
  BGitRepository.Enabled:= not GuiPyOptions.LockedPaths;
  BGitClone.Enabled:= not GuiPyOptions.LockedPaths;
  BSVN.Enabled:= not GuiPyOptions.LockedPaths;
  BRepository.Enabled:= not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.BSaveClick(Sender: TObject);
begin
  Close;
  Screen.Cursor:= crHourGlass;
  try
    ViewToModel;
    StoreApplicationData;
    Changed;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

function TFConfiguration.getCheckColor(s: string; LeerErlaubt: boolean): TColor;
begin
  Result:= clRed;
  if s = '' then
    if LeerErlaubt
      then Result:= StyleServices.getSystemColor(clWindow)
      else
  else if FileExists(dissolveUsername(s))
    then Result:= StyleServices.getSystemColor(clWindow)
end;

procedure TFConfiguration.CheckFile(WinControl: TWinControl; emptyAllowed: boolean);
  var s: String; E: TEdit;
begin
  s:= ExtendPath(WinControl);
  ShortenPath(WinControl, s);
  if WinControl is TEdit
    then begin
    E:= (WinControl as TEdit);
    E.Color:= getCheckColor(s, emptyAllowed);
    end
    else (WinControl as TComboBox).Color:= getCheckColor(s, emptyAllowed);
  WinControl.Enabled:= not GuiPyOptions.LockedPaths;
end;

procedure TFConfiguration.BSelectBrowserClick(Sender: TObject);
  var ODSelect: TOpenDialog;
begin
  ODSelect:= TOpenDialog.Create(Self);
  ODSelect.Options:= [ofPathMustExist, ofFileMustExist, ofEnableSizing];
  with ODSelect do begin
    InitialDir:= GetEnvironmentVariable('PROGRAMFILES');
    Filename  := '*.exe';
    Filter:= '*.exe|*.exe';
    if not Sysutils.DirectoryExists(InitialDir) then InitialDir:= 'C:\';
    if Execute then
      ShortenPath(EBrowserProgram, Filename);
    CheckFile(EBrowserProgram, true);
  end;
  FreeAndNil(ODSelect);
end;

function TFConfiguration.BrowserProgToName(const s: String): String;
  var Browser: String;
begin
  Browser:= UpperCase(s);
  if Pos('NETSCAPE', Browser) > 0
    then Result:= 'Netscape'
  else if Pos('IEXPLORE', Browser) > 0
    then Result:= 'Internet Explorer'
  else if Pos('OPERA', Browser) > 0
    then Result:= 'Opera'
  else if Pos('FIREFOX', Browser) > 0
    then Result:= 'Mozilla Firefox'
  else if Pos('MOZILLA', Browser) > 0
    then Result:= 'Mozilla'
  else Result:= 'unknown';
end;

procedure TFConfiguration.BBrowserTitleClick(Sender: TObject);
begin
  ShortenPath(EBrowsertitle, BrowserProgToName(EBrowserProgram.Hint));
end;

procedure TFConfiguration.BCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFConfiguration.FolderSelect(Edit: TEdit; const aFoldername: string);
  var s: string;
begin
  {$WARNINGS OFF}
  FolderDialog.DefaultFolder:= aFoldername;
  if FolderDialog.Execute then begin
    s:= withoutTrailingSlash(FolderDialog.Filename);
    ShortenPath(Edit, s);
  end;
  {$WARNINGS ON}
end;

procedure TFConfiguration.Changed;
begin
  ShowAlways:= true;
  CommandsDataModule.dlgFileOpen.Filter:= getFileFilters;

  // tab Editor
  IndentWidth:= EditorOptions.TabWidth;
  Indent1:= StringOfChar(' ', 1*IndentWidth);
  Indent2:= StringOfChar(' ', 2*IndentWidth);
  Indent3:= StringOfChar(' ', 3*IndentWidth);
  MakeControlStructureTemplates;

  // tab Git
  GitOK := FileExists(GuiPyOptions.GitFolder + '\bin\git.exe');
  PyIDEMainForm.mnToolsGit.Visible:= GitOK;
  if GitOK and (FGit = nil) then
    FGit:= TFGit.Create(Self);

  // tab Subversion
  SubversionOK := FileExists(GuiPyOptions.SVNFolder + '\svn.exe');
  PyIDEMainForm.mnToolsSVN.Visible:= SubversionOK;
  if SubversionOK and (FSubversion = nil) then
    FSubversion:= TFSubversion.Create(Self);
end;

procedure TFConfiguration.ModelToView;
begin
  if Assigned(GI_ActiveEditor)
    then FSynEdit.assign(GI_ActiveEditor.ActiveSynEdit)
    else FSynEdit.assign(EditorOptions);
  PrepareKeyStrokes;
  DoneItems;
  PrepActions;  // IDE commands
  CodeTemplateText:= CommandsDataModule.CodeTemplatesCompletion.AutoCompleteList.Text;
  SetValues(CommandsDataModule.SynEditPrint);
  CodeTemplatesInit;
  FileTemplatesInit;

  // tab Python
  RGEnginetypes.ItemIndex:= Ord(PyControl.PythonEngineType) - 1;

  //Gutter
  ckGutterVisible.Checked:= FSynEdit.Gutter.Visible;
  ckGutterAutosize.Checked:= FSynEdit.Gutter.AutoSize;  //fixed by KF Orig: FSynEdit.Gutter.Visible;
  ckGutterShowLineNumbers.Checked:= FSynEdit.Gutter.ShowLineNumbers;
  ckGutterShowLeaderZeros.Checked:= FSynEdit.Gutter.LeadingZeros;
  ckGutterStartAtZero.Checked:= FSynEdit.Gutter.ZeroStart;
  cbGutterFont.Checked := FSynEdit.Gutter.UseFontStyle;
  cbGutterColor.SelectedColor := FSynEdit.Gutter.Color;
  lblGutterFont.Font.Assign(FSynEdit.Gutter.Font);
  lblGutterFont.Caption:= lblGutterFont.Font.Name + ' ' + IntToStr(lblGutterFont.Font.Size) + 'pt';
  ckGutterGradient.Checked := FSynEdit.Gutter.Gradient;
  //Right Edge
  eRightEdge.Text:= IntToStr(FSynEdit.RightEdge);
  cbRightEdgeColor.SelectedColor:= FSynEdit.RightEdgeColor;
  //ActiveLineColor;
  cbActiveLineColor.SelectedColor := FSynEdit.ActiveLineColor;
  //Line Spacing
  eLineSpacing.Text:= IntToStr(FSynEdit.ExtraLineSpacing);
  eTabWidth.Text:= IntToStr(FSynEdit.TabWidth);
  //Break Chars
  //!!  eBreakchars.Text:= FSynEdit.WordBreakChars;
  //Bookmarks
  ckBookmarkKeys.Checked:= FSynEdit.BookMarkOptions.EnableKeys;
  ckBookmarkVisible.Checked:= FSynEdit.BookMarkOptions.GlyphsVisible;
  //Font
  labFont.Font.Assign(FSynEdit.Font);
  labFont.Caption:= labFont.Font.Name + ' ' + IntToStr(labFont.Font.Size) + 'pt';

  // tab Options2
  ckAutoIndent.Checked:= eoAutoIndent in FSynEdit.Options;
  ckRightMouseMoves.Checked := eoRightMouseMovesCursor in FSynEdit.Options;
  ckDragAndDropEditing.Checked:= eoDragDropEditing in FSynEdit.Options;
  ckEnhanceEndKey.Checked := eoEnhanceEndKey in FSynEdit.Options;
  ckWordWrap.Checked := FSynEdit.WordWrap;
  ckEnhanceHomeKey.Checked := eoEnhanceHomeKey in FSynEdit.Options;
  ckAltSetsColumnMode.Checked:= eoAltSetsColumnMode in FSynEdit.Options;
  ckTabsToSpaces.Checked:= eoTabsToSpaces in FSynEdit.Options;
  ckKeepCaretX.Checked:= eoKeepCaretX in FSynEdit.Options;
  ckSmartTabDelete.Checked := eoSmartTabDelete in FSynEdit.Options;
  ckTabIndent.Checked:= eoTabIndent in FSynEdit.Options;
  ckSmartTabs.Checked:= eoSmartTabs in FSynEdit.Options;

  ckHalfPageScroll.Checked:= eoHalfPageScroll in FSynEdit.Options;
  ckTrimTrailingSpaces.Checked:= eoTrimTrailingSpaces in FSynEdit.Options;
  ckScrollByOneLess.Checked:= eoScrollByOneLess in FSynEdit.Options;
  ckShowSpecialChars.Checked := eoShowSpecialChars in FSynEdit.Options;
  ckScrollPastEOF.Checked:= eoScrollPastEof in FSynEdit.Options;
  ckDisableScrollArrows.Checked := eoDisableScrollArrows in FSynEdit.Options;
  ckScrollPastEOL.Checked:= eoScrollPastEol in FSynEdit.Options;
  ckGroupUndo.Checked := eoGroupUndo in FSynEdit.Options;
  ckShowScrollHint.Checked:= eoShowScrollHint in FSynEdit.Options;
  ckHideShowScrollbars.Checked := eoHideShowScrollbars in FSynEdit.Options;
  ckScrollHintFollows.Checked := eoScrollHintFollows in FSynEdit.Options;
  ckShowLigatures.Checked := eoShowLigatures in FSynEdit.Options;

  with PyIDEOptions do begin
    // interpreter
    CBAlwaysUseSockets.Checked:= AlwaysUseSockets;
    CBClearOutputBeforeRun.Checked:= ClearOutputBeforeRun;
    CBInternalInterpreterHidden.Checked:= InternalInterpreterHidden;
    CBJumpToErrorOnException.Checked:= JumpToErrorOnException;
    CBMaskFPUExceptions.Checked:= MaskFPUExceptions;
    CBPostMortemOnException.Checked:= PostMortemOnException;
    CBPrettyPrintOutput.Checked:= PrettyPrintOutput;
    CBReinitializeBeforeRun.Checked:= ReinitializeBeforeRun;
    CBSaveEnvironmentBeforeRun.Checked:= SaveEnvironmentBeforeRun;
    CBSaveFilesBeforeRun.Checked:= SaveFilesBeforeRun;
    CBSaveInterpreterHistory.Checked:= SaveInterpreterHistory;
    CBTraceOnlyIntoOpenFiles.Checked:= TraceOnlyIntoOpenFiles;
    UDTimeOut.Position:= TimeOut;
    UDInterpreterHistorySize.Position:= InterpreterHistorySize;

    // tab editor
    CBCheckSyntaxAsYouType.Checked:= CheckSyntaxAsYouType;
    CBHighlightSelectedWord.Checked:= HighlightSelectedWord;
    CBAutoCompleteBrackets.Checked:= AutoCompleteBrackets;
    CBAutoHideFindToolbar.Checked:= AutoHideFindToolbar;
    CBAutoReloadChangedFiles.Checked:= AutoReloadChangedFiles;
    CBCodeFoldingEnabled.Checked:= CodeFoldingEnabled;
    CBGuiCodeFolding.Checked:= CodeFoldingForGuiElements;
    CBCompactLineNumbers.Checked:= CompactLineNumbers;
    CBCreateBackupFiles.Checked:= CreateBackupFiles;
    CBDetectUTF8Encoding.Checked:= DetectUTF8Encoding;
    CBDisplayPackageNames.Checked:= DisplayPackageNames;
    CBMarkExecutableLines.Checked:= MarkExecutableLines;
    CBSearchTextAtCaret.Checked:= SearchTextAtCaret;
    CBShowCodeHints.Checked:= ShowCodeHints;
    CBShowDebuggerHints.Checked:= ShowDebuggerHints;
    CBTrimTrailingSpacesOnSave.Checked:= TrimTrailingSpacesOnSave;
    CBUndoAfterSave.Checked:= UndoAfterSave;
    CBHighlightSelectedWordColor.Color:= HighlightSelectedWordColor;
    RGNewFileEncoding.ItemIndex:= Ord(NewFileEncoding);
    RGNewFileLineBreaks.ItemIndex:= ord(NewFileLineBreaks);

    // tab code completion
    CBCompletionCaseSensitive.Checked := CodeCompletionCaseSensitive;
    CBCompleteAsYouType.Checked:= CompleteAsYouType;
    CBCompleteKeywords.Checked:= CompleteKeywords;
    CBCompleteWithOneEntry.Checked:= CompleteWithOneEntry;
    CBCompleteWithWordBreakChars.Checked:= CompleteWithWordBreakChars;
    CBEditorCodeCompletion.Checked:= EditorCodeCompletion;
    CBInterpreterCodeCompletion.Checked:= InterpreterCodeCompletion;
    UDCodeComletionListSize.Position:= CodeCompletionListSize;
    ESpecialPackages.Text:= SpecialPackages;

    // tab general options
    CBSaveFilesAutomatically.Checked:= SaveFilesAutomatically;
    CBRestoreOpenFiles.Checked:= RestoreOpenFiles;
    CBRestoreOpenProject.Checked:= RestoreOpenProject;
    CBShowTabCloseButton.Checked:= ShowTabCloseButton;
    CBSmartNextPrevPage.Checked:= SmartNextPrevPage;
    CBStyleMainWindowBorder.Checked:= StyleMainWindowBorder;
    CBExporerInitiallyExpanded.Checked:= ExporerInitiallyExpanded;
    CBFileExplorerContextMenu.Checked:= FileExplorerContextMenu;
    CBProjectExporerInitiallyExpanded.Checked:= ProjectExporerInitiallyExpanded;
    CBFileExplorerBackgroundProcessing.Checked:= FileExplorerBackgroundProcessing;
    CBMethodsWithComment.Checked:= MethodsWithComment;
    CBAutoCheckForUpdates.Checked:= AutoCheckForUpdates;

    UDDaysBetweenChecks.Position:= DaysBetweenChecks;
    UDNoOfRecentFiles.Position:= NoOfRecentFiles;
    UDDockAnimationInterval.Position:= DockAnimationInterval;
    UDDockAnimationMoveWidth.Position:= DockAnimationMoveWidth;
    EFileTemplateForNewScripts.Text:= FileTemplateForNewScripts;
    RGEditorTabPosition.ItemIndex:= Ord(EditorsTabPosition);
    RGFileChangeNotification.ItemIndex:= Ord(FileChangeNotification);
    ShortenPath(ETempFolder, GuiPyOptions.TempDir);

    // tab ssh
    EScpCommand.text:= ScpCommand;
    EScpOptions.text:= ScpOptions;
    ESSHCommand.text:= SSHCommand;
    ESSHOptions.text:= SSHOptions;
    CBSSHDisableVariablesWin.Checked:= SSHDisableVariablesWin;
  end;

  with GuiPyOptions do begin
    // Color themes
    lbColorThemes.ItemIndex:= lbColorThemes.Items.IndexOf(fColorTheme);
    lbColorThemesClick(Self);

    // Class modeler
    CBShowGetSetMethods.Checked:= ShowGetSetMethods;
    CBShowTypeSelection.Checked:= ShowTypeSelection;
    CBShowKindProcedure.Checked:= ShowKindProcedure;
    CBShowParameterTypeSelection.Checked:= ShowParameterTypeSelection;

    // GUI design
    CBNameFromText.Checked:= NameFromText;
    CBGuiDesignerHints.Checked:= GuiDesignerHints;
    UDGridSize.Position:= GridSize;
    CBSnapToGrid.Checked:= SnapToGrid;
    EFrameWidth.Text:= IntToStr(FrameWidth);
    EFrameHeight.Text:= IntToStr(FrameHeight);

    // tab structograms
    CBDatatype.text:= StructoDatatype;
    CBSwitchWithCaseLine.Checked:= SwitchWithCaseLine;
    ECaseCount.text:= IntTostr(CaseCount);
    UDStructogramShadowWidth.Position:= StructogramShadowWidth;
    UDStructogramShadowIntensity.Position:= StructogramShadowIntensity;

    // tab sequence diagrams
    CBSDFillingColor.Selected:= SDFillingcolor;
    CBSDNoFilling.Checked:= SDNoFilling;
    CBSDShowMainCall.Checked:= SDShowMainCall;
    CBSDShowParameter.Checked:= SDShowParameter;
    CBSDShowReturn.Checked:= SDShowReturn;

    // tab UML design
    CBValidClassColor.Selected:= ValidClassColor;
    CBInvalidClassColor.Selected:= InvalidClassColor;
    RGClassHead.ItemIndex:= ClassHead;
    CBObjectColor.Selected:= ObjectColor;
    RGObjectHead.ItemIndex:= ObjectHead;
    RGObjectFooter.ItemIndex:= ObjectFooter;
    RGObjectCaption.ItemIndex:= ObjectCaption;
    CBObjectUnderline.Checked:= ObjectUnderline;
    CBCommentColor.Selected:= CommentColor;
    RGAttributsMethodsDisplay.ItemIndex:= 3 - DiVisibilityFilter;
    RGSequenceAttributsMethods.ItemIndex:= DISortOrder;
    RGParameterDisplay.ItemIndex:= DIShowParameter;
    RGVisibilityDisplay.ItemIndex:= 2 - DIShowIcons;
    UDShadowWidth.Position:= ShadowWidth;
    UDShadowIntensity.Position:= ShadowIntensity;

    // tab uml options
    CBUMLEdit.Checked:= PrivateAttributEditable;
    CBShowEmptyRects.Checked:= ShowEmptyRects;
    CBConstructorWithVisibility.Checked:= ConstructorWithVisibility;
    CBLowerCaseLetter.Checked:= ObjectLowerCaseLetter;
    CBOpenPublicClasses.Checked:= ShowPublicOnly;
    CBDefaultModifiers.Checked:= DefaultModifiers;
    CBShowObjectsWithMethods.Checked:= ShowObjectsWithMethods;
    CBShowObjectsWithInheritedPrivateAttributes.Checked:= ShowObjectsWithInheritedPrivateAttributes;
    CBIntegerInsteadofInt.Checked:= IntegerInsteadofInt;
    CBShowAllNewObjects.Checked:= ShowAllNewObjects;
    CBObjectsWithoutVisibility.Checked:= ObjectsWithoutVisibility;
    CBRelationshipAttributesBold.Checked:= RelationshipAttributesBold;
    CBShowClassparameterSeparately.Checked:= ShowClassparameterSeparately;
    CBRoleHidesAttribute.Checked:= RoleHidesAttribute;

    // tab restrictions
    CBLockedDosWindow.Checked:= LockedDOSWindow;
    CBLockedInternet.Checked:= LockedInternet;
    CBLockedPaths.Checked:= LockedPaths;
    CBLockedStructogram.Checked:= LockedStructogram;
    CBUsePredefinedLayouts.Checked:= UsePredefinedLayouts;
    if not IsAdministrator then begin
      CBLockedDosWindow.Enabled:= false;
      CBLockedInternet.Enabled:= false;
      CBLockedPaths.Enabled:= false;
      CBLockedStructogram.Enabled:= false;
      CBUsePredefinedLayouts.Enabled:= false;
    end;

    // tab associations
    CBAssociationPython.Checked:= HasAssociationWithGuiPy('.py');
    CBAssociationJfm.Checked := HasAssociationWithGuiPy('.pfm');
    CBAssociationUml.Checked := HasAssociationWithGuiPy('.puml');
    CBAssociationHtml.Checked:= HasAssociationWithGuiPy('.html');
    CBAssociationTxt.Checked := HasAssociationWithGuiPy('.txt');
    CBAssociationJsp.Checked := HasAssociationWithGuiPy('.jsp');
    CBAssociationPhp.Checked := HasAssociationWithGuiPy('.php');
    CBAssociationCss.Checked := HasAssociationWithGuiPy('.css');
    CBAssociationInc.Checked := HasAssociationWithGuiPy('.inc');
    CBAssociationJsg.Checked := HasAssociationWithGuiPy('.psg');
    CBAssociationJsd.Checked := HasAssociationWithGuiPy('.psd');
    EJEAssociation.Text:= getRegisteredGuiPy;
    EAdditionalAssociations.Text:= AdditionalAssociations;

    // tab Git
    ShortenPath(EGitFolder, AddPortableDrive(GitFolder));
    ShortenPath(CBLocalRepository, AddPortableDrive(GitLocalRepository));
    ShortenPath(CBRemoteRepository, GitRemoteRepository);
    EUserName.Text:= GitUserName;
    EUserEMail.Text:= GitUserEMail;

    // tab SVN
    ShortenPath(ESVNFolder, SVNFolder);
    ShortenPath(CBRepository, SVNRepository);

    // tab Browser
    CBUseIEinternForDocuments.Checked:= UseIEinternForDocuments;
    CBOnlyOneBrowserWindow.Checked:= OnlyOneBrowserWindow;
    EBrowsertitle.text:= BrowserTitle;
    CBOpenBrowserShortcut.Text:= OpenBrowserShortcut;
    ShortenPath(EBrowserProgram, BrowserProgram);

    // others
    EAuthor.Text:= Author;
    ETempFolder.Text:= TempDir;
  end;
  LanguageOptionsToView;
  CurrentLanguage:= getCurrentLanguage;
  RGLanguages.OnClick:= RGLanguagesClick;
end;

procedure TFConfiguration.LanguageOptionsToView;
begin
  with GuiPyLanguageOptions do begin
    // tab structograms
    EAlgorithm.Text:= Algorithm;
    EInput.Text:= Input;
    EOutput.Text:= Output;
    EWhile.Text:= _While;
    EFor.Text:= _For;
    EYes.Text:= Yes;
    ENo.Text:= No;
    EOther.Text:= Other;

    // tab sequence diagram
    ESDObject.Text:= SDObject;
    ESDNew.Text:= SDNew;
    ESDClose.Text:= SDClose;
  end;
end;

procedure TFConfiguration.LanguageOptionsToModel;
begin
  with GuiPyLanguageOptions do begin
    // tab structogram
    Algorithm:= EAlgorithm.Text;
    Input:= EInput.Text;
    Output:= EOutput.Text;
    _While:= EWhile.Text;
    _For:= EFor.Text;
    Yes:= EYes.Text;
    No:= ENo.Text;
    Other:= EOther.Text;

    // tab sequencediagram
    SDObject:= ESDObject.Text;
    SDNew:= ESDNew.Text;
    SDClose:= ESDClose.Text;
  end;
end;

procedure TFConfiguration.StoreApplicationData;
begin
  PyIDEOptions.Changed;
  PyIDEMainForm.StoreApplicationData;
end;

procedure TFConfiguration.ViewToModel;
  var LanguageNr: Integer;
      vOptions: TSynEditorOptions;

  procedure SetFlag(aOption: TSynEditorOption; aValue: Boolean);
  begin
    if aValue then
      Include(vOptions, aOption)
    else
      Exclude(vOptions, aOption);
  end;

begin
  RGLanguages.OnClick:= nil;
  // tab Python
  if RGEngineTypes.ItemIndex <> Ord(PyControl.PythonEngineType) - 1 then begin
     case RGEngineTypes.ItemIndex of
       0: PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemote);
       1: PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemoteTk);
       2: PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemoteWx);
     else PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonSSH);
     end;
     if PyControl.PythonEngineType = peInternal then
       PyIDEMainForm.actPythonEngineExecute(PyIDEMainForm.actPythonRemote);
   end;

  //Gutter
  FSynEdit.Gutter.Visible:= ckGutterVisible.Checked;
  FSynEdit.Gutter.AutoSize := ckGutterAutosize.Checked;
  FSynEdit.Gutter.ShowLineNumbers:= ckGutterShowLineNumbers.Checked;
  FSynEdit.Gutter.LeadingZeros:= ckGutterShowLeaderZeros.Checked;
  FSynEdit.Gutter.ZeroStart:= ckGutterStartAtZero.Checked;
  //FSynEdit.Gutter.Color:= cbGutterColor.SelectedColor;
  FSynEdit.Gutter.UseFontStyle := cbGutterFont.Checked;
  FSynEdit.Gutter.Font.Assign(lblGutterFont.Font);
  FSynEdit.Gutter.Gradient := ckGutterGradient.Checked;
  //Right Edge
  FSynEdit.RightEdge:= StrToIntDef(eRightEdge.Text, 80);
  FSynEdit.RightEdgeColor:= cbRightEdgeColor.SelectedColor;
  //ActiveLineColor;
  FSynEdit.ActiveLineColor := cbActiveLineColor.SelectedColor;
  //Line Spacing
  FSynEdit.ExtraLineSpacing:= StrToIntDef(eLineSpacing.Text, 0);
  FSynEdit.TabWidth:= StrToIntDef(eTabWidth.Text, 8);
  //Break Chars
//!!  FSynEdit.WordBreakChars:= eBreakchars.Text;
  //Bookmarks
  FSynEdit.BookMarkOptions.EnableKeys:= ckBookmarkKeys.Checked;
  FSynEdit.BookMarkOptions.GlyphsVisible:= ckBookmarkVisible.Checked;
  //Font
  FSynEdit.Font.Assign(labFont.Font);

  // tab options2
  FSynEdit.WordWrap := ckWordWrap.Checked;
  vOptions := FSynEdit.Options; //Keep old values for unsupported options
  SetFlag(eoAutoIndent, ckAutoIndent.Checked);
  SetFlag(eoDragDropEditing, ckDragAndDropEditing.Checked);
  SetFlag(eoTabIndent, ckTabIndent.Checked);
  SetFlag(eoSmartTabs, ckSmartTabs.Checked);
  SetFlag(eoAltSetsColumnMode, ckAltSetsColumnMode.Checked);
  SetFlag(eoHalfPageScroll, ckHalfPageScroll.Checked);
  SetFlag(eoScrollByOneLess, ckScrollByOneLess.Checked);
  SetFlag(eoScrollPastEof, ckScrollPastEOF.Checked);
  SetFlag(eoScrollPastEol, ckScrollPastEOL.Checked);
  SetFlag(eoShowScrollHint, ckShowScrollHint.Checked);
  SetFlag(eoTabsToSpaces, ckTabsToSpaces.Checked);
  SetFlag(eoTrimTrailingSpaces, ckTrimTrailingSpaces.Checked);
  SetFlag(eoKeepCaretX, ckKeepCaretX.Checked);
  SetFlag(eoSmartTabDelete, ckSmartTabDelete.Checked);
  SetFlag(eoRightMouseMovesCursor, ckRightMouseMoves.Checked);
  SetFlag(eoEnhanceHomeKey, ckEnhanceHomeKey.Checked);
  SetFlag(eoEnhanceEndKey, ckEnhanceEndKey.Checked);
  SetFlag(eoGroupUndo, ckGroupUndo.Checked);
  SetFlag(eoScrollHintFollows, ckScrollHintFollows.Checked);
  SetFlag(eoDisableScrollArrows, ckDisableScrollArrows.Checked);
  SetFlag(eoHideShowScrollbars, ckHideShowScrollbars.Checked);
  SetFlag(eoShowSpecialChars, ckShowSpecialChars.Checked);
  SetFlag(eoShowLigatures, ckShowLigatures.Checked);
  FSynEdit.Options := vOptions;

  with PyIDEOptions do begin
    // tab interpreter
    AlwaysUseSockets:= CBAlwaysUseSockets.Checked;
    ClearOutputBeforeRun:= CBClearOutputBeforeRun.Checked;
    InternalInterpreterHidden:= CBInternalInterpreterHidden.Checked;
    JumpToErrorOnException:= CBJumpToErrorOnException.Checked;
    MaskFPUExceptions:= CBMaskFPUExceptions.Checked;
    PostMortemOnException:= CBPostMortemOnException.Checked;
    PrettyPrintOutput:= CBPrettyPrintOutput.Checked;
    ReinitializeBeforeRun:= CBReinitializeBeforeRun.Checked;
    SaveEnvironmentBeforeRun:= CBSaveEnvironmentBeforeRun.Checked;
    SaveFilesBeforeRun:= CBSaveFilesBeforeRun.Checked;
    SaveInterpreterHistory:= CBSaveInterpreterHistory.Checked;
    TraceOnlyIntoOpenFiles:= CBTraceOnlyIntoOpenFiles.Checked;
    TimeOut:= UDTimeOut.Position;
    InterpreterHistorySize:= UDInterpreterHistorySize.Position;

    // tab editor
    CheckSyntaxAsYouType:= CBCheckSyntaxAsYouType.Checked;
    HighlightSelectedWord:= CBHighlightSelectedWord.Checked;
    AutoCompleteBrackets:= CBAutoCompleteBrackets.Checked;
    AutoHideFindToolbar:= CBAutoHideFindToolbar.Checked;
    AutoReloadChangedFiles:= CBAutoReloadChangedFiles.Checked;
    CodeFoldingEnabled:= CBCodeFoldingEnabled.Checked;
    CompactLineNumbers:= CBCompactLineNumbers.Checked;
    CreateBackupFiles:= CBCreateBackupFiles.Checked;
    DetectUTF8Encoding:= CBDetectUTF8Encoding.Checked;
    DisplayPackageNames:= CBDisplayPackageNames.Checked;
    MarkExecutableLines:= CBMarkExecutableLines.Checked;
    SearchTextAtCaret:= CBSearchTextAtCaret.Checked;
    ShowCodeHints:= CBShowCodeHints.Checked;
    ShowDebuggerHints:= CBShowDebuggerHints.Checked;
    TrimTrailingSpacesOnSave:= CBTrimTrailingSpacesOnSave.Checked;
    UndoAfterSave:= CBUndoAfterSave.Checked;
    HighlightSelectedWordColor:= CBHighlightSelectedWordColor.Color;
    NewFileEncoding:= TFileSaveFormat(RGNewFileEncoding.ItemIndex);
    NewFileLineBreaks:= TSynEditFileFormat(RGNewFileLineBreaks.ItemIndex);

    // tab code completion
    CodeCompletionCaseSensitive:= CBCompletionCaseSensitive.Checked;
    CompleteAsYouType:= CBCompleteAsYouType.Checked;
    CompleteKeywords:= CBCompleteKeywords.Checked;
    CompleteWithOneEntry:= CBCompleteWithOneEntry.Checked;
    CompleteWithWordBreakChars:= CBCompleteWithWordBreakChars.Checked;
    EditorCodeCompletion:= CBEditorCodeCompletion.Checked;
    InterpreterCodeCompletion:= CBInterpreterCodeCompletion.Checked;
    CodeCompletionListSize:= UDCodeComletionListSize.Position;
    SpecialPackages:= ESpecialPackages.Text;

    // tab general options
    AutoCheckForUpdates:= CBAutoCheckForUpdates.Checked;
    SaveFilesAutomatically:= CBSaveFilesAutomatically.Checked;
    RestoreOpenFiles:= CBRestoreOpenFiles.Checked;
    RestoreOpenProject:= CBRestoreOpenProject.Checked;
    ShowTabCloseButton:= CBShowTabCloseButton.Checked;
    SmartNextPrevPage:= CBSmartNextPrevPage.Checked;
    StyleMainWindowBorder:= CBStyleMainWindowBorder.Checked;
    ExporerInitiallyExpanded:= CBExporerInitiallyExpanded.Checked;
    FileExplorerContextMenu:= CBFileExplorerContextMenu.Checked;
    ProjectExporerInitiallyExpanded:= CBProjectExporerInitiallyExpanded.Checked;
    FileExplorerBackgroundProcessing:= CBFileExplorerBackgroundProcessing.Checked;
    MethodsWithComment:= CBMethodsWithComment.Checked;

    DaysBetweenChecks:= UDDaysBetweenChecks.Position;
    NoOfRecentFiles:= UDNoOfRecentFiles.Position;
    DockAnimationInterval:= UDDockAnimationInterval.Position;
    DockAnimationMoveWidth:= UDDockAnimationMoveWidth.Position;
    FileTemplateForNewScripts:= EFileTemplateForNewScripts.Text;
    EditorsTabPosition:= TSpTBXTabPosition(RGEditorTabPosition.ItemIndex);
    FileChangeNotification:= TFileChangeNotificationType(RGFileChangeNotification.ItemIndex);

    // tab ssh
    ScpCommand:= EScpCommand.text;
    ScpOptions:= EScpOptions.text;
    SSHCommand:= ESSHCommand.text;
    SSHOptions:= ESSHOptions.text;
    SSHDisableVariablesWin:= CBSSHDisableVariablesWin.Checked;

    getValues(CommandsDataModule.SynEditPrint);
  end;

  with GuiPyOptions do begin
    // Color themes
    if lbColorThemes.ItemIndex > -1 then
      fColorTheme:= lbColorThemes.Items[lbColorThemes.ItemIndex];

    // Class modeler
    ShowGetSetMethods:= CBShowGetSetMethods.Checked;
    ShowTypeSelection:= CBShowTypeSelection.Checked;
    ShowKindProcedure:= CBShowKindProcedure.Checked;
    ShowParameterTypeSelection:= CBShowParameterTypeSelection.Checked;

    // tab GUI designer
    NameFromText:= CBNameFromText.Checked;
    GuiDesignerHints:= CBGuiDesignerHints.Checked;
    GridSize:= UDGridSize.Position;
    SnapToGrid:= CBSnapToGrid.Checked;
    FrameWidth:= StrToInt(EFrameWidth.Text);
    FrameHeight:= strToInt(EFrameHeight.Text);

    // tab Structograms
    StructoDatatype:= CBDatatype.Text;
    SwitchWithCaseLine:= CBSwitchWithCaseLine.Checked;
    CaseCount:= StrToInt(ECaseCount.text);
    StructogramShadowWidth:= UDStructogramShadowWidth.Position;
    StructogramShadowIntensity:= UDStructogramShadowIntensity.Position;

    // tab Sequencediagram
    SDFillingcolor:= CBSDFillingcolor.Selected;
    SDNoFilling:= CBSDNoFilling.Checked;
    SDShowMainCall:= CBSDShowMainCall.Checked;
    SDShowParameter:= CBSDShowParameter.Checked;
    SDShowReturn:= CBSDShowReturn.Checked;

    // tab UML design
    ValidClassColor:= CBValidClassColor.Selected;
    InvalidClassColor:= CBInvalidClassColor.Selected;
    ClassHead:= RGClassHead.ItemIndex;
    ShadowWidth:= UDShadowWidth.Position;
    ShadowIntensity:= UDShadowIntensity.Position;
    ObjectColor:= CBObjectColor.Selected;
    ObjectHead:= RGObjectHead.ItemIndex;
    ObjectFooter:= RGObjectFooter.ItemIndex;
    ObjectCaption:= RGObjectCaption.ItemIndex;
    ObjectUnderline:= CBObjectUnderline.Checked;
    CommentColor:= CBCommentColor.Selected;
    DIVisibilityFilter:= 3 - RGAttributsMethodsDisplay.ItemIndex;
    DISortOrder:= RGSequenceAttributsMethods.ItemIndex;
    DIShowParameter:= RGParameterDisplay.ItemIndex;
    DIShowIcons:= 2 - RGVisibilityDisplay.ItemIndex;

    // tab uml options
    PrivateAttributEditable:= CBUMLEdit.Checked;
    ShowEmptyRects:= CBShowEmptyRects.Checked;
    ConstructorWithVisibility:= CBConstructorWithVisibility.Checked;
    ObjectLowerCaseLetter:= CBLowerCaseLetter.Checked;
    ShowPublicOnly:= CBOpenPublicClasses.Checked;
    DefaultModifiers:= CBDefaultModifiers.Checked;
    ShowObjectsWithMethods:= CBShowObjectsWithMethods.Checked;
    ShowObjectsWithInheritedPrivateAttributes:= CBShowObjectsWithInheritedPrivateAttributes.Checked;
    IntegerInsteadofInt:= CBIntegerInsteadofInt.Checked;
    ShowAllNewObjects:= CBShowAllNewObjects.Checked;
    ObjectsWithoutVisibility:= CBObjectswithoutVisibility.Checked;
    RelationshipAttributesBold:= CBRelationshipAttributesBold.Checked;
    ShowClassparameterSeparately:= CBShowClassparameterSeparately.Checked;
    RoleHidesAttribute:= CBRoleHidesAttribute.Checked;

    // tab restrictions
    LockedDOSWindow:= CBLockedDosWindow.Checked;
    LockedInternet:= CBLockedInternet.Checked;
    LockedPaths:= CBLockedPaths.Checked;
    LockedStructogram:= CBLockedStructogram.Checked;
    UsePredefinedLayouts:= CBUsePredefinedLayouts.Checked;

    // tab Associations
    AdditionalAssociations:= EAdditionalAssociations.Text;

    // tab Git
    GitFolder:= ExtendPath(EGitFolder);
    GitLocalRepository:= ExtendPath(CBLocalRepository);
    GitRemoteRepository:= ExtendPath(CBRemoteRepository);
    if assigned(FGit) and (EUserName.Text <> GuiPyOptions.GitUserName) then begin
      FGit.GitCall('config --global user.name="' + EUserName.Text + '"', '.');
      GitUserName:= EUserName.Text;
    end;
    if assigned(FGit) and (EUserEMail.Text <> GuiPyOptions.GitUserEMail) then begin
      FGit.GitCall('config --global user.email="' + EUserEMail.Text + '"', '.');
      GitUserEMail:= EUserEMail.Text;
    end;

    // tab SVN
    SVNFolder:= ExtendPath(ESVNFolder);
    SVNRepository:= ExtendPath(CBRepository);

    // tab TextDiff - implicit

    // tab Browser
    UseIEinternForDocuments:= CBUseIEinternForDocuments.Checked;
    OnlyOneBrowserWindow:= CBOnlyOneBrowserWindow.Checked;
    BrowserTitle:= EBrowsertitle.text;
    OpenBrowserShortcut:= CBOpenBrowserShortcut.Text;
    BrowserProgram:= ExtendPath(EBrowserProgram);

    // others
    Author:= EAuthor.Text;
    TempDir:= ExtendPath(ETempFolder);
  end;
  LanguageOptionsToModel;
  ApplyColorTheme;

  // tab languages
  LanguageNr:= RGLanguages.ItemIndex;
  if not PyIDEMainForm.mnLanguage.Items[LanguageNr].checked then
    PyIDEMainForm.mnLanguageClick(PyIDEMainForm.mnLanguage.Items[LanguageNr]);

  UpdateHighlighters;
  ActionProxyCollection.ApplyShortCuts;
  FileTemplatesGetItems;
  CodeTemplatesGetItems;
  EditorOptions.assign(FSynEdit);  // doesn't really work

  // get gutter.color after possible StyleChange
  if assigned(GI_EditorFactory) then
    GI_EditorFactory.ApplyToEditors(procedure(Editor: IEditor)
    begin
      EditorOptions.Gutter.Color:= Editor.SynEdit.Gutter.Color;
    end);

  for var i := 0 to cbHighlighters.Items.Count-1 do
     CommandsDataModule.SynEditOptionsDialogSetHighlighter(
      self, i, TSynCustomHighlighter(cbHighlighters.Items.Objects[i]));

  CommandsDataModule.ApplyEditorOptions;
end;

procedure TFConfiguration.BTempFolderClick(Sender: TObject);
  var s: string;
begin
  s:= GetTempDir;
  {$WARN SYMBOL_PLATFORM OFF}
  s:= IncludeTrailingPathDelimiter(GetLongPathName(s));
  {$WARN SYMBOL_PLATFORM ON}
  Sysutils.ForceDirectories(s);
  ShortenPath(ETempFolder, s);
end;

procedure TFConfiguration.SBTempSelectClick(Sender: TObject);
  var s: string;
begin
  s:= GetTempDir;
  {$WARN SYMBOL_PLATFORM OFF}
  s:= IncludeTrailingPathDelimiter(GetLongPathName(s));
  {$WARN SYMBOL_PLATFORM ON}
  FolderSelect(ETempFolder, s);
  Sysutils.ForceDirectories(s);
  ShortenPath(ETempFolder, s);
end;

procedure TFConfiguration.DoHelp(Adresse: string);
begin
  if isHttp(Adresse) and GuiPyOptions.LockedInternet then
    Adresse:= 'about:' + _('Internet locked!');
  OpenObject(Adresse);
end;

var
  en: array[0..MaxPages] of string =
      ('python', 'interpreter', 'compiler', 'programs', 'applets', 'disassembler', 'jar',
       'editor', 'options', 'code', 'colors', 'comment', 'templates', 'keyboard',
       'structogram', 'sequencediagram', 'browser', 'documentation', 'printer', 'mindstorms', 'android',
       'language', 'options', 'restrictions', 'associations', 'uml', 'uml2', 'visibility',
       'protocols', 'tools', 'git', 'junit', 'checkstyle', 'jalopy', 'subversion');
  de: array[0..MaxPages] of string =
      ('python', 'interpreter', 'compiler', 'programme', 'applets', 'disassembler', 'jar',
       'editor', 'optionen', 'code', 'farben', 'kommentar', 'vorlagen', 'tastatur',
       'struktogramm', 'sequenzdiagramm', 'browser', 'dokumentation', 'drucker', 'mindstorms', 'android',
       'sprache', 'optionen', 'restriktionen', 'verküpfungen', 'uml', 'uml2', 'sichtbarkeit',
       'protokolle', 'tools', 'git', 'junit', 'checkstyle', 'jalopy', 'subversion');

procedure TFConfiguration.BHelpClick(Sender: TObject);
  var count: integer; aNode: TTreeNode;
begin
  aNode:= TVConfiguration.Items.GetFirstNode;
  count:= 0;
  while (count < TVConfiguration.Items.Count) and (aNode <> TVConfiguration.Selected) do begin
    aNode:= aNode.GetNext;
    inc(count);
  end;
  if GetCurrentLanguage = 'de'
    then DoHelp(GetConfigurationAddress(de[count]))
    else DoHelp(GetConfigurationAddress(en[count]));
end;

procedure TFConfiguration.BCheckClick(Sender: TObject);
begin
  CheckAllFilesAndFolders;
end;

{$WARNINGS OFF}
function TFConfiguration.getDumpText: string;
  var Pathname, fMachine, fApp, s, s1, winplatform: String;
      SL: TStringList; aFile: IFile;
begin
  {$IFDEF WIN64}
  winplatform := 'x64';
  {$ELSE}
  winplatform := 'x86';
  {$ENDIF}
  Result:= '';
  Pathname:= GuiPyOptions.TempDir + 'Configuration.ini';
  aFile:= GI_FileFactory.GetFileByFileId(Pathname);
  if Assigned(aFile) then
    aFile.Close;
  Application.ProcessMessages;
  if FileExists(Pathname) then DeleteFile(Pathname);
  fMachine:= PyIDEMainForm.MachineStorage.Filename;
  fApp:= PyIDEMainForm.AppStorage.FileName;
  try
    s:= 'Installation ' + CrLf;
    s1:= Format('Version %s %s', [ApplicationVersion, winplatform]);
    s:= s + '  GuiPy-Version: ' + s1 + CrLf;
    if GI_PyControl.PythonLoaded then
      s1:= PyControl.PythonVersion.DisplayName + _(EngineTypeName[PyControl.PythonEngineType])
    else
      s1:= '<not loaded>';
    s:= s + '  Python-Version: ' + s1 + CrLf;
    s:= s + '  Windows-Version: ' + TOSVersion.ToString + CrLF;
    s:= s + '  CmdLine: ' + CmdLine + CrLf;
    s:= s + CrLf;
    s:= s + '  ' + fMachine + CrLf;
    s:= s + '  ' + fApp + CrLf;
    s:= s + CrLf;
    s:= s + StringOfChar('-', 80) + CrLf;
    s:= s + '--- ' + fMachine + CrLf + CrLf;
    SL:= TStringList.Create;
    SL.LoadFromFile(fMachine);
    s:= s + SL.Text + CrLf;
    s:= s + StringOfChar('-', 80) + CrLf;
    s:= s + '--- ' + fApp + CrLf + CrLf;
    SL.Clear;
    SL.LoadFromFile(fApp);
    s:= s + SL.Text;
    s:= s + StringOfChar('-', 80) + CrLf;
    FreeAndNil(SL);
    Result:= s + CrLf;
  except
    on e: exception do
      ErrorMsg(e.Message + ' ' + 'The configuration could not be generated.');
  end;
end;
{$WARNINGS ON}

procedure TFConfiguration.BDumpClick(Sender: TObject);
  var pathname: string; SL: TStringList;
begin
  SL:= TStringList.Create;
  SL.Text:= getDumpText;
  Pathname:= TPath.Combine(GuiPyOptions.TempDir, 'Configuration.ini');
  SL.SaveToFile(Pathname);
  FreeAndNil(SL);
  PyIDEMainForm.DoOpenFile(Pathname);
end;

procedure TFConfiguration.LMouseEnter(Sender: TObject);
begin
  Screen.Cursor:= crHandpoint;
end;

procedure TFConfiguration.LMouseLeave(Sender: TObject);
begin
  Screen.Cursor:= crDefault;
end;

procedure TFConfiguration.CallUpdater(const Target, Source1: string; Source2: string);
  var Updater, s: string;
begin
  if Source2 = '' then Source2:= '-xxx';
  Updater:= EditorFolder + 'setup.exe';
  s:= '-Update ' + HideBlanks(Target) + ' ' + HideBlanks(Source1) + ' ' + HideBlanks(Source2);
  s:= s + ' -INI ' + HideBlanks(PyIDEMainForm.MachineStorage.FileName);
  if FileExists(Updater) then
    try
      RunAsAdmin(Handle, Updater, s);
    except
      on e: exception do
        ErrorMsg(e.Message);
    end
  else
    ErrorMsg(Format(_('File \"%s\" not found.'), [Updater]));
end;

function TFConfiguration.GetConfigurationAddress(const s: string): string;
begin
  if GetCurrentLanguage = 'de'
    then Result:= Homepage + '/doku.php?id=de:konfiguration#' + s
    else Result:= Homepage + '/doku.php?id=en:configuration#' + s;
end;

procedure TFConfiguration.TVConfigurationChange(Sender: TObject; Node: TTreeNode);
  var aNode: TTreeNode; count: integer;
begin
  aNode:= TVConfiguration.Items.GetFirstNode;
  count:= 0;
  while (count < TVConfiguration.Items.Count) and (aNode <> Node) do begin
    aNode:= aNode.GetNext;
    inc(count);
  end;
  if aNode.HasChildren then inc(count);

  ShowPage(count);
  CheckAllFilesAndFolders;
end;

function TFConfiguration.getTVConfigurationItem(text: string): TTreeNode;
begin
  for var i:= 0 to TVConfiguration.Items.Count - 1 do
    if TVConfiguration.Items[i].text = text then
      exit(TVConfiguration.Items[i]);
  Result:= TVConfiguration.Items[0];
end;

procedure TFConfiguration.ShowPage(i: integer);
begin
  PageList.ActivePageIndex:= i;
  TVConfiguration.Selected:= TVConfiguration.Items[i];
  LTitle.Caption:= PageList.ActivePage.Caption;
  PageListClose;
  if PageList.ActivePage.Caption = _('File templates') then begin
    CommandsDataModule.ParameterCompletion.Editor := CodeSynTemplate;
    CommandsDataModule.ModifierCompletion.Editor := CodeSynTemplate;
    CodeSynTemplate.Highlighter := CommandsDataModule.SynPythonSyn;
  end;
  if PageList.ActivePage.Caption = _('Code templates') then begin
    CommandsDataModule.ParameterCompletion.Editor := CodeSynTemplate;
    CommandsDataModule.ModifierCompletion.Editor := CodeSynTemplate;
    CodeSynTemplate.Highlighter := CommandsDataModule.SynPythonSyn;
  end;
end;

procedure TFConfiguration.PageListClose;
begin
  CommandsDataModule.ParameterCompletion.Editor := nil;
  CommandsDataModule.ModifierCompletion.Editor := nil;
  CodeSynTemplate.Highlighter := nil;
  FileSynTemplate.Highlighter := nil;
end;

procedure TFConfiguration.PrepareShow;
begin
  ModelToView;
  CheckAllFilesAndFolders;
end;

function TFConfiguration.GetEncoding(const Pathname: string): TEncoding;
  var Stream: TStream; withBOM: boolean;
begin
  Result:= TEncoding.Ansi;
  if FileExists(Pathname) then
    try
      Stream:= TFileStream.Create(Pathname, fmOpenRead or fmShareDenyWrite);
      try
        Result:= SynUnicode.GetEncoding(Stream, withBOM);
      finally
        FreeAndNil(Stream);
      end;
    except
      on e: exception do
        ErrorMsg(e.Message);
    end;
end;

function TFConfiguration.GetFileFilters: String;
begin
  Result:=
    'GuiPy|*.py;*.pyw;*.pyi;*.pfm;*.puml;*.psg;*.psd' +
    '|Python (*.py;*.pyw;*.pyi)|*.py;*.pyw;*.pyi' +
    '|' + _('Form') + ' (*.pfm)|*.pfm' +
    '|UML (*.puml)|*.puml' +
    '|' + _('Structogram') + ' (*.psg)|*.psg' +
    '|' + _('Sequence diagram') + ' (*.psd)|*.psd' +
  	'|Cython (*.pyx*.pxd;*.pxi)|*.pyx;*.pxd;*.pxi' +
    '|HTML (*.html)|*.html;*.htm' +
    '|XML (*.xml)|*.xml|' + _('Text') + ' (*.txt)|*.txt' +
	  '|PHP (*.php;*.php3;*.phtml;*.inc)|*.php;*.php3;*.phtml;*.inc' +
    '|' + _('All') + ' (*.*)|*.*';
end;

procedure TFConfiguration.SetElevationRequiredState(aControl: TWinControl);
  const BCM_FIRST = $1600;
        BCM_SETSHIELD = BCM_FIRST + $000C;
begin
  SendMessage(aControl.Handle, BCM_SETSHIELD, 0, Integer(true));
end;

function TFConfiguration.RunAsAdmin(hWnd: HWND; const aFile, aParameters: string): THandle;
  var sei: TShellExecuteInfoA;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize:= SizeOf(sei);
  sei.Wnd:= hWnd;
  sei.fMask:= SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  // left side is pAnsiChar
  sei.lpVerb:= 'runas';
  sei.lpFile := pAnsiChar(AnsiString(aFile));
  sei.lpParameters := pAnsiChar(AnsiString(aParameters));
  sei.nShow:= SW_ShowNormal;
  if ShellExecuteExA(@sei) then
    Result:= 33
  else begin
    ErrorMsg(SysErrorMessage(GetLastError));
    Result:= 0;
  end;
end;

procedure TFConfiguration.MakeControlStructureTemplates;
  const
    ControlStructure: array[1..10] of string =
      ('#if', '#while', '#for', '#do', '#switch', '#try', 'else', '} else', '#ifelse', '{ }');
  var i: integer;
begin
  for i:= 1 to 21 do begin
    FreeAndNil(ControlStructureTemplates[i]);
    ControlStructureTemplates[i]:= TStringList.Create;
  end;
  ControlStructureTemplates[1].Text:= 'if |:' + CrLf + Indent1 + CrLf;
  ControlStructureTemplates[2].Text:= 'while |:' +  CrLf + Indent1;
  ControlStructureTemplates[3].Text:= 'for | in range(n):' +  CrLf + Indent1 + CrLf;
  ControlStructureTemplates[4].Text:= ''; // 'do:';
  ControlStructureTemplates[5].Text:=
         'if |:' + CrLf +
            Indent1 + 'elif: ' + CrLf + Indent2 + CrLf +
            Indent1 + 'elif: ' + CrLf + Indent2 + CrLf +
            Indent1 + 'else: ' + CrLf + Indent2 + CrLf;
  ControlStructureTemplates[6].Text:=
         'try:' + CrLf +
            Indent1 + '|' + CrLf +
         'except:' + CrLf  +
            Indent1 + CrLf +
         'finally:' + CrLf +
            Indent1 + CrLf;
  ControlStructureTemplates[7].Text:=  'else: ' + CrLf + Indent1 + '|' + CrLf;
  ControlStructureTemplates[8].Text:=  'else: ' + CrLf + Indent1 + '|' + CrLf;
  ControlStructureTemplates[9].Text:=  'if |:' + CrLf + Indent1 + CrLf + 'else:' + CrLf + Indent1 + CrLf;
  ControlStructureTemplates[10].Text:= CrLf + Indent1 + '|' + CrLf;

  ControlStructureTemplates[11].Text:= 'else if |:' + CrLf + Indent1 + CrLf;
  ControlStructureTemplates[12].Text:= 'for i in range(10):' +  CrLf + Indent1 + CrLf;
  ControlStructureTemplates[13].Text:= 'catch (Exception e):' +  CrLf + Indent1 + '|' + CrLf;
  ControlStructureTemplates[14].Text:= 'finally:' +  CrLf + Indent1 + '|' + CrLf;
  ControlStructureTemplates[15].Text:= 'def private |void name():' + CrLf + Indent1 + CrLf;
  ControlStructureTemplates[16].Text:= 'def |void name():' + CrLf + Indent1 + CrLf;
  ControlStructureTemplates[17].Text:= 'println(|)' + CrLf;
  ControlStructureTemplates[18].Text:= '|type name = new type()' + CrLf;
  ControlStructureTemplates[19].Text:= 'public static void main(String[] args) {' + CrLf + Indent1 + '|' + CrLf;
  ControlStructureTemplates[20].Text:= 'def |void name():' + CrLf + Indent1 + CrLf;
  ControlStructureTemplates[21].Text:= 'def |void name():' + CrLf + Indent1 + CrLf;
end;
{$WARN SYMBOL_PLATFORM OFF}

class function TFConfiguration.isDark: boolean;
  var BGColor, FGColor: TColor;
begin
  if StyleServices.IsSystemStyle then begin
    BGColor:= clWhite;
    FGColor:= clBlack;
  end else begin
    BGColor:= StyleServices.GetStyleColor(scPanel);
    FGColor:= StyleServices.GetStyleFontColor(sfTabTextInactiveNormal);
  end;
  if GetRValue(BGColor) + GetGValue(BGColor) + GetBValue(BGColor) >
     GetRValue(FGColor) + GetGValue(FGColor) + GetBValue(FGColor)
    then Result:= false
    else Result:= true;
end;

// style
// https://stackoverflow.com/questions/9130945/delphi-xe2-disabling-vcl-style-on-a-component
// https://theroadtodelphi.com/2012/02/06/changing-the-color-of-edit-controls-with-vcl-styles-enabled/

procedure TFConfiguration.ShortenPath(WinControl: TWinControl; const s: string);
  var s1, s2, s3: string; p{, w}: integer;
begin
  WinControl.Hint:= s;
  WinControl.ShowHint:= true;
{  if WinControl is TEdit
    then w:= WinControl.Width
    else w:= WinControl.Width - 16;
    }
  s1:= s; // GlobalMinimizeName(s, Canvas, w);
  if WinControl is TEdit
    then (WinControl as TEdit).Text:= s1
    else (WinControl as TComboBox).Text:= s1;
  p:= Pos('...', s1);
  if p > 0 then begin
    s2:= s;
    delete(s2, 1, p-1);
    s3:= copy(s1, p+3, length(s1));
    p:= Pos(s3, s2);
    delete(s2, p, length(s1));
    WinControl.HelpKeyword:= s2;
  end else
    WinControl.HelpKeyword:= '';
end;

function TFConfiguration.ExtendPath(WinControl: TWinControl): string;
  var s: string; p: integer;
begin
  if WinControl is TEdit
    then s:= (WinControl as TEdit).Text
    else s:= (WinControl as TComboBox).Text;
  p:= Pos('...', s);
  if p > 0 then begin
    delete(s, p, 3);
    insert(WinControl.HelpKeyword, s, p);
  end;
  Result:= s;
end;

function TFConfiguration.getMultiLineComment(Indent: string): string;
begin
  if PyIDEOptions.MethodsWithComment then
    Result:=  Indent + '"""' + CrLf +
              Indent + CrLf +
              Indent + '"""' + CrLf
  else
    Result:= '';
end;

{--- Python -------------------------------------------------------------------}

procedure TFConfiguration.actPVActivateExecute(Sender: TObject);
var
  Node : PVirtualNode;
  Level : integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then begin
    Level := vtPythonVersions.GetNodeLevel(Node);
    if Level = 1 then
    begin
      if Node.Parent.Index = 0 then
        PyControl.PythonVersionIndex := Node.Index
      else if Node.Parent.Index = 1 then
        PyControl.PythonVersionIndex := - (Node.Index + 1);
      vtPythonVersions.InvalidateChildren(nil, True);
    end;
  end;
end;

procedure TFConfiguration.actPVAddExecute(Sender: TObject);
Var
  PythonVersion: TPythonVersion;
  Directories: TArray<string>;
begin
  if SelectDirectory('', Directories, [], _('Select folder with Python installation (including virtualenv and venv)'))
  then begin
    if PythonVersionFromPath(Directories[0], PythonVersion) then
    begin
      SetLength(PyControl.CustomPythonVersions, Length(PyControl.CustomPythonVersions) + 1);
      PyControl.CustomPythonVersions[Length(PyControl.CustomPythonVersions)-1] := PythonVersion;
      vtPythonVersions.ReinitChildren(nil, True);
      vtPythonVersions.Selected[vtPythonVersions.GetLast] := True;
    end else
      StyledMessageDlg(_(SPythonFindError), mtError, [mbOK], 0);
  end;
end;

procedure TFConfiguration.actPVRemoveExecute(Sender: TObject);
var
  Node : PVirtualNode;
  Level : integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then begin
    Level := vtPythonVersions.GetNodeLevel(Node);
    if (Level = 1) and (Node.Parent.Index = 1) and
      not (PyControl.PythonVersionIndex = -(Node.Index + 1)) then
    begin
      Delete(PyControl.CustomPythonVersions, Node.Index, 1);
      vtPythonVersions.ReinitNode(Node.Parent, True);
    end;
  end;
end;

procedure TFConfiguration.actPVTestExecute(Sender: TObject);
var
  Node: PVirtualNode;
  Level: integer;
  Version: TPythonVersion;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then begin
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
var
  Node: PVirtualNode;
  Level: integer;
  Version: TPythonVersion;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then begin
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
var
  Node: PVirtualNode;
  Level: integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  if Assigned(Node) then begin
     Level := vtPythonVersions.GetNodeLevel(Node);
    if (Level = 1) then
    begin
      if Node.Parent.Index = 1 then begin
        PyControl.CustomPythonVersions[Node.Index].DisplayName :=
          InputBox(_('Rename Python Version'), _('New name:'),
          PyControl.CustomPythonVersions[Node.Index].DisplayName);
        vtPythonVersions.ReinitNode(Node.Parent, True);
      end;
    end;
  end;
end;

procedure TFConfiguration.vtPythonVersionsGetCellText(
  Sender: TCustomVirtualStringTree; var E: TVSTGetCellTextEventArgs);
Var
  Level : integer;
begin
  Level := vtPythonVersions.GetNodeLevel(E.Node);
  case Level of
    0:  if E.Column = 0 then
        begin
          if E.Node.Index = 0 then
            E.CellText := _(SRegisteredVersions)
          else
            E.CellText := _(SUnRegisteredVersions);
        end;
    1:  if E.Column = 0 then
        begin
          if E.Node.Parent.Index = 0 then
            E.CellText := PyControl.RegPythonVersions[E.Node.Index].DisplayName
          else
            E.CellText := PyControl.CustomPythonVersions[E.Node.Index].DisplayName;
        end
        else if E.Column = 1 then
        begin
          if E.Node.Parent.Index = 0 then
            E.CellText := PyControl.RegPythonVersions[E.Node.Index].InstallPath
          else
            E.CellText := PyControl.CustomPythonVersions[E.Node.Index].InstallPath;
        end;
  end;
end;

procedure TFConfiguration.vtPythonVersionsGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: UITypes.TImageIndex);
Var
  Level : integer;
begin
  ImageIndex := -1;
  if not (Kind in [ikNormal, ikSelected]) or (Column <> 0) then Exit;
  Level := vtPythonVersions.GetNodeLevel(Node);
  if (Level = 1) and GI_PyControl.PythonLoaded and
     (((Node.Parent.Index = 0) and (PyControl.PythonVersionIndex = integer(Node.Index))) or
      ((Node.Parent.Index = 1) and (PyControl.PythonVersionIndex = - (Node.Index + 1))))
  then
    ImageIndex := 0;
end;

procedure TFConfiguration.vtPythonVersionsInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
Var
  Level : integer;
begin
  Level := vtPythonVersions.GetNodeLevel(Node);
  if Level = 0 then begin
    if Node.Index = 0 then
      ChildCount := Length(PyControl.RegPythonVersions)
    else  if Node.Index = 1 then
      ChildCount := Length(PyControl.CustomPythonVersions);
  end;
end;

procedure TFConfiguration.vtPythonVersionsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
Var
  Level : integer;
begin
  Level := vtPythonVersions.GetNodeLevel(Node);
  if Level = 0 then begin
    if (Node.Index = 0) and (Length(PyControl.RegPythonVersions) > 0) then
      InitialStates := [ivsHasChildren, ivsExpanded]
    else if (Node.Index = 1) and (Length(PyControl.CustomPythonVersions) > 0) then
      InitialStates := [ivsHasChildren, ivsExpanded];
  end;
end;

{--- Editor Options -----------------------------------------------------------}

procedure TFConfiguration.EditStrCallback(const S: string);
begin
  if FExtended
    then cKeyCommand.Items.AddObject(_(S), TObject(ConvertExtendedToCommand(S)))
    else cKeyCommand.Items.AddObject(S, TObject(ConvertCodeStringToCommand(S)));
end;

procedure TFConfiguration.SynEditOptionsShow;
var Commands: TStringList;
    i : Integer;
begin
  //We need to do this now because it will not have been assigned when create occurs
  cKeyCommand.Items.Clear;
  //Start the callback to add the strings
  if FExtended then
    GetEditorCommandExtended(EditStrCallback)
  else
    GetEditorCommandValues(EditStrCallBack);
  //Now add in the user defined ones if they have any
  Commands := TStringList.Create;
  try
    CommandsDataModule.GetEditorAllUserCommands(Commands);
    for i := 0 to Commands.Count - 1 do
      if Commands.Objects[i] <> nil then
        cKeyCommand.Items.AddObject(Commands[i], Commands.Objects[i]);
  finally
    Commands.Free;
  end;

  if (KeyList.Items.Count > 0) then KeyList.Items[0].Selected:= True;

  if cbHighlighters.Items.Count > 0 then
    cbHighlighters.ItemIndex := 0;

  if cbHighlighters.ItemIndex = -1 then
    EnableColorItems(False)  //If there is still no selected item then disable controls
  else
    cbHighlightersChange(cbHighlighters);  //run OnChange handler (it wont be fired on setting the itemindex prop)
end;

{--- Editor Options Display ---------------------------------------------------}

procedure TFConfiguration.btnFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(labFont.Font);
  if FontDialog.Execute then
  begin
    labFont.Font.Assign(FontDialog.Font);
    labFont.Caption:= labFont.Font.Name;
    labFont.Caption:= labFont.Font.Name + ' ' + IntToStr(labFont.Font.Size) + 'pt';
  end;
end;

procedure TFConfiguration.btnGutterFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(lblGutterFont.Font);
  if FontDialog.Execute then
  begin
    lblGutterFont.Font.Assign(FontDialog.Font);
    lblGutterFont.Caption:= lblGutterFont.Font.Name + ' ' + IntToStr(lblGutterFont.Font.Size) + 'pt';
  end;
end;

procedure TFConfiguration.cbGutterFontClick(Sender: TObject);
begin
  lblGutterFont.Enabled := cbGutterFont.Checked;
  btnGutterFont.Enabled := cbGutterFont.Checked;
end;

{--- Options ------------------------------------------------------------------}

{--- Code Completion ----------------------------------------------------------}

procedure TFConfiguration.BCodeCompletionFontClick(Sender: TObject);
begin
  CommandsDataModule.dlgFontDialog.Font.Assign(PyIDEOptions.AutoCompletionFont);
  if CommandsDataModule.dlgFontDialog.Execute then
    PyIDEOptions.AutoCompletionFont.assign(CommandsDataModule.dlgFontDialog.Font);
end;

{--- Keystrokes ---------------------------------------------------------------}

procedure TFConfiguration.btnUpdateKeyClick(Sender: TObject);

var
//  Cmd          : Integer;
//  KeyLoc       : Integer;
//  TmpCommand   : string;
  OldShortcut  : TShortcut;
  OldShortcut2 : TShortcut;
  Key : TSynEditKeyStroke;
  S : string;
begin
  if KeyList.Selected = nil then Exit;
  if cKeyCommand.ItemIndex < 0 then Exit;

  Key := TSynEditKeyStroke(KeyList.Selected.Data);
  OldShortcut  := Key.ShortCut;
  OldShortcut2 := Key.ShortCut2;
  try
    UpdateKey(Key);
  except
     on E: ESynKeyError do begin
       S := _(SDuplicateKey);
       Key.ShortCut := OldShortcut;
       Key.ShortCut2 := OldShortcut2;
       ErrorMsg(S);
     end;
  end;
  FillInKeystrokeInfo(TSynEditKeyStroke(KeyList.Selected.Data), KeyList.Selected);
end;

procedure TFConfiguration.btnAddKeyClick(Sender: TObject);
var
  Item : TListItem;
  S : string;
begin
  if cKeyCommand.ItemIndex < 0 then Exit;
  Item:= KeyList.Items.Add;
  try
    Item.Data:= FSynEdit.Keystrokes.Add;
    UpdateKey(TSynEditKeystroke(Item.Data));
    FillInKeystrokeInfo(TSynEditKeystroke(Item.Data), Item);
    Item.Selected:= True;
  except
     on E: ESynKeyError do begin
       S := _(SDuplicateKey);
       ErrorMsg(S);
       TSynEditKeyStroke(Item.Data).Free;
       Item.Delete;
     end;
  end;
  Item.MakeVisible(True);
end;

procedure TFConfiguration.btnRemKeyClick(Sender: TObject);
begin
  if KeyList.Selected = nil then Exit;
  TSynEditKeyStroke(KeyList.Selected.Data).Free;
  KeyList.Selected.Delete;
end;

procedure TFConfiguration.cKeyCommandKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = SYNEDIT_RETURN then btnUpdateKey.Click;
end;

procedure TFConfiguration.UpdateKey(AKey: TSynEditKeystroke);
var
  Cmd: Integer;
begin
  Cmd := Integer(cKeyCommand.Items.Objects[cKeyCommand.ItemIndex]);

  AKey.Command:= Cmd;

  //if eKeyShort1.HotKey <> 0 then  Issue 304
    AKey.ShortCut := eKeyShort1.HotKey;

  //if eKeyShort2.HotKey <> 0 then
    AKey.ShortCut2:= eKeyShort2.HotKey;

end;

procedure TFConfiguration.FillInKeystrokeInfo(
  AKey: TSynEditKeystroke; AItem: TListItem);
var TmpString: string;      begin
  with AKey do
  begin
    if Command >= ecUserFirst then
    begin
      TmpString := 'User Command';
      if Assigned(GetUserCommandNames) then
        GetUserCommandNames(Command, TmpString);
    end else begin
      if FExtended then
        TmpString := _(ConvertCodeStringToExtended(EditorCommandToCodeString(Command)))
      else TmpString := EditorCommandToCodeString(Command);
    end;

    AItem.Caption:= TmpString;
    AItem.SubItems.Clear;

    TmpString := '';
    if Shortcut <> 0 then
      TmpString := ShortCutToText(ShortCut);

    if (TmpString <> '') and (Shortcut2 <> 0) then
      TmpString := TmpString + ' ' + ShortCutToText(ShortCut2);

    AItem.SubItems.Add(TmpString);
  end;
end;

procedure TFConfiguration.PrepareKeyStrokes;
  var i: integer;
      Item : TListItem;
begin
  FHandleChanges := True;  //Normally true, can prevent unwanted execution of event handlers

  KeyList.OnSelectItem := KeyListSelectItem;

  eKeyShort1:= TSynHotKey.Create(Self);
  with eKeyShort1 do
  begin
    Parent := gbKeystrokes;
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

  eKeyShort2:= TSynHotKey.Create(Self);
  with eKeyShort2 do
  begin
    Parent := gbKeystrokes;
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

  FExtended:= true;
  KeyList.Items.BeginUpdate;
  try
    KeyList.Items.Clear;
    for i:= 0 to FSynEdit.Keystrokes.Count-1 do
    begin
      Item:= KeyList.Items.Add;
      FillInKeystrokeInfo(FSynEdit.Keystrokes.Items[I], Item);
      Item.Data:= FSynEdit.Keystrokes.Items[I];
    end;
  finally
    KeyList.Items.EndUpdate;
  end;
end;

procedure TFConfiguration.KeyListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if not (Selected and Assigned(Item)) then Exit;
  cKeyCommand.Text      := Item.Caption;
  cKeyCommand.ItemIndex := cKeyCommand.Items.IndexOf(Item.Caption);
  eKeyShort1.HotKey     := TSynEditKeyStroke(Item.Data).ShortCut;
  eKeyShort2.HotKey     := TSynEditKeyStroke(Item.Data).ShortCut2;
end;

{--- Syntax Colors ------------------------------------------------------------}

procedure TFConfiguration.PrepareHighlighters;
type
  TSynHClass = class of TSynCustomHighlighter;
var
   wCount : integer;
   loop : integer;
   wHighlighter : TSynCustomHighlighter;
   wInternalSynH : TSynCustomHighlighter;
   wSynHClass : TSynHClass;
   FileName : string;
begin
  cbHighlighters.Items.Clear;
  CommandsDataModule.SynEditOptionsDialogGetHighlighterCount(self, wCount);
  for loop := 0 to wCount - 1 do begin
    CommandsDataModule.SynEditOptionsDialogGetHighlighter(self, loop, wHighlighter);
    if assigned(wHighlighter) then begin
       wSynHClass := TSynHClass(wHighlighter.classtype);
       wInternalSynH := wSynHClass.Create(nil);
       wInternalSynH.assign(wHighlighter);
       fHighlighters.add(wInternalSynH);
       cbHighlighters.Items.AddObject(_(wInternalSynH.FriendlyLanguageName), wInternalSynH);

       if (wInternalSynH.FriendlyLanguageName = 'Python') or
          ((wInternalSynH.FriendlyLanguageName = 'Python Interpreter') and
         not Assigned(fColorThemeHighlighter)) then
       begin
         fColorThemeHighlighter := wSynHClass.Create(nil);
         fColorThemeHighlighter.Assign(wHighlighter);
         SynThemeSample.Highlighter := fColorThemeHighlighter;
         SynThemeSample.Lines.Text := fColorThemeHighlighter.SampleSource;
       end;
    end;
  end;
  if cbHighlighters.Items.Count > 0 then begin
    cbHighlighters.ItemIndex := 0;
    cbHighlightersChange(cbHighlighters);
  end;

  lbColorThemes.Items.Clear;
  HighlighterFileDir := TPyScripterSettings.ColorThemesFilesDir;

  if HighlighterFileDir <> '' then
    for FileName in TDirectory.GetFiles(HighlighterFileDir,'*.ini') do
      lbColorThemes.Items.Add(TPath.GetFileNameWithoutExtension(FileName));
end;

procedure TFConfiguration.UpdateHighlighters;
  var i: integer;
begin
  for i:= 0 to fHighlighters.Count-1 do
    CommandsDataModule.SynEditOptionsDialogSetHighlighter(self, i, fHighlighters[i]);

   {if assigned(fSetHighlighterEvent) then
      for i := 0 to fHighlighters.Count-1 do
         fSetHighlighterEvent(self, loop, fHighlighters[i]);}
end;

procedure TFConfiguration.cbHighlightersChange(Sender: TObject);
var
  loop : integer;
  wSynH : TSynCustomHighlighter;
begin
  lbElements.items.BeginUpdate;
  SynSyntaxSample.Lines.BeginUpdate;
  try
    lbElements.itemindex := -1;
    lbElements.items.Clear;
    SynSyntaxSample.lines.clear;
    if cbHighlighters.itemindex > -1 then
    begin
      wSynH := SelectedHighlighter;
      for loop := 0 to wSynH.AttrCount - 1 do
        lbElements.Items.Add(wSynH.Attribute[loop].FriendlyName);
      SynSyntaxSample.Highlighter := wSynH;
      SynSyntaxSample.Lines.text := wSynH.SampleSource;
    end;

    //Select the first Element if avail to avoid exceptions
    if lbElements.Items.Count > 0 then  //Added by KF 2005_JUL_15
    begin
      lbElements.ItemIndex := 0;
      lbElementsClick(lbElements);  //We have to run it manually, as setting its Items prop won't fire the event.
      EnableColorItems(True);   //Controls can be enabled now because there is active highlighter and element.
    end
    else
      EnableColorItems(False);  //Else disable controls

  finally
    lbElements.items.EndUpdate;
    SynSyntaxSample.Lines.EndUpdate;
  end;
end;

procedure TFConfiguration.lbElementsClick(Sender: TObject);
var
  wSynH : TSynCustomHighlighter;
  wSynAttr : TSynHighlighterAttributes;

begin
  if lbElements.ItemIndex <> -1 then
  begin
    EnableColorItems(True);
    wSynH := SelectedHighlighter;
    wSynAttr := wSynH.Attribute[lbElements.ItemIndex];

    FHandleChanges := False;
    try
      cbxElementBold.Checked := (fsBold in wSynAttr.Style);
      cbxElementItalic.Checked := (fsItalic in wSynAttr.Style);
      cbxElementUnderline.Checked := (fsUnderline in wSynAttr.Style);
      cbxElementStrikeout.Checked := (fsStrikeOut in wSynAttr.Style);
      cbElementForeground.SelectedColor := wSynAttr.Foreground;
      cbElementBackground.SelectedColor := wSynAttr.Background;
    finally
      FHandleChanges := True;
    end;
  end
  else
    EnableColorItems(False);
end;

procedure TFConfiguration.cbElementForegroundSelectedColorChanged(
  Sender: TObject);
var
  wSynH : TSynCustomHighlighter;
  wSynAttr : TSynHighlighterAttributes;
begin
  wSynH := SelectedHighlighter;
  wSynAttr := wSynH.Attribute[lbElements.ItemIndex];
  wSynAttr.Foreground := cbElementForeground.SelectedColor;
end;

procedure TFConfiguration.cbElementBackgroundSelectedColorChanged(
  Sender: TObject);
var
  wSynH : TSynCustomHighlighter;
  wSynAttr : TSynHighlighterAttributes;
begin
  wSynH := SelectedHighlighter;
  wSynAttr := wSynH.Attribute[lbElements.ItemIndex];
  wSynAttr.Background := cbElementBackground.SelectedColor;
end;

procedure TFConfiguration.cbxElementBoldClick(Sender: TObject);
begin
  if FHandleChanges then
    UpdateColorFontStyle;
end;

procedure TFConfiguration.UpdateColorFontStyle;
var
  wfs : TFontStyles;
  wSynH : TSynCustomHighlighter;
  wSynAttr : TSynHighlighterAttributes;
begin
  wfs := [];
  wSynH := SelectedHighlighter;
  wSynAttr := wSynH.Attribute[lbElements.ItemIndex];

  if cbxElementBold.Checked then
    include(wfs, fsBold);

  if cbxElementItalic.Checked then
    include(wfs, fsItalic);

  if cbxElementUnderline.Checked then
    include(wfs, fsUnderline);

  if cbxElementStrikeout.Checked then
    include(wfs, fsStrikeOut);

  wSynAttr.style := wfs;
end;

procedure TFConfiguration.SynSyntaxSampleClick(Sender: TObject);
var
  i, TokenType, Start: Integer;
  Token: string;
  Attri: TSynHighlighterAttributes;
begin
  SynSyntaxSample.GetHighlighterAttriAtRowColEx(SynSyntaxSample.CaretXY, Token,
            TokenType, Start, Attri);
  for i := 0 to lbElements.Count - 1 do
    if Assigned(Attri) and (lbElements.Items[i] = Attri.FriendlyName) then begin
      lbElements.ItemIndex := i;
      lbElementsClick(Self);
      break;
    end;
end;

procedure TFConfiguration.EnableColorItems(aEnable : Boolean);
begin
  cbElementForeground.Enabled := aenable;
  cbElementBackground.Enabled := aenable;
  cbxElementBold.Enabled := aenable;
  cbxElementItalic.Enabled := aenable;
  cbxElementUnderline.Enabled := aenable;
  cbxElementStrikeout.Enabled := aenable;
  if aEnable then begin
    cbElementForeground.HandleNeeded;
    cbElementBackground.HandleNeeded;
  end;
end;

// https://www.slant.co/topics/358/~best-color-themes-for-text-editors#5

function TFConfiguration.SelectedHighlighter : TSynCustomHighlighter;
begin
  Result := nil;
  if cbHighlighters.ItemIndex > -1 then
    Result := cbHighlighters.Items.Objects[cbHighlighters.ItemIndex] as TSynCustomHighlighter;
end;

{--- Color Themes -------------------------------------------------------------}

procedure TFConfiguration.lbColorThemesClick(Sender: TObject);
Var
  AppStorage : TJvAppIniFileStorage;
  FileName : string;
begin
  if lbColorThemes.ItemIndex >= 0 then
  begin
    GuiPyOptions.fColorTheme:= lbColorThemes.Items[lbColorThemes.ItemIndex];
    FileName := IncludeTrailingPathDelimiter(HighlighterFileDir) +
                  GuiPyOptions.fColorTheme + '.ini';
    AppStorage := TJvAppIniFileStorage.Create(nil);
    try
      AppStorage.FlushOnDestroy := False;
      AppStorage.Location := flCustom;
      AppStorage.FileName := FileName;
      SynThemeSample.Highlighter.BeginUpdate;
      try
        AppStorage.ReadPersistent('Highlighters\'+SynThemeSample.Highlighter.FriendlyLanguageName,
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
Var
  i : integer;
  AppStorage : TJvAppIniFileStorage;
  FileName : string;
begin
  FileName := TPath.Combine(HighlighterFileDir, GuiPyOptions.ColorTheme + '.ini');
  if FileExists(Filename) then begin
    AppStorage := TJvAppIniFileStorage.Create(nil);
    try
      AppStorage.FlushOnDestroy := False;
      AppStorage.Location := flCustom;
      AppStorage.FileName := FileName;
      for i := 0 to cbHighlighters.Items.Count - 1 do
      begin
        TSynCustomHighlighter(cbHighlighters.Items.Objects[i]).BeginUpdate;
        try
          AppStorage.ReadPersistent('Highlighters\'+
            TSynCustomHighlighter(cbHighlighters.Items.Objects[i]).FriendlyLanguageName,
            TPersistent(cbHighlighters.Items.Objects[i]));
        finally
          TSynCustomHighlighter(cbHighlighters.Items.Objects[i]).EndUpdate;
        end;
      end;

      for i := 0 to cbHighlighters.Items.Count-1 do
        CommandsDataModule.SynEditOptionsDialogSetHighlighter(
          self, i, TSynCustomHighlighter(cbHighlighters.Items.Objects[i]));

    finally
        AppStorage.Free;
    end;
  end;
end;

{--- Code Templates -----------------------------------------------------------}

procedure TFConfiguration.CodeTemplatesInit;
begin
  CodeTemplatesSetItems;
  CodeSynTemplate.Color := StyleServices.GetSystemColor(clWindow);
  codeSynTemplate.Font.Color := StyleServices.GetSystemColor(clWindowText);
end;

procedure TFConfiguration.edShortcutKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['a'..'z', 'A'..'Z', '0'..'9', #8]) then
    Key := #0;
  inherited;
end;

procedure TFConfiguration.CodeTemplatesGetItems;
Var
 i, j : integer;
begin
  CodeTemplateText := '';
  for i := 0 to CodeTemplatesLvItems.Items.Count - 1 do begin
    CodeTemplateText := CodeTemplateText + CodeTemplatesLvItems.Items[i].Caption + sLineBreak;
    if CodeTemplatesLvItems.Items[i].SubItems[0] <> '' then
      CodeTemplateText := CodeTemplateText +'|' + CodeTemplatesLvItems.Items[i].SubItems[0] + sLineBreak;
    for j := 0 to TStringList(CodeTemplatesLvItems.Items[i].Data).Count - 1 do
      CodeTemplateText := CodeTemplateText + '=' +
        TStringList(CodeTemplatesLvItems.Items[i].Data)[j] + sLineBreak;
  end;
  CommandsDataModule.CodeTemplatesCompletion.AutoCompleteList.Text:= CodeTemplateText;
end;

procedure TFConfiguration.CodeTemplatesSetItems;
Var
 i, Count : integer;
 List : TStringList;
begin
  CodeTemplatesLvItems.Items.Clear;
  i := 0;
  Count := 0;
  List := TStringList.Create;
  try
    List.Text := CommandsDataModule.CodeTemplatesCompletion.AutoCompleteList.Text;
    while i < List.Count do begin
      if Length(List[i]) <= 0 then // Delphi's string list adds a blank line at the end
        Inc(i)
      else if not CharInSet(List[i][1], ['|', '=']) then begin
        Inc(Count);
        with CodeTemplatesLvItems.Items.Add() do begin
          Caption := List[i];
          Data := TStringList.Create;
          Inc(i);
          if List[i][1] = '|' then begin
            SubItems.Add(Copy(List[i], 2, MaxInt));
            Inc(i);
          end else
            SubItems.Add('');
        end;
      end else begin
        if (Count > 0) and (List[i][1] = '=') then
          TStringList(CodeTemplatesLvItems.Items[Count-1].Data).Add(Copy(List[i], 2, MaxInt));
        Inc(i);
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure TFConfiguration.actCodeAddItemExecute(Sender: TObject);
Var
  Item : TListItem;
  i : Integer;
begin
  if edShortCut.Text <> '' then begin
    CodeSynTemplate.Modified := False;
    for i := 0 to CodeTemplatesLvItems.Items.Count - 1 do
      if CompareText(CodeTemplatesLvItems.Items[i].Caption, edShortCut.Text) = 0 then begin
        Item := CodeTemplatesLvItems.Items[i];
        Item.Caption := edShortCut.Text;
        Item.SubItems[0] := edDescription.Text;
        TStringList(Item.Data).Assign(CodeSynTemplate.Lines);
        Item.Selected := True;
        Exit;
      end;

    with CodeTemplatesLvItems.Items.Add() do begin
      Caption := edShortCut.Text;
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
Var
  i : integer;
begin
  if (edShortCut.Text <> '') and (CodeTemplatesLvItems.ItemIndex >= 0) then begin
    for i := 0 to CodeTemplatesLvItems.Items.Count - 1 do
      if (CompareText(CodeTemplatesLvItems.Items[i].Caption, edShortCut.Text) = 0) and
         (i <> CodeTemplatesLvItems.ItemIndex) then
      begin
        StyledMessageDlg(_(SSameName), mtError, [mbOK], 0);
        Exit;
      end;
    with CodeTemplatesLvItems.Items[CodeTemplatesLvItems.ItemIndex] do begin
      Caption := edShortCut.Text;
      SubItems[0] := edDescription.Text;
      TStringList(Data).Assign(CodeSynTemplate.Lines);
      CodeSynTemplate.Modified := False;
    end;
  end;
end;

procedure TFConfiguration.actCodeMoveDownExecute(Sender: TObject);
Var
  Name, Value : string;
  P : Pointer;
  Index : integer;
begin
  if CodeTemplatesLvItems.ItemIndex < CodeTemplatesLvItems.Items.Count - 1 then
  begin
    Index := CodeTemplatesLvItems.ItemIndex;
    Name := CodeTemplatesLvItems.Items[Index].Caption;
    Value := CodeTemplatesLvItems.Items[Index].SubItems[0];
    P := CodeTemplatesLvItems.Items[Index].Data;
    CodeTemplatesLvItems.Items[Index].Data := nil;  // so that it does not get freed
    CodeTemplatesLvItems.Items.Delete(Index);

    with CodeTemplatesLvItems.Items.Insert(Index + 1) do begin
      Caption := Name;
      SubItems.Add(Value);
      Data := P;
      Selected := True;
      MakeVisible(True);
    end;
  end;
end;

procedure TFConfiguration.actCodeMoveUpExecute(Sender: TObject);
Var
  Name, Value : string;
  P : Pointer;
  Index : integer;
begin
  if CodeTemplatesLvItems.ItemIndex > 0 then begin
    Index := CodeTemplatesLvItems.ItemIndex;
    Name := CodeTemplatesLvItems.Items[Index].Caption;
    Value := CodeTemplatesLvItems.Items[Index].SubItems[0];
    P := CodeTemplatesLvItems.Items[Index].Data;
    CodeTemplatesLvItems.Items[Index].Data := nil;  // so that it does not get freed
    CodeTemplatesLvItems.Items.Delete(Index);

    with CodeTemplatesLvItems.Items.Insert(Index - 1) do begin
      Caption := Name;
      SubItems.Add(Value);
      Data := P;
      Selected := True;
      MakeVisible(True);
    end;
  end;
end;

procedure TFConfiguration.CodeTemplatesLvItemsDeletion(Sender: TObject; Item: TListItem);
begin
  if Assigned(Item.Data) then
    TStringList(Item.Data).Free;
end;

procedure TFConfiguration.CodeTemplatesLvItemsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then begin
    edShortCut.Text := Item.Caption;
    edDescription.Text := Item.SubItems[0];
    CodeSynTemplate.Lines.Assign(TStringList(Item.Data));
    CodeSynTemplate.Modified := False;
  end else begin
    edShortCut.Text := '';
    edDescription.Text := '';
    CodeSynTemplate.Text := '';
  end;
end;

function TFConfiguration.getClassCodeTemplate: string;
  var i: integer;
begin
  Result:= '';
  CodeTemplatesSetItems;
  for i := 0 to CodeTemplatesLvItems.Items.Count - 1 do
    if CodeTemplatesLvItems.Items[i].Caption = 'cls' then begin
      Result:= TStringList(CodeTemplatesLvItems.Items[i].Data).Text;
      exit;
    end;
end;

procedure TFConfiguration.PTemplatesActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  actCodeDeleteItem.Enabled := CodeTemplatesLvItems.ItemIndex >= 0;
  actCodeMoveUp.Enabled := CodeTemplatesLvItems.ItemIndex >= 1;
  actcodeMoveDown.Enabled := (CodeTemplatesLvItems.ItemIndex >= 0) and
                         (CodeTemplatesLvItems.ItemIndex < CodeTemplatesLvItems.Items.Count - 1);
  actCodeAddItem.Enabled := edShortCut.Text <> '';
  actcodeUpdateItem.Enabled := (edShortCut.Text <> '') and (CodeTemplatesLvItems.ItemIndex >= 0);

  actFileDeleteItem.Enabled := FileTemplatesLvItems.ItemIndex >= 0;
  actFileMoveUp.Enabled := FileTemplatesLvItems.ItemIndex >= 1;
  actFileMoveDown.Enabled := (FileTemplatesLvItems.ItemIndex >= 0) and
                         (FileTemplatesLvItems.ItemIndex < FileTemplatesLvItems.Items.Count - 1);
  actFileAddItem.Enabled := (edName.Text <> '') and (edCategory.Text <> '');
  actFileUpdateItem.Enabled := (edName.Text <> '') and (FileTemplatesLvItems.ItemIndex >= 0);

  Handled := True;
end;

{--- File Templates -----------------------------------------------------------}

procedure TFConfiguration.FileTemplatesInit;
begin
  TempFileTemplates.Clear;
  if cbFileTemplatesHighlighter.Items.Count = 0 then
    for var i := 0 to CommandsDataModule.Highlighters.Count - 1 do
      cbFileTemplatesHighlighter.Items.AddObject(CommandsDataModule.Highlighters[i],
        CommandsDataModule.Highlighters.Objects[i]);
  FileTemplatesSetItems;
end;

procedure TFConfiguration.FileTemplatesGetItems;
begin
  FileTemplates.Assign(TempFileTemplates);
end;

procedure TFConfiguration.StoreFieldsToFileTemplate(FileTemplate: TFileTemplate);
begin
  FileTemplate.Name := edName.Text;
  FileTemplate.Extension := edExtension.Text;
  FileTemplate.Category := edCategory.Text;
  FileTemplate.Highlighter := CBHighlighters.Text;
  FileTemplate.Template := FileSynTemplate.Text;
end;

procedure TFConfiguration.FileTemplatesSetItems;
begin
  TempFileTemplates.Assign(FileTemplates);
  FileTemplatesLvItems.Items.BeginUpdate;
  try
    FileTemplatesLvItems.Items.Clear;
    for var i := 0 to TempFileTemplates.Count - 1 do
      with FileTemplatesLvItems.Items.Add() do begin
        Caption := (TempFileTemplates[i] as TFileTemplate).Name;
        Data := TempFileTemplates[i];
        SubItems.Add(TFileTemplate(TempFileTemplates[i]).Category);
      end;
  finally
    FileTemplatesLvItems.Items.EndUpdate;
  end;
end;

procedure TFConfiguration.FileTemplatesLvItemsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var
  FileTemplate : TFileTemplate;
begin
  if Selected then begin
    FileTemplate := TFileTemplate(Item.Data);
    edName.Text := FileTemplate.Name;
    edCategory.Text := FileTemplate.Category;
    edExtension.Text := FileTemplate.Extension;
    CBFileTemplatesHighlighter.ItemIndex := CBFileTemplatesHighlighter.Items.IndexOf(FileTemplate.Highlighter);
    FileSynTemplate.Text := FileTemplate.Template;
    CBFileTemplatesHighlightersChange(Self);
  end else begin
    edName.Text := '';
    edCategory.Text := '';
    edExtension.Text := '';
    CBHighlighters.ItemIndex := -1;
    FileSynTemplate.Text := '';
  end;
end;

procedure TFConfiguration.actFileAddItemExecute(Sender: TObject);
Var
  Item : TListItem;
  FileTemplate : TFileTemplate;
  i : Integer;
begin
  if (edName.Text <> '') and (edCategory.Text <> '') then begin
    for i := 0 to FileTemplatesLvItems.Items.Count - 1 do
      if (CompareText(FileTemplatesLvItems.Items[i].Caption, edName.Text) = 0) and
         (CompareText(FileTemplatesLvItems.Items[i].SubItems[0], edCategory.Text) = 0) then
      begin
        Item := FileTemplatesLvItems.Items[i];
        FileTemplate := TFileTemplate(Item.Data);
        StoreFieldsToFileTemplate(FileTemplate);
        Item.Caption := edName.Text;
        Item.SubItems[0] := edCategory.Text;
        Item.Selected := True;
        Item.MakeVisible(False);
        Exit;
      end;

    FileTemplate := TFileTemplate.Create;
    TempFileTemplates.Add(FileTemplate);
    StoreFieldsToFileTemplate(FileTemplate);
    with FileTemplatesLvItems.Items.Add() do begin
      Caption := edName.Text;
      SubItems.Add(edCategory.Text);
      Data := FileTemplate;
      Selected := True;
      MakeVisible(False);
    end;
  end;
end;

procedure TFConfiguration.actFileDeleteItemExecute(Sender: TObject);
begin
  if FileTemplatesLvItems.ItemIndex >= 0 then begin
    TempFileTemplates.Delete(FileTemplatesLvItems.ItemIndex);
    FileTemplatesLvItems.Items.Delete(FileTemplatesLvItems.ItemIndex);
  end;
end;

procedure TFConfiguration.actFileUpdateItemExecute(Sender: TObject);
begin
  if (edName.Text <> '') and (FileTemplatesLvItems.ItemIndex >= 0) then begin
    for var i := 0 to FileTemplatesLvItems.Items.Count - 1 do
      if (CompareText(FileTemplatesLvItems.Items[i].Caption, edName.Text) = 0) and
         (CompareText(FileTemplatesLvItems.Items[i].SubItems[0], edCategory.Text) = 0) and
         (i <> FileTemplatesLvItems.ItemIndex) then
      begin
        StyledMessageDlg(_(SSameName), mtError, [mbOK], 0);
        Exit;
      end;
    with FileTemplatesLvItems.Items[FileTemplatesLvItems.ItemIndex] do begin
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
    FileSynTemplate.Highlighter :=
      CBFileTemplatesHighlighter.Items.Objects[CBfileTemplatesHighlighter.ItemIndex] as TSynCustomHighlighter;
end;

procedure TFConfiguration.actFileMoveUpExecute(Sender: TObject);
Var
  Name, Value : string;
  P : Pointer;
  Index : integer;
begin
  if FileTemplatesLvItems.ItemIndex > 0 then begin
    Index := FileTemplatesLvItems.ItemIndex;
    Name := FileTemplatesLvItems.Items[Index].Caption;
    Value := FileTemplatesLvItems.Items[Index].SubItems[0];
    P := FileTemplatesLvItems.Items[Index].Data;
    FileTemplatesLvItems.Items.Delete(Index);

    with FileTemplatesLvItems.Items.Insert(Index - 1) do begin
      Caption := Name;
      SubItems.Add(Value);
      Data := P;
      Selected := True;
    end;
    TempFileTemplates.Move(Index, Index - 1);
  end;
end;

procedure TFConfiguration.actFileMoveDownExecute(Sender: TObject);
Var
  Name, Value : string;
  P : Pointer;
  Index : integer;
begin
  if FileTemplatesLvItems.ItemIndex < FileTemplatesLvItems.Items.Count - 1 then begin
    Index := FileTemplatesLvItems.ItemIndex;
    Name := FileTemplatesLvItems.Items[Index].Caption;
    Value := FileTemplatesLvItems.Items[Index].SubItems[0];
    P := FileTemplatesLvItems.Items[Index].Data;
    FileTemplatesLvItems.Items.Delete(Index);

    with FileTemplatesLvItems.Items.Insert(Index + 1) do begin
      Caption := Name;
      SubItems.Add(Value);
      Data := P;
      Selected := True;
    end;
    TempFileTemplates.Move(Index, Index + 1);
  end;
end;

procedure TFConfiguration.CBFileTemplatesHighlighterChange(Sender: TObject);
begin
  if CBFileTemplatesHighlighter.ItemIndex < 0 then
    FileSynTemplate.Highlighter := nil
  else
    FileSynTemplate.Highlighter :=
      CBFileTemplatesHighlighter.Items.Objects[CBFileTemplatesHighlighter.ItemIndex] as TSynCustomHighlighter;
end;

{--- IDE Shortcuts ------------------------------------------------------------}

procedure TFConfiguration.lbCategoriesClick(Sender: TObject);
begin
  SelectItem(lbCategories.ItemIndex);
end;

procedure TFConfiguration.lbCommandsClick(Sender: TObject);
var
  A : TActionProxyItem;
begin
  if lbCommands.ItemIndex < 0 then Exit;

  A := CurrentAction;

  edNewShortCut.HotKey := 0;
  lbCurrentKeys.Items.Clear;
  lblDescription.Caption := GetLongHint(A.Hint);

  if A.ShortCut <> 0 then
    lbCurrentKeys.Items.AddObject(ShortCutToText(A.ShortCut), TObject(A.ShortCut));

  lbCurrentKeys.Items.AddStrings(A.SecondaryShortCuts);
end;

procedure TFConfiguration.actAssignShortcutExecute(Sender: TObject);
var
  ShortCut : TShortCut;
  CurAction : TActionProxyItem;
begin
  if lbCommands.ItemIndex < 0 then Exit;
  if edNewShortcut.HotKey <> 0 then begin
    try
      ShortCut := edNewShortcut.HotKey;

      CurAction := CurrentAction;

      if lbCurrentKeys.Items.IndexOf(ShortCutToText(edNewShortcut.HotKey)) < 0 then begin
        { show the keystroke }
        lbCurrentKeys.Items.AddObject(ShortCutToText(edNewShortcut.HotKey), TObject(edNewShortcut.HotKey));

        AssignKeysToActionProxy(CurAction);

        { track the keystroke assignment }
        IDEKeyList.Add(ShortCutToText(ShortCut) + '=' + CurAction.DisplayName);

      end else begin
        MessageBeep(MB_ICONEXCLAMATION);
      end;
    except
      MessageBeep(MB_ICONEXCLAMATION);
      edNewShortcut.SetFocus;
    end;
  end;
end;

procedure TFConfiguration.actRemoveShortcutExecute(Sender: TObject);
var
  CurAction : TActionProxyItem;
  Index : integer;
begin
  if (lbCurrentKeys.ItemIndex < 0) or (lbCommands.ItemIndex < 0) then Exit;
  CurAction := CurrentAction;
  { Remove shortcut from keylist }
  Index := IDEKeyList.IndexOf(lbCurrentKeys.Items[lbCurrentKeys.ItemIndex]
    + '=' + CurrentAction.DisplayName);
  if Index >= 0 then
    IDEKeyList.Delete(Index);

  { Remove shortcut from lbCurrentKeys }
  lbCurrentKeys.Items.Delete(lbCurrentKeys.ItemIndex);

  AssignKeysToActionProxy(CurAction);
end;

procedure TFConfiguration.actAssignShortcutUpdate(Sender: TObject);
var
  Enabled : boolean;
begin
  Enabled := False;
  if edNewShortCut.HotKey = 0 then begin
    lblAssignedTo.Visible := False;
    lblCurrent.Visible := False;
  end
  else begin
    lblAssignedTo.Visible := True;
    if IDEKeyList.IndexOfName(ShortCutToText(edNewShortCut.HotKey)) > -1 then begin
      lblCurrent.Visible := True;
      lblAssignedTo.Caption := IDEKeyList.Values[ShortCutToText(edNewShortCut.HotKey)];
    end else begin
      Enabled := lbCommands.ItemIndex >= 0;
      lblCurrent.Visible := False;
      lblAssignedTo.Caption := '['+_('Unassigned')+']';
    end;
  end;
  actAssignShortcut.Enabled := Enabled;
end;

procedure TFConfiguration.actRemoveShortcutUpdate(Sender: TObject);
begin
  actRemoveShortcut.Enabled :=
    (lbCurrentKeys.ItemIndex >= 0) and (lbCommands.ItemIndex >= 0);
end;

procedure TFConfiguration.actlPythonVersionsUpdate(Action: TBasicAction;
  var Handled: Boolean);
Var
  Node : PVirtualNode;
  Level : integer;
begin
  Node := vtPythonVersions.GetFirstSelected;
  Level := -1;  // to avoid compiler warning
  if Assigned(Node) then
    Level := vtPythonVersions.GetNodeLevel(Node);
  actPVActivate.Enabled := Assigned(Node) and (Level = 1) and
    not (((Node.Parent.Index = 0) and (PyControl.PythonVersionIndex = integer(Node.Index))) or
         ((Node.Parent.Index = 1) and (PyControl.PythonVersionIndex = -(Node.Index + 1))));

  actPVRemove.Enabled := Assigned(Node) and (Level = 1) and (Node.Parent.Index = 1) and
    not (PyControl.PythonVersionIndex = -(Node.Index + 1));
  actPVRename.Enabled := Assigned(Node) and (Level = 1) and (Node.Parent.Index = 1);
  actPVTest.Enabled :=Assigned(Node) and (Level = 1);
  actPVShow.Enabled :=Assigned(Node) and (Level = 1);
  //actPVCommandShell.Enabled :=Assigned(Node) and (Level = 1);
  Handled := True;
end;

function TFConfiguration.GetCurrentAction: TActionProxyItem;
begin
  if lbCommands.ItemIndex < 0 then  Exit(nil);

  Result := lbCommands.Items.Objects[lbCommands.ItemIndex] as TActionProxyItem;
end;

procedure TFConfiguration.AssignKeysToActionProxy(var CurAction: TActionProxyItem);
var
  i: Integer;
begin
  if lbCurrentKeys.Count > 0 then
    CurAction.ShortCut := TShortCut(lbCurrentKeys.Items.Objects[0])
  else
    CurAction.ShortCut := 0;
  { Assign secondary shortcuts }
  CurAction.SecondaryShortCuts.Clear;
  for i := 1 to lbCurrentKeys.Count - 1 do
    CurAction.SecondaryShortCuts.AddObject(lbCurrentKeys.Items[i],
      lbCurrentKeys.Items.Objects[i]);
end;

procedure TFConfiguration.SelectItem(Idx: Integer);
begin
  edNewShortCut.HotKey := 0;
  lbCurrentkeys.Items.Clear;
  lbCommands.Items.Clear;
  lblDescription.Caption := '';
  lbCommands.Items.AddStrings(FunctionList.Objects[Idx] as TStrings);
end;

procedure TFConfiguration.CustomShortcutsCreate;
begin
  FunctionList            := TStringList.Create;
  FunctionList.Sorted     := True;
  FunctionList.Duplicates := dupIgnore;

  IDEKeyList               := TStringList.Create;
  IDEKeyList.Sorted        := True;
  IDEKeyList.Duplicates    := dupIgnore;

  edNewShortcut := TSynHotKey.Create(Self);
  with edNewShortcut do
  begin
    Name := 'edNewShortcut';
    Parent := PIDEShortCuts;
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
  edNewShortCut.HotKey := 0;
  SetCategories;
  SelectItem(0);
  lbCategories.ItemIndex := 0;
end;

procedure TFConfiguration.SetCategories;
begin
  lbCategories.Items.Clear;
  lbCategories.Items.AddStrings(FunctionList);
  SelectItem(0);
end;

procedure TFConfiguration.DoneItems;
  var i: integer;
begin
  for i := Pred(FunctionList.Count) downto 0 do begin
    (FunctionList.Objects[i] as TStringList).Free;
    FunctionList.Delete(i);
  end;
  for i := 0 to CodeTemplatesLvItems.Items.Count - 1 do
    if assigned(CodeTemplatesLvItems.Items[i].Data) then begin
      var SL := TStringList(CodeTemplatesLvItems.Items[i].Data);
      FreeAndNil(SL);
      CodeTemplatesLvItems.Items[i].Data:= nil;
    end;
end;

procedure TFConfiguration.PrepActions;
begin
  ActionProxyCollection := TActionProxyCollection.Create(apcctAll);
  FillFunctionList;
  SetCategories;
end;

procedure TFConfiguration.FillFunctionList;
var
  i, j, Idx : Integer;
  A : TActionProxyItem;
begin
  for i := 0 to ActionProxyCollection.Count - 1 do begin
    A := TActionProxyItem(ActionProxyCollection.Items[i]);

    { get category index }
    Idx := FunctionList.IndexOf(_(A.Category));

    { if category doesn't already exist, add it }
    if Idx < 0 then
      Idx := FunctionList.AddObject(_(A.Category), TStringList.Create);

    { add keyboard function to list }
    (FunctionList.Objects[Idx] as TStringList).AddObject(A.DisplayName, A);

    { shortcut value already assigned }
    if A.ShortCut <> 0 then begin
      { track the keystroke }
      IDEKeyList.Add(ShortCutToText(A.ShortCut) + '=' + A.DisplayName);
    end;
    { Deal with secondary shortcuts }
    if A.IsSecondaryShortCutsStored then
      for j := 0 to A.SecondaryShortCuts.Count - 1 do
        IDEKeyList.Add(ShortCutToText(A.SecondaryShortCuts.ShortCuts[j]) + '=' + A.DisplayName);
  end;
end;

{--- Styles -------------------------------------------------------------------}

type
 TVclStylesPreviewClass = class(TVclStylesPreview);

procedure TFConfiguration.LBStyleNamesClick(Sender: TObject);
var
  LStyle : TCustomStyleServices;
  FileName : string;
  StyleName : string;
begin
  LStyle:=nil;
  if LBStyleNames.ItemIndex >= 0 then
  begin
    StyleName := LBStyleNames.Items[LBStyleNames.ItemIndex];
    if Integer(LBStyleNames.Items.Objects[LbStylenames.ItemIndex]) = 1 then
    begin
      // FileName
      if not Loading then
      begin
        FileName := ExternalStyleFilesDict.Items[StyleName];
        TStyleManager.LoadFromFile(FileName);
        LStyle := TStyleManager.Style[StyleName];
        LoadedStylesDict.Add(StyleName, FileName);
        //  The Style is now loaded and registerd
        LBStyleNames.Items.Objects[LbStylenames.ItemIndex] := nil;
      end;
    end
    else
    begin
         // Resource style
        LStyle := TStyleManager.Style[StyleName];
    end;
  end;

  if Assigned(LStyle) and not Loading  then
  begin
    FPreview.Caption:=StyleName;
    FPreview.Style:=LStyle;
    TVclStylesPreviewClass(FPreview).Paint;
  end;
end;

procedure TFConfiguration.ActionApplyStyleExecute(Sender: TObject);
var
  StyleName : string;
  FileName : string;
begin
  if LBStyleNames.ItemIndex >= 0 then begin
    StyleName := LBStyleNames.Items[LBStyleNames.ItemIndex];
    if Integer(LBStyleNames.Items.Objects[LbStylenames.ItemIndex]) = 1 then
    begin
      // FileName
      FileName := ExternalStyleFilesDict.Items[StyleName];
      SetStyle(FileName);
    end
    else
      // Resource style
     SetStyle(StyleName);
  end;
end;

procedure TFConfiguration.BApplyStyleClick(Sender: TObject);
begin
  // for an unknown reason, the main window disappears when
  // the style is changed, which is why they are temporarily hidden
  GI_FileFactory.ApplyToFiles(procedure(Fi: IFile)
  begin
    if Fi.GetFileKind = fkEditor then begin
      if assigned(TEditorForm(Fi.Form).Partner) then
        TEditorForm(Fi.Form).Partner.Hide;
    end;
  end);

  ActionApplyStyleExecute(Self);
  Application.ProcessMessages;

  GI_FileFactory.ApplyToFiles(procedure(Fi: IFile)
  begin
    if Fi.GetFileKind = fkEditor then begin
      if assigned(TEditorForm(Fi.Form).Partner) then begin
        TEditorForm(Fi.Form).Partner.Show;
      end;
    end;
  end);
end;

procedure TFConfiguration.SetStyle(StyleName: string);
// StyleName can be either a resource or a file name
var
  SName : string;
  StyleInfo : TStyleInfo;
begin
  if CompareText(StyleName, TStyleManager.ActiveStyle.Name) = 0 then
    Exit;

  if CompareText(StyleName, 'Windows') = 0 then
  begin
    TStyleManager.SetStyle(TStyleManager.SystemStyle);
    CurrentSkinName := 'Windows';
    Exit;
  end;

  for SName in TStyleManager.StyleNames do
    if SName = StyleName then
    begin
       // Resource style
      TStyleManager.SetStyle(StyleName);
      if LoadedStylesDict.ContainsKey(StyleName) then
        CurrentSkinName := LoadedStylesDict[StyleName]
      else
        CurrentSkinName := StyleName;
      Exit;
    end;

  // FileName
  if FileExists(StyleName) and TStyleManager.IsValidStyle(StyleName, StyleInfo) then
  begin
    if not TStyleManager.TrySetStyle(StyleInfo.Name, False) then
    begin
      TStyleManager.LoadFromFile(StyleName);
      LoadedStylesDict.Add(StyleInfo.Name, StyleName);
    end;
    TStyleManager.SetStyle(StyleInfo.Name);
    CurrentSkinName := StyleName;
  end;
end;

procedure TFConfiguration.StyleSelectorFormCreate;
begin
  inherited;
  CurrentSkinName := TStyleManager.ActiveStyle.Name;
  LoadedStylesDict := TDictionary<string, string>.Create;

  Loading:=False;
  LBStyleNames.Sorted := True;
  ExternalStyleFilesDict := TDictionary<string, string>.Create;
  FStylesPath := TPyScripterSettings.StylesFilesDir;
  FPreview:= TVclStylesPreview.Create(Self);
  FPreview.Parent:= StylesPreviewPanel;
  FPreview.Icon := Application.Icon.Handle;
  FPreview.BoundsRect := StylesPreviewPanel.ClientRect;
end;

procedure TFConfiguration.StyleSelectorFormShow;
//  Todo Select active style
Var
  Index : integer;
begin
  if LBStyleNames.Items.Count = 0 then
    FillVclStylesList;
  if (LBStyleNames.Items.Count> 0) then
   begin
     Index := LBStyleNames.Items.IndexOf(TStyleManager.ActiveStyle.Name);
     if Index >= 0 then
       LBStyleNames.Selected[Index] :=  True
     else
       LBStyleNames.Selected[0] :=  True;
   end;
   LBStyleNamesClick(Self);
end;

procedure TFConfiguration.FillVclStylesList;
Var
  FileName : string;
  StyleInfo:  TStyleInfo;
begin
   Loading:=True;

   // First add resource styles
   LBStyleNames.Items.AddStrings(TStyleManager.StyleNames);
   // Remove Windows
   // LBStyleNames.Items.Delete(LBStyleNames.Items.IndexOf('Windows'));

   // Then styles in files
    try
       for FileName in TDirectory.GetFiles(FStylesPath,'*.vsf') do
       begin
          if TStyleManager.IsValidStyle(FileName, StyleInfo) and
             (LBStyleNames.Items.IndexOf(StyleInfo.Name) < 0)
          then
          begin
            // TObject(1) denotes external file
            LBStyleNames.Items.AddObject(StyleInfo.Name, TObject(1));
            ExternalStyleFilesDict.Add(StyleInfo.Name, FileName);
          end;
       end;

    except
    end;

   Loading:=False;
end;

{--- Printer Margins & Options ------------------------------------------------}

procedure TFConfiguration.CBUnitsChange(Sender: TObject);
begin
  FInternalCall := True;
  GetMargins(FMargins);
  FInternalCall := False;
  FMargins.UnitSystem := TUnitSystem(CBUnits.ItemIndex);
  SetMargins(FMargins);
end;

procedure TFConfiguration.GetMargins(SynEditMargins: TSynEditPrintMargins);
var
  CurEdit: TEdit;
  function StringToFloat(Edit: TEdit): Double;
  begin
    CurEdit := Edit;
    Result := StrToFloat(Edit.Text);
  end;
begin
  with SynEditMargins do begin
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
      StyledMessageDlg(_(SInvalidNumber), mtError, [mbOk], 0);
      CurEdit.SetFocus;
    end;
    MirrorMargins := CBMirrorMargins.Checked;
  end;
end;

procedure TFConfiguration.SetMargins(SynEditMargins: TSynEditPrintMargins);
begin
  with SynEditMargins do begin
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

{--- Printer Header & Footer --------------------------------------------------}

procedure TFConfiguration.PageNumCmdExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.SelText := '$PAGENUM$';
end;

procedure TFConfiguration.PagesCmdExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.SelText := '$PAGECOUNT$';
end;

procedure TFConfiguration.TimeCmdExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.SelText := '$TIME$';
end;

procedure TFConfiguration.TitleCmdExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.SelText := '$TITLE$';
end;

procedure TFConfiguration.DateCmdExecute(Sender: TObject);
begin
  if Assigned(Editor) then
    Editor.SelText := '$DATE$';
end;

procedure TFConfiguration.FontCmdExecute(Sender: TObject);
begin
  if not Assigned(Editor) then Exit;

  SelectLine(HeaderFooterCharPos.y);
  FontDialog.Font.Assign(CurrText);
  if FontDialog.Execute then
    CurrText.Assign(FontDialog.Font);
  SelectNone;
end;

procedure TFConfiguration.BoldCmdExecute(Sender: TObject);
begin
  if not Assigned(Editor) then Exit;

  SelectLine(HeaderFooterCharPos.y);
  if fsBold in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsBold]
  else
    CurrText.Style := CurrText.Style + [fsBold];
  SelectNone;
end;

procedure TFConfiguration.ItalicCmdExecute(Sender: TObject);
begin
  if not Assigned(Editor) then Exit;

  SelectLine(HeaderFooterCharPos.y);
  if fsItalic in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsItalic]
  else
    CurrText.Style := CurrText.Style + [fsItalic];
  SelectNone;
end;

procedure TFConfiguration.UnderlineCmdExecute(Sender: TObject);
begin
  if not Assigned(Editor) then Exit;

  SelectLine(HeaderFooterCharPos.y);
  if fsUnderLine in CurrText.Style then
    CurrText.Style := CurrText.Style - [fsUnderLine]
  else
    CurrText.Style := CurrText.Style + [fsUnderLine];
  SelectNone;
end;

procedure TFConfiguration.REHeaderLeftEnter(Sender: TObject);
begin
  Editor := Sender as TCustomRichEdit;
  SetHeaderFooterOptions;
end;

procedure TFConfiguration.REHeaderLeftSelectionChange(Sender: TObject);
begin
  UpdateHeaderFooterCursorPos;
end;

procedure TFConfiguration.RGLanguagesClick(Sender: TObject);
begin
  LanguageOptionsToModel;
  PyIDEMainForm.AppStorage.WritePersistent('GuiPy Language Options\' + CurrentLanguage,
    GuiPyLanguageOptions);
  CurrentLanguage:= PyIDEMainForm.getLanguageCode(RGLanguages.ItemIndex);
  GuiPyLanguageOptions.getInLanguage(CurrentLanguage);
  PyIDEMainForm.AppStorage.ReadPersistent('GuiPy Language Options\' + CurrentLanguage,
    GuiPyLanguageOptions);
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
  with (Sender as TPaintBox).Canvas do begin
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
  if Assigned(Editor) then begin
    HeaderFooterOldStart := Editor.SelStart;
    Editor.SelStart := SendMessage(Editor.Handle, EM_LINEINDEX, LineNum, 0);
    Editor.SelLength := Length(Editor.Lines[LineNum]);
  end;
end;

procedure TFConfiguration.SetHeaderFooterOptions;
begin
  PageNumCmd.Enabled := Assigned(Editor) and Editor.Focused;
  PagesCmd.Enabled := Assigned(Editor) and Editor.Focused;
  TimeCmd.Enabled := Assigned(Editor) and Editor.Focused;
  DateCmd.Enabled := Assigned(Editor) and Editor.Focused;
  TitleCmd.Enabled := Assigned(Editor) and Editor.Focused;
  FontCmd.Enabled := Assigned(Editor) and Editor.Focused;
  BoldCmd.Enabled := Assigned(Editor) and Editor.Focused;
  ItalicCmd.Enabled := Assigned(Editor) and Editor.Focused;
  UnderlineCmd.Enabled := Assigned(Editor) and Editor.Focused;
end;

function TFConfiguration.CurrText: TTextAttributes;
begin
  Assert(Assigned(Editor));
  Result := Editor.SelAttributes;
end;

procedure TFConfiguration.SelectNone;
begin
  if Assigned(Editor) then begin
    Editor.SelStart := HeaderFooterOldStart;
    Editor.SelLength := 0;
  end;
end;

procedure TFConfiguration.UpdateHeaderFooterCursorPos;
begin
  if Assigned(Editor) and Editor.HandleAllocated then begin
    HeaderFooterCharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0, Editor.SelStart);
    HeaderFooterCharPos.X := (Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, HeaderFooterCharPos.Y, 0));
  end;
end;

procedure TFConfiguration.AddLines(HeadFoot: THeaderFooter; AEdit: TCustomRichEdit;
  Al: TALignment);
var
  i: Integer;
  AFont: TFont;
begin
  Editor := AEdit;
  AFont := TFont.Create;
  for i := 0 to Editor.Lines.Count - 1 do begin
    SelectLine(i);
    AFont.Assign(CurrText);
    if not CBColors.Checked then
      AFont.Color := HeadFoot.DefaultFont.Color;

    // TrimRight is used to fix a long standing bug occurring because
    // TntRichEdit ads #$D at the end of the string!
    HeadFoot.Add(TrimRight(Editor.Lines[i]), AFont, Al, i + 1);
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
    SynEditPrint.Header.FrameTypes := SynEditPrint.Header.FrameTypes + [ftShaded];
  SynEditPrint.Header.LineColor := PBHeaderLine.Color;
  SynEditPrint.Header.ShadedColor := PBHeaderShadow.Color;
  SynEditPrint.Header.MirrorPosition := CBHeaderMirror.Checked;

  SynEditPrint.Footer.FrameTypes := [];
  if CBFooterLine.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftLine];
  if CBFooterBox.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftBox];
  if CBFooterShadow.Checked then
    SynEditPrint.Footer.FrameTypes := SynEditPrint.Footer.FrameTypes + [ftShaded];
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
var
  i: Integer;
  AItem: THeaderFooterItem;
  LNum: Integer;
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
  for i := 0 to SynEditPrint.Header.Count - 1 do begin
    AItem := SynEditPrint.Header.Get(i);
    case AItem.Alignment of
      taLeftJustify: Editor := REHeaderLeft;
      taCenter: Editor := REHeaderCenter;
      taRightJustify: Editor := REHeaderRight;
    end;
    LNum := Editor.Lines.Add(AItem.Text);
    SelectLine(LNum);
    CurrText.Assign(AItem.Font);
    SelectNone;
  end;

  SynEditPrint.Footer.FixLines;
  for i := 0 to SynEditPrint.Footer.Count - 1 do begin
    AItem := SynEditPrint.Footer.Get(i);
    case AItem.Alignment of
      taLeftJustify: Editor := REFooterLeft;
      taCenter: Editor := REFooterCenter;
      taRightJustify: Editor := REFooterRight;
    end;
    LNum := Editor.Lines.Add(AItem.Text);
    SelectLine(LNum);
    CurrText.Assign(AItem.Font);
    SelectNone;
  end;
end;

{--- Associations -------------------------------------------------------------}

procedure TFConfiguration.BFileExtensionsClick(Sender: TObject);
  var s, s1, s2: string; p: integer; b: byte;
begin
  if VistaOrBetter then begin
    s2:=      CBAssociationPython.Caption + ' ' + BoolToStr(CBAssociationPython.Checked) + ' ';
    s2:= s2 + CBAssociationJfm.Caption  + ' ' + BoolToStr(CBAssociationJfm.Checked) + ' ';
    s2:= s2 + CBAssociationUML.Caption  + ' ' + BoolToStr(CBAssociationUML.Checked) + ' ';
    s2:= s2 + CBAssociationHtml.Caption + ' ' + BoolToStr(CBAssociationHtml.Checked) + ' ';
    s2:= s2 + CBAssociationTxt.Caption  + ' ' + BoolToStr(CBAssociationTxt.Checked) + ' ';
    s2:= s2 + CBAssociationJsp.Caption  + ' ' + BoolToStr(CBAssociationJsp.Checked) + ' ';
    s2:= s2 + CBAssociationPhp.Caption  + ' ' + BoolToStr(CBAssociationPhp.Checked) + ' ';
    s2:= s2 + CBAssociationCss.Caption  + ' ' + BoolToStr(CBAssociationCss.Checked) + ' ';
    s2:= s2 + CBAssociationInc.Caption  + ' ' + BoolToStr(CBAssociationInc.Checked) + ' ';
    s2:= s2 + CBAssociationJsg.Caption  + ' ' + BoolToStr(CBAssociationJsg.Checked) + ' ';
    s2:= s2 + CBAssociationJsd.Caption  + ' ' + BoolToStr(CBAssociationJsd.Checked) + ' ';

    s:= GuiPyOptions.AdditionalAssociations + ';';
    p:= Pos(';', s);
    while p > 0 do begin
      s1:= copy(s, 1, p-1);
      delete(s, 1, p);
      p:= Pos('.', s1);
      if p > 0 then delete(s1, 1, p);
      b:= length(s1);
      if (s1 <> '') and (b in [2, 3, 4, 5]) then s2:= s2 + '.' + s1 + ' ' + BoolToStr(true)+ ' ';
      p:= Pos(';', s);
    end;
    CallUpdater(ParamStr(0), 'registry', s2);
  end
  else
    MakeAssociations;
end;

procedure TFConfiguration.BJEAssociationClick(Sender: TObject);
begin
 // CallUpdater(ParamStr(0), 'jeregistry', HideBlanks(encodeQuotationMark(EJEAssociation.Text)))
end;

procedure TFConfiguration.MakeAssociations;
  var Reg: TRegistry; s, s1: string; p: integer;

  procedure EditAssociation(const Extension: string; docreate: boolean);
  begin
    with Reg do begin
      try
        Access:= KEY_ALL_ACCESS;
        // HKEY_LOCAL_MACHINE\Software\Classes
        RootKey:= HKEY_LOCAL_MACHINE;
        if docreate then begin
          if OpenKey('SOFTWARE\Classes\' + Extension, true) then
            WriteString('', 'GuiPy')
        end else begin
          if OpenKey('SOFTWARE\Classes\' + Extension, false) then
            if ReadString('') = 'GuiPy' then
              WriteString('', '');
        end;
        CloseKey;

        // HKEY_CURRENT_USER\Software\Classes
        RootKey:= HKEY_CURRENT_USER;
        if docreate then begin
          if OpenKey('SOFTWARE\Classes\' + Extension, true) then
            WriteString('', 'GuiPy');
        end else begin
          if OpenKey('SOFTWARE\Classes\' + Extension, false) then
            if ReadString('') = 'GuiPy' then
              WriteString('', '');
        end;
        CloseKey;
      except
        on E: Exception do
          ErrorMsg(E.Message);
      end
    end;
  end;

begin
  RegisterGuiPy;
  Reg:= TRegistry.Create;
  try
    with Reg do begin
      EditAssociation(CBAssociationPython.Caption, CBAssociationPython.Checked);
      EditAssociation(CBAssociationJfm.Caption,  CBAssociationJfm.Checked);
      EditAssociation(CBAssociationUml.Caption,  CBAssociationUml.Checked);
      EditAssociation(CBAssociationHtml.Caption, CBAssociationHtml.Checked);
      EditAssociation(CBAssociationTxt.Caption,  CBAssociationTxt.Checked);
      EditAssociation(CBAssociationJsp.Caption,  CBAssociationJsp.Checked);
      EditAssociation(CBAssociationPhp.Caption,  CBAssociationPhp.Checked);
      EditAssociation(CBAssociationCss.Caption,  CBAssociationCss.Checked);
      EditAssociation(CBAssociationInc.Caption,  CBAssociationInc.Checked);
      EditAssociation(CBAssociationJsg.Caption,  CBAssociationJsg.Checked);
      s:= GuiPyOptions.AdditionalAssociations + ';';
      p:= Pos(';', s);
      while p > 0 do begin
        s1:= copy(s, 1, p-1);
        delete(s, 1, p);
        p:= Pos('.', s1);
        if p > 0 then delete(s1, 1, p);
        if (s1 <> '') and (Pos(' ', s1) = 0) then EditAssociation('.' + s1, true);
        p:= Pos(';', s);
      end;
    end;
  finally
    FreeAndNil(Reg);
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil) ;
end;

procedure TFConfiguration.RegisterGuiPy;
  var GuiPy, Filename: String; Reg: TRegistry;

  procedure WriteToRegistry(const Key: String);
  begin
    with Reg do begin
      OpenKey(Key, true);
      WriteString('', 'GuiPy');
      CloseKey;
      OpenKey(Key + '\DefaultIcon', true);
      WriteString('', GuiPy + ',0');
      CloseKey;
      OpenKey(Key + '\Shell\Open\command', true);
      WriteString('', GuiPy);
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec', true);
      WriteString('', '[FileOpen("%1")]');
      OpenKey('Application', TRUE);
      FileName := ExtractFileName(ParamStr(0));
      FileName := Copy(FileName, 1, Length(FileName)-4);
      WriteString('', Filename);
      CloseKey;
      OpenKey(Key + '\Shell\Open\ddeexec\topic', true);
      WriteString('', 'System');
      CloseKey;
    end;
  end;

begin
  GuiPy:= HideBlanks(ParamStr(0));
  Reg:= TRegistry.Create;
  try
    with Reg do begin
      Access:= KEY_ALL_ACCESS;
      RootKey:= HKEY_LOCAL_MACHINE;
      WriteToRegistry('SOFTWARE\Classes\GuiPy');
      RootKey:= HKEY_CURRENT_USER;
      WriteToRegistry('\SOFTWARE\Classes\GuiPy');
    end;
  finally
    FreeAndNil(Reg);
  end;
end;

{--- Git ----------------------------------------------------------------------}

procedure TFConfiguration.BGitFolderClick(Sender: TObject);
  var Dir: String;
begin
  Dir:= EGitFolder.Hint;
  if not Sysutils.DirectoryExists(Dir) then Dir:= GuiPyOptions.SourcePath;
  {$WARNINGS OFF}
  FolderDialog.DefaultFolder:= Dir;
  if FolderDialog.Execute then
    ShortenPath(EGitFolder, FolderDialog.Filename);
  {$WARNINGS ON}
  CheckFolder(EGitFolder, true);
end;

procedure TFConfiguration.BGitRepositoryClick(Sender: TObject);
  var Dir: String;
begin
  Dir:= CBLocalRepository.Text;
  if not Sysutils.DirectoryExists(Dir) then Dir:= GuiPyOptions.SourcePath;
  FolderDialog.DefaultFolder:= Dir;
  if FolderDialog.Execute then begin
    Dir:= FolderDialog.Filename;
    SysUtils.ForceDirectories(Dir);
    if not FGit.IsRepository(Dir) then
      FGit.GitCall('init', Dir);
    if CBLocalRepository.Items.IndexOf(Dir) = -1 then
      CBLocalRepository.Items.Insert(0, Dir);
    CBLocalRepository.Text:= Dir;
  end;
  CheckFolderCB(CBLocalRepository);
end;

procedure TFConfiguration.BGitCloneClick(Sender: TObject);
  var Dir, Remote, aName: String;
begin
  Screen.Cursor:= crHourGlass;
  try
    Dir:= CBLocalRepository.Text;
    Remote:= CBRemoteRepository.Text;
    if not Sysutils.DirectoryExists(Dir) then SysUtils.ForceDirectories(Dir);
    FGit.GitCall('clone ' + Remote + ' ', Dir);
    aName:= ExtractFileNameEx(Remote);
    aName:= ChangeFileExt(aName, '');
    if not EndsWith(Dir, '\' + aName) then
      CBLocalRepository.Text:= Dir + '\' + aName;
    if CBRemoteRepository.Items.IndexOf(Remote) = -1 then
      CBRemoteRepository.Items.Insert(0, Remote);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TFConfiguration.LGitFolderClick(Sender: TObject);
begin
  DoHelp('https://git-scm.com/');
end;

{--- SVN ----------------------------------------------------------------------}

procedure TFConfiguration.BSVNClick(Sender: TObject);
  var Dir: String;
begin
  Dir:= ESVNFolder.Hint;
  if not Sysutils.DirectoryExists(Dir) then Dir:= GuiPyOptions.SourcePath;
  {$WARNINGS OFF}
  FolderDialog.DefaultFolder:= Dir;
  if FolderDialog.Execute then
    ShortenPath(ESVNFolder, FolderDialog.Filename);
  {$WARNINGS ON}
  CheckFolder(ESVNFolder, true);
end;

procedure TFConfiguration.BRepositoryClick(Sender: TObject);
  var Dir: String;
begin
  Dir:= CBRepository.Hint;
  if not Sysutils.DirectoryExists(Dir) then Dir:= GuiPyOptions.SourcePath;
  {$WARNINGS OFF}
  FolderDialog.DefaultFolder:= Dir;
  if FolderDialog.Execute then begin
    Dir:= FolderDialog.Filename;
    ShortenPath(CBRepository, Dir);
    Sysutils.ForceDirectories(Dir);
    if not FSubversion.IsRepository(Dir) then
      FSubversion.CallSVN('\svnadmin.exe', 'create ' + HideBlanks(Dir));
  end;
  {$WARNINGS ON}
  CheckFolderCB(CBRepository);
end;

procedure TFConfiguration.LSVNClick(Sender: TObject);
begin
  DoHelp('https://subversion.apache.org/');
end;

procedure TFConfiguration.OpenAndShowPage(Page: string);
begin
  // due to visible/modal-exception
  if not Visible then begin
    PrepareShow;
    TThread.ForceQueue(nil, procedure
      begin
        TVConfiguration.Selected:= getTVConfigurationItem(_(Page));
      end);
    ShowModal;
  end;
end;

{--- end of Configuration -----------------------------------------------------}

{--- TGuiPyOptions ---------------------------------------------------------}

constructor TGuiPyOptions.Create;
begin
  inherited;
  fColorTheme:= 'Obsidian';
  // Class modeler
  fShowGetSetMethods:= true;
  fShowTypeSelection:= true;
  fShowKindProcedure:= true;
  fShowParameterTypeSelection:= true;

  // GUI designer
  fNameFromText:= true;
  fGuiDesignerHints:= true;
  fSnapToGrid:= true;
  fGridSize:= 8;
  fFrameWidth:= 300;
  fFrameHeight:= 300;

  // Structogram
  fStructoDatatype:= 'int';
  fSwitchWithCaseLine:= false;
  fCaseCount:= 4;
  fStructogramShadowWidth:= 3;
  fStructogramShadowIntensity:= 8;

  // Sequencediagram
  fSDFillingcolor:= clYellow;
  fSDNoFilling:= false;
  fSDShowMainCall:= false;
  fSDShowParameter:= true;
  fSDShowReturn:= true;

  // UML design
  fValidClassColor:= clWhite;
  fInvalidClassColor:= clFuchsia;
  fClassHead:= 0;
  fShadowWidth:= 3;
  fShadowIntensity:= 8;
  fObjectColor:= clYellow;
  fObjectHead:= 1;
  fObjectFooter:= 1;
  fObjectCaption:= 0;
  fObjectUnderline:= true;
  fCommentColor:= clSkyBlue;
  fDiVisibilityFilter:= 0;
  fDiSortOrder:= 0;
  fDIShowParameter:= 4;
  fDiShowIcons:= 1;

  // uml options
  fShowEmptyRects:= false;
  fIntegerInsteadofInt:= false;
  fConstructorWithVisibility:= false;
  fRelationshipAttributesBold:= true;
  fShowClassparameterSeparately:= false;
  fRoleHidesAttribute:= false;
  fDefaultModifiers:= true;
  fShowPublicOnly:= false;
  fShowObjectsWithInheritedPrivateAttributes:= true;
  fShowObjectsWithMethods:= false;
  fObjectLowerCaseLetter:= true;
  fShowAllNewObjects:= true;
  fObjectsWithoutVisibility:= true;
  fPrivateAttributEditable:= true;

   // restrictions
  fLockedDOSWindow:= false;
  fLockedInternet:= false;
  fLockedPaths:= false;
  fLockedStructogram:= false;
  fUsePredefinedLayouts:= false;

  // Browser
  fBrowserURLs:= '';
  fCBWidth:= 200;
  fUseIEinternForDocuments:= true;

  // Associations
  fAdditionalAssociations:= '';

  // Git
  fGitFolder:= '';
  fGitLocalRepository:= '';
  fGitRemoteRepository:= '';
  fGitUserName:= '';
  fGitUserEMail:= '';

  // Subversion
  fSVNFolder:= '';
  fSVNRepository:= '';

  // Others
  fMethodComment:= TStringList.Create;
  fAuthor:= '';

  // Others
  fTextDiffState:= '';
  fTextDiffIgnoreCase:= false;
  fTextDiffIgnoreBlanks:= false;
  fSourcepath:= GetDocumentsPath;
  fTempDir:= IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP'));

  fUMLFont:= TFont.Create;
  fUMLFont.Name:= 'Segoe UI';
  fUMLFont.Size:= 12;
  fStructogramFont:= TFont.Create;
  fStructogramFont.Name:= 'Segoe UI';
  fStructogramFont.Size:= 12;
  fSequenceFont:= TFont.Create;
  fSequenceFont.Name:= 'Segoe UI';
  fSequenceFont.Size:= 12;
end;

destructor TGuiPyOptions.destroy;
begin
  inherited;
  FreeAndNil(fMethodComment);
  FreeAndNil(fUMLFont);
  FreeAndNil(fStructogramFont);
  FreeAndNil(fSequenceFont);
end;

procedure TGuiPyOptions.setMethodComment(Value: TStringList);
begin
  fMethodComment.assign(Value);
end;

procedure TGuiPyOptions.setUMLFont(Value: TFont);
begin
  fUMLFont.assign(Value);
end;

procedure TGuiPyOptions.setStructogramFont(Value: TFont);
begin
  fStructogramFont.assign(Value);
end;

procedure TGuiPyOptions.setSequenceFont(Value: TFont);
begin
  fSequenceFont.assign(Value);
end;

function TGuiPyOptions.getGitFolder: string;
begin
  Result:= AddPortableDrive(fGitFolder);
end;

procedure TGuiPyOptions.setGitFolder(aValue: string);
begin
  fGitFolder:= RemovePortableDrive(aValue);
end;

function TGuiPyOptions.getGitLocalRepository: string;
begin
  Result:= AddPortableDrive(fGitLocalRepository);
end;

procedure TGuiPyOptions.setGitLocalRepository(aValue: string);
begin
  fGitLocalRepository:= RemovePortableDrive(aValue);
end;

function TGuiPyOptions.getSVNFolder: string;
begin
  Result:= AddPortableDrive(fSVNFolder);
end;

procedure TGuiPyOptions.setSVNFolder(aValue: string);
begin
  fSVNFolder:= AddPortableDrive(aValue);
end;

function TGuiPyOptions.getSVNRepository: string;
begin
  Result:= RemovePortableDrive(fSVNRepository);
end;

procedure TGuiPyOptions.setSVNRepository(aValue: string);
begin
  fSVNRepository:= AddPortableDrive(aValue);
end;

function TGuiPyOptions.getSourcePath: string;
begin
  Result:= AddPortableDrive(fSourcePath);
end;

procedure TGuiPyOptions.setSourcePath(aValue: string);
begin
  fSourcePath:= RemovePortableDrive(aValue);
end;

function TGuiPyOptions.getTempDir: string;
begin
  Result:= AddPortableDrive(fTempDir);
end;

procedure TGuiPyOptions.setTempDir(aValue: string);
begin
  fTempDir:= RemovePortableDrive(aValue);
end;

{--- TGuiPyLanguageOptions ----------------------------------------------------}

procedure TGuiPyLanguageOptions.getInLanguage(Language: string);
  var CurrentLanguage: string;
begin
  CurrentLanguage:= getCurrentLanguage;
  UseLanguage(Language);

  // Structogram
  fAlgorithm:=  _('Algorithm');
  fInput:= _('Input:');
  fOutput:= _('Output:');
  fWhile:= _('repeat while');
  fFor:= _('for item in list');
  fYes:= _('yes');
  fNo:= _('no');
  fOther:= _('else');

  // Sequencediagram
  fSDObject:= _('Object');
  fSDNew:= _('new');
  fSDClose:= _('close');
  UseLanguage(CurrentLanguage);
end;


initialization
  TStyleManager.Engine.RegisterStyleHook(TEdit, TEditStyleHookColor);

//finalization
  // TStyleManager.Engine.UnRegisterStyleHook(TEdit, TEditStyleHookColor);

end.
