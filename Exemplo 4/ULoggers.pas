unit ULoggers;

interface

uses ULog, System.SysUtils;

type TLogArquivo = class(TInterfacedObject,ILogger)
  private
    FArquivo: String;
    procedure Escreve(Msg: String);
  public
    constructor Create(AArquivo: String); reintroduce;
    procedure Log(Msg: array of variant); overload;
    procedure Log(Exception: Exception); overload;
end;

 TLogEvent = class(TInterfacedObject,ILogger)
  private
    procedure Escreve(Msg: String);
  public
    procedure Log(Msg: array of variant); overload;
    procedure Log(Exception: Exception); overload;
end ;

implementation

uses
  System.Classes,Variants, Winapi.Windows;

{ TLogTexto }

constructor TLogArquivo.Create(AArquivo: String);
begin
  FArquivo := AArquivo;
end;

procedure TLogArquivo.Escreve(Msg: String);
var tmp: tstringlist;
begin
  tmp := TStringList.Create;
  try
    if FileExists(FArquivo) then
      tmp.LoadFromFile(FArquivo);

    tmp.Add(Msg);
    tmp.SaveToFile(FArquivo);
  finally
    tmp.DisposeOf;
  end;
end;

procedure TLogArquivo.Log(Exception: Exception);
begin
  Escreve('[ERRO]: '+Exception.ToString+' ('+Exception.ClassName+')');
end;

procedure TLogArquivo.Log(Msg: array of variant);
var dt: TDateTime;
  I: Integer;
  tmp: String;
begin
  dt := 0;
  tmp := '';
  for I := Low(msg) to High(msg) do
  begin
    if (vartype(msg[i]) = varDate) and
      ( dt = 0) then
     dt := msg[i]
    else
      tmp := tmp+' '+vartostrdef(msg[i],'');
  end;

  if dt <> 0 then
    tmp := '['+FormatDateTime('DD/MM/YY HH:NN:SS:ZZZZ',dt)+'] '+tmp;

  Escreve(tmp);
end;

{ TLogEvent }

procedure TLogEvent.Escreve(Msg: String);
begin
  OutputDebugString(Pchar(Msg));
end;

procedure TLogEvent.Log(Msg: array of variant);
var dt: TDateTime;
  I: Integer;
  tmp: String;
begin
  dt := 0;
  tmp := '';
  for I := Low(msg) to High(msg) do
  begin
    if (vartype(msg[i]) = varDate) and
      ( dt = 0) then
     dt := msg[i]
    else
      tmp := tmp+' '+vartostrdef(msg[i],'');
  end;

  if dt <> 0 then
    tmp := '['+FormatDateTime('DD/MM/YY HH:NN:SS:ZZZZ',dt)+'] '+tmp;

  Escreve(tmp);
end;

procedure TLogEvent.Log(Exception: Exception);
begin
  Escreve('[ERRO]: '+Exception.ToString+' ('+Exception.ClassName+')');
end;

end.
