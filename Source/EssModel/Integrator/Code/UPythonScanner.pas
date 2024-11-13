{-------------------------------------------------------------------------------
 Unit:     UPythonScanner
 Author:   Gerhard Röhner
 Date:     June 2021
 Purpose:  python scanner
-------------------------------------------------------------------------------}

unit UPythonScanner;

interface

  const
    NEWLINE = Chr($0A);
    INDENT = Chr($03);
    DEDENT_ = Chr($04);

  type

  TPythonScannerWithTokens = class
  public
    Comment: string; // Accumulated comment string used for documentation of entities.
    Line: Integer;             // current line, calculated by GetNextToken
    Column: integer;           // current column
    LastTokenLine: integer;
    LastTokenColumn: integer;
    TokenLine: integer;
    TokenColumn: integer;
    StartPos: PChar;
    CurrPos: PChar;
    LastCurrPos: PChar;
    ScanStr: string;
    LastToken: string;
    Token: string;
    TokenTyp: string;
    CompoundTokens: boolean;
    IndentIndex: integer;
    Indents: array[1..50] of integer;
    PushToken: string;
    InhibitDetermineIndent: boolean;
    constructor Create;
    destructor Destroy; override;
    procedure Init(const s: string);   // simple scanning of a string
    function GetChar: char;
    procedure DetermineIndent;
    procedure EatWhiteSpace;
    function GetNextToken: string;
    procedure SkipTo(ch: char);
    procedure SkipToChars(ch: string);
    procedure SkipPairTo(const open, close: string);
    function LookAheadToken: String;
    function getExtends: string;
    function getFilename: String;
    function GetFrameType: integer;
  end;

implementation

uses SysUtils, Character;

{--- Scanner ------------------------------------------------------------------}

constructor TPythonScannerWithTokens.Create;
  var i: integer;
begin
  inherited;
  Line:= 1;
  Column:= 1;
  LastTokenLine:= -1;
  IndentIndex:= 0;
  for i:= 1 to 50 do
    Indents[i]:= 0;
  Token:= NEWLINE;
end;

destructor TPythonScannerWithTokens.Destroy;
begin
  inherited;
end;

function TPythonScannerWithTokens.GetChar: char;
begin
  Result:= CurrPos^;
  if (CurrPos^ = #10) or ((CurrPos^ = #13) and ((CurrPos+1)^ <> #10)) then begin
    inc(Line);
    Column:= 0;
  end;
  if Result <> #0 then begin
    inc(CurrPos);
    inc(Column);
  end;
end;

procedure TPythonScannerWithTokens.EatWhiteSpace;
var
  inComment, continueLastComment, State: Boolean;

  procedure EatOne;
  begin
    if inComment
      then Comment:= Comment + GetChar
      else GetChar;
  end;

  function EatWhite: Boolean;
  begin
    Result:= False;
    while not CharInSet(CurrPos^, [#0, #10, #13, #33..#255]) do begin
      Result:= True;
      EatOne;
    end;
  end;

  function EatTripleComment: Boolean;
  begin
    Result:= True;
    while not ((CurrPos^ = '"') and ((CurrPos + 1)^ = '"') and ((CurrPos + 2)^ = '"')) and (CurrPos^ <> #0) do
      EatOne;
    continueLastComment:= False;
    EatOne;
    EatOne;
    EatOne;
  end;

  function EatHashComment: Boolean;
  begin
    Result:= True;
    while (CurrPos^ <> #13) and (CurrPos^ <> #10) and (CurrPos^ <> #0) do
      EatOne;
    continueLastComment:= True;
    inComment:= False;
    if CurrPos^ = #13 then
      GetChar;
  end;

begin
  inComment:= False;
  continueLastComment:= False;
  State:= True;
  while State do begin
    State:= False;
    if (CurrPos^ = #10) or ((CurrPos^ = #13) and ((CurrPos + 1)^ = #10)) then
      continueLastComment:= False;
    if not CharInSet(CurrPos^, [#0, #10, #13, #33..#255]) then
      State:= EatWhite;
    if CurrPos^ = '#' then begin
      inComment:= true;
      Comment:= '';
      EatOne;
      State:= EatHashComment;
      inComment:= False;
    end;
    if (CurrPos^ = '"') and ((CurrPos + 1)^ = '"') and ((CurrPos + 2)^ = '"') then begin
      if not continueLastComment
        then Comment:= ''
        else Comment:= Comment + #13#10;
      EatOne;
      EatOne;
      EatOne; // Skip the triple slashes
      inComment:= true;
      State:= EatTripleComment;
      inComment:= false;
    end;
  end;
end;

procedure TPythonScannerWithTokens.DetermineIndent;
  var Spaces: integer;
begin
  if not InhibitDetermineIndent then begin
    Spaces:= 0;
    if CurrPos^ = #13 then
      GetChar;
    while (CurrPos^ = #10) and (CurrPos^ <> #0) do begin
      GetChar;
      if CurrPos^= #13 then
        GetChar;
    end;
    while CurrPos^ = ' ' do begin
      inc(Spaces);
      GetChar;
    end;
    if (CurrPos^ = '#') or (CurrPos^ = '"') and ((CurrPos+1)^ = '"') and ((CurrPos+2)^ = '"') then
      exit;
    if IndentIndex = 0 then begin
      inc(IndentIndex);
      Indents[IndentIndex]:= Spaces
    end else if Spaces > Indents[IndentIndex] then begin
      PushToken:= INDENT + PushToken;
      inc(IndentIndex);
      Indents[IndentIndex]:= Spaces;
    end else while (IndentIndex > 1) and (Spaces < Indents[IndentIndex]) do begin
      PushToken:= DEDENT_ + PushToken;
      Indents[IndentIndex]:= 0;
      dec(IndentIndex);
    end;
  end;
end;

function TPythonScannerWithTokens.GetNextToken: string;
  var bracket: integer;

  procedure AddOne;
  begin
    Token:= Token + GetChar;
  end;

begin
  LastToken:= Token;
  LastCurrPos:= CurrPos;
  if PushToken <> '' then begin
    Token:= PushToken[1];
    delete(PushToken, 1, 1);
    Exit(Token);
  end;
  Token:= '';
  TokenTyp:= '';
  if LastToken = NEWLINE then begin
    DetermineIndent;
    if PushToken <> '' then begin
      Token:= PushToken[1];
      Delete(PushToken, 1, 1);
      Exit(Token);
    end;
  end;
  // 2.1.5. line joining
  EatWhiteSpace;
  if (CurrPos^ = '\') and ((CurrPos + 1)^ = #10) then begin
    GetChar;
    GetChar;
    EatWhiteSpace;
  end;
  if LastTokenLine = -1 then begin
    LastTokenLine:= Line;
    LastTokenColumn:= Column;
  end else begin
    LastTokenLine:= TokenLine;
    LastTokenColumn:= TokenColumn;
  end;
  TokenLine:= Line;
  TokenColumn:= Column;
  if CurrPos^ = '"' then begin // Parse String
    AddOne;
    while not CharInSet(CurrPos^, ['"', #0]) do begin
      if ((CurrPos^ = '\') and CharInSet((CurrPos + 1)^, ['"', '\'])) then
        AddOne;
      AddOne;
    end;
    AddOne;
    TokenTyp:= 'String';
  end else if CurrPos^ = '''' then begin // Parse char
    AddOne;
    while not CharInSet(CurrPos^, ['''', #0]) do begin
      if ((CurrPos^ = '\') and CharInSet((CurrPos + 1)^, ['''', '\'])) then
        AddOne;
      AddOne;
    end;
    AddOne;
    TokenTyp:= 'int'; // instead of char
  end else //Identifier
    if CurrPos^.isLetter or (CurrPos^ = '_') then begin
      while CurrPos^ = '_' do
        GetChar;
      AddOne;
      while true do begin
        while CurrPos^.IsLetterOrDigit or (CurrPos^ = '_') do
          AddOne;
        if CompoundTokens and (CurrPos^ = '.') then begin
          AddOne;
          if Token = 'self.' then
            Token:= '';
          Continue;
        end;
        Break;
      end;
      while CurrPos^ = '[' do begin
        bracket:= 1;
        AddOne;
        while (bracket > 0) and (CurrPos^ <> #0) and (CurrPos^ <> '}') and (CurrPos^ <> ';') do begin
          if CurrPos^ = '['
            then inc(bracket)
          else if CurrPos^ = ']'
            then dec(bracket);
          AddOne;
        end;
      end;
    end
  else if CharInSet(CurrPos^, [';', '[', ']', '{', '}', '(', ')', ',', ':', '.', '?', '@']) then begin
    //single chars to test
    AddOne;
    if (CurrPos^= '.') and ((CurrPos+1)^ = '.') then begin
      AddOne;
      AddOne;
    end
  end else if CurrPos^ = '=' then begin //single chars to test
    AddOne;
    while CurrPos^ = '=' do AddOne;
  end
  else if CurrPos^ = '[' then begin  // lose Klammern
    AddOne;
    EatWhitespace;
    if CurrPos^ = ']' then AddOne;
  end else if CharInSet(CurrPos^, ['*', '/', '%', '+', '-', '<', '>', '&', '^', '|']) then begin // operators
    AddOne;
    if CharInSet(CurrPos^,  ['=', '+', '-']) then
      AddOne;
  end else if CharInSet(CurrPos^, ['0'..'9']) then begin
    while CharInSet(CurrPos^, ['0'..'9']) do
      AddOne;
    TokenTyp:= 'int';
    while CharInSet(CurrPos^, ['0'..'9', '.', 'E', 'e']) do begin
      AddOne;
      TokenTyp:= 'double';
    end;
  end else if CurrPos^ = #13 then begin
    GetChar;
    if CurrPos^ = #10 then
      AddOne;              // NEWLINE
  end else if CurrPos^= #10 then
    AddOne
  else
    while not CharInSet(CurrPos^, [#0, #9, #12, #32, ',', '=', ';', '{', '}', '(', ')', '"', '''']) do
      AddOne;
  Result:= Token;
end;

procedure TPythonScannerWithTokens.Init(const s: String);
begin
  Token:= NEWLINE;
  PushToken:= '';
  ScanStr:= s;
  CurrPos := PChar(ScanStr);
  StartPos:= PChar(ScanStr);
  CompoundTokens:= true;
  DetermineIndent;
end;

procedure TPythonScannerWithTokens.SkipTo(ch: char);
begin
  while (Token <> ch) and (Token <> '') do begin
    if Token = '{'
      then SkipPairTo('{', '}')
    else if Token = '('
      then SkipPairTo('(', ')')
    else if Token = '['
      then SkipPairTo('[', ']')
    else GetNextToken;
  end;
end;

procedure TPythonScannerWithTokens.SkipToChars(ch: string);
begin
  while (Pos(Token, ch) = 0) and (Token <> '') do begin
    if Token = '{'
      then SkipPairTo('{', '}')
    else if Token = '('
      then SkipPairTo('(', ')')
    else if Token = '['
      then SkipPairTo('[', ']')
    else GetNextToken;
  end;
end;

procedure TPythonScannerWithTokens.SkipPairTo(const open, close: string);
  var Count: integer;
begin
  Count:= 1;
  InhibitDetermineIndent:= true;
  while (Count > 0) and (Token <> '') do begin
    GetNextToken;
    if Token = open
      then Inc(Count)
    else if Token = close
      then Dec(Count);
  end;
  InhibitDetermineIndent:= false;
end;

function TPythonScannerWithTokens.LookAheadToken: String;
  var SaveCurrPos: PChar;
      SaveLastCurrPos: PChar;
      SaveLastToken: String;
      SaveToken: string;
      SaveLine: integer;
begin
  SaveCurrPos:= CurrPos;
  SaveLastCurrPos:= LastCurrPos;
  SaveLastToken:= LastToken;
  SaveToken:= Token;
  SaveLine:= Line;
  Result:= GetNextToken;
  LastToken:= SaveLastToken;
  Token:= SaveToken;
  LastCurrPos:= SaveLastCurrPos;
  CurrPos:= SaveCurrPos;
  Line:= SaveLine;
end;

function TPythonScannerWithTokens.getFilename: string;
begin
  getNextToken;
  while (Token <> '') and (Token <> 'def') do
    getNextToken;
  if Token = 'def' then
    Result:= getNextToken;
end;

function TPythonScannerWithTokens.getExtends: string;
begin
  Result:= '';
  GetNextToken;
  while (Token <> '') and (Token <> 'class') do
    GetNextToken;

  if Token = 'class' then begin
    GetNextToken;
    GetNextToken;
    if Token = '(' then
      Result:= GetNextToken;
  end;
end;

function TPythonScannerWithTokens.GetFrameType: integer;
  var Typ: string;
begin
  CompoundTokens:= true;
  Typ:= getExtends;
  if ScanStr <> '' then
    if (Typ = 'QMainWindow') or (Typ = 'QWidget')
      then Result:= 3
    else if Typ = 'tk.Frame'
      then Result:= 2
      else Result:= 1
  else Result:= 0;
end;

end.
