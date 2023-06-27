unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type EArrayFull = class(Exception);
type EArrayFull2 = class(EArrayFull)
  private
    FTamanhoArray: Integer;
  published
    constructor Create(const Msg: string; const ATamanhoArray: Integer); Reintroduce;
    property TamanhoArray: Integer read FTamanhoArray write FTamanhoArray;
end;

type TMinhaArray = class
  private
    FMinhaArray: TArray<Integer>;
    FMax: Integer;
    function IsFull: Boolean;
  public
    Constructor Create(AMax: Integer); reintroduce;
    procedure Add(Valor: Integer);
    procedure Add2(Valor: Integer);
    procedure Add3(Valor: Integer);
end;

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

procedure TMinhaArray.Add2(Valor: Integer);
begin
  if IsFull then
    raise EArrayFull2.Create('Array full',length(FMinhaArray))
  else
  begin
    SetLength(FMinhaArray,length(FMinhaArray)+1);
    FMinhaArray[High(FMinhaArray)] := Valor;
  end;
end;

procedure TMinhaArray.Add3(Valor: Integer);
var Ex: EArrayFull2 ;
begin
  if IsFull then
  begin
    Ex := EArrayFull2.Create('Array full',0);
    Ex.TamanhoArray := Length(FMinhaArray);
  end
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
  FMinhaArray.Add(24);
  ShowMessage('Nunca vai passar aqui!');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  try
    // This procedure raises an exception
    FMinhaArray.Add(24);
    ShowMessage('Nunca vai passar aqui!');
  except
    on EArrayFull do
      ShowMessage('Deu pau e eu tratei.');
  end;
  ShowMessage('Vai passar poraqui');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  try
    // This procedure raises an exception
    FMinhaArray.Add2(24);
    ShowMessage('Nunca vai passar aqui!');
  except
    on E: EArrayFull2 do
      ShowMessage('Deu pau e eu tratei.:'+E.Message+#13+
      'Tamanho da Array : '+E.TamanhoArray.ToString);
  end;
  ShowMessage('Vai passar poraqui');
end;

{ EArrayFull2 }

constructor EArrayFull2.Create(const Msg: string; const ATamanhoArray: Integer);
begin
  inherited Create(Msg);
  FTamanhoArray := ATamanhoArray;
end;

end.
