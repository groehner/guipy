{ -------------------------------------------------------------------------------
  Unit:     UGenerateStructogram
  Author:   Gerhard Röhner
  Date:     March 2021
  Purpose:  generate a structogram from python code
  ------------------------------------------------------------------------------- }

unit UGenerateStructogram;

interface

uses
  UTypes,
  UPythonScanner,
  UPythonIntegrator;

type
  TGenerateStructogram = class(TPythonParser)
  private
    FStructogram: TStrList;
    FCurrent: TStrElement;
    FScanner: TPythonScannerWithTokens;

    procedure SkipTo(Chr: Char);
    procedure SkipToChars(const Chr: string);
    procedure ParseDecorators;
    function GetNextToken: string;
    procedure SkipNewLines;
    procedure SkipMethod;
    function GetExpression(Token: Char): string;
    function GetSimpleExpression: string;
    function IsIdentifier(Expression: string): Boolean;
    function CleanUp(const Expression: string): string;
    function WithoutTypes(const Expression: string): string;
    function WithoutLineJoining(const Expression: string): string;
    function WithoutLinefeeds(const Expression: string): string;
    function WithoutMultipleSpaces(const Expression: string): string;
    function WithoutComments(const Expression: string): string;
    function WithoutSelfAndVisibility(const Expression: string): string;
    function KnownStatement(const Expression: string): Boolean;

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
    constructor Create(WithView: Boolean); override;
    destructor Destroy; override;
    procedure GenerateStructogram(const Source: string; Structogram: TStrList);
  end;

implementation

uses
  SysUtils,
  Character,
  UConfiguration,
  UUtils;

constructor TGenerateStructogram.Create(WithView: Boolean);
begin
  inherited;
  FScanner := TPythonScannerWithTokens.Create;
end;

procedure TGenerateStructogram.GenerateStructogram(const Source: string;
  Structogram: TStrList);
begin
  FStructogram := Structogram;
  FCurrent := Structogram;
  FScanner.Init(Source);
  SkipNewLines;
  ParseDecorators;
  // function
  if FScanner.Token = 'def' then
    GenerateMethod
  else
    // statement sequence
    while FScanner.Token <> '' do
    begin
      ParseDecorators;
      if (FScanner.Token = 'class') or (FScanner.Token = 'def') then
        Break // only one global function
      else
        GenerateStatement;
    end;
end;

destructor TGenerateStructogram.Destroy;
begin
  FreeAndNil(FScanner);
  inherited;
end;

function TGenerateStructogram.GetNextToken: string;
begin
  Result := FScanner.GetNextToken;
end;

procedure TGenerateStructogram.SkipNewLines;
begin
  while FScanner.Token = NEWLINE do
    GetNextToken;
end;

procedure TGenerateStructogram.SkipMethod;
var
  TempFCurrent, Tmp: TStrElement;
begin
  SkipTo(':');
  GetNextToken;
  TempFCurrent := FCurrent;
  FCurrent := TStrElement.Create(nil);
  GenerateSuite;
  while not Assigned(FCurrent) do
  begin
    Tmp := FCurrent.Prev;
    FreeAndNil(FCurrent);
    FCurrent := Tmp;
  end;
  FCurrent := TempFCurrent;
end;

procedure TGenerateStructogram.SkipTo(Chr: Char);
begin
  FScanner.SkipTo(Chr);
end;

procedure TGenerateStructogram.SkipToChars(const Chr: string);
begin
  FScanner.SkipToChars(Chr);
end;

function TGenerateStructogram.IsIdentifier(Expression: string): Boolean;
begin
  Result := False;
  var
  I := Pos('<', Expression);
  if I > 0 then
    Delete(Expression, I, Length(Expression));
  if Length(Expression) = 0 then
    Exit;
  if not(Expression[1].IsLetter or (Expression[1] = '_')) then
    Exit;
  for I := 2 to Length(Expression) do
    if not(Expression[I].IsLetterOrDigit or (Pos(Expression[I], '_,[]<>') > 0))
    then
      Exit;
  if Expression[Length(Expression)] = '.' then
    Exit;
  Result := not IsReservedWord(Expression);
end;

procedure TGenerateStructogram.ParseDecorators;
begin
  while FScanner.Token = '@' do
  begin
    SkipTo(NEWLINE);
    GetNextToken;
  end;
  SkipNewLines;
end;

function TGenerateStructogram.CleanUp(const Expression: string): string;
begin
  Result := Trim(WithoutSelfAndVisibility(WithoutMultipleSpaces
    (WithoutLinefeeds(WithoutLineJoining(WithoutComments(Expression))))));
end;

function TGenerateStructogram.GetExpression(Token: Char): string;
var
  Start: PChar;
begin
  Start := FScanner.CurrPos;
  SkipTo(Token);
  SetString(Result, Start, FScanner.CurrPos - Start - 1);
  Result := CleanUp(Result);
end;

function TGenerateStructogram.GetSimpleExpression: string;
var
  Start: PChar;
begin
  Start := FScanner.LastCurrPos;
  SkipToChars(NEWLINE + ';');
  SetString(Result, Start, FScanner.CurrPos - Start - 1);
  Result := CleanUp(Result);
end;

function TGenerateStructogram.WithoutTypes(const Expression: string): string;
var
  Int, Pos1, Pos2: Integer;
begin
  Result := Expression;
  Int := 1;
  while Int <= Length(Result) do
  begin
    if Result[Int] = ':' then
    begin
      Pos1 := Int;
      Pos2 := Int + 1;
      while Pos2 <= Length(Result) do
      begin
        if Result[Pos2] = ',' then
        begin
          Delete(Result, Pos1, Pos2 - Pos1);
          Break;
        end;
        if Pos2 = Length(Result) then
        begin
          Delete(Result, Pos1, Pos2 - Pos1 + 1);
          Break;
        end;
        Inc(Pos2);
      end;
    end;
    Inc(Int);
  end;

end;

function TGenerateStructogram.WithoutSelfAndVisibility
  (const Expression: string): string;
begin
  Result := myStringReplace(myStringReplace(Expression, 'self.', ''), '_', '');
end;

function TGenerateStructogram.WithoutLineJoining(const Expression: string): string;
begin
  Result := myStringReplace(Expression, '\'#10, '');
end;

function TGenerateStructogram.WithoutLinefeeds(const Expression: string): string;
var
  Int: Integer;
begin
  Result := Expression;
  Int := 1;
  while Int <= Length(Result) do
  begin
    if Result[Int] = #10 then
      Delete(Result, Int, 1)
    else
      Inc(Int);
  end;
end;

function TGenerateStructogram.WithoutMultipleSpaces(const Expression: string): string;
var
  Pos1, Pos2: Integer;
begin
  Result := Expression;
  Pos1 := Pos('  ', Result);
  while Pos1 > 0 do
  begin
    Pos2 := Pos1 + 1;
    while (Pos2 <= Length(Result)) and (Result[Pos2] = ' ') do
      Inc(Pos2);
    Delete(Result, Pos1, Pos2 - Pos1 - 1);
    Pos1 := Pos('  ', Result);
  end;
end;

function TGenerateStructogram.WithoutComments(const Expression: string): string;
var
  Pos1, Pos2: Integer;
  Double, Single: Boolean;
begin
  Result := Expression;
  Double := False;
  Single := False;
  Pos1 := 1;
  while Pos1 <= Length(Result) do
  begin
    if (Result[Pos1] = '"') and not Single then
      Double := not Double
    else if (Result[Pos1] = '''') and not Double then
      Single := not Single
    else if (Result[Pos1] = '#') and not Double and not Single then
    begin
      Pos2 := Pos1 + 1;
      while (Pos2 <= Length(Result)) and (Result[Pos2] <> #10) do
        Inc(Pos2);
      Delete(Result, Pos1, Pos2 - Pos1);
    end;
    Inc(Pos1);
  end;
end;

function TGenerateStructogram.KnownStatement(const Expression: string): Boolean;
const
  Statements: array [1 .. 13] of string = ('assert', 'break', 'pass', 'del',
    'return', 'yield', 'raise', 'continue', 'import', 'from', 'future',
    'global', 'nonlocal');
begin
  Result := False;
  for var I := 1 to 13 do
    if Statements[I] = Expression then
      Result := True;
end;

procedure TGenerateStructogram.GenerateSuite;
begin
  if FScanner.Token = NEWLINE then
  begin
    SkipNewLines;
    if FScanner.Token = INDENT then
    begin
      GetNextToken;
      repeat
        GenerateStatement;
        SkipNewLines;
      until (FScanner.Token = DEDENT_) or (FScanner.Token = '');
      GetNextToken; // skip DEDENT_
    end;
  end
  else
  begin
    GenerateSimpleStatement;
    while (FScanner.Token <> NEWLINE) and (FScanner.Token <> '') do
      GenerateSimpleStatement;
    if FScanner.Token = NEWLINE then
      GetNextToken;
  end;
end;

procedure TGenerateStructogram.GenerateStatement;
begin
  if FScanner.Token = '' then
    Exit;
  if FScanner.Token = '@' then
    ParseDecorators;
  if FScanner.Token = 'async' then
    GetNextToken;
  if FScanner.Token = 'if' then
    GenerateIfStatement
  else if FScanner.Token = 'while' then
    GenerateWhileStatement
  else if FScanner.Token = 'for' then
    GenerateForStatement
  else if FScanner.Token = 'with' then
    GenerateWithStatement
  else if FScanner.Token = 'def' then
    SkipMethod
  else
    GenerateSimpleStatement;
end;

procedure TGenerateStructogram.GenerateIfStatement;
// 8.1
// if_stmt ::=  "if" assignment_expression ":" suite
// ("elif" assignment_expression ":" suite)*
// ["else" ":" suite]
var
  ElemIf: TStrIf;
  ElemSwitch: TStrSwitch;
  Expression: string;
  CaseCount: Integer;
  SavedFCurrent, Tmp: TStrElement;

  procedure GenerateEmptyStatement;
  var
    Elem: TStrStatement;
  begin
    Elem := TStrStatement.Create(FStructogram);
    FStructogram.Insert(FCurrent, Elem);
    Elem.Text := '';
    FCurrent := Elem;
  end;

  procedure GenerateEnd;
  begin
    if FScanner.Token = 'else' then
    begin
      SkipTo(':');
      GetNextToken;
      GenerateSuite;
    end
    else
      GenerateEmptyStatement;
  end;

  procedure NewCase(Text: string);
  begin
    Inc(CaseCount);
    var Elems := ElemSwitch.CaseElems;
    SetLength(Elems, CaseCount + 1);
    ElemSwitch.CaseElems:= Elems;
    ElemSwitch.CaseElems[CaseCount] := TStrListHead.CreateStructogram
      (FStructogram, ElemSwitch);
    ElemSwitch.CaseElems[CaseCount].Text := 'case ' + IntToStr(CaseCount)
      + ' head';
    ElemSwitch.CaseElems[CaseCount].Next.Text := Text;
    FCurrent := ElemSwitch.CaseElems[CaseCount].Next;
  end;

begin
  SavedFCurrent := FCurrent;
  FCurrent := TStrElement.Create(FStructogram);
  Tmp := FCurrent;
  Expression := GetExpression(':');
  GetNextToken;
  GenerateSuite;
  if FScanner.Token = 'elif' then
  begin
    ElemSwitch := TStrSwitch.CreateStructogram(FStructogram);
    ElemSwitch.Text := 'falls'; // ToDo falls?
    FStructogram.Insert(SavedFCurrent, ElemSwitch);
    Tmp.Next.Prev := nil;
    CaseCount := 0;
    var Elems := ElemSwitch.CaseElems;
    SetLength(Elems, CaseCount + 1);
    ElemSwitch.CaseElems:= Elems;
    ElemSwitch.CaseElems[0] := TStrListHead.CreateStructogram(FStructogram,
      ElemSwitch);
    ElemSwitch.CaseElems[0].Text := 'case ' + IntToStr(CaseCount) + ' head';
    ElemSwitch.CaseElems[0].Next.Text := Expression;
    FStructogram.Insert(ElemSwitch.CaseElems[0].Next, Tmp.Next);
    FreeAndNil(Tmp);
    while FScanner.Token = 'elif' do
    begin
      Expression := GetExpression(':');
      NewCase(Expression);
      GetNextToken;
      GenerateSuite;
    end;
    NewCase(GuiPyLanguageOptions.Other);
    GenerateEnd;
    FCurrent := ElemSwitch;
  end
  else
  begin
    ElemIf := TStrIf.CreateStructogram(FStructogram);
    FStructogram.Insert(SavedFCurrent, ElemIf);
    ElemIf.Text := Expression;
    if Assigned(Tmp.Next) then
      Tmp.Next.Prev := nil;
    FStructogram.Insert(ElemIf.ThenElem, Tmp.Next);
    FreeAndNil(Tmp);
    FCurrent := ElemIf.ElseElem;
    GenerateEnd;
    FCurrent := ElemIf;
  end;
end;

procedure TGenerateStructogram.GenerateWhileStatement;
// 8.2
// "while" assignment_expression ":" suite ["else" ":" suite]
var
  Elem: TStrWhile;
  Expression: string;
begin
  Elem := TStrWhile.CreateStructogram(FStructogram);
  FStructogram.Insert(FCurrent, Elem);
  Expression := GetExpression(':');
  Elem.Text := GuiPyLanguageOptions._While + ' ' + Expression;
  FCurrent := Elem.DoElem;
  GetNextToken;
  GenerateSuite;
  FCurrent := Elem;
end;

procedure TGenerateStructogram.GenerateForStatement;
// 8.3
// for_stmt ::=  "for" target_list "in" expression_list ":" suite
// ["else" ":" suite]

var
  Elem: TStrFor;
  Expression: string;
begin
  Elem := TStrFor.CreateStructogram(FStructogram);
  FStructogram.Insert(FCurrent, Elem);
  Expression := GetExpression(':');
  Elem.Text := GuiPyLanguageOptions._For + ' ' + Expression;
  FCurrent := Elem.DoElem;
  GetNextToken;
  GenerateSuite;
  FCurrent := Elem;
end;

procedure TGenerateStructogram.GenerateWithStatement;
// 8.5
// with_stmt ::=  "with" with_item ("," with_item)* ":" suite
// with_item ::=  expression ["as" target]
var
  Elem: TStrWhile;
  Expression: string;
begin
  Elem := TStrWhile.CreateStructogram(FStructogram);
  FStructogram.Insert(FCurrent, Elem);
  Expression := GetExpression(':');
  Elem.Text := GuiPyLanguageOptions._While + ' ' + Expression;
  FCurrent := Elem.DoElem;
  GetNextToken;
  GenerateSuite;
  FCurrent := Elem;
end;

procedure TGenerateStructogram.GenerateSimpleStatement;
begin
  if KnownStatement(FScanner.Token) then
    GenerateKnownSimpleStatement
  else
  begin
    var Ident := FScanner.Token;
    if IsIdentifier(Ident) and (FScanner.LookAheadToken = '(') then
      GenerateMethodCall(Ident)
    else
      GenerateAssignmentOrExpression(Ident);
  end;
  if FScanner.Token = ';' then
    GetNextToken;
end;

procedure TGenerateStructogram.GenerateKnownSimpleStatement;
var
  Elem: TStrElement;
begin
  if FScanner.Token = 'break' then
    Elem := TStrBreak.Create(FStructogram)
  else
    Elem := TStrStatement.Create(FStructogram);
  FStructogram.Insert(FCurrent, Elem);
  Elem.Text := GetSimpleExpression;
  FCurrent := Elem;
end;

procedure TGenerateStructogram.GenerateMethodCall(const Method: string);
var
  Elem: TStrElement;
  Expression: string;
  Posi: Integer;
begin
  Expression := GetSimpleExpression;
  if Method = 'print' then
  begin
    Elem := TStrStatement.Create(FStructogram);
    Posi := Pos('(', Expression);
    Delete(Expression, 1, Posi);
    Posi := Length(Expression);
    while (Posi > 0) and (Expression[Posi] <> ')') do
      Dec(Posi);
    Delete(Expression, Posi, Length(Expression));
    Elem.Text := GuiPyLanguageOptions.Output + ' ' + Expression;
  end
  else
  begin
    Elem := TStrSubprogram.Create(FStructogram);
    Elem.Text := Expression;
  end;
  FStructogram.Insert(FCurrent, Elem);
  FCurrent := Elem;
end;

procedure TGenerateStructogram.GenerateAssignmentOrExpression
  (const Ident: string);
var
  Elem: TStrElement;
  Expression: string;
  Posi: Integer;
begin
  Elem := TStrStatement.Create(FStructogram);
  FStructogram.Insert(FCurrent, Elem);
  Expression := GetSimpleExpression;
  Elem.Text := Expression;
  if (Pos('=', Expression) > 0) then
  begin
    Posi := Pos('input(', Expression);
    if (Posi > 0) and ((Posi = 1) or IsWordBreakChar(Expression[Posi - 1])) then
      Elem.Text := GuiPyLanguageOptions.Input + ' ' + Ident;
  end;
  FCurrent := Elem;
end;

procedure TGenerateStructogram.GenerateMethod;
var
  Method, Expression: string;
begin
  Method := GetNextToken;
  GetNextToken;
  Expression := GetExpression(')');
  if Left(Expression, 6) = 'self, ' then
    Expression := Copy(Expression, 7, Length(Expression));
  Method := Method + '(' + WithoutTypes(Expression) + ')';
  FStructogram.Text := FStructogram.Text + ' ' + Method;
  SkipTo(':');
  GetNextToken;
  GenerateSuite;
end;

end.
