unit uConsoleApplication;

interface

uses
   Windows,
   SysUtils,
   uProduto,
   uIAeroNave,
   uAviao,
   uHelicoptero,
   Variants,
   Classes;

type
   TConsoleApplication = class

   private
      class procedure Cabecalho(cabecalho:string);
      class procedure PressioneQualquerTecla;
      class procedure MenuTipoReferencia;
      class procedure ClearScreen;
      class procedure GotoXY(X, Y : Word);
      class function GetConOutputHandle : THandle;

      class procedure ClassesTObject;
      class function ReferenceEquals(obj1, obj2:TObject):boolean;

      class procedure Interfaces;
      class procedure MostraComoAeronavesFazem(AeroNave:IAeroNave);

      class procedure EventosDelegates;
      class procedure MostrarCalculoNoDelegateDuasCasasDecimais(const produto:TObject);
      class procedure MostrarCalculoNoDelegateTresCasasDecimais(const produto:TObject);

      class procedure BoxingUnboxing;

      class procedure DynamicsVariants;
   public
      class procedure Executar;
   end;
implementation

var
   ConHandle : THandle; // Handle to console window
   Coord : TCoord; // To store/set screen position
   MaxX, MaxY : Word; // To store max window size
   NOAW : DWord; // To store results of some functions

class procedure TConsoleApplication.Executar;
begin
    ConHandle := GetConOutputHandle;
    // Get max window size
    Coord := GetLargestConsoleWindowSize(ConHandle);
    MaxX := Coord.X;
    MaxY := Coord.Y;
    MenuTipoReferencia;
end;

class function TConsoleApplication.GetConOutputHandle : THandle;
begin
    Result := GetStdHandle(STD_OUTPUT_HANDLE)
end;

class procedure TConsoleApplication.Cabecalho(cabecalho:string);
begin
    ClearScreen;
    WriteLn('============================================================');
    WriteLn(cabecalho);
    WriteLn('============================================================');
    WriteLn('');
end;

class procedure TConsoleApplication.ClearScreen;
begin
    Coord.X := 0; Coord.Y := 0;
    FillConsoleOutputCharacter( ConHandle, ' ', MaxX*MaxY, Coord, NOAW);
    GotoXY(0, 0);
end;

class procedure TConsoleApplication.GotoXY(X, Y : Word);
begin
    Coord.X := X; Coord.Y := Y;
    SetConsoleCursorPosition(ConHandle, Coord);
end;

class procedure TConsoleApplication.PressioneQualquerTecla;
begin
    WriteLn('');
    WriteLn('Presione qualquer tecla para continuar...');
    ReadLn;
end;

class procedure TConsoleApplication.MenuTipoReferencia;
var opcao:string;
    parar:boolean;
begin
   opcao := '';
   repeat
      Cabecalho('Menu Tipo por Referencia');
      WriteLn('Voce quer aprender sobre :');
      WriteLn('1 - Classes e TObject');
      WriteLn('2 - Interfaces');
      WriteLn('3 - Delegates(Eventos)');
      WriteLn('4 - Boxing e Unboxing');
      WriteLn('5 - Dynamics (Variants)');
      WriteLn('6 - Sair');
      ReadLn(opcao);
      if (opcao = '1') then
         ClassesTObject
      else if (opcao = '2') then
         Interfaces
      else if (opcao = '3') then
         EventosDelegates
      else if (opcao = '4') then
         BoxingUnboxing
      else if (opcao = '5') then
         DynamicsVariants;

      parar := opcao = '6';
   until(parar);
end;

class procedure TConsoleApplication.ClassesTObject;
var Produto1, Produto2, Produto3: TProduto;
begin
   Cabecalho('Classes e TObject');
   Produto1 := TProduto.Create;
   produto1.Codigo := 1;
   produto1.Descricao := 'Coca-Cola 2L Gelada';
   produto1.Preco := 5.75;
   produto1.Quantidade := 5;
   produto1.CalculaTotal;

   WriteLn('[Antes de criar ''produto2''] Variavel ''produto1'' ' + produto1.ConverterParaString);
   WriteLn('');

   produto2 := produto1;
   produto2.Quantidade := 10;
   produto2.CalculaTotal;
   WriteLn('[Depois de criar ''produto2''] Variavel ''produto2'' ' + produto2.ConverterParaString);
   WriteLn('[Depois de criar ''produto2''] Variavel ''produto1'' ' + produto1.ConverterParaString);
   WriteLn('');

   WriteLn('Metodo do TObject');
   WriteLn('produto1.ClassName = ' + produto1.ClassName);

   Produto3 := TProduto.Create;
   produto3.Codigo := 1;
   produto3.Descricao := 'Coca-Cola 2L Gelada';
   produto3.Preco := 5.75;
   produto3.Quantidade := 10;
   produto3.CalculaTotal;
   WriteLn('Repare que os dados do ''produto1'' e exatamente igual ao ''produto3'' ');
   WriteLn('Variavel ''produto1'' ' + produto1.ConverterParaString);
   WriteLn('Variavel ''produto3'' ' + produto3.ConverterParaString);

   if (produto1 = produto3) then
   begin
      WriteLn('Se entrar aqui e por que algo errado nao esta certo!');
   end
   else
   begin
      WriteLn('''Produto1'' e ''Produto3'' são identicos, mas não tem a mesma referencia!');
      WriteLn('Debugar a funcao ReferenceEquals e veja que os enderecos de memoria são os mesmos!');
      if ReferenceEquals(produto1, produto2) then
         WriteLn('Porem ''Produto1'' e a mesma referencia de ''Produto2'' na Heap. Confirmado! :D');
   end;

   FreeAndNil(produto2);
   try
       produto2.Quantidade := 10;
   Except on e:Exception do
      begin
          WriteLn('Ocorreu um acesso violento! ' + e.Message);
          WriteLn('Repare que tentei acessar uma variavel que não possui um conteudo na Heap');
      end;
   end;

   PressioneQualquerTecla;
end;

class function TConsoleApplication.ReferenceEquals(obj1, obj2:TObject):boolean;
var intObj1, intObj2: Integer;
begin
  intObj1 := integer(obj1);
  intObj2 := integer(obj2);

  Result := intObj1 = intObj2;
end;

class procedure TConsoleApplication.Interfaces;
var
   Aviao: TAviao;
   Helicoptero: THelicoptero;
begin
   Cabecalho('Interfaces');
   WriteLn('Instanciando classe Aviao');
   Aviao := TAviao.Create;
   WriteLn('');
   MostraComoAeronavesFazem(Aviao);

   WriteLn('');
   WriteLn('Instanciando classe Helicoptero');
   Helicoptero := THelicoptero.Create;
   WriteLn('');
   MostraComoAeronavesFazem(Helicoptero);
   PressioneQualquerTecla;
end;

class procedure TConsoleApplication.MostraComoAeronavesFazem(AeroNave:IAeroNave);
begin
   WriteLn('Para mostrar o que a aeronave faz nao preciso da classe, apenas da interface. Conheço a abstracao isso ja e suficiente.');
   WriteLn('');
   WriteLn('Nome da Aeronave ' + aeroNave.Nome);
   aeroNave.Decolar;
   WriteLn('');
   aeroNave.Pousar;
end;

class procedure TConsoleApplication.EventosDelegates;
var produto1, produto2: TProduto;
begin
   Cabecalho('Delegate(Eventos)');
   produto1 := TProduto.Create;
   produto1.Codigo := 1;
   produto1.Descricao := 'Coca-Cola 2L Gelada';
   produto1.Preco := 5.75;
   produto1.Quantidade := 5;
   produto1.OnMostrarCalculo := MostrarCalculoNoDelegateDuasCasasDecimais;
   produto1.CalculaTotal;

   produto2 := TProduto.Create;
   produto2.Codigo := 2;
   produto2.Descricao := 'Gasolina Aditivada 1L';
   produto2.Preco := 5.019;
   produto2.Quantidade := 13;
   produto2.OnMostrarCalculo := MostrarCalculoNoDelegateTresCasasDecimais;
   produto2.CalculaTotal;

   PressioneQualquerTecla;
end;

class procedure TConsoleApplication.MostrarCalculoNoDelegateDuasCasasDecimais(const produto:TObject);
var produtoToShow:TProduto;
begin
   produtoToShow := TProduto(produto);
   writeLn('Mostrando calculo com duas casas decimais');
   writeLn('Valor Total do Produto => ' + FormatFloat('R$ #,##0.00', produtoToShow.Preco) + ' x ' + IntToStr(produtoToShow.Quantidade) + ' = ' + FormatFloat('R$ #,##0.00', produtoToShow.Total));
end;

class procedure TConsoleApplication.MostrarCalculoNoDelegateTresCasasDecimais(const produto:TObject);
var produtoToShow:TProduto;
begin
   produtoToShow := TProduto(produto);
   writeLn('Mostrando calculo com tres casas decimais');
   writeLn('Valor Total do Produto => ' + FormatFloat('R$ #,###0.000)', produtoToShow.Preco) + ' x ' + IntToStr(produtoToShow.Quantidade) + ' = ' + FormatFloat('R$ #,##0.00', produtoToShow.Total));
end;

class procedure TConsoleApplication.BoxingUnboxing;
var o:TObject;
    inteiro, i :Integer;
begin
   Cabecalho('Boxing e Unboxing');
   inteiro := 123;
   o := TObject(inteiro);
   writeLn('No C# o boxing é implicito, aqui no Delphi nao!');
   writeLn('Fazendo Unboxing ' + IntToStr(integer(o)));
   i := Integer(o);
   writeLn('Copiado ao Valor de ''o'' para ''i'' valor =' + IntToStr(i));
   PressioneQualquerTecla;
end;

class procedure TConsoleApplication.DynamicsVariants;
var variantString, variantInt, variantDateTime, variantStringList: Variant;
begin
  Cabecalho('Variants (Dynamics C#)');

  variantString := 'Eduardo Aguiar';
  variantInt := 42;
  variantDateTime := Now;

  WriteLn(VarToStr(variantString));
  WriteLn(Integer(variantInt));
  WriteLn(DateToStr(variantDateTime));

  try
     WriteLn(DateToStr(variantString));
  except on e:Exception do
    begin
       WriteLn('Erro conversão ' + e.Message);
    end;
  end;

  PressioneQualquerTecla;
end;

end.
