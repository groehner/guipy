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
  TagText          =  1;   // used in UObjectGenerator
  TagAlignment     =  2;
  TagBoolean       =  3;
  TagColor         =  4;
  PickBoolean = 'true'#13#10'false';
  CrLf = #13#10;

type

  TScrollbar = (_TB_none, _TB_horizontal, _TB_vertical, _TB_both);

  TBaseWidget = class(TCustomControl)
  private
    FSizeable: boolean;

    // events
    FActivate: TEvent;
    FButtonPress: TEvent;
    FButtonRelease: TEvent;
    FConfigure: TEvent;
    FDeactivate: TEvent;
    FEnter: TEvent;
    FFocusIn: TEvent;
    FFocusOut: TEvent;
    FKeyPress: TEvent;
    FKeyRelease: TEvent;
    FLeave: TEvent;
    FMotion: TEvent;
    FMouseWheel: TEvent;

    procedure setX(aValue: integer);
    function  getX: integer;
    procedure setY(aValue: integer);
    function  getY: integer;
  protected
    procedure setAttributValue(key, s: string);
    procedure setValue(Variable, Value: String);
    function getAttrAsKey(Attr: string): string; virtual; abstract;
    procedure MakeCommand(Attr, Value: String); virtual;
    procedure InsertVariable(const Variable: string);
    function Indent1: string;
    function Indent2: string;
    function Indent3: string;
  public
    property Sizeable: boolean read FSizeable write FSizeable default true;
  published
    // common attribute for tk and ttk
    property Cursor;
    property Height;
    property Width;
    property x: integer read getX write setX;
    property y: integer read getY write setY;

    // events
    {$WARNINGS OFF}
    property Activate: TEvent read Factivate write Factivate;
    property ButtonPress: TEvent read FbuttonPress write FbuttonPress;
    property ButtonRelease: TEvent read FbuttonRelease write FbuttonRelease;
    property Configure: TEvent read Fconfigure write Fconfigure;
    property Deactivate: TEvent read Fdeactivate write Fdeactivate;
    property Enter: TEvent read FEnter write FEnter;
    property FocusIn: TEvent read FfocusIn write FfocusIn;
    property FocusOut: TEvent read FfocusOut write FfocusOut;
    property KeyPress: TEvent read fkeyPress write fkeyPress;
    property KeyRelease: TEvent read fkeyRelease write fkeyRelease;
    property Leave: TEvent read fleave write fleave;
    property Motion: TEvent read fMotion write fMotion;
    property MouseWheel: TEvent read fmouseWheel write fmouseWheel;
    {$WARNINGS ON}
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function getContainer: string;
    procedure MakeFont;
    procedure Rename(const OldName, NewName, Events: string); virtual;
    function Partner: TEditorForm;
    function isFontAttribute(const s: string): boolean;
    procedure UpdateObjectInspector;

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
    function HandlerName(const event: string): string; virtual; abstract;
    function MakeHandler(const event: string ): string; virtual; abstract;
    procedure SizeLabelToText; virtual; abstract;
  end;

implementation

uses SysUtils, TypInfo, Math, UITypes,
     UGuiForm, UGUIDesigner, UObjectInspector, UConfiguration, UUtils;

constructor TBaseWidget.create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FButtonPress:= TEvent.Create(Self);
  FButtonRelease:= TEvent.Create(Self);
  FKeyPress:= TEvent.Create(Self);
  FKeyRelease:= TEvent.Create(Self);
  FActivate:= TEvent.Create(Self);
  FConfigure:= TEvent.Create(Self);
  FDeactivate:= TEvent.Create(Self);
  FEnter:= TEvent.Create(Self);
  FFocusIn:= TEvent.Create(Self);
  FFocusOut:= TEvent.Create(Self);
  FLeave:= TEvent.Create(Self);
  FMouseWheel:= TEvent.Create(Self);
  FMotion:= TEvent.Create(Self);
end;

function TBaseWidget.Partner: TEditorForm;
begin
  Result:= (Owner as TFGuiForm).Partner as TEditorForm
end;

destructor TBaseWidget.Destroy;
begin
  FActivate.Destroy;
  FButtonPress.Destroy;
  FButtonRelease.Destroy;
  FConfigure.Destroy;
  FDeactivate.Destroy;
  FEnter.Destroy;
  FFocusIn.Destroy;
  FFocusOut.Destroy;
  FKeyPress.Destroy;
  FKeyRelease.Destroy;
  FLeave.Destroy;
  FMotion.Destroy;
  FMouseWheel.Destroy;
  inherited;
end;

procedure TBaseWidget.setAttributValue(key, s: string);
begin
  if Pos(Indent2, s) = 0 then
    s:= Indent2 + s;
  Partner.setAttributValue(Name, key, s, 1);
end;

function TBaseWidget.isFontAttribute(const s: string): boolean;
begin
  Result:= Pos(s, ' Font Name Size Bold Italic') > 0;
end;

procedure TBaseWidget.MakeFont;
  var s1, s2: string;
begin
  s1:= 'self.' + Name + '[''font'']';
  s2:= ' = (' + asString(Font.Name) + ', ' + IntToStr(Font.Size);
  if fsBold   in Font.Style then s2:= s2 + ', ' + asString('bold');
  if fsItalic in Font.Style then s2:= s2 + ', ' + asString('italic');
  if fsStrikeout in Font.Style then s2:= s2 + ', ' + asString('overstrike');
  if fsUnderline in Font.Style then s2:= s2 + ', ' + asString('underline');
  s2:= s2 + ')';
  setAttributValue(s1, s1 + s2);
  Invalidate;
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

procedure TBaseWidget.InsertVariable(const Variable: string);
begin
  Partner.InsertAttribute(Indent2 + Variable);
end;

function TBaseWidget.getContainer: string;
begin
  if (Parent = nil) or (Parent is TFGUIForm)
    then Result:= ''
    else Result:= 'self.' + Parent.Name;
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

procedure TBaseWidget.UpdateObjectInspector;
begin
  TThread.ForceQueue(nil, procedure
  begin
    FObjectInspector.SetSelectedObject(Self);
  end);
end;

end.
