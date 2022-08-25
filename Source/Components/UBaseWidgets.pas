{-------------------------------------------------------------------------------
 Unit:     UBaseWidgets
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  base widget of Tkinter, TTKinter and PyQt
-------------------------------------------------------------------------------}

unit UBaseWidgets;

interface

uses
  Windows, Messages, Controls, Graphics, Classes, StdCtrls, ELEvents, frmEditor;

const
  TagText      =  1;   // used in UObjectGenerator
  TagAlignment =  2;
  TagBoolean   =  3;
  TagColor     =  4;
  PickBoolean  = 'true'#13#10'false';
  CrLf         = sLineBreak;

type

  //TScrollbar = (_TB_none, _TB_horizontal, _TB_vertical, _TB_both);

  TBaseWidget = class(TCustomControl)
  private
    FSizeable: boolean;
    FPartner: TEditorForm;
    procedure setX(aValue: integer);
    function  getX: integer;
    procedure setY(aValue: integer);
    function  getY: integer;
    function getPartner: TEditorForm;
  protected
    procedure setAttributValue(key, s: string);
    procedure insertValue(s: string);
    function surround(s: string): string;
    procedure setValue(Variable, Value: String);
    procedure MakeCommand(Attr, Value: String); virtual;
    procedure FormatItems(Items: TStrings);
    function isFontAttribute(const s: string): boolean;
    function enumToString<T{: enum}>(AValue: T): string;
    function BitmapFromRelativePath(RelPath: string): TBitmap;
    procedure UpdateObjectInspector;
    procedure WrapText(Text: string; Wrapwidth: integer;
                       var tw, th: integer; var SL: TStringList);
    function Indent1: string;
    function Indent2: string;
    function Indent3: string;
    function defaultItems: string;
  public
    property Sizeable: boolean read FSizeable write FSizeable default true;
    property Partner: TEditorForm read getPartner write FPartner;
  published
    // common attribute for tk, ttk and qt
    property Cursor;
    property Height;
    property Width;
    property x: integer read getX write setX;
    property y: integer read getY write setY;
  public
    constructor Create(aOwner: TComponent); override;
    procedure Rename(const OldName, NewName, Events: string); virtual;
    function HandlerName(const event: string): string; virtual;
    function HandlerParameter(const event: string): string; virtual;
    function HandlerNameAndParameter(const event: string): string;
    // all abstract, needed for object inspector/generator
    function getAttributes(ShowAttributes: integer): string; virtual; abstract;
    function getEvents(ShowEvents: integer): string; virtual; abstract;
    procedure setAttribute(Attr, Value, Typ: string); virtual; abstract;

    procedure NewWidget(Widget: String = ''); virtual; abstract;
    procedure SetPositionAndSize; virtual; abstract;
    function getNameAndType: String; virtual; abstract;
    procedure DeleteEvents; virtual; abstract;
    procedure Resize; override; abstract;
    procedure DeleteWidget; virtual; abstract;
    procedure setEvent(Attr: string); virtual; abstract;
    procedure DeleteEventHandler(const Event: string); virtual; abstract;
    function MakeBinding(Eventname: string): string; virtual; abstract;
    function MakeHandler(const event: string ): string; virtual; abstract;
    procedure SizeToText; virtual;
  end;

implementation

uses SysUtils, TypInfo, Math, UITypes, RTTI,
     Vcl.Imaging.GIFImg, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
     JvGnugettext,
     UGuiForm, UGUIDesigner, UObjectInspector, UConfiguration, UUtils;

constructor TBaseWidget.create(aOwner: TComponent);
begin
  inherited Create(aOwner);
end;

procedure TBaseWidget.setAttributValue(key, s: string);
begin
  if Pos(Indent2, s) = 0 then
    s:= Indent2 + s;
  Partner.setAttributValue(Indent2 + 'self.' + Name, key, s, 1);
end;

procedure TBaseWidget.insertValue(s: string);
begin
  if Pos(Indent2, s) = 0 then
    s:= Indent2 + s;
  Partner.insertValue(Indent2 + 'self.' + Name, s, 1);
end;

function TBaseWidget.surround(s: string): string;
begin
  if Pos(Indent2, s) = 0
    then Result:= Indent2 + s + CrLf
    else Result:= s + CrLf;
end;

function TBaseWidget.isFontAttribute(const s: string): boolean;
begin
  Result:= Pos(s, ' Font Name Size Bold Italic ') > 0;
end;

procedure TBaseWidget.setValue(Variable, Value: String);
  var s: String;
begin
  if Variable <> '' then begin
    s:= 'self.' + Variable + '.set';
    setAttributValue(s, s + '(' + Value + ')');
  end;
end;

procedure TBaseWidget.MakeCommand(Attr, Value: String);
begin
  var func:= CrLF +
         Indent1 + 'def ' + Value +'(self):' + CrLf +
         Indent2 + '# ToDo insert source code here' + CrLf +
         Indent2 + 'pass' + CrLf;
  Partner.InsertProcedure(func);
end;

procedure TBaseWidget.Rename(const OldName, NewName, Events: string);
begin
  Partner.ReplaceComponentname(OldName, NewName, Events);
end;

procedure TBaseWidget.FormatItems(Items: TStrings);
  var s, ts: string; i, ls, Indent: integer;
begin
  i:= 0;
  Indent:= 0;
  while i < Items.Count do begin
    s:= Items[i];
    ts:= trim(s);
    if ts = '' then begin
      Items.Delete(i);
      Continue;
    end;
    ls:= LeftSpaces(s, 2);
    if ls > Indent then begin
      inc(Indent, 2);
      if ls <> Indent then
        Items[i]:= StringOfChar(' ', Indent) + ts;
    end else if ls < Indent then begin
      if ls mod 2 = 1 then begin
        Items[i]:= StringOfchar(' ', ls + 1) + ts;
        Indent:= ls + 1;
      end else
        Indent:= ls;
    end;
    inc(i);
  end;
end;

procedure TBaseWidget.setX(aValue: integer);
begin
  if aValue <> Top then begin
    Left:= aValue;
    Invalidate;
  end;
end;

function TBaseWidget.getX: integer;
begin
  Result:= Left;
end;

procedure TBaseWidget.setY(aValue: integer);
begin
  if aValue <> Top then begin
    Top:= aValue;
    Invalidate;
  end;
end;

function TBaseWidget.getY: integer;
begin
  Result:= Top;
end;

function TBaseWidget.Indent1: string;
begin
  Result:= FConfiguration.Indent1
end;

function TBaseWidget.Indent2: string;
begin
  Result:= FConfiguration.Indent2;
end;

function TBaseWidget.Indent3: string;
begin
  Result:= FConfiguration.Indent3;
end;

function TBaseWidget.defaultItems: string;
begin
  Result:= _('America') + #13#10 + _('Europe') + #13#10 + _('Asia');
end;

function TBaseWidget.HandlerName(const event: string): string;
begin
  Result:= Name + '_' + event;
end;

function TBaseWidget.HandlerParameter(const event: string): string;
begin
  Result:= 'self, event';
end;

function TBaseWidget.HandlerNameAndParameter(const event: string): string;
begin
  Result:= HandlerName(event) + '(' + HandlerParameter(event) + '):';
end;

procedure TBaseWidget.UpdateObjectInspector;
begin
  FObjectInspector.Invalidate
end;

function TBaseWidget.BitmapFromRelativePath(RelPath: string): TBitmap;
  var pathname, ext: string;
      png: TPngImage;
      gif: TGifImage;
      jpg: TJPEGImage;
begin
  Result:= nil;
  pathname:= FGuiDesigner.getPath + 'images\' + copy(RelPath, 8, length(RelPath));
  if FileExists(pathname) then begin
    ext:= Uppercase(ExtractFileExt(RelPath));
    Result:= Graphics.TBitmap.Create;
    if ext = '.PNG' then begin
      png:= TPngImage.Create;
      png.LoadFromFile(pathname);
      Result.Assign(png);
      FreeAndNil(png);
    end else if ext = '.GIF' then begin
      gif:= TGifImage.Create;
      gif.LoadFromFile(Pathname);
      Result.Assign(gif.Bitmap);
      FreeAndNil(gif);
    end else if (ext = '.JPG') or (ext = 'JPEG') then begin
      jpg:= TJPEGImage.Create;
      jpg.LoadFromFile(Pathname);
      Result.Assign(jpg);
      FreeAndNil(jpg);
    end;
  end;
end;

function TBaseWidget.enumToString<T{: enum}>(AValue: T): string;
begin
  var s:= TRttiEnumerationType.GetName(AValue);
  if (length(s) > 4) and (s[1] = '_') and (s[4] = '_') then
    delete(s, 1, 4);
  Result:= s;
end;

procedure TBaseWidget.WrapText(Text: string; WrapWidth: integer;
                               var tw, th: integer; var SL: TStringList);
  var s, s1, s2: string; p: integer; SL1: TStringList;

  procedure split(s: string; var s1, s2: string);
    var p, m, n, x: integer;
  begin
    x:= Canvas.TextWidth('x');
    n:= 0;
    repeat
      m:= n - 1;
      inc(n);
      while (n <= length(s)) and (s[n] <> ' ') do
        inc(n);
    until Canvas.TextWidth(copy(s, 1, n-1)) > WrapWidth - x;
    if m > 0 then begin
      s1:= copy(s, 1, m);
      p:= Pos(CrLf, s1);
      if p > 0 then begin
        s1:= copy(s1, 1, p-1);
        s2:= copy(s, p+2, length(s));
        exit;
      end;
      s2:= copy(s, m+1, length(s));
    end else begin
      n:= 1;
      while (n <= length(s)) and
            (Canvas.TextWidth(copy(s, 1, n-1)) <= WrapWidth - x) do
        inc(n);
      s1:= copy(s, 1, n-1);
      s2:= copy(s, n, length(s));
    end;
  end;

begin
  SL.Clear;
  SL1:= TStringList.Create;
  SL1.Text:= myStringReplace(Text, '\n', CrLf);
  for p:= 0 to SL1.Count - 1 do begin
    s:= SL1[p];
    s1:= '';
    s2:= '';
    while Canvas.TextWidth(s) > WrapWidth do begin
      split(s, s1, s2);
      SL.Add(s1);
      s:= s2;
    end;
    SL.Add(s);
  end;
  FreeAndNil(SL1);

  tw:= 0;
  for p:= 0 to SL.Count - 1 do
    tw:= max(tw, Canvas.TextWidth(SL[p]));
  th:= SL.Count * Canvas.TextHeight('Hg');
end;

function TBaseWidget.getPartner: TEditorForm;
begin
  if (FPartner = nil) and assigned(Owner) and assigned((Owner as TFGuiForm).Partner) then
    FPartner:= (Owner as TFGuiForm).Partner as TEditorForm;
  Result:= fPartner;
end;

procedure TBaseWidget.SizeToText;
begin
  // do nothing
end;

end.
