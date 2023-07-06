program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ULog in 'ULog.pas',
  ULoggers in 'ULoggers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  LogCentral.AddLogger(TLogArquivo.Create('c:\temp\logBruto.log'),[tlDebug,tlErro]);
  LogCentral.AddLogger(TLogEvent.Create,[tlDebug]);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
