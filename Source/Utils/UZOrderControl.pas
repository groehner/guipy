unit UZOrderControl;

{
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  PURPOSE     Get and Set the Z order of VCL controls

  AUTHOR      Scott Hollows
  Web     www.ScottHollows.com
  Email   scott.hollow@gmail.com

  LEGAL
  Placed in the public domain
  Use at your own risk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}

interface

function ZzGetControlZOrder(AControl: TObject
  // only Controls are processed, but you can throw anything you like at this
  ): Integer;
// return the Z order of the control within its parent
// if not found or not applicable, return -1
// the order is zero based, so the first control is # 0

function ZzSetControlZOrder(AControl: TObject;
  // only Controls are processed, but you can throw anything you like at this
  ANewZorder: Integer // ignore if this is -1
  ): Boolean;
// set the Z order of the control
// if a control already exists at this Z Order, the AControl will be placed underneath it (pushing the other control up)
// the order is zero based, so the first control is # 0
//
// ignore all errors
// return True if change was applied
// return FALSE if the Z order was not changed at all

implementation

uses
  Windows,
  SysUtils,
  System.Classes,
  Vcl.Controls;

// =============================================================================

function ZzGetControlZOrder(AControl: TObject
  // only Controls are processed, but throw anything you like at this
  ): Integer;
// return the Z order of the control within its parent
// if not found or not applicable, return -1
// the order is zero based, so the first control is # 0
var
  VControl: TControl;
  VList: TList;
  VParent: TWinControl;
begin
  Result := -1; // flag for not found or not relevent
  try
    if (AControl is TControl) // some of these might not be needed
      and ((AControl as TControl).Parent is TComponent) and
      Assigned((AControl as TControl).Parent) // unlikely but may as well check
    then
    begin
      VControl := AControl as TControl;
      VParent := VControl.Parent;
      VList := TList.Create;
      // determine current position in z-order
      for var I := 0 to VParent.ControlCount - 1 do // loop through all children
        if VParent.Controls[I] = AControl then // found the control
        begin
          Result := I;
          Break;
        end;

      VList.Free;
    end;
  except
    on E: Exception do
      OutputDebugString(PChar('Exception: ' + E.ClassName + ' - ' + E.Message));
  end;
end;

// =============================================================================

function ZzSetControlZOrder(AControl: TObject;
  // only Controls are processed, but you can throw anything you like at this
  ANewZorder: Integer // ignore if this is -1
  ): Boolean;
// set the Z order of the control
// if a control already exists at this Z Order, the control will be placed underneath it (pushing the other control up)
// the order is zero based, so the first control is # 0
//
// ignore all errors
// return True if change was applied
// return FALSE if not changed, probably because the Z Order can not be set
var
  VControl: TControl;
  VZorderList: TList; // list of controls to be raised
  VParent: TWinControl; // form, panel, button etc
  VCurrentZ: Integer;
  VFirstZ: Integer;
begin
  Result := False;
  VCurrentZ := ZzGetControlZOrder(AControl);
  if (AControl is TControl) and (VCurrentZ <> -1) and (VCurrentZ <> ANewZorder)
    and (ANewZorder >= 0) and Assigned((AControl as TControl).Parent)
  // unlikely but may as well check
  then
  begin
    VZorderList := TList.Create;
    try
      VControl := AControl as TControl;
      VParent := VControl.Parent;
      if ANewZorder > VCurrentZ // if moving higher in Z order
      then
        VFirstZ := ANewZorder + 1
      else
        VFirstZ := ANewZorder;
      // populate list of controls that need to be raised to the top
      VZorderList.Add(AControl); // source control
      for var I := VFirstZ to VParent.ControlCount - 1 do
        if VParent.Controls[I] <> AControl then
        // skip source control as already added
          VZorderList.Add(VParent.Controls[I]); // other controls
      // loop through controls and bring each one to the front
      for var I := 0 to VZorderList.Count - 1 do
        TControl(VZorderList[I]).BringToFront;
      if VParent is TControl then
        (VParent as TControl).Repaint;
      Result := True;
    finally
      VZorderList.Free;
    end;
  end;
end;

// =============================================================================

end.
