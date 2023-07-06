unit ULog;

interface

uses SysUtils,System.Generics.Collections;

type TTipoLog = (tlErro,tlTrace,tlAuditoria,tlDebug,tlPerformance);
     TTipoLogSet = set of TTipoLog;

ILogger = interface
['{5BD70123-9EF4-4D0F-AD68-4CF35BC3BB4A}']
  procedure Log(Msg: array of variant); overload;
  procedure Log(Exception: Exception); overload;
end;

TLogCentral = class
  private
    FLoggers: TObjectDictionary<TTipoLog,TList<ILogger>>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure AddLogger(ALogger: ILogger;ATipos: TTipoLogSet);
    procedure Log(ATipo: TTipoLog;AMsg: Array of variant); overload;
    procedure Log(AException: Exception); overload;
    procedure Log(ATipo: TTipoLog;AMsg: String); overload;
end;


var LogCentral: TLogCentral;


implementation

{ LogCentral }



{ TLogCentral }

procedure TLogCentral.Log(ATipo: TTipoLog; AMsg: array of variant);
var Logger: ILogger;
begin
  if FLoggers.ContainsKey(ATipo) then
    for Logger in FLoggers[ATipo] do
      Logger.Log(AMsg);
end;

procedure TLogCentral.Log(AException: Exception);
var Logger: ILogger;
begin
  if FLoggers.ContainsKey(tlErro) then
    for Logger in FLoggers[tlErro] do
      Logger.Log(AException);
end;

procedure TLogCentral.AddLogger(ALogger: ILogger; ATipos: TTipoLogSet);
var ATipo: TTipoLog;
begin
  for ATipo in ATipos do
  begin
    if not FLoggers.ContainsKey(ATipo) then
      FLoggers.Add(ATipo,TList<ILogger>.Create);

    FLoggers[ATipo].Add(ALogger);
  end;
end;

constructor TLogCentral.Create;
begin
  FLoggers := TObjectDictionary<TTipoLog,TList<ILogger>>.Create([doOwnsValues]);
end;

destructor TLogCentral.Destroy;
begin
  FLoggers.DisposeOf;
  inherited;
end;

procedure TLogCentral.Log(ATipo: TTipoLog; AMsg: String);
begin
  Log(ATipo,[AMsg,Now]);
end;


initialization
  LogCentral := TLogCentral.Create;

finalization
  LogCentral.DisposeOf;

end.



