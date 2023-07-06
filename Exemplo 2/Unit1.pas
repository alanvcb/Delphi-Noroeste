unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function RoundABNT(const AValue: Double; const Digits: SmallInt): Double;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses MAth;

procedure TForm1.Button1Click(Sender: TObject);
begin
  edit2.Text := RoundABNT(StrToFloat(Edit1.Text),2).ToString;
end;

function TForm1.RoundABNT(const AValue: Double; const Digits: SmallInt): Double;
var
  Pow: Extended;
  PowValue: Extended;
  RestPart: Extended;
  IntPart: Int64;
  FracPart: Int64;
  LastNumber: Int64;
begin
  Pow      := IntPower(10, Abs(Digits) );
  PowValue := SimpleRoundTo(AValue * Pow, -9) ; // SimpleRoundTo elimina dizimas ;
  IntPart  := Trunc(PowValue);
  FracPart := Trunc(Frac(PowValue) * 100);

  if (FracPart > 50) then
    System.Inc(IntPart)
  else
  if (FracPart = 50) then
  begin
    LastNumber := Round(Frac(IntPart / 10) * 10);

    if odd(LastNumber) then
      System.Inc( IntPart )
    else
    begin
      RestPart := Frac(PowValue * 10);

      if RestPart > 0 then
        System.Inc(IntPart);
    end;
  end;

  Result := (IntPart / Pow);
end;

end.
