program PrinterPal;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp, PalSettings
  { you can add units after this };

type

  { TPrinterPal }

  TPrinterPal = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TPrinterPal }

procedure TPrinterPal.DoRun;
var
  ErrorMsg, ConfigFile: String;
  PalSettings: TPalSettings;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  ConfigFile := '';
  if HasOption('c', 'config') then begin
    ConfigFile := GetOptionValue('c', 'config');
  end;

  { add your program here }
  if ConfigFile = '' then begin
    PalSettings:=TPalSettings.Create;
  end else begin
    PalSettings:=TPalSettings.Create(ConfigFile);
  end;

  // stop program loop
  FreeAndNil(PalSettings);
  Terminate;
end;

constructor TPrinterPal.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TPrinterPal.Destroy;
begin
  inherited Destroy;
end;

procedure TPrinterPal.WriteHelp;
begin
  { add your help code here }
  WriteLn;
  WriteLn('Usage:');
  WriteLn;
  WriteLn('  printerpal [--OPTIONS]');
  WriteLn;
  WriteLn('Options:');
  WriteLn;
  WriteLn('  --config -c <FILE>', #9#9, 'Path to config file.');
  WriteLn;
end;

var
  Application: TPrinterPal;
begin
  Application:=TPrinterPal.Create(nil);
  Application.Title:='PrinterPal';
  Application.Run;
  Application.Free;
end.

