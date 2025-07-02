{ -------------------------------------------------------------------------------
  Unit:     UBaseWidgets
  Author:   Gerhard Röhner
  Date:     May 2021
  Purpose:  base widget of Tkinter, TTKinter and PyQt
  ------------------------------------------------------------------------------- }

unit UBaseWidgets;

interface

uses
  Controls,
  Graphics,
  Classes,
  frmEditor;

const
  TagText = 1; // used in UObjectGenerator
  TagAlignment = 2;
  TagBoolean = 3;
  TagColor = 4;
  PickBoolean = 'true'#13#10'false';
  MouseEvents1    = '|ButtonPress|ButtonRelease|Motion';
  MouseEvents2    = '|Enter|Leave|MouseWheel';
  KeyboardEvents1 = '|KeyPress|KeyRelease';
  MiscEvents      = '|Activate|Deactivate|Configure|FocusIn|FocusOut';
  AllEvents       =  MouseEvents1 + MouseEvents2 + KeyboardEvents1 + MiscEvents + '|';


type

  TBaseWidget = class(TCustomControl)
  private
    FSizeable: Boolean;
    FPartner: TEditorForm;
    procedure SetX(Value: Integer);
    function GetX: Integer;
    procedure SetY(Value: Integer);
    function GetY: Integer;
    function GetPartner: TEditorForm;
  protected
    procedure SetAttributValue(Key, Value: string);
    procedure InsertValue(Value: string);
    function Surround(Source: string): string;
    procedure SetValue(Variable, Value: string);
    procedure MakeCommand(Attr, Value: string); virtual;
    procedure FormatItems(Items: TStrings);
    function IsFontAttribute(const Attr: string): Boolean;
    function EnumToString<T { : enum } >(AValue: T): string;
    function BitmapFromRelativePath(RelPath: string): TBitmap;
    procedure UpdateObjectInspector;
    procedure WrapText(Text: string; WrapWidth: Integer;
      var Textwidth, TextHeight: Integer; var StringList: TStringList);
    function Indent1: string;
    function Indent2: string;
    function Indent3: string;
    function DefaultItems: string;
  public
    property Sizeable: Boolean read FSizeable write FSizeable default True;
    property Partner: TEditorForm read GetPartner write FPartner;
  published
    // common attribute for tk, ttk and qt
    property Cursor;
    property Height;
    property Width;
    property Font;
    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;
  public
    constructor Create(Owner: TComponent); override;
    procedure Rename(const OldName, NewName, Events: string); virtual;
    function Handlername(const Event: string): string; virtual;
    function HandlerParameter(const Event: string): string; virtual;
    function HandlerNameAndParameter(const Event: string): string;
    // all abstract, needed for object inspector/generator
    function GetAttributes(ShowAttributes: Integer): string; virtual; abstract;
    function GetEvents(ShowEvents: Integer): string; virtual; abstract;
    procedure SetAttribute(Attr, Value, Typ: string); virtual; abstract;

    procedure NewWidget(Widget: string = ''); virtual; abstract;
    procedure SetPositionAndSize; virtual; abstract;
    function GetNameAndType: string; virtual; abstract;
    function GetType: string; virtual; abstract;
    procedure DeleteEvents; virtual; abstract;
    procedure Resize; override; abstract;
    procedure DeleteWidget; virtual; abstract;
    procedure SetEvent(Attr: string); virtual; abstract;
    procedure DeleteEventHandler(const Event: string); virtual; abstract;
    function MakeBinding(Eventname: string): string; virtual; abstract;
    function MakeHandler(const Event: string): string; virtual; abstract;
    procedure SizeToText; virtual;
    procedure MakeFont; virtual; abstract;
    procedure Zoom(ZoomIn: Boolean);
    procedure SetFontSize(Size: Integer);
    procedure UnScaleFontSize;
    function PPIScale(Size: Integer): Integer;
    function PPIUnScale(Size: Integer): Integer;
  end;

function IsEvent(Str: string): Boolean;

implementation

uses
  SysUtils,
  Math,
  Rtti,
  Vcl.Imaging.GIFImg,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  JvGnugettext,
  StringResources,
  UGUIForm,
  UGUIDesigner,
  UObjectInspector,
  UConfiguration,
  UUtils;

const
  CrLf = #13#10;

function IsEvent(Str: string): Boolean;
begin      // Tk                   or  Qt
  Result:= (Pos(Str, AllEvents) > 0) or (Str <> '') and (CharInSet(Str[1], ['a'..'z']));
end;

constructor TBaseWidget.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  ParentFont := False;
end;

procedure TBaseWidget.SetAttributValue(Key, Value: string);
begin
  if Pos(Indent2, Value) = 0 then
    Value := Indent2 + Value;
  Partner.SetAttributValue(Indent2 + 'self.' + Name, Key, Value, 1);
end;

procedure TBaseWidget.InsertValue(Value: string);
begin
  if Pos(Indent2, Value) = 0 then
    Value := Indent2 + Value;
  Partner.InsertValue(Indent2 + 'self.' + Name, Value, 1);
end;

function TBaseWidget.Surround(Source: string): string;
begin
  if Pos(Indent2, Source) = 0 then
    Result := Indent2 + Source + CrLf
  else
    Result := Source + CrLf;
end;

function TBaseWidget.IsFontAttribute(const Attr: string): Boolean;
begin
  Result := Pos(Attr, ' Font Name Size Bold Italic ') > 0;
end;

procedure TBaseWidget.SetValue(Variable, Value: string);
begin
  if Variable <> '' then
  begin
    var
    Str := 'self.' + Variable + '.set';
    SetAttributValue(Str, Str + '(' + Value + ')');
  end;
end;

procedure TBaseWidget.MakeCommand(Attr, Value: string);
begin
  if not Partner.HasText('def ' + Value + '(self):') then begin
    var
    Func := CrLf + Indent1 + 'def ' + Value + '(self):' + CrLf + Indent2 +
      LNGInsertSourceCodeHere + CrLf + Indent2 + 'pass' + CrLf;
    Partner.InsertProcedure(Func);
  end;
end;

procedure TBaseWidget.Rename(const OldName, NewName, Events: string);
begin
  Partner.ReplaceComponentname(OldName, NewName, Events);
end;

procedure TBaseWidget.FormatItems(Items: TStrings);
var
  Str, TrimStr: string;
  Int, LSpace, Indent: Integer;
begin
  Int := 0;
  Indent := 0;
  while Int < Items.Count do
  begin
    Str := Items[Int];
    TrimStr := Trim(Str);
    if TrimStr = '' then
    begin
      Items.Delete(Int);
      Continue;
    end;
    LSpace := LeftSpaces(Str, 2);
    if LSpace > Indent then
    begin
      Inc(Indent, 2);
      if LSpace <> Indent then
        Items[Int] := StringOfChar(' ', Indent) + TrimStr;
    end
    else if LSpace < Indent then
    begin
      if LSpace mod 2 = 1 then
      begin
        Items[Int] := StringOfChar(' ', LSpace + 1) + TrimStr;
        Indent := LSpace + 1;
      end
      else
        Indent := LSpace;
    end;
    Inc(Int);
  end;
end;

procedure TBaseWidget.SetX(Value: Integer);
begin
  if Value <> Left then
  begin
    Left := Value;
    Invalidate;
  end;
end;

function TBaseWidget.GetX: Integer;
begin
  Result := Left;
end;

procedure TBaseWidget.SetY(Value: Integer);
begin
  if Value <> Top then
  begin
    Top := Value;
    Invalidate;
  end;
end;

function TBaseWidget.GetY: Integer;
begin
  Result := Top;
end;

function TBaseWidget.Indent1: string;
begin
  Result := FConfiguration.Indent1;
end;

function TBaseWidget.Indent2: string;
begin
  Result := FConfiguration.Indent2;
end;

function TBaseWidget.Indent3: string;
begin
  Result := FConfiguration.Indent3;
end;

function TBaseWidget.DefaultItems: string;
begin
  Result := _('America') + #13#10 + _('Europe') + #13#10 + _('Asia');
end;

function TBaseWidget.Handlername(const Event: string): string;
begin
  Result := Name + '_' + Event;
end;

function TBaseWidget.HandlerParameter(const Event: string): string;
begin
  Result := 'self, event';
end;

function TBaseWidget.HandlerNameAndParameter(const Event: string): string;
begin
  Result := HandlerName(Event) + '(' + HandlerParameter(Event) + '):';
end;

procedure TBaseWidget.UpdateObjectInspector;
begin
  FObjectInspector.Invalidate;
end;

function TBaseWidget.BitmapFromRelativePath(RelPath: string): TBitmap;
var
  Pathname, Ext: string;
  Png: TPngImage;
  Gif: TGIFImage;
  Jpg: TJPEGImage;
begin
  Result := nil;
  Pathname := FGUIDesigner.getPath + 'images\' +
    Copy(RelPath, 8, Length(RelPath));
  if FileExists(Pathname) then
  begin
    Ext := UpperCase(ExtractFileExt(RelPath));
    Result := Graphics.TBitmap.Create;
    if Ext = '.PNG' then
    begin
      Png := TPngImage.Create;
      Png.LoadFromFile(Pathname);
      Result.Assign(Png);
      FreeAndNil(Png);
    end
    else if Ext = '.GIF' then
    begin
      Gif := TGIFImage.Create;
      Gif.LoadFromFile(Pathname);
      Result.Assign(Gif.Bitmap);
      FreeAndNil(Gif);
    end
    else if (Ext = '.JPG') or (Ext = 'JPEG') then
    begin
      Jpg := TJPEGImage.Create;
      Jpg.LoadFromFile(Pathname);
      Result.Assign(Jpg);
      FreeAndNil(Jpg);
    end;
  end;
end;

function TBaseWidget.EnumToString<T { : enum } >(AValue: T): string;
begin
  var
  Name := TRttiEnumerationType.GetName(AValue);
  if (Length(Name) > 4) and (Name[1] = '_') and (Name[4] = '_') then
    Delete(Name, 1, 4);
  Result := Name;
end;

procedure TBaseWidget.WrapText(Text: string; WrapWidth: Integer;
  var Textwidth, TextHeight: Integer; var StringList: TStringList);
var
  Str, Str1, Str2: string;
  StringList1: TStringList;

  procedure Split(Str: string; var Str1, Str2: string);
  var
    Posi, Num1, Num, XWidth: Integer;
  begin
    XWidth := Canvas.Textwidth('x');
    Num := 0;
    repeat
      Num1 := Num - 1;
      Inc(Num);
      while (Num <= Length(Str)) and (Str[Num] <> ' ') do
        Inc(Num);
    until Canvas.Textwidth(Copy(Str, 1, Num - 1)) > WrapWidth - XWidth;
    if Num1 > 0 then
    begin
      Str1 := Copy(Str, 1, Num1);
      Posi := Pos(CrLf, Str1);
      if Posi > 0 then
      begin
        Str1 := Copy(Str1, 1, Posi - 1);
        Str2 := Copy(Str, Posi + 2, Length(Str));
        Exit;
      end;
      Str2 := Copy(Str, Num1 + 1, Length(Str));
    end
    else
    begin
      Num := 1;
      while (Num <= Length(Str)) and
        (Canvas.Textwidth(Copy(Str, 1, Num - 1)) <= WrapWidth - XWidth) do
        Inc(Num);
      Str1 := Copy(Str, 1, Num - 1);
      Str2 := Copy(Str, Num, Length(Str));
    end;
  end;

begin
  StringList.Clear;
  StringList1 := TStringList.Create;
  StringList1.Text := MyStringReplace(Text, '\n', CrLf);
  for var I := 0 to StringList1.Count - 1 do
  begin
    Str := StringList1[I];
    Str1 := '';
    Str2 := '';
    while Canvas.Textwidth(Str) > WrapWidth do
    begin
      Split(Str, Str1, Str2);
      StringList.Add(Str1);
      Str := Str2;
    end;
    StringList.Add(Str);
  end;
  FreeAndNil(StringList1);

  Textwidth := 0;
  for var I := 0 to StringList.Count - 1 do
    Textwidth := Max(Textwidth, Canvas.Textwidth(StringList[I]));
  TextHeight := StringList.Count * Canvas.TextHeight('Hg');
end;

function TBaseWidget.GetPartner: TEditorForm;
begin
  if not Assigned(FPartner) and Assigned(Owner) and
    Assigned((Owner as TFGuiForm).Partner) then
    FPartner := (Owner as TFGuiForm).Partner;
  Result := FPartner;
end;

procedure TBaseWidget.SizeToText;
begin
  // do nothing
end;

procedure TBaseWidget.Zoom(ZoomIn: Boolean);
begin
  if ZoomIn then
    Font.Size := Font.Size + GuiPyOptions.ZoomSteps
  else
    Font.Size := Max(Font.Size - GuiPyOptions.ZoomSteps, 6);
  Canvas.Font.Assign(Font);
  MakeFont;
  Invalidate;
end;

procedure TBaseWidget.SetFontSize(Size: Integer);
begin
  Font.Size := Size;
end;

procedure TBaseWidget.UnScaleFontSize;
begin
  Font.Size := PPIUnScale(Font.Size);
end;

function TBaseWidget.PPIScale(Size: Integer): Integer;
begin
  Result := MyMulDiv(Size, FCurrentPPI, 96);
  // MulDiv needs Windows, but then we get a strange error with BitmapFromRelativePath
end;

function TBaseWidget.PPIUnScale(Size: Integer): Integer;
begin
  Result := MyMulDiv(Size, 96, FCurrentPPI);
end;

end.
