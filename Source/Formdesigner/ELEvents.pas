{-------------------------------------------------------------------------------
 Unit:     ELEvents
 Author:   Gerhard R�hner
 Date:     May 2021
 Purpose:  tkinter mouse and key events
-------------------------------------------------------------------------------}

unit ELEvents;

interface

uses
  System.Classes,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  dlgPyIDEBase, Vcl.Controls;

type

  TEvent = class(TComponent)
  private
    // modifier
    FControl: Boolean;
    FShift: Boolean;
    FAlt: Boolean;
    FDouble: Boolean;
    FTriple: Boolean;
    FAny: Boolean;
    FActive: Boolean;
    // qualifier
    FKey: string;
    FButton: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    function getModifiers(Eventname: string): string;
    function getDetail(Eventname: string): string;
    procedure Clear;
  published
    property Control: Boolean read FControl write FControl default False;
    property Shift: Boolean read FShift write FShift default False;

    property Alt: Boolean read FAlt write FAlt default False;
    property Double: Boolean read FDouble write FDouble default False;
    property Triple: Boolean read FTriple write FTriple default False;
    property Any: Boolean read FAny write FAny default False;
    // active events
    property Active: Boolean read FActive write FActive default False;
    property Key: string read FKey write FKey;
    property Button: Integer read FButton write FButton default 0;
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

procedure GetEventProperties(Obj: TObject; PropName: string; var Event: TEvent);
procedure SetEventProperties(Obj: TObject; PropName: string; Event: TEvent);


implementation

uses
  System.SysUtils,
  System.TypInfo,
  Vcl.Forms,
  RTTI,
  UBaseWidgets;

{$R *.dfm}

procedure GetEventProperties(Obj: TObject; PropName: string; var Event: TEvent);
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
    SetSubComponent(True);
end;

procedure TEvent.Clear;
begin
  FControl:= False;
  FShift:= False;
  FAlt:= False;
  FDouble:= False;
  FTriple:= False;
  FAny:= False;
  FActive:= False;
  FKey:= '';
  FButton:= 0;
end;

function TEvent.getModifiers(Eventname: string): string;
  var s: string;
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

function TEvent.getDetail(Eventname: string): string;
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
  CBAny.Checked:= False;
end;

function TELEventEditorDlg.Execute: Boolean;
begin
  Result := (ShowModal = mrOk);
end;

initialization
  // ReadComponent must know this type
  System.Classes.RegisterClass(TEvent);

end.
