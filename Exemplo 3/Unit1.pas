unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Math;

type
  TForm1 = class(TForm)
    Resultado: TRadioGroup;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    FValorPrincipal: Extended;
    procedure Soma(valor: Integer);
    procedure Divide(valor: Integer);
    procedure Multiplica(valor: Integer);
    procedure Subtrai(valor: Integer);
    procedure ArredondaPraBaixo;
    procedure ArredondaPraCima;
    function Aleatorio: Integer;
    procedure Corrige;
    procedure RodaAleatorio;
    procedure setValorPrincipal(const Value: Extended);
    { Private declarations }
  public
    property ValorPrincipal: Extended read FValorPrincipal write setValorPrincipal;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.Aleatorio: Integer;
begin
  Result := Random(20)+1;
end;

procedure TForm1.ArredondaPraBaixo;
begin
  ValorPrincipal := Floor(valorPrincipal);
end;

procedure TForm1.ArredondaPraCima;
begin
  ValorPrincipal := Ceil(valorPrincipal);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i: integer;
begin
  for I := 0 to Aleatorio do
  begin
    RodaAleatorio;
  end;
end;

procedure TForm1.Corrige;
begin
  while ValorPrincipal < 1 do
  begin
    case Aleatorio of
      1..10: Soma(Aleatorio);
      11..20: Multiplica(Aleatorio);
    end;
    ArredondaPraCima;
  end;


  while ValorPrincipal > 20 do
  begin
    case Aleatorio of
      1..10: Subtrai(Aleatorio);
      11..20: Divide(Aleatorio);
    end;
    ArredondaPraBaixo;
  end;

  if (ValorPrincipal < 1) or (ValorPrincipal > 20) then
    Corrige;
end;

procedure TForm1.Divide(valor: Integer);
begin
  ValorPrincipal := ValorPrincipal / Valor;
end;

procedure TForm1.Multiplica(valor: Integer);
begin
  ValorPrincipal := ValorPrincipal * Valor;
end;

procedure TForm1.RodaAleatorio;
  var Passos: Integer;
    I: Integer;
begin
    Randomize;
    Passos := Aleatorio;
    ValorPrincipal := Aleatorio;
    for I := 1 to Passos do
    begin
      case Aleatorio of
        1..4   : Soma(Aleatorio);
        5..8   : Subtrai(Aleatorio);
        9..12  : Divide(Aleatorio);
        13..16 : Multiplica(Aleatorio);
        17..18 : ArredondaPraBaixo;
        19..20 : ArredondaPraCima;
      end;
    end;
    Corrige;
    Resultado.ItemIndex := Trunc(ValorPrincipal)-1;
end;

procedure TForm1.setValorPrincipal(const Value: Extended);
begin
  FValorPrincipal := Value;
  if (trunc(FValorPrincipal) > 0) or
     (trunc(FValorPrincipal) < 20) then
  begin
    Resultado.ItemIndex := tRUNC(FValorPrincipal);
    Application.ProcessMessages;
    sleep(150)
  end;
end;

procedure TForm1.Soma(valor: Integer);
begin
  ValorPrincipal := ValorPrincipal + Valor;
end;

procedure TForm1.Subtrai(valor: Integer);
begin
  ValorPrincipal := ValorPrincipal - Valor;
end;

end.
