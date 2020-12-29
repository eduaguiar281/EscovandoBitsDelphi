unit uIAeroNave;

interface

type
    IAeroNave = interface
        function GetNome:string;
        procedure Decolar;
        procedure Pousar;

        property Nome:String read GetNome;
    end;

implementation

end.
 