unit uAviao;

interface
  uses
     Windows,
     SysUtils,
     uIAeroNave;

   type
     TAviao = Class(TInterfacedObject, IAeroNave)
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
{TAviao}

constructor TAviao.Create();
begin
    FNome := self.ClassName;
end;

function TAviao.GetNome:string;
begin
    result := FNome;
end;

procedure TAviao.Decolar;
begin
   WriteLn('Ligar turbinas');
   WriteLn('Pagar velocidade');
   WriteLn('Subir');
end;

procedure TAviao.Pousar;
begin
   WriteLn('Diminuir velocidade');
   WriteLn('Ligar trem de pouso');
   WriteLn('Parar');
end;

end.
