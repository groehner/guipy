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

function zzGetControlZOrder (
                  aControl   : TObject     // only Controls are processed, but you can throw anything you like at this
                  ) : integer;
  // return the Z order of the control within its parent
  // if not found or not applicable, return -1
  // the order is zero based, so the first control is # 0

function zzSetControlZOrder (
                  aControl   : TObject;    // only Controls are processed, but you can throw anything you like at this
                  aNewZorder : integer     // ignore if this is -1
                  ) : boolean;
  // set the Z order of the control
  // if a control already exists at this Z Order, the aControl will be placed underneath it (pushing the other control up)
  // the order is zero based, so the first control is # 0
  //
  // ignore all errors
  // return TRUE if change was applied
  // return FALSE if the Z order was not changed at all

implementation

uses
       System.Classes
//    ,MainForm          // for testing
      ,VCL.Controls;

// =============================================================================

function zzGetControlZOrder (
                  aControl   : TObject        // only Controls are processed, but throw anything you like at this
                  ) : integer;
  // return the Z order of the control within its parent
  // if not found or not applicable, return -1
  // the order is zero based, so the first control is # 0
var
  i        : integer;
  vControl : TControl;
  vList    : TList;
  vParent  : TWinControl;
begin
  result := -1;                                         // flag for not found or not relevent

  try

      if    (aControl  is TControl)                          // some of these might not be needed
        and ((aControl as TControl).Parent is TComponent)
        and ((aControl as TControl).Parent <> nil)           // unlikely but may as well check
//      and ((aControl as TControl).Parent is TWinControl)   // not required as the parent must be a TWinControl if not nil
      then
          begin
          vControl := aControl as TControl;
          vParent  := vControl.Parent as TWinControl;

          vList := TList.Create;
                                                         // determine current position in z-order
          for i := 0 to vParent.ControlCount - 1 do      // loop through all children
              if  vParent.Controls[i] = aControl then    // found the control
                  begin
                  result := i;
                  Break;
                  end;

          vList.Free;
          end;
  except          // ignore all errors
  end;
end;

// =============================================================================

function zzSetControlZOrder (
                  aControl   : TObject;    // only Controls are processed, but you can throw anything you like at this
                  aNewZorder : integer     // ignore if this is -1
                  ) : boolean;
  // set the Z order of the control
  // if a control already exists at this Z Order, the control will be placed underneath it (pushing the other control up)
  // the order is zero based, so the first control is # 0
  //
  // ignore all errors
  // return TRUE if change was applied
  // return FALSE if not changed, probably because the Z Order can not be set
var
  i           : Integer;
  vControl    : TControl;
  vZorderList : TList;         // list of controls to be raised
  vParent     : TWinControl;   // form, panel, button etc
  vCurrentZ   : integer;
  vFirstZ     : integer;
begin
  result := FALSE;

  vCurrentZ := zzGetControlZOrder(aControl);

  if    (aControl is TControl)
    and (vCurrentZ <> -1)
    and (vCurrentZ <> aNewZorder)
    and (aNewZorder >= 0)
    and ((aControl as TControl).Parent <> nil)           // unlikely but may as well check
//  and ((aControl as TControl).Parent is TWinControl)   // not required as the parent must be a TWinControl if not nil
  then
        begin
        vZorderList := TList.Create;
        try
              vControl := aControl as TControl;
              vParent  := vControl.Parent as TWinControl;

              if     aNewZOrder > vCurrentZ      // if moving higher in Z order
                then vFirstZ := aNewZOrder + 1
                else vFirstZ := aNewZOrder;
                                                                 // populate list of controls that need to be raised to the top
              vZorderList.Add (aControl);                        // source control
              for i := vFirstZ to vParent.ControlCount - 1 do
                  if  vParent.Controls[i] <> aControl then       // skip source control as already added
                      vZorderList.Add (vParent.Controls[i]);     // other controls

                                                    // loop through controls and bring each one to the front
              for i := 0 to vZorderList.count - 1 do
                  TControl (vZorderList[i]).BringToFront;

              if  vParent is TControl then
                  (vParent as TControl).Repaint;

              result := TRUE;

        finally
             vZorderList.Free;
        end;
        end;
end;

// =============================================================================

end.
