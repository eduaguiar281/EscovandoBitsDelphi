unit uProduto;

interface
   uses SysUtils;

type
  MostrarCalculo = procedure (const produto:TObject) of object;

  TProduto = class(TObject)
  private
    FCodigo:Integer;
    FDescricao: string;
    FPreco: double;
    FQuantidade: integer;
    FTotal: double;
    FMostrarCalculo: MostrarCalculo;
    procedure SetCodigo(const value: integer);
    procedure SetDescricao(const value:string);
    procedure SetPreco(const value:double);
    procedure SetQuantidade(const value:integer);
    procedure SetMostrarCalculo(const value:MostrarCalculo);
    { Private declarations }
  public
    { Public declarations }
    property Codigo:Integer read FCodigo write SetCodigo;
    property Descricao: string read FDescricao write SetDescricao;
    property Preco: double read FPreco write SetPreco;
    property Quantidade : integer read FQuantidade write SetQuantidade;
    property Total : double read FTotal;
    property OnMostrarCalculo:MostrarCalculo read FMostrarCalculo write SetMostrarCalculo;
    procedure CalculaTotal;
    function ConverterParaString:string;
  end;

implementation

{TProduto}

procedure TProduto.CalculaTotal;
begin
    FTotal := FPreco * FQuantidade;
    if Assigned(FMostrarCalculo) then
       FMostrarCalculo(self);
end;

procedure TProduto.SetCodigo(const value: Integer);
begin
    FCodigo := value;
end;

procedure TProduto.SetDescricao(const value:string);
begin
   FDescricao := value;
end;

procedure TProduto.SetPreco(const value:double);
begin
   FPreco := value;
end;

procedure TProduto.SetQuantidade(const value:integer);
begin
   FQuantidade := value;
end;

function TProduto.ConverterParaString:String;
begin
    result := IntToStr(FCodigo) + '- ' + FDescricao + ' => '
        + FormatFloat('R$ #,##0.00', FPreco) + ' x '
        + IntToStr(FQuantidade) + ' = '
        + FormatFloat('R$ #,##0.00', FTotal);
end;

procedure TProduto.SetMostrarCalculo(const value:MostrarCalculo);
begin
   FMostrarCalculo := value;
end;

end.
