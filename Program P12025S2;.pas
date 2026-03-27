Program P12025S2; 


procedure LeerPuntosCuestionarios (var puntosCuestionarios : integer; var error: char);
var 
nota, CantnotasLeidas: integer; 
begin 
    CantnotasLeidas:= 0; 
    puntosCuestionarios := 0; 
    read(nota);

    while (nota<>-1) and (CantnotasLeidas <3) do
    begin
        CantnotasLeidas := CantnotasLeidas + 1;
        puntosCuestionarios := puntosCuestionarios + nota; 
        read(nota)
    end;

    if nota <> -1 then
        error := CANTIDAD_INCORRECTA_CUESTIONARIOS; 
    else 
        error := NO_ERROR; 
    
end; 


function ResultadoCurso (modalidad : char, aproboLab: boolean ; parcial1, parcial2: real; cuestionarios : integer):char;
var 
    total : real; 
    resultado : char; 
begin 
    total := parcial1 + parcial2; 

    if modalidad = PRESENCIAL then
        total:= total + cuestionarios; 
    
    if aproboLab and (total >= 25) then 
        if (total >= 60) and (parcial1 >= 10) and (parcial2 >=15) then
            resultado := 'E';
        else
            resultado := 'R'; 
    
    resultado := resultado
end; 


    procedure siguienteDigito (var num: Natural; var digito :integer);
    begin 
        digito := num mod 10;
        num := num div 10
    end; 

    function esCantidadDe (cant : integer; dig : integer; num : Natural) : boolean;
    var 
    digito : integer; 
    begin 
        while (num <> 0) and (cant >=0) do
        begin 
            siguienteDigito(num, digito); 
            if digito = dig then 
                cant:= cant - 1; 
        end; 
        esCantidadDe := cant = 0 
    end; 

procedure procesarTexto (clave: integer; accion : char);
var 
i; j, min :Integer; 
begin 
    if n < MAX then 
        min := n; 
    else 
        min := MAX; 

    for i := 1 to min do
        procesarMensaje(clave, accion);

    for j := min to MAX do 
        procesarMensaje (0, accion)
end; 




procedure CantidadDeLetras (var cnt : integer);
var 
    largo : integer; 
    fin : boolean; 
begin 
    cnt:=0; 
    repeat
        leerPalabraLargo (largo, fin);
        cnt := cnt + largo
    until (fin)
end; 

procedure oracionMasLarga (n: integer; var largo : integer); 
var 
i ; cant : integer; 
begin 
    CantidadDeLetras (largo); 
    for i := 2 to n do 
    begin 
        CantidadDeLetras(cant); 
        if cant > largo then 
            largo := cant; 

    end 
end; 



MULTIPLICACIONES 
function esPotencia (k, N : integer) : boolean; 
var 
potencia : integer; 
begin 
    potencia := 1; 
    while potencia < N do
        Potencia := potencia * k; 
    esPotencia := potencia = n
end; 

DIVISIONES 
function esPotencia (k, N : integer) : boolean; 
var 
cociente : integer; 
begin 
    cociente := N; 
    while cociente mod k=O do
        cociente := cociente div k; 
    esPotencia := cociente = 1
end; 



functioncantidad(k,m,n:integer):integer;
var 
i:integer; 
contador: integer; 
begin 
    contador := 0; 
    for i := m to n do 
        if esPotencia(k,i) then 
            contador := contador + 1; 
        cantidad := contador
end; 


        
    



