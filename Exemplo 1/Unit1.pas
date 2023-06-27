unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type EArrayFull = class(Exception);

type TMinhaArray = class
  private
    FMinhaArray: TArray<Integer>;
    FMax: Integer;
    function IsFull: Boolean;
  public
    Constructor Create(AMax: Integer); reintroduce;
    procedure Add(Valor: Integer);
end;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FMinhaArray: TMinhaArray;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TMinhaArray }

procedure TMinhaArray.Add(Valor: Integer);
begin
  if IsFull then
    raise EArrayFull.Create('Array full')
  else
  begin
    SetLength(FMinhaArray,length(FMinhaArray)+1);
    FMinhaArray[High(FMinhaArray)] := Valor;
  end;
end;

constructor TMinhaArray.Create(AMax: Integer);
begin
  inherited Create;
  FMax := AMax;
end;

function TMinhaArray.IsFull: Boolean;
begin
  Result := Length(FMinhaArray) = FMax;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i: Integer;
begin
  I := 0;
  FMinhaArray := TMinhaArray.Create(10);
  repeat
    FMinhaArray.Add(Random(999));
    I := I + 1;
  until I = 10;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // Unguarded call
  FMinhaArray.Add(24);  ShowMessage('Nunca vai passar aqui!');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  try
    // This procedure raises an exception
    FMinhaArray.Add(24);    ShowMessage('Nunca vai passar aqui!');
  except    on EArrayFull do
      ShowMessage('Deu pau e eu tratei.');  end;  ShowMessage('Vai passar poraqui');
end;

end.
