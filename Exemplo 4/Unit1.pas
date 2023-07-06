unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ULog;


{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var a,b,c: integer;
begin
  try
    a := 5;
    b := 0;
    c := a div b;
  except
    on e: exception do
      LogCentral.Log(e);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  LogCentral.Log(tlDebug,'Teste');
end;

end.
