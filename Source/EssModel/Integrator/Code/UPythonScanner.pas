{ -------------------------------------------------------------------------------
  Unit:     UPythonScanner
  Author:   Gerhard Röhner
  Date:     June 2021
  Purpose:  python scanner
  ------------------------------------------------------------------------------- }

unit UPythonScanner;

interface

const
  NEWLINE = Chr($0A);
  INDENT = Chr($03);
  DEDENT_ = Chr($04);

type

  TPythonScannerWithTokens = class
  private
    FColumn: Integer; // current FColumn
    FComment: string;
    // Accumulated FComment string used for documentation of entities.
    FCompoundTokens: Boolean;
    FCurrPos: PChar;
    FIndentIndex: Integer;
    FIndents: array [1 .. 50] of Integer;
    FInhibitDetermineIndent: Boolean;
    FLastCurrPos: PChar;
    FLastToken: string;
    FLastTokenColumn: Integer;
    FLastTokenLine: Integer;
    FLine: Integer; // current line, calculated by GetNextToken
    FPushToken: string;
    FScanStr: string;
    FStartPos: PChar;
    FToken: string;
    FTokenColumn: Integer;
    FTokenLine: Integer;
    FTokenTyp: string;
    procedure DetermineIndent;
    procedure EatWhitespace;
    function GetChar: Char;
    function GetExtends: string;
    procedure SkipPairTo(const Open, Close: string);
  public
    constructor Create;
    procedure Init(const Source: string); // simple scanning of a source
    function GetFilename: string;
    function GetFrameType: Integer;
    function GetNextToken: string;
    function LookAheadToken: string;
    procedure SkipTo(Chr: Char);
    procedure SkipToChars(Chr: string);

    property CurrPos: PChar read FCurrPos;
    property LastCurrPos: PChar read FLastCurrPos;
    property Token: string read FToken;
  end;

implementation

uses
  SysUtils,
  Character;

{ --- Scanner ------------------------------------------------------------------ }

constructor TPythonScannerWithTokens.Create;
begin
  inherited;
  FLine := 1;
  FColumn := 1;
  FLastTokenLine := -1;
  FIndentIndex := 0;
  for var I := 1 to 50 do
    FIndents[I] := 0;
  FToken := NEWLINE;
end;

function TPythonScannerWithTokens.GetChar: Char;
begin
  Result := FCurrPos^;
  if (FCurrPos^ = #10) or ((FCurrPos^ = #13) and ((FCurrPos + 1)^ <> #10)) then
  begin
    Inc(FLine);
    FColumn := 0;
  end;
  if Result <> #0 then
  begin
    Inc(FCurrPos);
    Inc(FColumn);
  end;
end;

procedure TPythonScannerWithTokens.EatWhitespace;
var
  InComment, ContinueLastComment, State: Boolean;

  procedure EatOne;
  begin
    if InComment then
      FComment := FComment + GetChar
    else
      GetChar;
  end;

  function EatWhite: Boolean;
  begin
    Result := False;
    while not CharInSet(FCurrPos^, [#0, #10, #13, #33 .. #255]) do
    begin
      Result := True;
      EatOne;
    end;
  end;

  function EatTripleComment: Boolean;
  begin
    Result := True;
    while not((FCurrPos^ = '"') and ((FCurrPos + 1)^ = '"') and
      ((FCurrPos + 2)^ = '"')) and (FCurrPos^ <> #0) do
      EatOne;
    ContinueLastComment := False;
    EatOne;
    EatOne;
    EatOne;
  end;

  function EatHashComment: Boolean;
  begin
    Result := True;
    while (FCurrPos^ <> #13) and (FCurrPos^ <> #10) and (FCurrPos^ <> #0) do
      EatOne;
    ContinueLastComment := True;
    InComment := False;
    if FCurrPos^ = #13 then
      GetChar;
  end;

begin
  InComment := False;
  ContinueLastComment := False;
  State := True;
  while State do
  begin
    State := False;
    if (FCurrPos^ = #10) or ((FCurrPos^ = #13) and ((FCurrPos + 1)^ = #10)) then
      ContinueLastComment := False;
    if not CharInSet(FCurrPos^, [#0, #10, #13, #33 .. #255]) then
      State := EatWhite;
    if FCurrPos^ = '#' then
    begin
      InComment := True;
      FComment := '';
      EatOne;
      State := EatHashComment;
      InComment := False;
    end;
    if (FCurrPos^ = '"') and ((FCurrPos + 1)^ = '"') and ((FCurrPos + 2)^ = '"')
    then
    begin
      if not ContinueLastComment then
        FComment := ''
      else
        FComment := FComment + #13#10;
      EatOne;
      EatOne;
      EatOne; // Skip the triple slashes
      InComment := True;
      State := EatTripleComment;
      InComment := False;
    end;
  end;
end;

procedure TPythonScannerWithTokens.DetermineIndent;
var
  Spaces: Integer;
begin
  if not FInhibitDetermineIndent then
  begin
    Spaces := 0;
    if FCurrPos^ = #13 then
      GetChar;
    while (FCurrPos^ = #10) and (FCurrPos^ <> #0) do
    begin
      GetChar;
      if FCurrPos^ = #13 then
        GetChar;
    end;
    while FCurrPos^ = ' ' do
    begin
      Inc(Spaces);
      GetChar;
    end;
    if (FCurrPos^ = '#') or (FCurrPos^ = '"') and ((FCurrPos + 1)^ = '"') and
      ((FCurrPos + 2)^ = '"') then
      Exit;
    if FIndentIndex = 0 then
    begin
      Inc(FIndentIndex);
      FIndents[FIndentIndex] := Spaces;
    end
    else if Spaces > FIndents[FIndentIndex] then
    begin
      FPushToken := INDENT + FPushToken;
      Inc(FIndentIndex);
      FIndents[FIndentIndex] := Spaces;
    end
    else
      while (FIndentIndex > 1) and (Spaces < FIndents[FIndentIndex]) do
      begin
        FPushToken := DEDENT_ + FPushToken;
        FIndents[FIndentIndex] := 0;
        Dec(FIndentIndex);
      end;
  end;
end;

function TPythonScannerWithTokens.GetNextToken: string;
var
  Bracket: Integer;

  procedure AddOne;
  begin
    FToken := FToken + GetChar;
  end;

begin
  FLastToken := FToken;
  FLastCurrPos := FCurrPos;
  if FPushToken <> '' then
  begin
    FToken := FPushToken[1];
    Delete(FPushToken, 1, 1);
    Exit(FToken);
  end;
  FToken := '';
  FTokenTyp := '';
  if FLastToken = NEWLINE then
  begin
    DetermineIndent;
    if FPushToken <> '' then
    begin
      FToken := FPushToken[1];
      Delete(FPushToken, 1, 1);
      Exit(FToken);
    end;
  end;
  // 2.1.5. FLine joining
  EatWhitespace;
  if (FCurrPos^ = '\') and ((FCurrPos + 1)^ = #10) then
  begin
    GetChar;
    GetChar;
    EatWhitespace;
  end;
  if FLastTokenLine = -1 then
  begin
    FLastTokenLine := FLine;
    FLastTokenColumn := FColumn;
  end
  else
  begin
    FLastTokenLine := FTokenLine;
    FLastTokenColumn := FTokenColumn;
  end;
  FTokenLine := FLine;
  FTokenColumn := FColumn;
  if FCurrPos^ = '"' then
  begin // Parse String
    AddOne;
    while not CharInSet(FCurrPos^, ['"', #0]) do
    begin
      if ((FCurrPos^ = '\') and CharInSet((FCurrPos + 1)^, ['"', '\'])) then
        AddOne;
      AddOne;
    end;
    AddOne;
    FTokenTyp := 'String';
  end
  else if FCurrPos^ = '''' then
  begin // Parse Char
    AddOne;
    while not CharInSet(FCurrPos^, ['''', #0]) do
    begin
      if ((FCurrPos^ = '\') and CharInSet((FCurrPos + 1)^, ['''', '\'])) then
        AddOne;
      AddOne;
    end;
    AddOne;
    FTokenTyp := 'int'; // instead of Char
  end
  else // Identifier
    if FCurrPos^.IsLetter or (FCurrPos^ = '_') then
    begin
      while FCurrPos^ = '_' do
        GetChar;
      AddOne;
      while True do
      begin
        while FCurrPos^.IsLetterOrDigit or (FCurrPos^ = '_') do
          AddOne;
        if FCompoundTokens and (FCurrPos^ = '.') then
        begin
          AddOne;
          if FToken = 'self.' then
            FToken := '';
          Continue;
        end;
        Break;
      end;
      while FCurrPos^ = '[' do
      begin
        Bracket := 1;
        AddOne;
        while (Bracket > 0) and (FCurrPos^ <> #0) and (FCurrPos^ <> '}') and
          (FCurrPos^ <> ';') do
        begin
          if FCurrPos^ = '[' then
            Inc(Bracket)
          else if FCurrPos^ = ']' then
            Dec(Bracket);
          AddOne;
        end;
      end;
    end
    else if CharInSet(FCurrPos^, [';', '[', ']', '{', '}', '(', ')', ',', ':',
      '.', '?', '@']) then
    begin
      // single chars to test
      AddOne;
      if (FCurrPos^ = '.') and ((FCurrPos + 1)^ = '.') then
      begin
        AddOne;
        AddOne;
      end;
    end
    else if FCurrPos^ = '=' then
    begin // single chars to test
      AddOne;
      while FCurrPos^ = '=' do
        AddOne;
    end
    else if FCurrPos^ = '[' then
    begin // lose Klammern
      AddOne;
      EatWhitespace;
      if FCurrPos^ = ']' then
        AddOne;
    end
    else if CharInSet(FCurrPos^, ['*', '/', '%', '+', '-', '<', '>', '&', '^',
      '|']) then
    begin // operators
      AddOne;
      if CharInSet(FCurrPos^, ['=', '+', '-']) then
        AddOne;
    end
    else if CharInSet(FCurrPos^, ['0' .. '9']) then
    begin
      while CharInSet(FCurrPos^, ['0' .. '9']) do
        AddOne;
      FTokenTyp := 'int';
      while CharInSet(FCurrPos^, ['0' .. '9', '.', 'E', 'e']) do
      begin
        AddOne;
        FTokenTyp := 'double';
      end;
    end
    else if FCurrPos^ = #13 then
    begin
      GetChar;
      if FCurrPos^ = #10 then
        AddOne; // NEWLINE
    end
    else if FCurrPos^ = #10 then
      AddOne
    else
      while not CharInSet(FCurrPos^, [#0, #9, #12, #32, ',', '=', ';', '{', '}',
        '(', ')', '"', '''']) do
        AddOne;
  Result := FToken;
end;

procedure TPythonScannerWithTokens.Init(const Source: string);
begin
  FToken := NEWLINE;
  FPushToken := '';
  FScanStr := Source;
  FCurrPos := PChar(FScanStr);
  FStartPos := PChar(FScanStr);
  FCompoundTokens := True;
  DetermineIndent;
end;

procedure TPythonScannerWithTokens.SkipTo(Chr: Char);
begin
  while (FToken <> Chr) and (FToken <> '') do
  begin
    if FToken = '{' then
      SkipPairTo('{', '}')
    else if FToken = '(' then
      SkipPairTo('(', ')')
    else if FToken = '[' then
      SkipPairTo('[', ']')
    else
      GetNextToken;
  end;
end;

procedure TPythonScannerWithTokens.SkipToChars(Chr: string);
begin
  while (Pos(FToken, Chr) = 0) and (FToken <> '') do
  begin
    if FToken = '{' then
      SkipPairTo('{', '}')
    else if FToken = '(' then
      SkipPairTo('(', ')')
    else if FToken = '[' then
      SkipPairTo('[', ']')
    else
      GetNextToken;
  end;
end;

procedure TPythonScannerWithTokens.SkipPairTo(const Open, Close: string);
var
  Count: Integer;
begin
  Count := 1;
  FInhibitDetermineIndent := True;
  while (Count > 0) and (FToken <> '') do
  begin
    GetNextToken;
    if FToken = Open then
      Inc(Count)
    else if FToken = Close then
      Dec(Count);
  end;
  FInhibitDetermineIndent := False;
end;

function TPythonScannerWithTokens.LookAheadToken: string;
var
  SaveCurrPos: PChar;
  SaveLastCurrPos: PChar;
  SaveLastToken: string;
  SaveToken: string;
  SaveLine: Integer;
begin
  SaveCurrPos := FCurrPos;
  SaveLastCurrPos := FLastCurrPos;
  SaveLastToken := FLastToken;
  SaveToken := FToken;
  SaveLine := FLine;
  Result := GetNextToken;
  FLastToken := SaveLastToken;
  FToken := SaveToken;
  FLastCurrPos := SaveLastCurrPos;
  FCurrPos := SaveCurrPos;
  FLine := SaveLine;
end;

function TPythonScannerWithTokens.GetFilename: string;
begin
  GetNextToken;
  while (FToken <> '') and (FToken <> 'def') do
    GetNextToken;
  if FToken = 'def' then
    Result := GetNextToken;
end;

function TPythonScannerWithTokens.GetExtends: string;
begin
  Result := '';
  GetNextToken;
  while (FToken <> '') and (FToken <> 'class') do
    GetNextToken;
  if FToken = 'class' then
  begin
    GetNextToken;
    GetNextToken;
    if FToken = '(' then
      Result := GetNextToken;
  end;
end;

function TPythonScannerWithTokens.GetFrameType: Integer;
var
  Typ: string;
begin
  FCompoundTokens := True;
  Typ := GetExtends;
  if FScanStr <> '' then
    if (Typ = 'QMainWindow') or (Typ = 'QWidget') then
      Result := 3
    else if Typ = 'tk.Frame' then
      Result := 2
    else
      Result := 1
  else
    Result := 0;
end;

end.
