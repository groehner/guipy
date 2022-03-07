{
  ESS-Model
  Copyright (C) 2002  Eldean AB, Peter Söderman, Ville Krumlinde

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
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

unit UListeners;

{
  Listener interface for the objectmodel

  Obs
  Object that are listeners have to inherit from TComponent.
  If TInterfaceObject is used there will be an error in refcount.
  TComponent implements it's own queryinterface and addref.


 alternativ implementation:
   TMethodReference
   AddListener(Self, [ [mtBeforeChange,OnBeforeChange] , [mtBeforeAdd,OnBeforeAdd] ]);

}

interface

uses uModelEntity;

type

  IObjectModelListener = interface(IUnknown)
    ['{4CC11ED0-016F-4CC4-952E-E223340B1174}']
    procedure Change(Sender: TModelEntity);
  end;

  IBeforeObjectModelListener = interface(IObjectModelListener)
    ['{714C82A0-1098-11D4-B920-005004E9A134}']
  end;

  IAfterObjectModelListener = interface(IObjectModelListener)
    ['{714C82A1-1098-11D4-B920-005004E9A134}']
  end;

  IModelEntityListener = interface(IObjectModelListener)
    ['{A0114AD4-5559-4A17-A4CC-19029E2EE268}']
    procedure AddChild(Sender: TModelEntity; NewChild: TModelEntity);
    procedure Remove(Sender: TModelEntity);
    procedure EntityChange(Sender: TModelEntity);
  end;

  IAbstractPackageListener = interface(IModelEntityListener)
    ['{1B711E8E-2051-4B2E-B197-57B00350E492}']
  end;

// **************** Unit Listener
  IUnitPackageListener = interface(IAbstractPackageListener)
    ['{AEFED5B4-14A4-41FF-AAD0-E4C449D01B58}']
  end;

  IBeforeUnitPackageListener = interface(IUnitPackageListener)
    ['{D8475313-BA6D-4050-A105-9287CA678216}']
  end;

  IAfterUnitPackageListener = interface(IUnitPackageListener)
    ['{2D08BE97-E22D-4105-86ED-84350C2C8C57}']
  end;
//End **************** Unit Listener

// **************** Package Listener
  ILogicPackageListener = interface(IAbstractPackageListener)
    ['{6FB79808-C0B4-4753-BD6D-F92C261DA4E5}']
  end;

  IBeforeLogicPackageListener = interface(ILogicPackageListener)
    ['{5E248881-7BD9-4AB4-8C90-C101B16C69EC}']
  end;

  IAfterLogicPackageListener = interface(ILogicPackageListener)
    ['{255D189B-91EE-4716-99A7-3665728854F1}']
  end;
//End **************** Package Listener

  IClassifierListener = interface(IModelEntityListener)
    ['{F0C0631A-16AC-4266-8A8A-5F9AA395554B}']
  end;

// **********  Class Listener
  IClassListener = interface(IClassifierListener)
    ['{4FBA6C2E-DF42-4213-9E58-0F1CBD80AEB2}']
  end;

  IBeforeClassListener = interface(IClassListener)
    ['{46AD8567-B5E8-4284-808C-A8C0FCCBE6FD}']
  end;

  IAfterClassListener = interface(IClassListener)
    ['{F874EE04-3077-4D7A-8F16-E34631807EDA}']
  end;
//End **********  Class Listener

// **********  Objekt Listener Röhner
  IObjektListener = interface(IClassListener)
    ['{D7FF5410-23A2-4745-B16B-646A5EDE8556}']
  end;

  IBeforeObjektListener = interface(IObjektListener)
    ['{74EACABA-80E6-4F7E-99DA-BCE19E3CD9C2}']
  end;

  IAfterObjektListener = interface(IObjektListener)
    ['{14424746-FDB7-4976-8521-11CA0722B81A}']
  end;
//End **********  Class Listener

// **********  Interface Listener
  IInterfaceListener = interface(IClassifierListener)
    ['{6AB92947-C77C-49E7-93DF-EEF0B7D7F45E}']
  end;

  IBeforeInterfaceListener = interface(IInterfaceListener)
    ['{AF2C3B4E-12E4-4F5A-AA07-77049CE1E8B5}']
  end;

  IAfterInterfaceListener = interface(IInterfaceListener)
    ['{039E9A7A-475E-47A8-98E2-727C278F7AB4}']
  end;
//End **********  Interface Listener

// **********  Datatype Listener
  IDatatypeListener = interface(IClassifierListener)
    ['{9650274C-47AA-44D4-B76B-A867DF094E4A}']
  end;

  IBeforeDatatypeListener = interface(IDatatypeListener)
    ['{492B6671-1FB8-472B-A1DA-FB002C864779}']
  end;

  IAfterDatatypeListener = interface(IDatatypeListener)
    ['{3CD87D48-BD6A-43F4-9A6F-D0748D6E3F1A}']
  end;
//End **********  Datatype Listener

// **********  Feature Listener
  IFeatureListener = interface(IModelEntityListener)
    ['{C1F9E76B-DA8A-4508-BC60-962A806EDBF8}']
  end;

  IBeforeFeatureListener = interface(IFeatureListener)
    ['{78A97F99-7E32-47A3-984F-357EAE52C9BE}']
  end;

  IAfterFeatureListener = interface(IFeatureListener)
    ['{457C122C-CC1A-404D-B447-C099D4D40F19}']
  end;
//End **********  Feature Listener

// **********  Operation Listener
  IOperationListener = interface(IFeatureListener)
    ['{AF64DADA-191F-46F4-BEB0-7C3856CC549F}']
  end;

  IBeforeOperationListener = interface(IOperationListener)
    ['{16BE909B-8505-4006-B30F-5EDAF9875FD2}']
  end;

  IAfterOperationListener = interface(IOperationListener)
    ['{10A8F860-8871-4ED0-B2FC-71BD65E9F7BA}']
  end;
//End **********  Operation Listener

// **********  Attribute Listener
  IAttributeListener = interface(IFeatureListener)
    ['{03BA6E23-0F3C-4647-87FD-F8A5F04DA6C1}']
  end;

  IBeforeAttributeListener = interface(IAttributeListener)
    ['{9F4EB07A-2C7F-490B-9161-655B3FA163E5}']
  end;

  IAfterAttributeListener = interface(IAttributeListener)
    ['{8B48D0F6-1D96-4D72-B37E-6B36C84D0528}']
  end;
//End **********  Attribute Listener

// **********  Property Listener
  IPropertyListener = interface(IAttributeListener)
    ['{EEC99E1F-191A-4022-8AC9-F71DE9AFACE1}']
  end;

  IBeforePropertyListener = interface(IPropertyListener)
    ['{B119A949-B894-4BAE-AE65-48CD05B7584A}']
  end;

  IAfterPropertyListener = interface(IPropertyListener)
    ['{29AABC5C-173C-410D-9B1C-B0EEFEB3DC46}']
  end;
//End **********  Attribute Listener

// **********  Parameter Listener
  IParameterListener = interface(IModelEntityListener)
    ['{9D0FF740-0F95-11D4-B920-005004E9A134}']
  end;

  IBeforeParameterListener = interface(IParameterListener)
    ['{9D0FF741-0F95-11D4-B920-005004E9A134}']
  end;

  IAfterParameterListener = interface(IParameterListener)
    ['{9D0FF742-0F95-11D4-B920-005004E9A134}']
  end;
//End **********  Paremeter Listener


implementation

end.
