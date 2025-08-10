program setup;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  Controls,
  SysUtils,
  UMemo in 'UMemo.pas' {FMemo},
  UUtils in 'UUtils.pas',
  USetup in 'USetup.pas' {FSetup},
  UUpdater in 'UUpdater.pas' {FUpdater},
  UWait in 'UWait.pas' {Fwait},
  UStringRessources in 'UStringRessources.pas';

{$R administrator.res}  // uncomment for debugging

var Param: string;

begin
  Application.Initialize;
  Application.CreateForm(TFSetup, FSetup);
  Application.CreateForm(TFMemo, FMemo);
  Application.CreateForm(TFUpdater, FUpdater);
  Application.CreateForm(TFwait, FWait);
  Param:= paramStr(1);
  if (Param <> '-Update') and (Param <> '-Registry') then begin
    Application.ShowMainForm:= true;
    Application.Run;
  end else begin
    Application.ShowMainForm:= false;
    FWait.Show;
    FWait.Invalidate;
    Application.ProcessMessages;
    Screen.Cursor:= crHourGlass;
    FUpdater.MakeUpdate;
    FWait.Hide;
    Screen.Cursor:= crDefault;
    if FUpdater.Restart then
      if FUpdater.Error then begin
        FUpdater.Show;
        Application.Run;
      end else
        FUpdater.BOKClick(nil)
  end;
end.
