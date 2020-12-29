unit uRetangulo;

interface

type
   TRetangulo = Record
      Base :Double;
      Altura : Double;
      //function CalcularArea:Double;
   end;

implementation

{TRetangulo}

{
function TRetangulo.CalcularArea:double;
begin
    Result = Base * Altura;
end;
 }

end.
