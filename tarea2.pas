{ Función que calcula el total de puntos obtenidos }
function calcularTotalPuntos(estud:Estudiante) : real;
var 
  total : real;
begin 
  total := estud.parcial1 + estud.parcial2; 

  if estud.modalidad = PRESENCIAL then
    total := total + estud.cuestionarios; 

  calcularTotalPuntos := total; 
end; 



{ Función que calcula el resultado final del estudiante }
function resultadoEstudiante (estud:Estudiante) : ResultadoCurso;
var 
  total : real;
  LabAprobada, CumpleMinimo, TotalExonera : boolean;
  CumpleP1P2 : boolean; 
  Asiste : boolean; 

begin
  total := calcularTotalPuntos(estud);

  LabAprobada := estud.labAprobado; 

  CumpleMinimo := (total >= 25.0);
  TotalExonera := (total >= 60.0);

  if estud.modalidad = PRESENCIAL then
    Asiste := (estud.asistencias >= 60.0)
  else 
    Asiste := true; 

  CumpleP1P2 := (estud.parcial1 >= 10.0) and (estud.parcial2 >= 15.0);

  if LabAprobada and TotalExonera and CumpleP1P2 and Asiste then
    resultadoEstudiante := Exonera
  else
    if LabAprobada and CumpleMinimo and Asiste then
      resultadoEstudiante := Aprueba
    else 
      resultadoEstudiante := Reprueba; 
end;  



{ Retorna el promedio de las calificaciones de los estudiantes en `cestudiantes` }
function promedioEstudiantes (cestudiantes: InfoEstudiantes) : real;
var 
  i : integer; 
  suma : real; 

begin 
  if cestudiantes.tope = 0 then
    promedioEstudiantes := 0
  else 
  begin 
    suma := 0;

    for i := 1 to cestudiantes.tope do 
      suma := suma + calcularTotalPuntos( cestudiantes.estudiantes[i] );
    
    promedioEstudiantes := suma / cestudiantes.tope; 
  end;
end; 


{ Retorna la estructura `cestudiantes' sin información de estudiantes }
 procedure borrarInfoEstudiantes (var cestudiantes: InfoEstudiantes);
 begin 
 cestudiantes.tope := 0;
 end;


{ Inserta un nodo en una lista ordenada de estudiantes }
procedure insertarOrdenado(ciestud: integer; posicion: integer; var lmodord: InfoEstudModalidad);
var 
  nuevo, act, ant : InfoEstudModalidad;

begin 
  new(nuevo);
  nuevo^.ciest := ciestud;
  nuevo^.indice := posicion;
  nuevo^.sig := nil;

  act := lmodord;
  ant := nil; 

  while (act <> nil) and (act^.ciest < ciestud) do
  begin 
    ant := act;
    act := act^.sig;
  end; 

  if ant = nil then
  begin 
    nuevo^.sig := lmodord;
    lmodord := nuevo; 
  end
  else
  begin 
    nuevo^.sig := act;
    ant^.sig := nuevo;
  end;
end;




{ Retorna dos listas de estudiantes, de acuerdo a la modalidad en que cursaor la asignatura 
  Retorna también la cantidad de estudiantes que cursaron en modalidad PRESENCIAL y la de los 
  que cursaron en modalidad REMOTO. }
procedure estudEnModalidad(cestudiantes: InfoEstudiantes; 
                           var estudmod:EstudModalidad; 
                           var npres,nrem:integer);
var  
  i : integer; 
  est : Estudiante;
begin
  estudmod.presencial := nil;
  estudmod.remoto := nil;
  npres := 0;
  nrem := 0;

  for i := 1 to cestudiantes.tope do
  begin 
    est := cestudiantes.estudiantes[i];

    if est.modalidad = PRESENCIAL then 
    begin 
      insertarOrdenado(est.CI, i, estudmod.presencial);
      npres := npres + 1;
    end
    else 
    begin 
      insertarOrdenado(est.CI, i, estudmod.remoto);
      nrem := nrem + 1; 
    end;
  end; 
end; 
                    

{ Retorna el primer estudiante que cursó en la modalidad dada y que obtuvo el resultado` indicado }
procedure buscarEstudianteCalificacion (cestudiantes:InfoEstudiantes;
                                        estudmod:EstudModalidad; 
                                        modalidad:char; resultado : ResultadoCurso; 
                                        var encontrado : boolean; var estud : Estudiante);
var 
  lista : InfoEstudModalidad;
  r : ResultadoCurso;
begin
  encontrado := false;  

  if modalidad = PRESENCIAL then 
    lista := estudmod.presencial
  else 
    lista := estudmod.remoto; 

  while (lista <> nil) and (not encontrado) do
  begin 
    estud := cestudiantes.estudiantes[ lista^.indice ];
    r := resultadoEstudiante(estud); 

    if r = resultado then 
      encontrado := true
    else 
      lista := lista^.sig;
  end;
end;
    