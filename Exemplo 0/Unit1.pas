unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    function DivideMaisUm(A,B: Integer): Integer;
    function DivideMaisUm2(A,B: Integer): Integer;
    function DivideMaisUm3(A,B: Integer): Integer;
    function DivideMaisUm4(A,B: Integer): Integer;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.Math;

procedure TForm1.Button1Click(Sender: TObject);
var Result: Integer;
begin
  Result := DivideMaisUm(12,0);
  ShowMessage('Fim da procedure : '+Result.ToString)
end;

procedure TForm1.Button2Click(Sender: TObject);
var Result: Integer;
begin
  Result := DivideMaisUm2(12,0);
  ShowMessage('Fim da procedure : '+Result.ToString)

end;

procedure TForm1.Button3Click(Sender: TObject);
var Result: Integer;
begin
  Result := 0;
  try
    Result := DivideMaisUm3(12,0);
  except
    on e: Exception do
      showmessage(E.Message);
  end;

  ShowMessage('Fim da procedure : '+Result.ToString)
end;

procedure TForm1.Button4Click(Sender: TObject);
var Result: Integer;
begin
  Result := 0;
  try
    Result := DivideMaisUm4(12,0);
  except
    on e: Exception do
      showmessage(E.ToString);
  end;

  ShowMessage('Fim da procedure : '+Result.ToString)

end;

function TForm1.DivideMaisUm(A, B: Integer): Integer;
begin
  try
    Result := A div B;
    Inc(Result);
  except
    Result := 0;
  end;
end;

function TForm1.DivideMaisUm2(A, B: Integer): Integer;
begin
  try
    Result := A div B;
    Inc(Result);
  except
    on EDivByZero do
    begin
      Result := 0;
      MessageDlg('Erro de divisão por zero',TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0)
    end;
    on E: Exception do
    begin
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
      Result := 0;
    end;
  end;
end;

function TForm1.DivideMaisUm3(A, B: Integer): Integer;
begin
  try
    Result := A div B;
    Inc(Result);
  except
    on EDivByZero do
    begin
      Result := 0;
      if A = 0 then
        raise EArgumentException.Create('Parametro A com valor zero')
      else
        raise EArgumentException.Create('Parametro B com valor zero');
    end;
    on E: Exception do
    begin
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
      Result := 0;
    end;
  end;
end;

function TForm1.DivideMaisUm4(A, B: Integer): Integer;
begin
  try
    Result := A div B;
    Inc(Result);
  except
    on EDivByZero do
    begin
      Result := 0;
      if A = 0 then
        Exception.RaiseOuterException(
          EArgumentException.Create('Parametro A com valor zero'))
      else
        Exception.RaiseOuterException(
          EArgumentException.Create('Parametro B com valor zero'));
    end;
    on E: Exception do
    begin
      MessageDlg(E.Message,TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
      Result := 0;
    end;
  end;
end;

end.
