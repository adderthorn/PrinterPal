unit PalSettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

type
  TPalSettings = class
  private
    FVerboseLogging: boolean;
    procedure ReadIni(FileName: string);
    procedure WriteIni(FileName: string);
  public
    constructor Create; overload;
    constructor Create(FileName: string); overload;
  published
    property VerboseLogging: boolean read FVerboseLogging;
  end;

const
  DEFAULT_INI = 'palsettings.ini';
  LOGGING_SECT = 'Logging';
  VERBOSE_LOGGING_KEY = 'VerboseLogging';

implementation

constructor TPalSettings.Create;
begin
  if not FileExists(DEFAULT_INI) then
    WriteIni(DEFAULT_INI);
  ReadIni(DEFAULT_INI);
end;

constructor TPalSettings.Create(FileName: string);
begin
  if not FileExists(FileName) then
    WriteIni(FileName);
  ReadIni(FileName);
end;

procedure TPalSettings.ReadIni(FileName: string);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(FileName);

  FVerboseLogging := IniFile.ReadBool(LOGGING_SECT, VERBOSE_LOGGING_KEY, false);

  FreeAndNil(IniFile);
end;

procedure TPalSettings.WriteIni(FileName: string);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(FileName);
  IniFile.WriteBOM:=false;
  IniFile.WriteBool(LOGGING_SECT, VERBOSE_LOGGING_KEY, FVerboseLogging);
  FreeAndNil(IniFile);
end;

end.

