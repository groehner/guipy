{-------------------------------------------------------------------------------
 Unit:     ELEvents
 Author:   Gerhard Röhner
 Date:     May 2021
 Purpose:  tkinter mouse and key events
-------------------------------------------------------------------------------}

unit ELEvents;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, RTTI,
  dlgPyIDEBase;

type

  TEvent = class(TComponent)
  private
    // modifier
    FControl: boolean;
    FShift: boolean;
    FAlt: boolean;
    FDouble: boolean;
    FTriple: boolean;
    FAny: boolean;
    FActive: boolean;
    // qualifier
    FKey: string;
    FButton: integer;
  public
    constructor Create(AOwner: TComponent); override;
    function getModifiers(Eventname: String): string;
    function getDetail(Eventname: String): string;
    procedure Clear;
  published
    property Control: boolean read FControl write FControl default false;
    property Shift: boolean read FShift write FShift default false;

    property Alt: boolean read FAlt write FAlt default false;
    property Double: boolean read FDouble write FDouble default false;
    property Triple: boolean read FTriple write FTriple default false;
    property Any: boolean read FAny write FAny default false;
    // active events
    property Active: boolean read FActive write FActive default false;
    property Key: string read FKey write FKey;
    property Button: integer read FButton write FButton default 0;
  end;

  TELEventEditorDlg = class(TPyIDEDlgBase)
    GBModifier: TGroupBox;
    CBControl: TCheckBox;
    CBShift: TCheckBox;
    CBAlt: TCheckBox;
    CBDouble: TCheckBox;
    CBTriple: TCheckBox;
    RBMouseButton: TRadioGroup;
    GBKey: TGroupBox;
    CBKey: TComboBox;
    CBAny: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormResize(Sender: TObject);
    procedure CBKeySelect(Sender: TObject);
    procedure CBAnyClick(Sender: TObject);
  public
    function Execute: Boolean;
    procedure setEvent(Event: TEvent);
    procedure getEvent(var Event: TEvent);
  end;

procedure GetEventProperties(Obj: TObject; PropName: String; var Event: TEvent);
procedure SetEventProperties(Obj: TObject; PropName: string; Event: TEvent);


implementation

uses UBaseWidgets;

{$R *.dfm}

procedure GetEventProperties(Obj: TObject; PropName: String; var Event: TEvent);
var
  FContext : TRttiContext;
  FType    : TRttiType;
  FProp    : TRttiProperty;
begin
  FType:= FContext.GetType(Obj.ClassType);
  FProp:= FType.GetProperty(PropName);
  if FProp.IsWritable and (FProp.PropertyType.TypeKind = tkClass) then
    Event:=  TEvent(FProp.GetValue(Obj).AsObject);
end;

procedure SetEventProperties(Obj: TObject; PropName: string; Event: TEvent);
var
  FContext : TRttiContext;
  FType    : TRttiType;
  FProp    : TRttiProperty;
  Value    : TValue;
begin
  FType:= FContext.GetType(Obj.ClassType);
  FProp:= FType.GetProperty(PropName);
  if FProp.IsWritable then begin
    TValue.Make(@Event, TypeInfo(TEvent), Value);
    FProp.SetValue(Obj, Value);
  end;
end;

{--- TEvent -------------------------------------------------------------------}

constructor TEvent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Clear;
  if AOwner is TBaseWidget then
    SetSubComponent(true);
end;

procedure TEvent.Clear;
begin
  FControl:= false;
  FShift:= false;
  FAlt:= false;
  FDouble:= false;
  FTriple:= false;
  FAny:= false;
  FActive:= false;
  FKey:= '';
  FButton:= 0;
end;

function TEvent.getModifiers(Eventname: string): string;
  var s: String;
begin
  s:= '';
  if FControl then s:= s + 'Control-';
  if FShift   then s:= s + 'Shift-';
  if FAlt     then s:= s + 'Alt-';
  if FDouble  then s:= s + 'Double-';
  if FTriple  then s:= s + 'Triple-';
  if FAny     then s:= s + 'Any-';
  if (Pos('Button', Eventname) = 0) and (FButton > 0) then
    s:= s + 'Button' + IntToStr(FButton) + '-';
  Result:= s;
end;

function TEvent.getDetail(Eventname: String): string;
begin
  Result:= '';
  if (Pos('Button', Eventname) > 0) and (FButton > 0) then
    Result:= '-' + IntToStr(FButton)
  else if (Pos('Key', Eventname) > 0) and not FAny and (FKey <> '')
    then Result:= '-' + FKey;
end;

{--- TELEventEditorDlg --------------------------------------------------------}

procedure TELEventEditorDlg.FormResize(Sender: TObject);
begin
  SetBounds(Mouse.CursorPos.x - Width, Mouse.CursorPos.y + 10, Width, Height);
end;

procedure TELEventEditorDlg.setEvent(Event: TEvent);
begin
  CBControl.Checked:= Event.Control;
  CBShift.Checked  := Event.Shift;
  CBAlt.Checked    := Event.Alt;
  CBDouble.Checked := Event.Double;
  CBTriple.Checked := Event.Triple;
  CBAny.Checked    := Event.Any;
  CBKey.Text       := Event.Key;
  RBMouseButton.ItemIndex:= Event.Button;
end;

procedure TELEventEditorDlg.getEvent(var Event: TEvent);
begin
  Event.Control:= CBControl.Checked;
  Event.Shift  := CBShift.Checked;
  Event.Alt    := CBAlt.Checked;
  Event.Double := CBDouble.Checked;
  Event.Triple := CBTriple.Checked;
  Event.Any    := CBAny.Checked;
  Event.Key    := CBKey.Text;
  Event.Button := RBMouseButton.ItemIndex
end;

procedure TELEventEditorDlg.CBAnyClick(Sender: TObject);
begin
  if CBAny.Checked then
    CBKey.Text:= '';
end;

procedure TELEventEditorDlg.CBKeySelect(Sender: TObject);
begin
  CBAny.Checked:= false;
end;

function TELEventEditorDlg.Execute: Boolean;
begin
  Result := (ShowModal = mrOk);
end;

initialization
  // ReadComponent must know this type
  System.Classes.RegisterClass(TEvent);

end.
