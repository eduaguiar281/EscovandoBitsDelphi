program ConsoleApp;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uConsoleApplication in 'uConsoleApplication.pas',
  uProduto in 'uProduto.pas',
  uRetangulo in 'uRetangulo.pas',
  uIAeroNave in 'uIAeroNave.pas',
  uAviao in 'uAviao.pas',
  uHelicoptero in 'uHelicoptero.pas';

begin
  { TODO -oUser -cConsole Main : Insert code here }
  WriteLn('Iniciando...');
  TConsoleApplication.Executar();
end.
 