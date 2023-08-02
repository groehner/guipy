{-----------------------------------------------------------------------------
 Unit Name: cPythonSourceScanner
 Author:    Kiriakos Vlahos
 Date:      14-Jun-2005
 Purpose:   Class for Scanning and analysing Python code
            Does not check correctness
            Code draws from Bicycle Repair Man and Boa Constructor
 History:
-----------------------------------------------------------------------------}
unit cPythonSourceScanner;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Contnrs,
  System.RegularExpressions,
  System.Threading;

Type
  TParsedModule = class;

  TCodePos = record
    LineNo : integer;
    CharOffset : integer;
  end;

  TBaseCodeElement = class
    // abstract base class
  private
    fParent : TBaseCodeElement;
  protected
    fIsProxy : boolean;
    fIsFinal : boolean;
    fTyp: String;
    fCodePos : TCodePos;
  public
    Name : string;
    function GetRoot : TBaseCodeElement;
    function GetModule : TParsedModule;
    function GetDottedName : string;
    function GetModuleSource : string;
    property CodePos : TCodePos read fCodePos;
    property Parent : TBaseCodeElement read fParent write fParent;
    property IsProxy : boolean read fIsProxy;  // true if derived from live Python object
    property Typ: string read fTyp write fTyp;
    property IsFinal: boolean read fIsFinal write fIsFinal;
  end;

  TCodeBlock = record
    StartLine : integer;
    LastCommentLine: integer;
    EndLine : integer;
  end;

  TModuleImport = class(TBaseCodeElement)
  private
    fRealName : string; // used if name is an alias
    fPrefixDotCount : integer; // for relative package imports
    fCodeBlock : TCodeBlock;
    function GetRealName: string;
  public
    ImportAll : Boolean;
    ImportedNames : TObjectList;
    property RealName : string read GetRealName;
    property PrefixDotCount : integer read fPrefixDotCount;
    property CodeBlock : TCodeBlock read fCodeBlock;
    constructor Create(AName : string; CB : TCodeBlock);
    destructor Destroy; override;
  end;

  TVariableAttribute = (vaBuiltIn, vaClassAttribute, vaCall, vaArgument,
                        vaStarArgument, vaStarStarArgument, vaArgumentWithDefault,
                        vaImported);
  TVariableAttributes = set of TVariableAttribute;

  TVariable = class(TBaseCodeElement)
    // The parent can be TParsedModule, TParsedClass, TParsedFunction or TModuleImport
  private
    // only used if Parent is TModuleImport and Name is an alias
    fRealName : string;
    function GetRealName: string;
  public
    aType: string;
    ObjType : string;
    DefaultValue : string;
    Attributes : TVariableAttributes;
    property RealName : string read GetRealName;
  end;

  TCodeElement = class(TBaseCodeElement)
  private
    fCodeBlock : TCodeBlock;
    fDocString : string;
    fIndent : integer;
    fDocStringExtracted : boolean;
    function GetChildCount: integer;
    function GetChildren(i : integer): TCodeElement;
    procedure ExtractDocString;
  protected
    fChildren : TObjectList;
    function GetDocString: string; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddChild(CE : TCodeElement);
    procedure GetSortedClasses(SortedClasses : TObjectList);
    procedure GetSortedFunctions(SortedFunctions : TObjectList);
    procedure GetNameSpace(SList : TStringList); virtual;
    function GetScopeForLine(LineNo : integer) : TCodeElement;
    function GetChildByName(ChildName : string): TCodeElement;
    property CodeBlock : TCodeBlock read fCodeBlock;
    property Indent : integer read fIndent;
    property ChildCount : integer read GetChildCount;
    property Children[i : integer] : TCodeElement read GetChildren;
    property DocString : string read GetDocString;
  end;

  TParsedFunction = class(TCodeElement)
  private
    fArguments : TObjectList;
    fLocals : TObjectList;
  public
    ReturnType : string;
    ReturnAttributes : TVariableAttributes;
    isStaticMethod: boolean;
    isClassMethod: boolean;
    isAbstractMethod: boolean;
    constructor Create;
    destructor Destroy; override;
    function ArgumentsString : string; virtual;
    function HasArgument(Name : string): Boolean;
    procedure GetNameSpace(SList : TStringList); override;
    property Arguments : TObjectList read fArguments;
    property Locals : TObjectList read fLocals;
  end;

  TParsedClass = class(TCodeElement)
  private
    fSuperClasses : TStringList;
    fAttributes : TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    property SuperClasses : TStringList read fSuperClasses;
    property Attributes : TObjectList read fAttributes;
  end;

  TParsedModule = class(TCodeElement)
  private
    fImportedModules : TObjectList;
    fSource : string;
    fFileName : string;
    fMaskedSource : string;
    fAllExportsVar : string;
    fFileAge : TDateTime;
    function GetIsPackage: boolean;
    procedure SetFileName(const Value: string);
  protected
    fGlobals : TObjectList;
    function GetAllExportsVar: string; virtual;
  public
    constructor Create; overload;
    constructor Create(const Source : string); overload;
    constructor Create(const FName : string; const Source : string); overload;
    destructor Destroy; override;
    procedure Clear;
    procedure GetSortedImports(ImportsList : TObjectList);
    procedure GetUniqueSortedGlobals(GlobalsList : TObjectList);
    property ImportedModules : TObjectList read fImportedModules;
    property Globals : TObjectList read fGlobals;
    property Source : string read fSource write fSource;
    property FileName : string read fFileName write SetFileName;
    property MaskedSource : string read fMaskedSource;
    property IsPackage : boolean read GetIsPackage;
    property AllExportsVar : string read GetAllExportsVar;
    property FileAge : TDateTime read fFileAge write fFileAge;
  end;

  TScannerProgressEvent = procedure(CharNo, NoOfChars : integer; var Stop : Boolean) of object;

  TPythonScanner = class
  private
    fOnScannerProgress : TScannerProgressEvent;
    fCodeRE : TRegEx;
    fBlankLineRE : TRegEx;
    //fEscapedQuotesRE : TRegEx;
    //fStringsAndCommentsRE : TRegEx;
    fLineContinueRE : TRegEx;
    fImportRE : TRegEx;
    fFromImportRE : TRegEx;
    fAssignmentRE : TRegEx;
    fForRE : TRegEx;
    fReturnRE : TRegEx;
    fWithRE : TRegEx;
    fGlobalRE : TRegEx;
    fAliasRE : TRegEx;
    fListRE : TRegEx;
    fCommentLineRE : TRegEx;
    fClassMethodRE : TRegEx;
    fStaticMethodRE : TRegEx;
    fAbstractMethodRE : TRegEx;
  protected
    procedure DoScannerProgress(CharNo, NoOfChars : integer; var Stop : Boolean);
  public
    property OnScannerProgress : TScannerProgressEvent
      read fOnScannerProgress write fOnScannerProgress;

    constructor Create;
    function ScanModule(Module : TParsedModule) : boolean;
  end;

  IAsyncSourceScanner = interface
  ['{B9406B98-FEF9-4D18-AFC6-A6E4DCE37979}']
    function GetParsedModule : TParsedModule;
    function Finished : Boolean;
    procedure StopScanning;
    property ParsedModule : TParsedModule read GetParsedModule;
  end;

  TAsynchSourceScanner = class(TInterfacedObject, IAsyncSourceScanner)
  private
    fStopped : Boolean;
    fParsedModule : TParsedModule;
    fPythonScanner : TPythonScanner;
    fFuture : IFuture<TParsedModule>;
    function FutureTask(Sender : TObject) : TParsedModule;
    procedure ScanProgress(CharNo, NoOfChars : integer; var Stop : Boolean);
    // IAsyncSourceScanner implementation
    function Finished : Boolean;
    function GetParsedModule : TParsedModule;
    procedure StopScanning;
  public
    constructor Create(const FileName : string; const Source : string);
    destructor Destroy; override;
  end;

  TAsynchSourceScannerFactory = class
  private
    fIList : TInterfaceList;
    procedure ClearFinished;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ReleaseScanner(Scanner : IAsyncSourceScanner);
    function CreateAsynchSourceScanner(const FileName : string; const Source : string): IAsyncSourceScanner;
  end;

  Var
    AsynchSourceScannerFactory : TAsynchSourceScannerFactory;

  function CodeBlock(StartLine, EndLine : integer) : TCodeBlock;
  function GetExpressionBuiltInType(Expr : string; Var IsBuiltIn : boolean) : string;
  function GetExpressionType(Expr: string; var VarAtts: TVariableAttributes): string;

implementation

uses
  WinApi.Windows,
  System.Math,
  VarPyth,
  JclStrings,
  JvGnugettext,
  SynCompletionProposal,
  StringResources,
  uEditAppIntfs,
  uCommonFunctions,
  cPySupportTypes,
  cPyBaseDebugger,
  cSSHSupport,
  uUtils;

Const
  MaskChar = WideChar(#96);

Var
  DocStringRE : TRegEx;

function HaveImplicitContinuation(S : string; var BracesCount : integer) : Boolean;
var
  I: Integer;
begin
  for I := 1 to Length(S) do
    if (Ord(S[i]) < 128) then begin
      if AnsiChar(S[i]) in ['(', '[', '{'] then
        Inc(BracesCount)
      else if AnsiChar(S[i]) in [')', ']', '}'] then
         Dec(BracesCount);
    end;
  Result := BracesCount > 0;
end;

function GetGroup(Match: TMatch; i: integer): string;
begin
  if i < Match.Groups.Count
    then Result:= Match.Groups[i].Value
    else Result:= '';
end;

function GetGroupOffset(Match: TMatch; i: integer): integer;
begin
  if i < Match.Groups.Count
    then Result:= Match.Groups[i].Index
    else Result:= 0;
end;

function GetGroupLength(Match: TMatch; i: integer): integer;
begin
  if i < Match.Groups.Count
    then Result:= Match.Groups[i].Length
    else Result:= 0;
end;

{ Code Ellement }

constructor TCodeElement.Create;
begin
  inherited;
  fParent := nil;
  fChildren := nil;
end;

destructor TCodeElement.Destroy;
begin
  FreeAndNil(fChildren);
  inherited;
end;

procedure TCodeElement.AddChild(CE : TCodeElement);
begin
  if fChildren = nil then
    fChildren := TObjectList.Create(True);

  CE.fParent := Self;
  fChildren.Add(CE);
end;

function TCodeElement.GetChildCount: integer;
begin
  if Assigned(fChildren) then
    Result := fChildren.Count
  else
    Result := 0;
end;

function TCodeElement.GetChildren(i : integer): TCodeElement;
begin
  if Assigned(fChildren) then begin
    Result := TCodeElement(fChildren[i]);
    Assert(Result is TCodeElement);
    Assert(Assigned(Result));
  end else
    Result := nil;
end;

function TCodeElement.GetChildByName(ChildName: string): TCodeElement;
var
  i : integer;
  CE : TCodeElement;
begin
  Result := nil;
  if not Assigned(fChildren) then Exit;
  for i := 0 to fChildren.Count - 1 do begin
    CE := GetChildren(i);
    if CE.Name = ChildName then begin
      Result := CE;
      Exit;
    end;
  end;
end;

function CompareCodeElements(Item1, Item2: Pointer): Integer;
begin
  Result := CompareStr(TCodeElement(Item1).Name, TCodeElement(Item2).Name);
end;

procedure TCodeElement.GetSortedClasses(SortedClasses: TObjectList);
Var
  i : integer;
begin
  if not Assigned(fChildren) then Exit;
  for i := 0 to Self.fChildren.Count - 1 do
    if fChildren[i] is TParsedClass then
      SortedClasses.Add(fChildren[i]);
  SortedClasses.Sort(CompareCodeElements);
end;

procedure TCodeElement.GetSortedFunctions(SortedFunctions: TObjectList);
Var
  i : integer;
begin
  if not Assigned(fChildren) then Exit;
  for i := 0 to Self.fChildren.Count - 1 do
    if fChildren[i] is TParsedFunction then
      SortedFunctions.Add(fChildren[i]);
  SortedFunctions.Sort(CompareCodeElements);
end;

procedure TCodeElement.GetNameSpace(SList: TStringList);
Var
  i : integer;
begin
  //  Add from Children
  if Assigned(fChildren) then
    for i := 0 to fChildren.Count - 1 do
      SList.AddObject(TCodeElement(fChildren[i]).Name, fChildren[i]);
end;

function TCodeElement.GetScopeForLine(LineNo: integer): TCodeElement;
Var
  i : integer;
  CE : TCodeElement;
begin
  if (LineNo >= fCodeBlock.StartLine) and (LineNo <= fCodeBlock.EndLine) then begin
    Result := Self;
    //  try to see whether the line belongs to a child
    if not Assigned(fChildren) then Exit;
    for i := 0 to fChildren.Count - 1 do begin
      CE := Children[i];
      if LineNo < CE.CodeBlock.StartLine then
        break
      else if LineNo > CE.CodeBlock.EndLine then
        continue
      else begin
        // recursive call
        Result := CE.GetScopeForLine(LineNo);
        break;
      end;
    end;
  end else
    Result := nil;
end;

procedure TCodeElement.ExtractDocString;
var
  ModuleSource, DocStringSource : string;
  CB : TCodeBlock;
begin
  if fDocStringExtracted then Exit;

  fDocStringExtracted := True;
  fDocString := '';

  CB := fCodeBlock;
  if Assigned(fChildren) and (fChildren.Count > 0) then
    CB.EndLine := Pred(Children[0].CodeBlock.StartLine);
  if CB.StartLine > CB.EndLine then Exit;

  ModuleSource := GetModuleSource;
  if ModuleSource = '' then Exit;

  DocStringSource := GetLineRange(ModuleSource, CB.StartLine, CB.EndLine);
  if DocStringSource = '' then Exit;

  var Match:= DocStringRE.Match(DocStringSource);
  if Match.Success then begin
    fDocString := GetGroup(Match, 2);
    if fDocString = '' then
      fDocString := getGroup(Match, 3);

    fDocString := FormatDocString(fDocString);
  end;
end;

function TCodeElement.GetDocString: string;
begin
  if not fDocStringExtracted then
    ExtractDocString;
  Result := fDocString;
end;

{ TPythonScanner }

constructor TPythonScanner.Create;
begin
  inherited;
  fCodeRE := CompiledRegEx(Format('^([ \t]*)(class|def)[ \t]+(%s)[ \t]*(\(([^>]*)\))?[ \t]*(->[ \t]*([^ \t:][^:]*))?:',
    [IdentRE]));
  fBlankLineRE := CompiledRegEx('^[ \t]*($|\$|\"\"\"|''''''|' + MaskChar +')');
  // fBlankLineRE := CompiledRegEx('^[ \t]*($|\$|\#|\"\"\"|''''''|' + MaskChar +')');
  //fEscapedQuotesRE := CompiledRegEx('(\\\\|\\\"|\\\'')');
  //fStringsAndCommentsRE :=
  //  CompiledRegEx('(?sm)(\"\"\".*?\"\"\"|''''''.*?''''''|\"[^\"]*\"|\''[^\'']*\''|#.*?\n)');
  fLineContinueRE := CompiledRegEx('\\[ \t]*(#.*)?$');
  fImportRE := CompiledRegEx('^[ \t]*import[ \t]+([^#;]+)');
  fFromImportRE :=
    CompiledRegEx(Format('^[ \t]*from[ \t]+(\.*)(%s)[ \t]+import[ \t]+([^#;]+)', [DottedIdentRE]));
    { TODO : Deal with form . import module as module  syntax }
    //CompiledRegEx(Format('^[ \t]*from[ \t]+(\.*)(%s)?[ \t]+import[ \t]+([^#;]+)', [DottedIdentRE]));
  fAssignmentRE :=
    //CompiledRegEx(Format('^([ \t]*(self.)?%s[ \t]*(:[ \t]*Final(\[\w*\])?)?[ \t]*(,[ \t]*(self.)?%s[ \t]*)*(=))+(.*)',
    //  [IdentRE, IdentRE]));

    CompiledRegEx(Format('^([ \t]*(self.)?%s[ \t]*(:[ \t]*(Final(\[\w*\])?)|.+)?[ \t]*(,[ \t]*(self.)?%s[ \t]*)*(=))+(.*)',
      [IdentRE, IdentRE]));
  fForRE := CompiledRegEx(Format('^\s*for +(%s)( *, *%s)* *(in)', [IdentRe, IdentRe]));
  fReturnRE := CompiledRegEx('^[ \t]*return[ \t]+(.*)');
  fWithRE := CompiledRegEx(Format('^[ \t]*with +(%s) *(\(?).*as +(%s)', [DottedIdentRE, IdentRE]));
  fGlobalRE := CompiledRegEx(Format('^[ \t]*global +((%s)( *, *%s)*)', [IdentRE, IdentRE]));
  fAliasRE :=
    CompiledRegEx(Format('^[ \t]*(%s)([ \t]+as[ \t]+(%s))?', [DottedIdentRE, IdentRE]));
  fListRE := CompiledRegEx('\[(.*)\]');
  fCommentLineRE := CompiledRegEx('^([ \t]*)#');
  fClassMethodRE := CompiledRegEx('^[ \t]*@classmethod[ \t]*$');
  fStaticMethodRE := CompiledRegEx('^[ \t]*@staticmethod[ \t]*$');
  fAbstractMethodRE := CompiledRegEx('^[ \t]*@abstractmethod[ \t]*$');
end;

procedure TPythonScanner.DoScannerProgress(CharNo, NoOfChars : integer;
  var Stop: Boolean);
begin
  if Assigned(fOnScannerProgress) then
    fOnScannerProgress(CharNo, NoOfChars, Stop);
end;

function TPythonScanner.ScanModule(Module : TParsedModule): boolean;
// Expectes Module Source code in Module.Source
// Parses the Python Source code and adds code elements as children of Module
{ TODO 2 : Optimize out calls to Trim }
Var
  UseModifiedSource : boolean;
  SourceLines : TFunc<TStringList>;

  function GetNthSourceLine(LineNo : integer) : string;
  begin
    if not Assigned(SourceLines) then begin
      SourceLines := TSmartPtr.Make(TStringList.Create);
      SourceLines.Text := Module.Source;
    end;

    if LineNo <= SourceLines.Count then
      Result := SourceLines[LineNo-1]
    else
      Result := '';
  end;

  procedure GetLine(var P : PWideChar; var Line : string; var LineNo : integer);
  Var
    Start : PWideChar;
  begin
    Inc(LineNo);
    Start := P;
    while not CharInSet(P^, [#0, #10, #13]) do Inc(P);
    if UseModifiedSource then
      SetString(Line, Start, P - Start)
    else
      Line := GetNthSourceLine(LineNo);
    if P^ = WideChar(#13) then Inc(P);
    if P^ = WideChar(#10) then Inc(P);
  end;

  procedure CharOffsetToCodePos(CharOffset, FirstLine : integer; LineStarts : TList;
    var CodePos: TCodePos);
  var
    i : integer;
  begin
    CodePos.LineNo := FirstLine;
    CodePos.CharOffset := CharOffset;
    for i := LineStarts.Count - 1 downto 0 do begin
      if Integer(LineStarts[i]) <= CharOffset then begin
        CodePos.CharOffset := CharOffset - Integer(LineStarts[i]) + 1;
        CodePos.LineNo := FirstLine + i + 1;
        break;
      end;
    end;
  end;

  procedure RemoveComment(var S : string);
  begin
    // Remove comment
    var Index := CharPos(S, WideChar('#'));
    if Index > 0 then
      S := Copy(S, 1, Index -1);
  end;

  function ProcessLineContinuation(var P : PWideChar; var Line : string;
    var LineNo: integer; LineStarts : TList): boolean;
  // Process continuation lines
  var
    ExplicitContinuation, ImplicitContinuation : boolean;
    NewLine : string;
    TrimmedLine : string;
    BracesCount : integer;
  begin
    BracesCount := 0;
    LineStarts.Clear;
    RemoveComment(Line);
    var Match:= fLineContinueRE.Match(Line);
    ExplicitContinuation := Match.Success;
    ImplicitContinuation := not ExplicitContinuation  and
      HaveImplicitContinuation(Line, BracesCount);
    Result := ExplicitContinuation or ImplicitContinuation;

    while (ExplicitContinuation or ImplicitContinuation) and (P^ <> WideChar(#0)) do begin
      if ExplicitContinuation then
        // Drop the continuation char
        Line := Copy(Line, 1, getGroupOffset(Match, 0) - 1);
      LineStarts.Add(Pointer(Length(Line)+2));
      GetLine(P, NewLine, LineNo);
      RemoveComment(NewLine);
      TrimmedLine := Trim(NewLine);
      if ExplicitContinuation and (TrimmedLine='') then break;
      // issue 212
      if StrIsLeft(PWideChar(TrimmedLine), 'class ') or StrIsLeft(PWideChar(TrimmedLine), 'def ') then break;

      Line := Line + WideChar(' ') + NewLine;
      Match:= fLineContinueRE.Match(Line);
      ExplicitContinuation := Match.Success;
      ImplicitContinuation := not ExplicitContinuation  and
        HaveImplicitContinuation(NewLine, BracesCount);
    end;
  end;

  function GetActiveClass(CodeElement : TBaseCodeElement) : TParsedClass;
  begin
    while Assigned(CodeElement) and (CodeElement.ClassType <> TParsedClass) do
      CodeElement := CodeElement.Parent;
    Result := TParsedClass(CodeElement);
  end;

  procedure ReplaceQuotedChars(var Source : string);
  //  replace quoted \ ' " with **
  Var
    pRes, pSource : PWideChar;
  begin
    if Length(Source) = 0 then Exit;
    pRes := PWideChar(Source);
    pSource := PWideChar(Source);
    while pSource^ <> WideChar(#0) do begin
      if (pSource^ = WideChar('\')) then begin
        Inc(pSource);
        if CharInSet(pSource^, ['\', '''', '"']) then begin
          pRes^ := WideChar('*');
          Inc(pRes);
          pRes^ := WideChar('*');
        end else
          Inc(pRes);
      end;
      inc(pSource);
      inc(pRes);
    end;
  end;

  procedure MaskStringsAndComments(var Source : string);
  // Replace all chars in strings and comments with *
  Type
    TParseState = (psNormal, psInTripleSingleQuote, psInTripleDoubleQuote,
    psInSingleString, psInDoubleString, psInComment);
  Var
    pRes, pSource : PWideChar;
    ParseState : TParseState;
  begin
    if Length(Source) = 0 then Exit;
    pRes := PWideChar(Source);
    pSource := PWideChar(Source);
    ParseState := psNormal;
    while pSource^ <> #0 do begin
      case pSource^ of
        WideChar('"') :
           case ParseState of
             psNormal :
               if StrIsLeft(psource + 1, '""') then begin
                 ParseState := psInTripleDoubleQuote;
                 Inc(pRes,2);
                 Inc(pSource, 2);
               end else
                 ParseState := psInDoubleString;
             psInTripleSingleQuote,
             psInSingleString,
             psInComment :
               pRes^ := MaskChar;
             psInTripleDoubleQuote :
               if StrIsLeft(psource + 1, '""') then begin
                 ParseState := psNormal;
                 Inc(pRes,2);
                 Inc(pSource, 2);
               end else
                 pRes^ := MaskChar;
             psInDoubleString :
               ParseState := psNormal;
           end;
        WideChar(''''):
           case ParseState of
             psNormal :
               if StrIsLeft(psource + 1, '''''') then begin
                 ParseState := psInTripleSingleQuote;
                 Inc(pRes, 2);
                 Inc(pSource, 2);
               end else
                 ParseState := psInSingleString;
             psInTripleDoubleQuote,
             psInDoubleString,
             psInComment :
               pRes^ := MaskChar;
             psInTripleSingleQuote :
               if StrIsLeft(psource + 1, '''''') then begin
                 ParseState := psNormal;
                 Inc(pRes, 2);
                 Inc(pSource, 2);
               end else
                 pRes^ := MaskChar;
             psInSingleString :
               ParseState := psNormal;
           end;
        WideChar('#') :
          if ParseState = psNormal then
            ParseState := psInComment
          else
            pRes^ := MaskChar;
        WideChar(#10), WideChar(#13):
          begin
            if ParseState in [psInSingleString, psInDoubleString, psInComment] then
              ParseState := psNormal;
          end;
        WideChar(' '),
        WideChar(#9) : {do nothing};
      else
        if ParseState <> psNormal then
          pRes^ := MaskChar;
      end;
      inc(pSource);
      inc(pRes);
    end;
  end;

var
  P, CodeStartP : PWideChar;
  LineNo, Indent, Index, CharOffset, CharOffset2, LastLength, Semicolon : integer;
  CodeStart : integer;
  Line, Param, AsgnTargetList, S, SourceLine, LeftS, RightS, Typ, CommentChars : string;
  Stop, IsFinal : Boolean;
  CodeElement, LastCodeElement, Parent : TCodeElement;
  ModuleImport : TModuleImport;
  Variable : TVariable;
  Klass : TParsedClass;
  LineStarts: TList;
  GlobalList : TStringList;
  AsgnTargetCount : integer;
  isClassMethod: boolean;
  isStaticMethod: boolean;
  isAbstractMethod: boolean;
  initialComment: boolean;
  ClassStaticMethodStart: integer;
  LastNotEmptyLine: integer;
begin
  SourceLines := nil;
  ClassStaticMethodStart:= 0;
  LastNotEmptyLine:= 0;
  isClassMethod:= false;
  isStaticMethod:= false;
  isAbstractMethod:= false;

  LineStarts := TSmartPtr.Make(TList.Create)();
  GlobalList := TSmartPtr.Make(TStringList.Create)();
  GlobalList.CaseSensitive := True;
  UseModifiedSource := True;

  Module.Clear;
  Module.fCodeBlock.StartLine := 1;
  Module.fIndent := -1;  // so that everything is a child of the module

  // Change \" \' and \\ into ** so that text searches
  // for " and ' won't hit escaped ones
  //Module.fMaskedSource := fEscapedQuotesRE.Replace(Source, '**', False);
  Module.fMaskedSource := Copy(Module.fSource, 1, MaxInt);
  ReplaceQuotedChars(Module.fMaskedSource);

  // Replace all chars in strings and comments with *
  // This ensures that text searches don't mistake comments for keywords, and that all
  // matches are in the same line/comment as the original
  MaskStringsAndComments(Module.fMaskedSource);

  P := PWideChar(Module.fMaskedSource);
  LineNo := 0;
  Stop := False;

  LastCodeElement := Module;
  initialComment:= true;
  CommentChars:= '';

  while not Stop and (P^ <> #0) do begin
    GetLine(P, Line, LineNo);

    // skip blank lines and comment lines
    if Length(Line) = 0 then
      continue;
    var BLMatch:= fBlankLineRE.Match(Line);
    if BLMatch.Success then begin
      if CommentChars = '' then
        CommentChars:= getGroup(BLMatch, 1);
      if initialComment and (CommentChars <> '#') then
        LastCodeElement.fCodeBlock.LastCommentLine:= LineNo;
      continue;
    end;

    // skip comments
    if fCommentLineRE.IsMatch(Line) then begin
      if CommentChars = '' then
        CommentChars:= '#';
      if initialComment and (CommentChars = '#') then
          LastCodeElement.fCodeBlock.LastCommentLine:= LineNo;
      continue;
    end;
    CommentChars:= '';

    initialComment:= false;
    CodeStartP := P;
    CodeStart := LineNo;
    // Process continuation lines
    ProcessLineContinuation(P, Line, LineNo, LineStarts);

    var CodeMatch:= fCodeRe.Match(Line);
    if CodeMatch.Success then begin
      // found class or function definition
      GlobalList.Clear;

      S := getGroup(CodeMatch, 5);
      if getGroup(CodeMatch, 2) = 'class' then begin
        // class definition
        CodeElement := TParsedClass.Create;
        TParsedClass(CodeElement).fSuperClasses.CommaText := S;
        initialComment:= true;
      end else begin
        // function or method definition
        CodeElement := TParsedFunction.Create;
        initialComment:= true;
        TParsedFunction(CodeElement).ReturnType := getGroup(CodeMatch, 7);
        TParsedFunction(CodeElement).isStaticMethod:= isStaticMethod;
        TParsedFunction(CodeElement).isClassMethod:= isClassMethod;
        TParsedFunction(CodeElement).isAbstractMethod:= isAbstractMethod;
        isStaticMethod:= false;
        isClassMethod:= false;
        isAbstractMethod:= false;

        if S <> '' then begin
          CharOffset := getGroupOffset(CodeMatch, 5);
          LastLength := Length(S);
          Param := GetParameter(S);
          CharOffset2 := CalcIndent(Param);
          Param := Trim(Param);
          Index := 0;
          While Param <> '' do begin
            Variable := TVariable.Create;
            Variable.Parent := CodeElement;
            CharOffsetToCodePos(CharOffset + CharOffset2, CodeStart, LineStarts, Variable.fCodePos);
            if StrIsLeft(PWideChar(Param), '**') then begin
              Variable.Name := Copy(Param, 3, Length(Param) -2);
              Include(Variable.Attributes, vaStarStarArgument);
            end else if Param[1] = '*' then begin
              Variable.Name := Copy(Param, 2, Length(Param) - 1);
              Include(Variable.Attributes, vaStarArgument);
            end else begin
              Index := CharPos(Param, WideChar('='));
              if Index > 0 then begin
                Variable.Name := Trim(Copy(Param, 1, Index - 1));
                Variable.DefaultValue := Copy(Param, Index + 1, Length(Param) - Index);
                if Variable.DefaultValue.Length > 0 then begin
                  // Deal with string arguments (Issue 32)
                  if CharPos(Variable.DefaultValue, MaskChar) > 0 then begin
                    SourceLine := GetNthSourceLine(Variable.fCodePos.LineNo);
                    Variable.DefaultValue :=
                      Copy(SourceLine, Variable.CodePos.CharOffset + Index, Length(Variable.DefaultValue));
                  end;
                  Variable.DefaultValue := Trim(Variable.DefaultValue);

                  Include(Variable.Attributes, vaArgumentWithDefault);
                  Variable.ObjType := GetExpressionType(Variable.DefaultValue, Variable.Attributes);
                  Variable.aType:= '';
                end;
              end else begin
                Variable.Name := Param;
                Include(Variable.Attributes, vaArgument);
              end;
            end;
            // Deal with string annotations (Issue 511)
            if CharPos(Variable.Name, MaskChar) > 0 then begin
              SourceLine := GetNthSourceLine(Variable.fCodePos.LineNo);
              Variable.Name :=
                Copy(SourceLine, Variable.CodePos.CharOffset, Length(Variable.Name));
            end;
            if StrSplit(':', Variable.Name, LeftS, RightS) then begin
              Variable.Name := TrimRight(LeftS);
              Variable.ObjType := Trim(RightS);
              Variable.aType:= Variable.ObjType;
            end;
            TParsedFunction(CodeElement).fArguments.Add(Variable);

            Inc(CharOffset,  LastLength - Length(S));
            LastLength := Length(S);
            Param := GetParameter(S);
            CharOffset2 := CalcIndent(Param);
            Param := Trim(Param);
          end;
        end;
      end;

      CodeElement.Name := getGroup(CodeMatch, 3);
      CodeElement.fCodePos.LineNo := CodeStart;
      CodeElement.fCodePos.CharOffset := getGroupOffset(CodeMatch, 3);

      CodeElement.fIndent := CalcIndent(getGroup(CodeMatch, 1));
      CodeElement.fCodeBlock.StartLine := CodeStart;
      if ClassStaticMethodStart > 0 then begin
        CodeElement.fCodeBlock.StartLine := ClassStaticMethodStart;
        ClassStaticMethodStart:= 0;
      end;

      // Decide where to insert CodeElement
      if CodeElement.Indent > LastCodeElement.Indent then
        LastCodeElement.AddChild(CodeElement)
      else begin
        LastCodeElement.fCodeBlock.EndLine := LastNotEmptyLine; // Pred(CodeStart);
        Parent := LastCodeElement.Parent as TCodeElement;
        while Assigned(Parent) do begin
          // Note that Module.Indent = -1
          if Parent.Indent < CodeElement.Indent then begin
            Parent.AddChild(CodeElement);
            break;
          end else
            Parent.fCodeBlock.EndLine := Pred(CodeStart);
          Parent := Parent.Parent as TCodeElement;
        end;
      end;
      LastCodeElement := CodeElement;
      LastNotEmptyLine:= LineNo;
    end else begin
      // Close Functions and Classes based on indentation
      Indent := CalcIndent(Line);
      while Assigned(LastCodeElement) and (LastCodeElement.Indent >= Indent) do begin
        // Note that Module.Indent = -1
        LastCodeElement.fCodeBlock.EndLine := LastNotEmptyLine; // Pred(LineNo);
        LastCodeElement := LastCodeElement.Parent as TCodeElement;
      end;
      if LastCodeElement.fCodeBlock.LastCommentLine = 0 then
        LastCodeElement.fCodeBlock.LastCommentLine:=
          LastCodeElement.fCodeBlock.StartLine;

      LastNotEmptyLine:= LineNo;
      // search for imports
      var ImportMatch:= fImportRE.Match(Line);
      var FromImportMatch:= fFromImportRE.Match(Line);
      var AssignmentMatch:= fAssignmentRE.Match(Line);
      var ForMatch:= fForRE.Match(Line);
      var ReturnMatch:= fReturnRE.Match(Line);
      var WithMatch:= fWithRE.Match(Line);
      var GlobalMatch:= fGlobalRE.Match(Line);
      if ImportMatch.Success then begin
        // Import statement
        S := getGroup(ImportMatch, 2);
        CharOffset := getGroupOffset(ImportMatch, 1);
        LastLength := Length(S);
        Param := StrToken(S, ',');
        While Param <> '' do begin
          var AliasMatch:= fAliasRE.Match(Param);
          if AliasMatch.Success then begin
            if getGroup(AliasMatch, 3) <> '' then begin
              Param := getGroup(AliasMatch, 3);
              CharOffset2 := getGroupOffset(AliasMatch, 3) - 1;
            end else begin
              Param := getGroup(AliasMatch, 1);
              CharOffset2 := getGroupOffset(AliasMatch, 1) - 1;
            end;
            ModuleImport := TModuleImport.Create(Param, CodeBlock(CodeStart, LineNo));
            CharOffsetToCodePos(CharOffset + CharOffset2, CodeStart, LineStarts, ModuleImport.fCodePos);
            ModuleImport.Parent := Module;
            if getGroup(AliasMatch, 3) <> '' then
              ModuleImport.fRealName := getGroup(AliasMatch, 1);
            Module.fImportedModules.Add(ModuleImport);
          end;
          Inc(CharOffset,  LastLength - Length(S));
          LastLength := Length(S);
          Param := StrToken(S, ',');
        end;
      end else if FromImportMatch.Success then begin
        // From Import statement
        ModuleImport := TModuleImport.Create(getGroup(FromImportMatch, 2),
          CodeBlock(CodeStart, LineNo));
        ModuleImport.fPrefixDotCount := FromImportMatch.Groups[1].Length;
        ModuleImport.fCodePos.LineNo := CodeStart;
        ModuleImport.fCodePos.CharOffset := getGroupOffset(FromImportMatch, 2);
        S := getGroup(FromImportMatch, 3);
        if Trim(S) = '*' then
          ModuleImport.ImportAll := True
        else begin
          ModuleImport.ImportedNames := TObjectList.Create(True);
          CharOffset := getGroupOffset(FromImportMatch, 3);
          if Pos('(', S) > 0 then begin
            Inc(CharOffset);
            S := StrRemoveChars(S, ['(',')']); //from module import (a,b,c) form
          end;
          LastLength := Length(S);
          Param := StrToken(S, ',');
          While Param <> '' do begin
            var AliasMatch:= fAliasRE.Match(Param);
            if AliasMatch.Success then begin
              if getGroup(AliasMatch, 3) <> '' then begin
                Param := getGroup(AliasMatch, 3);
                CharOffset2 := getGroupOffset(AliasMatch, 3) - 1;
              end else begin
                Param := getGroup(AliasMatch, 1);
                CharOffset2 := getGroupOffset(AliasMatch, 1) - 1;
              end;
              Variable := TVariable.Create;
              Variable.Name := Param;
              CharOffsetToCodePos(CharOffset + CharOffset2, CodeStart, LineStarts, Variable.fCodePos);
              Variable.Parent := ModuleImport;
              Include(Variable.Attributes, vaImported);
              if getGroup(AliasMatch, 3) <> '' then
                Variable.fRealName := getGroup(AliasMatch, 1);
              ModuleImport.ImportedNames.Add(Variable);
            end;
            Inc(CharOffset,  LastLength - Length(S));
            LastLength := Length(S);
            Param := StrToken(S, ',');
          end;
        end;
        ModuleImport.Parent := Module;
        Module.fImportedModules.Add(ModuleImport);
      end else if AssignmentMatch.Success then begin
        S := Copy(Line, 1, getGroupOffset(AssignmentMatch, 8)-1);
        AsgnTargetList := StrToken(S, '=');
        CharOffset2 := 1; // Keeps track of the end of the identifier
        while AsgnTargetList <> '' do begin
          AsgnTargetCount := 0;
          Variable := nil;
          while AsgnTargetList <> '' do begin
            Param := StrToken(AsgnTargetList, ',');
            CharOffset := CharOffset2;  // Keeps track of the start of the identifier
            Inc(CharOffset, CalcIndent(Param, 1)); // do not expand tabs
            Inc(CharOffset2, Succ(Length(Param))); // account for ,
            Param := Trim(Param);
            // Typ and Final
            Typ:= '';
            IsFinal:= false;
            Semicolon:= Pos(':', Param);
            if Semicolon > 0 then begin
              Typ:= trim(copy(Param, Semicolon + 1, length(Param)));
              Param:= trim(copy(Param, 1, Semicolon - 1));
              if Typ = 'Final' then begin
                IsFinal:= true;
                Typ:= ''
              end else if StrIsLeft(PWideChar(Typ), 'Final[') then begin
                IsFinal:= true;
                Typ:= Copy(Typ, 7, Length(Typ) - 7);
              end;
            end;

            if StrIsLeft(PWideChar(Param), 'self.') then begin
              // class variable
              Param := Copy(Param, 6, Length(Param) - 5);
              Inc(CharOffset, 5);  // Length of "self."

              // search for class attributes - only in constructor __init__
              if LastCodeElement.Name = '__init__' then begin
                Klass := GetActiveClass(LastCodeElement);
                if Assigned(Klass) then begin
                  Variable := TVariable.Create;
                  Variable.Name := Param;
                  Variable.Parent := Klass;
                  Variable.Typ := Typ;
                  Variable.IsFinal:= IsFinal;
                  CharOffsetToCodePos(CharOffset, CodeStart, LineStarts, Variable.fCodePos);
                  Klass.fAttributes.Add(Variable);
                  Inc(AsgnTargetCount);
                end;
              end;
            end else if (GlobalList.IndexOf(Param) < 0) then begin
              // search for local/global variables
              Variable := TVariable.Create;
              Variable.Name := Param;
              Variable.Parent := LastCodeElement;
              Variable.Typ := Typ;
              Variable.IsFinal:= IsFinal;

              CharOffsetToCodePos(CharOffset, CodeStart, LineStarts, Variable.fCodePos);
              if LastCodeElement.ClassType = TParsedFunction then begin
                if TParsedFunction(LastCodeElement).HasArgument(Variable.Name) then
                  FreeAndNil(Variable)
                else
                  TParsedFunction(LastCodeElement).Locals.Add(Variable);
              end else if LastCodeElement.ClassType = TParsedClass then begin
                Include(Variable.Attributes, vaClassAttribute);
                TParsedClass(LastCodeElement).Attributes.Add(Variable)
              end else begin
                Module.Globals.Add(Variable);
                if Variable.Name = '__all__' then begin
                  Line := GetNthSourceLine(CodeStart);
                  UseModifiedSource := False;
                  ProcessLineContinuation(CodeStartP, Line, CodeStart, LineStarts);
                  var ListMatch:= fListRE.Match(Line);
                  if ListMatch.Success then
                    Module.fAllExportsVar := getGroup(ListMatch, 1);
                  UseModifiedSource := True;
                end;
              end;
              Inc(AsgnTargetCount);
            end;
          end;
          // Variable Type if the assignment has a single target
          if Assigned(Variable) and (AsgnTargetCount = 1) then begin
            Variable.DefaultValue:= trim(getGroup(AssignmentMatch, 9));
            if Left(Variable.DefaultValue, 2) = '''`' then begin // a masked string
              SourceLine:= GetNthSourceLine(LineNo);
              Variable.DefaultValue:= trim(copy(SourceLine,
                                            getGroupOffset(AssignmentMatch, 9),
                                            getGroupLength(AssignmentMatch, 9)));
            end;
            Variable.ObjType := GetExpressionType(getGroup(AssignmentMatch, 9),
              Variable.Attributes);
          end;

          AsgnTargetList := StrToken(S, '=');
        end;
      end else if ForMatch.Success then begin
        AsgnTargetList := Copy(Line, getGroupOffset(ForMatch, 1),
          getGroupOffset(ForMatch, 3)-getGroupOffset(ForMatch, 1));
        CharOffset2 := getGroupOffset(ForMatch, 1); // Keeps track of the end of the identifier
        while AsgnTargetList <> '' do begin
          Param := StrToken(AsgnTargetList, ',');
          CharOffset := CharOffset2;  // Keeps track of the start of the identifier
          Inc(CharOffset, CalcIndent(Param, 1)); // do not expand tabs
          Inc(CharOffset2, Succ(Length(Param))); // account for ,
          Param := Trim(Param);
          if (GlobalList.IndexOf(Param) < 0) then begin
            // search for local/global variables
            Variable := TVariable.Create;
            Variable.Name := Param;
            Variable.Parent := LastCodeElement;
            CharOffsetToCodePos(CharOffset, CodeStart, LineStarts, Variable.fCodePos);
            if LastCodeElement.ClassType = TParsedFunction then
              TParsedFunction(LastCodeElement).Locals.Add(Variable)
            else if LastCodeElement.ClassType = TParsedClass then begin
              //  Do not add for variables to class
              Variable.Free;
            end else begin
              Module.Globals.Add(Variable);
            end;
          end;
        end;
      end else if ReturnMatch.Success then begin
        // only process first return statement
        if (LastCodeElement is TParsedFunction) and
          (TParsedFunction(LastCodeElement).ReturnType = '')
        then
          TParsedFunction(LastCodeElement).ReturnType :=
            GetExpressionType(getGroup(ReturnMatch, 1),
            TParsedFunction(LastCodeElement).ReturnAttributes);
      end else if WithMatch.Success then begin
        Variable := TVariable.Create;
        Variable.Name := getGroup(WithMatch, 3);
        Variable.Parent := LastCodeElement;
        Variable.fCodePos.LineNo := LineNo;
        Variable.fCodePos.CharOffset := getGroupOffset(WithMatch, 3);
        Variable.ObjType := getGroup(WithMatch, 1);
        if getGroup(WithMatch, 2) <> '' then
          Include(Variable.Attributes, vaCall);
        if LastCodeElement.ClassType = TParsedFunction then
          TParsedFunction(LastCodeElement).Locals.Add(Variable)
        else if LastCodeElement.ClassType = TParsedClass then begin
          Include(Variable.Attributes, vaClassAttribute);
          TParsedClass(LastCodeElement).Attributes.Add(Variable)
        end else
          Module.Globals.Add(Variable);
      end else if GlobalMatch.Success then begin
        S := getGroup(GlobalMatch, 1);
        while S <> '' do
          GlobalList.Add(Trim(StrToken(S, ',')));
      end else if fStaticMethodRE.IsMatch(Line) then begin
        IsStaticMethod:= true;
        if ClassStaticMethodStart = 0 then
          ClassStaticMethodStart:= LineNo;
      end else if fClassMethodRE.IsMatch(Line) then begin
        isClassMethod:= true;
        if ClassStaticMethodStart = 0 then
          ClassStaticMethodStart:= LineNo;
      end else if fAbstractMethodRE.IsMatch(Line) then begin
        isAbstractMethod:= true;
        if ClassStaticMethodStart = 0 then
          ClassStaticMethodStart:= LineNo;
      end;
    end;
    DoScannerProgress(P - PWideChar(Module.fMaskedSource), Length(Module.fMaskedSource), Stop);
  end;
  // Account for blank line in the end;
  if Length(Module.fMaskedSource) > 0 then begin
    Dec(P);
    if CharInSet(P^, [#10, #13]) then
      Inc(LineNo);
  end;
  while Assigned(LastCodeElement) do begin
    LastCodeElement.fCodeBlock.EndLine := LastNotEmptyLine; // Max(LineNo, LastCodeElement.fCodeBlock.StartLine);
    LastCodeElement := LastCodeElement.Parent as TCodeElement;
  end;

  Result := not Stop;
end;

{ TParsedModule }

constructor TParsedModule.Create;
begin
   inherited;
   fImportedModules := TObjectList.Create(True);
   fGlobals := TObjectList.Create(True);
   fCodePos.LineNo := 1;
   fCodePos.CharOffset := 1;
end;

procedure TParsedModule.Clear;
begin
  //fSource := '';
  fMaskedSource := '';
  if Assigned(fChildren) then
    fChildren.Clear;
  fImportedModules.Clear;
  fGlobals.Clear;
  inherited;
end;

constructor TParsedModule.Create(const Source: string);
begin
  Create;
  fSource := Source;
end;

constructor TParsedModule.Create(const FName, Source: string);
begin
  Create(Source);
  FileName := FName;
end;

destructor TParsedModule.Destroy;
begin
  fImportedModules.Free;
  fGlobals.Free;
  inherited;
end;

function CompareVariables(Item1, Item2: Pointer): Integer;
begin
  Result := CompareStr(TVariable(Item1).Name, TVariable(Item2).Name);
end;

procedure TParsedModule.GetUniqueSortedGlobals(GlobalsList: TObjectList);
Var
  i, j : integer;
  HasName : boolean;
begin
  for i := 0 to fGlobals.Count - 1 do begin
    HasName := False;
    for j := 0 to GlobalsList.Count - 1 do
      if (TVariable(fGlobals[i]).Name = TVariable(GlobalsList[j]).Name) then begin
        HasName := True;
        break;
      end;
    if not HasName then
      GlobalsList.Add(fGlobals[i]);
  end;
  GlobalsList.Sort(CompareVariables);
end;

procedure TParsedModule.SetFileName(const Value: string);
begin
  fFileName := Value;
  Name := FileNameToModuleName(Value);
end;

function CompareImports(Item1, Item2: Pointer): Integer;
begin
  Result := CompareStr(TModuleImport(Item1).Name, TModuleImport(Item2).Name);
end;

procedure TParsedModule.GetSortedImports(ImportsList: TObjectList);
Var
  i : integer;
begin
  for i := 0 to ImportedModules.Count - 1 do
    ImportsList.Add(ImportedModules[i]);
  ImportsList.Sort(CompareImports);
end;



function TParsedModule.GetIsPackage: boolean;
begin
  Result := FileIsPythonPackage(fFileName);
end;

function TParsedModule.GetAllExportsVar: string;
begin
  Result := fAllExportsVar;
end;

{ TModuleImport }

constructor TModuleImport.Create(AName : string; CB : TCodeBlock);
begin
  inherited Create;
  Name := AName;
  fCodeBlock := CB;
  ImportAll := False;
  ImportedNames := nil;
end;

destructor TModuleImport.Destroy;
begin
  FreeAndNil(ImportedNames);
  inherited;
end;

function TModuleImport.GetRealName: string;
begin
  if fRealName <> '' then
    Result := fRealName
  else
    Result := Name;
end;

{ TParsedFunction }

function TParsedFunction.ArgumentsString: string;
  function FormatArgument(Variable : TVariable) : string;
  begin
    if vaStarArgument in Variable.Attributes then
      Result := '*' + Variable.Name
    else if vaStarStarArgument in Variable.Attributes then
      Result := '**' + Variable.Name
    else
      Result := Variable.Name;
    if Variable.ObjType <> '' then
      Result := Result + ': ' + Variable.ObjType;
    if vaArgumentWithDefault in Variable.Attributes then
      Result := Result + '=' + Variable.DefaultValue;
  end;

Var
  i : integer;
begin
  Result:= '';
  if fArguments.Count > 0 then begin
    Result := FormatArgument(TVariable(fArguments[0]));
    for i := 1 to fArguments.Count - 1 do
      Result := Result + ', ' + FormatArgument(TVariable(Arguments[i]));
  end;
end;

constructor TParsedFunction.Create;
begin
  inherited;
  fLocals := TObjectList.Create(True);
  fArguments := TObjectList.Create(True);
end;

destructor TParsedFunction.Destroy;
begin
  FreeAndNil(fLocals);
  FreeAndNil(fArguments);
  inherited;
end;

procedure TParsedFunction.GetNameSpace(SList: TStringList);
Var
  i : integer;
begin
  inherited;
  // Add Locals
  for i := 0 to fLocals.Count - 1 do
    SList.AddObject(TVariable(fLocals[i]).Name, fLocals[i]);
  // Add arguments
  for i := 0 to fArguments.Count - 1 do
    SList.AddObject(TVariable(fArguments[i]).Name, fArguments[i]);
end;

function TParsedFunction.HasArgument(Name: string): Boolean;
var
  Variable : TObject;
begin
  Result := False;
  for Variable in fArguments do
    if (Variable as TVariable).Name = Name then begin
      Result := True;
      Exit;
    end;
end;

{ TParsedClass }

constructor TParsedClass.Create;
begin
  inherited;
  fSuperClasses := TStringList.Create;
  fSuperClasses.CaseSensitive := True;
  fSuperClasses.StrictDelimiter := True;
  fAttributes := TObjectList.Create(True);
end;

destructor TParsedClass.Destroy;
begin
  FreeAndNil(fSuperClasses);
  FreeAndNil(fAttributes);
  inherited;
end;

function CodeBlock(StartLine, EndLine : integer) : TCodeBlock;
begin
  Result.StartLine := StartLine;
  Result.EndLine := EndLine;
end;

function GetExpressionType(Expr: string; var VarAtts: TVariableAttributes): string;
Var
  IsBuiltInType : Boolean;
begin
  if Expr.Length = 0 then Exit('');

  var Match:= TPyRegExpr.FunctionCallRE.Match(Expr);
  if Match.Success then begin
    Result := getGroup(Match, 1);
    if getGroup(Match, 2) <> '' then  //= '('
    Include(VarAtts, vaCall);
  end else begin
    Result := GetExpressionBuiltInType(Expr, IsBuiltInType);
    if IsBuiltInType then
      Include(VarAtts, vaBuiltIn);
  end;
end;

function GetExpressionBuiltInType(Expr : string; Var IsBuiltIn : boolean) : string;
Var
  i :  integer;
begin
  Result := '';
  IsBuiltIn := False;

  Expr := Trim(Expr);
  if (Expr = '') or (Word(Expr[1]) > $FF) then Exit;

  IsBuiltIn := True;
  case Expr[1] of
    '"','''' : Result := 'str';
    '0'..'9', '+', '-' :
      begin
        Result := 'int';
        for i := 2 to Length(Expr) - 1 do begin
          if Expr[i] = '.' then begin
            Result := 'float';
            break;
          end else if not CharInSet(Expr[i], ['0'..'9', '+', '-']) then
            break;
        end;
      end;
    '{' :
      if (CharPos(Expr, ',') = 0) or (CharPos(Expr, ':') <> 0) then
        Result := 'dict'
      else
        Result := 'set';
    '[': Result := 'list';
  else
    if (Expr[1] = '(') and (CharPos(Expr, ',') <> 0) then
      Result := 'tuple'  // speculative
    else
      IsBuiltIn := False;
  end;
end;

{ TBaseCodeElement }

function TBaseCodeElement.GetDottedName: string;
// Unique name in dotted notation;
begin
  if Assigned(Parent) then
    Result := Parent.GetDottedName + '.' + Name
  else
    Result := Name;
end;

function TBaseCodeElement.GetModule: TParsedModule;
begin
  Result := GetRoot as TParsedModule;
end;

function TBaseCodeElement.GetModuleSource: string;
var
  ParsedModule : TParsedModule;
begin
  ParsedModule := GetModule;
  if Assigned(ParsedModule) then
    Result := ParsedModule.Source
  else
    Result := '';
end;

function TBaseCodeElement.GetRoot: TBaseCodeElement;
begin
  Result := self;
  while Assigned(Result.fParent) do
    Result := Result.fParent;
end;

{ TVariable }
function TVariable.GetRealName: string;
begin
  if fRealName <> '' then
    Result := fRealName
  else
    Result := Name;
end;

{ TAsynchSourceScanner }

constructor TAsynchSourceScanner.Create(const FileName, Source: string);
begin
  inherited Create;
  fParsedModule := TParsedModule.Create(FileName, Source);
  fPythonScanner := TPythonScanner.Create;
  fPythonScanner.OnScannerProgress := ScanProgress;
  fFuture := TTask.Future<TParsedModule>(Self, FutureTask);
end;

destructor TAsynchSourceScanner.Destroy;
begin
  inherited;
  fFuture.Wait;
  FreeAndNil(fParsedModule);
  FreeAndNil(fPythonScanner);
  inherited;
end;

function TAsynchSourceScanner.Finished: Boolean;
begin
  Result := fFuture.Status in [TTaskStatus.Completed, TTaskStatus.Exception];
end;

function TAsynchSourceScanner.GetParsedModule: TParsedModule;
begin
  Result := fFuture.Value;
end;

procedure TAsynchSourceScanner.ScanProgress(CharNo, NoOfChars: integer;
  var Stop: Boolean);
begin
  if fStopped then Stop := True;
end;

procedure TAsynchSourceScanner.StopScanning;
begin
  fStopped := True;
end;

function TAsynchSourceScanner.FutureTask(Sender : TObject) : TParsedModule;
begin
  StopWatch.Reset; //
  StopWatch.Start;
  if not fPythonScanner.ScanModule(fParsedModule) then
    FreeAndNil(fParsedModule);
  Result := fParsedModule;
  StopWatch.Stop;
  OutputDebugString(PWideChar(Format('ScanModule time in ms: %d', [StopWatch.ElapsedMilliseconds])));
end;

{ TAsynchSourceScannerFactory }

procedure TAsynchSourceScannerFactory.ClearFinished;
var
  i : integer;
  Scanner :  IAsyncSourceScanner;
begin
  fIList.Lock;
  try
    for i := fIList.Count - 1 downto 0 do begin
      Scanner := IAsyncSourceScanner(fIList[i]);
      if Scanner.Finished then
        fIList.Delete(i);
    end;
  finally
    fIList.UnLock;
  end;
end;

constructor TAsynchSourceScannerFactory.Create;
begin
  inherited;
  fIList := TInterfaceList.Create;
end;

function TAsynchSourceScannerFactory.CreateAsynchSourceScanner(const FileName,
  Source: string): IAsyncSourceScanner;
begin
  ClearFinished;
  Result := TAsynchSourceScanner.Create(FileName, Source);
  fIList.Add(Result);
end;

destructor TAsynchSourceScannerFactory.Destroy;
begin
  while fIList.Count > 0 do begin
    ClearFinished;
    Sleep(10);  // wait for threads to finish
  end;
  fIList.Free;
  inherited;
end;

procedure TAsynchSourceScannerFactory.ReleaseScanner(
  Scanner: IAsyncSourceScanner);
begin
  fIList.Remove(Scanner);
end;

initialization
  DocStringRE.Create('(?sm)^[ \t]*[ur]?(\"\"\"(.*?)\"\"\"|''''''(.*?)'''''')');
  DocStringRE.Study;

  AsynchSourceScannerFactory := TAsynchSourceScannerFactory.Create;
finalization
  FreeAndNil(AsynchSourceScannerFactory);
end.
