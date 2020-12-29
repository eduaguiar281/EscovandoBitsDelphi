unit uHelicoptero;

interface
  uses
     Windows,
     SysUtils,
     uIAeroNave;

   type
     THelicoptero = Class(TInterfacedObject, IAeroNave)
     private
        FNome:String;
     public
        function GetNome:string;
        procedure Decolar;
        procedure Pousar;
        property Nome:String read GetNome;
        constructor Create();
   end;

implementation
{THelicoptero}

constructor THelicoptero.Create();
begin
   FNome := Self.ClassName;
end;

function THelicoptero.GetNome:string;
begin
    result := FNome;
end;

procedure THelicoptero.Decolar;
begin
   WriteLn('Ligar rotores');
   WriteLn('Aguardar rotacao necessaria');
   WriteLn('Subir');
end;

procedure THelicoptero.Pousar;
begin
   WriteLn('Diminur velocidade dos rotores');
   WriteLn('Abaixar');
   WriteLn('Pousar');
   WriteLn('Desligar rotores');
end;

end.

