{-------------------------------------------------------------------------------
 Unit:     UStructogram
 Author:   Gerhard Röhner
 Date:     March 2021
 Purpose:  generate a structogram from python code
-------------------------------------------------------------------------------}

unit UGenerateStructogram;

interface

uses UTypes, UPythonScanner, UPythonIntegrator;

type
  TGenerateStructogram = class(TPythonParser)
  private
    FStructogram: TStrList;
    FCurrent: TStrElement;
    Scanner: TPythonScannerWithTokens;

    procedure SkipTo(ch: char);
    procedure SkipToChars(ch: string);
    procedure ParseDecorators;
    function getNextToken: String;
    procedure SkipNewLines;
    procedure SkipMethod;
    function getExpression(Token: char): String;
    function getSimpleExpression: String;
    function IsIdentifier(s: string): Boolean;
    function CleanUp(s: string): string;
    function withoutTypes(s: string): string;
    function withoutLineJoining(s: String): string;
    function withoutLinefeeds(s: string): string;
    function withoutMultipleSpaces(s: String): string;
    function withoutComments(s: string): string;
    function withoutSelfAndVisibility(s: string): string;
    function KnownStatement(s: String): boolean;

    procedure GenerateStatement;
    procedure GenerateIfStatement;
    procedure GenerateWhileStatement;
    procedure GenerateForStatement;
    procedure GenerateWithStatement;
    procedure GenerateSuite;
    procedure GenerateSimpleStatement;
    procedure GenerateKnownSimpleStatement;
    procedure GenerateMethod;
    procedure GenerateMethodCall(const Method: string);
    procedure GenerateAssignmentOrExpression(const Ident: string);
  public
    constructor Create(aWithView: Boolean); override;
    destructor Destroy; override;
    procedure GenerateStructogram(const s: string; aStructogram: TStrList);
  end;

implementation

uses SysUtils, Character, UConfiguration, UUtils;

constructor TGenerateStructogram.Create;
begin
  inherited;
  Scanner:= TPythonScannerWithTokens.Create;
end;

procedure TGenerateStructogram.GenerateStructogram(const s: string; aStructogram: TStrList);
begin
  FStructogram:= aStructogram;
  FCurrent:= aStructogram;
  Scanner.Init(s);
  SkipNewLines;
  ParseDecorators;
  // function
  if Scanner.Token = 'def' then
    GenerateMethod
  else
  // statement sequence
    while Scanner.Token <> '' do begin
      ParseDecorators;
      if (Scanner.Token = 'class') or (Scanner.Token = 'def')
        then break // only one global function
        else GenerateStatement;
    end;
end;

destructor TGenerateStructogram.Destroy;
begin
  FreeAndNil(Scanner);
end;

function TGenerateStructogram.getNextToken: String;
begin
  Result:= Scanner.GetNextToken;
end;

procedure TGenerateStructogram.SkipNewLines;
begin
  while Scanner.Token = NEWLINE do
    GetNextToken;
end;

procedure TGenerateStructogram.SkipMethod;
  var TempFCurrent, tmp: TStrElement;
begin
  SkipTo(':');
  GetNextToken;
  TempFCurrent:= FCurrent;
  FCurrent:= TStrElement.Create(nil);
  GenerateSuite;
  while FCurrent <> nil do begin
    tmp:= FCurrent.prev;
    FreeAndNil(FCurrent);
    FCurrent:= tmp;
  end;
  FCurrent:= TempFCurrent;
end;

procedure TGenerateStructogram.SkipTo(ch: char);
begin
  Scanner.SkipTo(ch);
end;

procedure TGenerateStructogram.SkipToChars(ch: string);
begin
  Scanner.SkipToChars(ch);
end;

function TGenerateStructogram.IsIdentifier(s: string): Boolean;
begin
  Result := False;
  var I := Pos('<', s);
  if I > 0 then
    Delete(s, I, length(s));
  if length(s) = 0 then
    exit;
  if not (s[1].isLetter or (s[1] = '_')) then
    exit;
  for I := 2 to length(s) do
    if not (s[i].IsLetterOrDigit or (Pos(s[i], '_,[]<>') > 0)) then
      exit;
  if s[length(s)] = '.' then
    exit;
  Result := not IsReservedWord(s);
end;

procedure TGenerateStructogram.ParseDecorators;
begin
  while Scanner.Token = '@' do begin
    SkipTo(NEWLINE);
    GetNextToken;
  end;
  SkipNewLines;
end;

function TGenerateStructogram.CleanUp(s: string): string;
begin
  Result:= trim(
           withoutSelfAndVisibility(
           withoutMultipleSpaces(
           withoutLineFeeds(
           withoutLineJoining(
           withoutComments(s))))));
end;

function TGenerateStructogram.getExpression(Token: Char): String;
  var Start: PChar;
begin
  Start:= Scanner.CurrPos;
  SkipTo(Token);
  setString(Result, Start, Scanner.CurrPos - Start - 1);
  Result:= CleanUp(Result);
end;

function TGenerateStructogram.getSimpleExpression: String;
  var Start: PChar;
begin
  Start:= Scanner.LastCurrPos;
  SkipToChars(NEWLINE + ';');
  setString(Result, Start, Scanner.CurrPos - Start - 1);
  Result:= CleanUp(Result);
end;

function TGenerateStructogram.withoutTypes(s: string): string;
  var i, p1, p2: integer;
begin
  i:= 1;
  while i <= Length(s) do begin
    if s[i] = ':' then begin
      p1:= i;
      p2:= i + 1;
      while p2 <= Length(s) do begin
        if s[p2] = ',' then begin
          delete(s, p1, p2 - p1);
          break;
        end;
        if p2 = Length(s) then begin
          delete(s, p1, p2 - p1 + 1);
          break;
        end;
        inc(p2);
      end;
    end;
    inc(i);
  end;
  Result:= s;
end;

function TGenerateStructogram.withoutSelfAndVisibility(s: string): string;
begin
  Result:= myStringReplace(myStringReplace(s, 'self.', ''), '_', '');
end;

function TGenerateStructogram.withoutLineJoining(s: String): string;
begin
  Result:= myStringReplace(s, '\'#10, '');
end;

function TGenerateStructogram.withoutLinefeeds(s: string): string;
  var i: integer;
begin
  i:= 1;
  while i <= Length(s) do begin
    if s[i] = #10
      then Delete(s, i, 1)
      else inc(i);
  end;
  Result:= s;
end;

function TGenerateStructogram.withoutMultipleSpaces(s: String): string;
  var p, q: integer;
begin
  p:= Pos('  ', s);
  while p > 0 do begin
    q:= p + 1;
    while (q <= Length(s)) and (s[q] = ' ') do
      inc(q);
    delete(s, p, q - p - 1);
    p:= Pos('  ', s);
  end;
  Result:= s;
end;

function TGenerateStructogram.withoutComments(s: string): string;
  var p, q: integer; Double, Single: boolean;
begin
  Double:= false;
  Single:= false;
  p:= 1;
  while p <= Length(s) do begin
    if (s[p] = '"') and not Single then
      Double:= not Double
    else if (s[p] = '''') and not Double then
      Single:= not Single
    else if (s[p] = '#') and not Double and not Single then begin
      q:= p + 1;
      while (q <= Length(s)) and (s[q] <> #10) do
        inc(q);
      delete(s, p, q - p);
   end;
   inc(p);
  end;
  Result:= s;
end;

function TGenerateStructogram.KnownStatement(s: string): boolean;
  const Statements: array[1..13] of String =
         ('assert', 'break', 'pass', 'del', 'return', 'yield', 'raise',
          'continue', 'import', 'from', 'future', 'global', 'nonlocal');
  var i: integer;
begin
  Result:= false;
  for i:= 1 to 13 do
    if Statements[i] = s then
      Result:= true;
end;

procedure TGenerateStructogram.GenerateSuite;
begin
  if Scanner.Token = NEWLINE then begin
    SkipNewLines;
    if Scanner.Token = INDENT then begin
      GetNextToken;
      repeat
        GenerateStatement;
        SkipNewLines;
      until (Scanner.Token = DEDENT) or (Scanner.Token = '');
      GetNextToken;  // skip DEDENT
    end;
  end else begin
    GenerateSimpleStatement;
    while (Scanner.Token <> NEWLINE) and (Scanner.Token <> '') do
      GenerateSimpleStatement;
    if Scanner.Token = NEWLINE then
      GetNextToken;
  end;
end;

procedure TGenerateStructogram.GenerateStatement;
begin
  if Scanner.Token = '' then
    exit;
  if Scanner.Token = '@' then
    ParseDecorators;
  if Scanner.Token = 'async' then
    GetNextToken;
  if Scanner.Token = 'if' then
    GenerateIfStatement
  else if Scanner.Token = 'while' then
    GenerateWhileStatement
  else if Scanner.Token = 'for' then
    GenerateForStatement
  else if Scanner.Token = 'with' then
    GenerateWithStatement
  else if Scanner.Token = 'def' then
    SkipMethod
  else
    GenerateSimpleStatement;
end;

procedure TGenerateStructogram.GenerateIfStatement;
// 8.1
// if_stmt ::=  "if" assignment_expression ":" suite
//             ("elif" assignment_expression ":" suite)*
//             ["else" ":" suite]
  var elemIf: TStrIf; elemSwitch: TStrSwitch;
      Expression: String; CaseCount: integer;
      SavedFCurrent, FTemp: TStrElement;

  procedure GenerateEmptyStatement;
    var elem: TStrStatement;
  begin
    elem:= TStrStatement.create(FStructogram);
    FStructogram.insert(FCurrent, elem);
    elem.text:= '';
    FCurrent:= elem;
  end;

  procedure GenerateEnd;
  begin
    if Scanner.Token = 'else' then begin
      SkipTo(':');
      GetNextToken;
      GenerateSuite;
    end else
      GenerateEmptyStatement;
  end;

  procedure NewCase(text: string);
  begin
    inc(CaseCount);
    SetLength(elemSwitch.case_elems, CaseCount+1);
    elemSwitch.case_elems[CaseCount]:= TStrListHead.CreateStructogram(FStructogram, elemSwitch);
    elemSwitch.case_elems[CaseCount].text:= 'case ' + IntToStr(CaseCount) + ' head';
    elemSwitch.case_elems[CaseCount].next.text:= text;
    FCurrent:= elemSwitch.case_elems[CaseCount].next;
  end;

begin
  SavedFCurrent:= FCurrent;
  FCurrent:= TStrElement.Create(FStructogram);
  FTemp:= FCurrent;
  Expression:= getExpression(':');
  GetNextToken;
  GenerateSuite;
  if Scanner.Token = 'elif' then begin
    elemSwitch:= TStrSwitch.createStructogram(FStructogram);
    elemSwitch.text:= 'falls';  // ToDo falls?
    FStructogram.insert(SavedFCurrent, elemSwitch);
    FTemp.next.prev:= nil;
    CaseCount:= 0;
    SetLength(elemSwitch.case_elems, CaseCount + 1);

    elemSwitch.case_elems[0]:= TStrListHead.CreateStructogram(FStructogram, elemSwitch);
    elemSwitch.case_elems[0].text:= 'case ' + IntToStr(CaseCount) + ' head';
    elemSwitch.case_elems[0].next.text:= Expression;
    FStructogram.insert(elemSwitch.case_elems[0].next, FTemp.next);
    FreeAndNil(FTemp);
    while Scanner.Token = 'elif' do begin
      Expression:= getExpression(':');
      newCase(Expression);
      GetNextToken;
      GenerateSuite;
    end;
    newCase(GuiPyLanguageOptions.Other);
    GenerateEnd;
    FCurrent:= elemSwitch;
  end else begin
    elemIf:= TStrIf.createStructogram(FStructogram);
    FStructogram.insert(SavedFCurrent, elemIf);
    elemIf.Text:= Expression;
    if assigned(FTemp.next) then
      FTemp.next.prev:= nil;
    FStructogram.insert(elemIf.then_elem, FTemp.next);
    FreeAndNil(FTemp);
    FCurrent:= elemIf.else_elem;
    GenerateEnd;
    FCurrent:= elemIf;
  end;
end;

procedure TGenerateStructogram.GenerateWhileStatement;
// 8.2
// "while" assignment_expression ":" suite ["else" ":" suite]
  var elem: TStrWhile;
      Expression: String;
begin
  elem:= TStrWhile.createStructogram(FStructogram);
  FStructogram.insert(FCurrent, elem);
  Expression:= getExpression(':');
  elem.text:= GuiPyLanguageOptions._While + ' ' + Expression;
  FCurrent:= elem.do_elem;
  GetNextToken;
  GenerateSuite;
  FCurrent:= elem;
end;

procedure TGenerateStructogram.GenerateForStatement;
// 8.3
// for_stmt ::=  "for" target_list "in" expression_list ":" suite
//              ["else" ":" suite]

  var elem: TStrFor;
      Expression: String;
begin
  elem:= TStrFor.createStructogram(FStructogram);
  FStructogram.insert(FCurrent, elem);
  Expression:= getExpression(':');
  elem.text:= GuiPyLanguageOptions._For + ' ' + Expression;
  FCurrent:= elem.do_elem;
  GetNextToken;
  GenerateSuite;
  FCurrent:= elem;
end;

procedure TGenerateStructogram.GenerateWithStatement;
// 8.5
// with_stmt ::=  "with" with_item ("," with_item)* ":" suite
// with_item ::=  expression ["as" target]
  var elem: TStrWhile;
      Expression: String;
begin
  elem:= TStrWhile.createStructogram(FStructogram);
  FStructogram.insert(FCurrent, elem);
  Expression:= getExpression(':');
  elem.text:= GuiPyLanguageOptions._While + ' ' + Expression;
  FCurrent:= elem.do_elem;
  GetNextToken;
  GenerateSuite;
  FCurrent:= elem;
end;

procedure TGenerateStructogram.GenerateSimpleStatement;
  var Ident: string;
begin
  if KnownStatement(Scanner.Token) then
    GenerateKnownSimpleStatement
  else begin
    Ident:= Scanner.Token;
    if IsIdentifier(Ident) and (Scanner.LookAheadToken = '(')
      then GenerateMethodCall(Ident)
      else GenerateAssignmentOrExpression(Ident);
  end;
  if Scanner.Token = ';' then
    GetNextToken;
end;

procedure TGenerateStructogram.GenerateKnownSimpleStatement;
  var elem: TStrElement;
begin
  if Scanner.Token = 'break'
    then elem:= TStrBreak.create(FStructogram)
    else elem:= TStrStatement.create(FStructogram);
  FStructogram.insert(FCurrent, elem);
  elem.text:= getSimpleExpression;
  FCurrent:= elem;
end;

procedure TGenerateStructogram.GenerateMethodCall(const Method: string);
  var elem: TStrElement;
      Expression: string;
      p: integer;
begin
  Expression:= getSimpleExpression;
  if Method = 'print' then begin
    elem:= TStrStatement.create(FStructogram);
    p:= Pos('(', Expression); delete(Expression, 1, p);
    p:= length(Expression);
    while (p > 0) and (Expression[p] <> ')') do
      dec(p);
    delete(Expression, p, length(Expression));
    elem.text:= GuiPyLanguageOptions.Output + ' ' + Expression;
  end else begin
    elem:= TStrSubprogram.create(FStructogram);
    elem.text:= Expression;
  end;
  FStructogram.insert(FCurrent, elem);
  FCurrent:= elem;
end;

procedure TGenerateStructogram.GenerateAssignmentOrExpression(const Ident: string);
  var elem: TStrElement;
      Expression: string;
      p: integer;
begin
  elem:= TStrStatement.create(FStructogram);
  FStructogram.insert(FCurrent, elem);
  Expression:= getSimpleExpression;
  elem.text:= Expression;
  if (Pos('=', Expression) > 0) then begin
    p:= Pos('input(', Expression);
    if (p > 0) and ((p = 1) or IsWordBreakChar(Expression[p-1])) then
      elem.text:= GuiPyLanguageOptions.Input + ' ' + Ident
  end;
  FCurrent:= elem;
end;

procedure TGenerateStructogram.GenerateMethod;
  var Method, Expression: string;
begin
  Method:= GetNextToken;
  GetNextToken;
  Expression:= getExpression(')');
  if Left(Expression, 6) = 'self, ' then
    Expression:= copy(Expression, 7, length(Expression));
  Method:= Method + '(' + withoutTypes(Expression) + ')';
  FStructogram.text:= FStructogram.text + ' ' + Method;
  SkipTo(':');
  GetNextToken;
  GenerateSuite;
end;

end.
