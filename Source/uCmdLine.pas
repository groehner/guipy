{Copyright (C) 2006  Benito van der Zander

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
}
unit uCmdLine;

interface
{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

uses sysutils; //for exceptions
type
  TStringArray=array of string;
  TLongintArray=array of longint;
  TFloatArray=array of extended;
  TBooleanArray=array of Boolean;
  TCommandLineReaderShowError = procedure (errorDescription: string);
  ECommandLineParseException = class(Exception);
  TKindOfProperty=(kpStr,kpFile,kpInt,kpFloat,kpFlag);
  TProperty=record
   name,desc,strvalue:string;
   found: Boolean;
   case kind: TKindOfProperty of
     kpStr,kpFile: ();
     kpInt: (intvalue: longint);
     kpFloat: (floatvalue: extended);
     kpFlag: (flagvalue,flagdefault: Boolean;
              abbreviation: Char)
  end;
  PProperty=^TProperty;

  { TCommandLineReader }

  TCommandLineReader=class
  protected
    parsed{,searchNameLessFile,searchNameLessInt,searchNameLessFloat,searchNameLessFlag}: Boolean;
    propertyArray: array of TProperty;
    nameless: TStringArray;
    function findProperty(name:string):PProperty;
    function declareProperty(name,description,default:string;kind: TKindOfProperty):PProperty;
  public
    onShowError: TCommandLineReaderShowError;
    automaticalShowError: Boolean;
    allowDOSStyle: Boolean;

    constructor Create;
    destructor Destroy; override;

    function avaibleOptions:string;

    procedure parse();overload;
    procedure parse(const s:string);overload;

    //DeclareFlag allows the use of flags
    //Example:
    //   declareFlag('flag','f',true);
    //  Following command-line options are always possible
    //    --enable-flag      =>     flag:=true
    //    --disable-flag     =>     flag:=false
    //    --flag             =>     flag:=not default
    //    -xfy               =>     flag:=not default
    procedure declareFlag(const name,description:string;flagNameAbbreviation:Char;default:Boolean=False);overload;
    procedure declareFlag(const name,description:string;default:Boolean=False);overload;


    //declareFile allows the use of a file name
    //Example:
    //   declareFile('file');
    //  Following command-line options are  possible
    //    --file C:\test                  =>     file:=C:\test
    //    --file 'C:\test'                =>     file:=C:\test
    //    --file "C:\test"                =>     file:=C:\test
    //    --file='C:\test'                =>     file:=C:\test
    //    --file="C:\test"                =>     file:=C:\test
    //    --file C:\Eigene Dateien\a.bmp  =>     file:=C:\Eigene
    //                                           or file:=C:\Eigene Dateien\a.bmp,
    //                                             if C:\Eigene does not exist
    procedure declareFile(const name,description:string;default:string='');

    //DeclareXXXX allows the use of string, int, float, ...
    //Example:
    //   declareString('property');
    //  Following command-line options are  possible
    //    --file 123                  =>     file:=123
    //    --file '123'                =>     file:=123
    //    --file "123"                =>     file:=123
    //    --file='123'                =>     file:=123
    //    --file="123"                =>     file:=123

    procedure declareString(const name,description:string;value: string='');
    procedure declareInt(const name,description:string;value: longint=0);
    procedure declareFloat(const name,description:string;value: extended=0);

    function readString(const name:string):string; overload;
    function readInt(const name:string):longint;overload;
    function readFloat(const name:string):extended; overload;
    function readFlag(const name:string):Boolean;overload;

    function existsProperty(const name:string):Boolean;

    function readNamelessFiles():TStringArray;
    function readNamelessString():TStringArray;
    function readNamelessInt():TLongintArray;
    function readNamelessFloat():TFloatArray;
    function readNamelessFlag():TBooleanArray;
  end;

var
  CmdLineReader: TCommandLineReader;

implementation
uses
  Windows, JvGnugettext, StringResources;

const
  Null = Char(#0);
  Tab = Char(#9);
  Space = Char(#32);
  Quote = Char(#34);

constructor TCommandLineReader.Create;
begin
  parsed:=False;
  {$IFDEF Win32}
    allowDOSStyle := True;
  {$ELSE}
    allowDOSStyle := False;
  {$ENDIF}
  onShowError := nil;
  {searchNameLessFile:=false;
  searchNameLessInt:=false;
  searchNameLessFloat:=false;
  searchNameLessFlag:=false;}
  automaticalShowError := not IsLibrary;
end;

destructor TCommandLineReader.destroy;
begin
  inherited;
end;

function TCommandLineReader.avaibleOptions: string;
var i:Integer;
begin
  result := '';
  for i := 0 to high(propertyArray) do begin
    result := result + '--' + propertyArray[i].name;
    case propertyArray[i].kind of
      kpFlag: if propertyArray[i].abbreviation <> #0 then
                result := result + ' or -' + propertyArray[i].abbreviation;
      else result := result + '=';
    end;
    result := result + Tab + Tab + propertyArray[i].desc + #13#10;
  end;
end;

procedure TCommandLineReader.parse();
var params: string;
    p: Integer;
begin
  params := GetCommandLineW;
  if params = '' then Exit;
  if params[1] = Quote then begin
    params[1] := 'X';
    Delete(params, 1 , Pos(Quote ,params));
  end else begin
    p := Pos(Space, params);
    if p > 0 then
      Delete(params, 1, p)
    else
      // if there is no quote and no space then it must be just the executable name
      params := '';
  end;
  parse(params);
end;

procedure TCommandLineReader.parse(const s:string);
var cmd: PChar;

  procedure raiseError;
  var errorMessage: string;
  begin
    if Assigned(onShowError) or automaticalShowError then begin
      errorMessage := _(SParseError) + Copy(string(cmd), 1, 100) + #13#10;
      if Length(propertyArray) = 0 then
        errorMessage := _(SParseErrorOptions)
      else
        errorMessage := _(SParseInvalidOptions) + avaibleOptions;
    end;

    if Assigned(onShowError) then
      onShowError(errorMessage);
    if automaticalShowError then
      if system.IsConsole then
         writeln(errorMessage)
       else
         MessageBox(0, PChar(errorMessage), PChar(string(_(SCommandLineOptions))), MB_ICONWARNING or MB_OK);

    raise ECommandLineParseException.Create('Error before '+string(cmd));
  end;

var currentProperty:longint;
    valueStart: PChar;
    valueLength: longint;
    flagValue: Boolean;
    stringStart: Char;
    i:Integer;
begin
  cmd := PChar(s);
  currentProperty := -1;
  SetLength(nameless,0);
  for i := 0 to high(propertyArray) do
    propertyArray[i].found := False;
  while cmd^ <> Null do begin
    if (cmd^ = '-') or (allowDOSStyle and (cmd^ = '/')) then begin
      //Start of property name
      if (cmd^ = '/') or ((cmd + 1)^ = '-') then begin //long property
        if cmd^ <> '/' then Inc(cmd);
        Inc(cmd);
        valueStart := cmd;
        while not CharInSet(cmd^, [Space, Null, Char('=')]) do
          Inc(cmd);
        currentProperty := -1;
        if (StrLIComp(valueStart, 'enable-', 7) = 0) or
           (StrLIComp(valueStart, 'disable-', 8) = 0) then
        begin
          flagValue := valueStart^ = 'e';
          if flagValue then Inc(valueStart,7)
          else Inc(valueStart,8);
          {while not (cmd^ in ['-',#0,'=']) do
            inc(cmd);}
          valueLength := longint(cmd-valueStart);
          for i := 0 to high(propertyArray) do
            if (Length(propertyArray[i].name) = valueLength) and
               (StrLIComp(valueStart,@propertyArray[i].name[1], valueLength) = 0) and
               (propertyArray[i].kind = kpFlag) then
            begin
              propertyArray[i].flagvalue := flagValue;
              propertyArray[i].found := True;
              Break;
            end;
        end else begin
          valueLength := longint(cmd-valueStart);
          for i := 0 to high(propertyArray) do
            if (Length(propertyArray[i].name)=valueLength) and
               (StrLIComp(valueStart, @propertyArray[i].name[1], valueLength)=0) then begin
              if propertyArray[i].kind = kpFlag then
                propertyArray[i].flagvalue := not propertyArray[i].flagdefault;
              currentProperty := i;
              propertyArray[i].found := True;
              Break;
            end;
          if currentProperty=-1 then raiseError;
          if propertyArray[currentProperty].kind = kpFlag then
            currentProperty := -1;
        end;
      end else if CharInSet((cmd+1)^, [Space, Null]) then raiseError //unknown format
      else begin //flag abbreviation string
        Inc(cmd);
        while not CharInSet(cmd^, [Space, Null]) do begin
          for i := 0 to high(propertyArray) do
            if (propertyArray[i].kind = kpFlag) and (propertyArray[i].abbreviation = cmd^) then begin
              propertyArray[i].flagvalue := not propertyArray[i].flagdefault;
              propertyArray[i].found := True;
            end;
          Inc(cmd);
        end;
      end;
    end else if cmd^ <> ' ' then begin
      //Start of property value
      if CharInSet(cmd^, [Quote, Char('''')]) then begin
        stringStart := cmd^;
        Inc(cmd);
        valueStart := cmd;
        while not CharInSet(cmd^, [stringStart, Null]) do
          Inc(cmd);
        valueLength := longint(cmd-valueStart);
        if currentProperty<>-1 then begin
          setlength(propertyArray[currentProperty].strvalue, valueLength);
          move(valueStart^,propertyArray[currentProperty].strvalue[1], valueLength*SizeOf(Char));
          case propertyArray[currentProperty].kind of
            kpInt: propertyArray[currentProperty].intvalue := StrToInt(propertyArray[currentProperty].strvalue);
            kpFloat:  propertyArray[currentProperty].floatvalue := StrToFloat(propertyArray[currentProperty].strvalue);
          end;
        end else begin
          SetLength(nameless, Length(nameless)+1);
          setlength(nameless[high(nameless)], valueLength);
          move(valueStart^,nameless[high(nameless)][1], valueLength*SizeOf(Char));
        end;
      end else begin
        valueStart := cmd;
        while not CharInSet(cmd^, [Space, Null]) do Inc(cmd);
        valueLength := longint(cmd - valueStart);
        if currentProperty=-1 then begin
          SetLength(nameless,Length(nameless) + 1);
          setlength(nameless[high(nameless)], valueLength);
          move(valueStart^,nameless[high(nameless)][1], valueLength*SizeOf(Char));
        end else begin
          setlength(propertyArray[currentProperty].strvalue, valueLength);
          move(valueStart^,propertyArray[currentProperty].strvalue[1], valueLength*SizeOf(Char));
          try
            case propertyArray[currentProperty].kind of
              kpInt: propertyArray[currentProperty].intvalue := StrToInt(propertyArray[currentProperty].strvalue);
              kpFloat:  propertyArray[currentProperty].floatvalue := StrToFloat(propertyArray[currentProperty].strvalue);
              kpFile: with propertyArray[currentProperty] do begin
                while not FileExists(strvalue) do begin
                  while cmd^ = ' ' do Inc(cmd);
                  while not CharInSet(cmd^, [Space, Null]) do Inc(cmd);
                  valueLength := longint(cmd-valueStart);
                  setlength(strvalue, valueLength);
                  move(valueStart^,strvalue[1], valueLength*SizeOf(Char));
                  if cmd^ = Null then Exit;
                end;
              end;
            end;
          except
            raiseError();
          end;
        end;
      end;
      currentProperty := -1;
    end;
    if cmd^ <> Null then Inc(cmd)
    else Break;

  end;
  parsed := True;
end;

function TCommandLineReader.findProperty(name:string):PProperty;
var i:Integer;
begin
  name := LowerCase(name);
  for i := 0 to high(propertyArray) do
    if propertyArray[i].name = name then begin
      result := @propertyArray[i];
      Exit;
    end;
  raise ECommandLineParseException.Create('Property not found: '+name);
end;

function TCommandLineReader.declareProperty(name,description,default:string;kind: TKindOfProperty):PProperty;
begin
  SetLength(propertyArray,Length(propertyArray)+1);
  result := @propertyArray[high(propertyArray)];
  result^.name := LowerCase(name);
  result^.desc := description;
  result^.strvalue := default;
  result^.kind := kind;
end;
procedure TCommandLineReader.declareFlag(const name,description:string;flagNameAbbreviation:Char;default:Boolean=False);
begin
  with declareProperty(name,description,'',kpFlag)^ do begin
    flagvalue := default;
    flagdefault := default;
    abbreviation := flagNameAbbreviation;
  end;
end;
procedure TCommandLineReader.declareFlag(const name,description:string;default:Boolean=False);
begin
  declareFlag(name, description, Null, default);
end;

procedure TCommandLineReader.declareFile(const name,description:string; default:string='');
begin
  declareProperty(name, description, '', kpFile);
end;

procedure TCommandLineReader.declareString(const name, description:string; value: string='');
begin
  declareProperty(name,description,value,kpStr);
end;
procedure TCommandLineReader.declareInt(const name, description:string; value: longint=0);
begin
  declareProperty(name,description,IntToStr(value),kpInt)^.intvalue := value;
end;
procedure TCommandLineReader.declareFloat(const name, description:string; value: extended=0);
begin
  declareProperty(name,description,FloatToStr(value),kpFloat)^.floatvalue := value;
end;

function TCommandLineReader.readString(const name:string):string;
begin
  if not parsed then parse;
  result := findProperty(name)^.strvalue;
end;

function TCommandLineReader.readInt(const name:string):longint;
var prop: PProperty;
begin
  if not parsed then parse;
  prop := findProperty(name);
  if prop^.kind<>kpInt then raise ECommandLineParseException.Create('No integer property: '+name);
  result := prop^.intvalue;
end;

function TCommandLineReader.readFloat(const name:string):extended;
var prop: PProperty;
begin
  if not parsed then parse;
  prop := findProperty(name);
  if prop^.kind<>kpFloat then raise ECommandLineParseException.Create('No extended property: '+name);
  result := prop^.Floatvalue;
end;

function TCommandLineReader.readFlag(const name:string):Boolean;
var prop: PProperty;
begin
  if not parsed then parse;
  prop := findProperty(name);
  if prop^.kind <> kpFlag then
    raise ECommandLineParseException.Create('No flag property: '+name);
  result := prop^.flagvalue;
end;

function TCommandLineReader.existsProperty(const name:string):Boolean;
begin
  if not parsed then parse;
  result := findProperty(name)^.found;
end;

function TCommandLineReader.readNamelessFiles():TStringArray;
begin
  Result := nameless;
end;

function TCommandLineReader.readNamelessString():TStringArray;
begin
  result := nameless;
end;

function TCommandLineReader.readNamelessInt():TLongintArray;
var i,p:Integer;
begin
  SetLength(result,Length(nameless));
  p := 0;
  for i := 0 to high(nameless) do
    try
      result[p] := StrToInt(nameless[i]);
      Inc(p);
    except
    end;
  SetLength(result,p);
end;

function TCommandLineReader.readNamelessFloat():TFloatArray;
var i, p:Integer;
begin
  SetLength(result,Length(nameless));
  p := 0;
  for i := 0 to high(nameless) do
    try
      result[p] := StrToFloat(nameless[i]);
      Inc(p);
    except
    end;
  SetLength(result,p);
end;

function TCommandLineReader.readNamelessFlag():TBooleanArray;
var i, p:Integer;
begin
  SetLength(result,Length(nameless));
  p := 0;
  for i := 0 to high(nameless) do begin
    if LowerCase(nameless[i]) = 'true' then Result[p] := True
    else if LowerCase(nameless[i]) = 'false' then Result[p] := False
    else Dec(p);
    Inc(p);
  end;
  SetLength(result,p);
end;

const
  sSyntax = 'GuiPy command line syntax:';
  sOptions = 'Command line options:';
  sPyScripterCommandLine = 'guipy [options] [filename1, [filename2, ...]]';

initialization
  CmdLineReader  :=  TCommandLineReader.Create;
  CmdLineReader.allowDOSStyle := True;
  CmdLineReader.automaticalShowError  :=  True;
  CmdLineReader.declareFlag('HELP','Show GuiPy command line options', Char('H'),False);
  CmdLineReader.declareFlag('NEWINSTANCE','Start a new instance of GuiPy', Char('N'),False);
  CmdLineReader.declareFlag('PYTHON38','Use Python version 3.8',False);
  CmdLineReader.declareFlag('PYTHON39','Use Python version 3.9',False);
  CmdLineReader.declareFlag('PYTHON310','Use Python version 3.10',False);
  CmdLineReader.declareFlag('PYTHON311','Use Python version 3.11',False);
  CmdLineReader.declareFlag('PYTHON312','Use Python version 3.12',False);
  CmdLineReader.declareFlag('PYTHON313','Use Python version 3.13',False);
  CmdLineReader.declareFlag('PYTHON314','Use Python version 3.14',False);
  CmdLineReader.declareString('PROJECT','Specify a project file to open');
  CmdLineReader.declareString('PYTHONDLLPATH','Use a specific Pythonxx.dll');

  try
      CmdLineReader.parse;
      if CmdLineReader.readFlag('HELP') then begin
        if system.IsConsole then begin
          writeln(sSyntax);
          writeln(sPyScripterCommandLine);
          writeln(sOptions);
          writeln(CmdLineReader.avaibleOptions);
         end else
          MessageBox(0,
            PChar(sPyScripterCommandLine + sLineBreak + sOptions + sLineBreak + CmdLineReader.avaibleOptions),
            sSyntax, MB_ICONINFORMATION or MB_OK);
        Halt(0);
      end;
  except
    on E: ECommandLineParseException do Halt(1);
  end;

finalization
  CmdLineReader.free;
end.
