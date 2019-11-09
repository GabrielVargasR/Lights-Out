program lights;

{
********************************************************************************
                                  Autores
********************************************************************************

- Gabriel Vargas Rodríguez - 2018103129
- David Solano Fuentes - 2018167435

Arquitectura de Computadores - Grupo 2

********************************************************************************
                              Manual de usuario
********************************************************************************

Opciones:
    F1 - Modo juego
    F2 - Modo editor
    F3 - Acerca de y Ayuda
    F4 - Salir

  Modo juego
    - El objetivo es apagar todas las luces
    - Para seleccionar una luz indique el numero de fila y luego el de columna
    - Cada luz seleccinada cambiara el estado de la misma y de las 4 luces adyacentes
    - Para saltar al siguiente nivel, presione la tecla "s"

  Modo editor:
    - Seleccione las luces que desea prender indicando el numero de fila seguido por el numero de columna
    - Una vez finalizado su nivel, presione enter

********************************************************************************
                          Ligas realizadas
********************************************************************************
  - Sleep (Inline): ciclo de nops para hacer un delay a mensajes de éxito en modo de juego y modo editor
  - loadLvl (biblioteca): módulo para abrir un documento con la matriz del nivel correspondiente
  - creando (biblioteca): módulo para crear archivo de nivel en modo editor. Toma la matriz correspondiente y
    escribe un archivo de texto

********************************************************************************
                            Análisis de resultados
********************************************************************************
  - Modo juego: B - no carga bien los niveles
  - Modo editor: B - no guarda bien los niveles
  - Valida input para modo juego y editor: A
  - Acerca de y ayuda: A
  - Salir de la aplicación: A
  - Liga inline: A
  - Liga loadlvl: D - se reconoce el archivo, pero faltó implementación
  - Liga creando: B - no se crea el archivo
  - Puzzles: A
  - Manejo de ventanas: A
  - Modo gráfico: A
}

uses graph, crt;

  type
   matriz = array[1..5, 1..5] of integer;

var gDriver, gMode, error, i, j, k, l : Integer;
    key1, key2 : char;
    keyNum1, keyNum2: Integer;
    matrizJuego: matriz;
    matrizEditor: matriz;
    nivel : string;


procedure initScreen;
begin
  gDriver := Detect;
  InitGraph(gDriver, gMode, 'g:\TP\BGI\Lights~1');
  error := GraphResult;

  if error <> grOK then
    begin
      Writeln('Error: ', GraphErrorMsg(error));
      halt;
    end else

    begin
      SetColor(4);
      OutTextXY(40, 450, 'Opciones: F1 - Modo Juego   F2 - Modo Editor   F3 - Ayuda   F4 - Salir');
    end;
end;

procedure quit;
begin
  CloseGraph;
  halt;
end;

procedure acercaDe; Forward;
procedure modoJuego; Forward;
procedure modoEditor; Forward;

procedure menuFn;
begin
  key2:= readkey;
  if key2=#59 then modoJuego;
  if key2=#60 then modoEditor;
  if key2=#61 then acercaDe;
  if key2=#62 then quit;
end;

procedure loadMat;
begin
  for i := 1 to 5 do
  begin
    for j := 1 to 5 do
    begin
      matrizJuego[i,j]:=0;
    end;
  end;

  matrizJuego[3, 3]:= 1;
  matrizJuego[4, 3]:= 1;
  matrizJuego[2, 3]:= 1;
  matrizJuego[3, 2]:= 1;
  matrizJuego[3, 4]:= 1;
end;

procedure pintaMatriz;
begin
  {Inicializa pantalla según los valores de la matriz de juego}
  k:=0;
  for i:=1 to 5 do
    begin
      k:= k+70;
      l:=0;
      for j:=1 to 5 do
      begin
        l:= l+70;
        if matrizJuego[i,j] = 1 then SetFillStyle(1, 14)
          else SetFillStyle(1, 15);
        FillEllipse(k, l, 25, 25);
      end;
    end;
end;

procedure sleep;
begin
  inline($BB/$32/$00/$B9/$DC/$FF/$90/$E2/$FD/$4B/$83/$FB/$00/$75/$F4);
end;

procedure acercaDe;
begin
  initScreen;
  OutTextXY(200,20,'Lights Out - Sem II 2019');
  OutTextXY(150,30,'Arquitectura de computadores - Grupo 2');

  OutTextXY(20,70,'Autores:');
  OutTextXY(40,90,'David Solano - 2018167435');
  OutTextXY(40,100,'Gabriel Vargas - 2018103129');

  OutTextXY(20, 140, 'Opciones:');
  OutTextXY(40, 160, 'F1 - Modo juego');
  OutTextXY(40, 170, 'F2 - Modo editor');
  OutTextXY(40, 180, 'F3 - Acerca de y Ayuda');
  OutTextXY(40, 190, 'F4 - Salir');

  OutTextXY(20, 230, 'Modo juego:');
  OutTextXY(40, 250, '- El objetivo es apagar todas las luces');
  OutTextXY(40, 260, '- Para seleccionar una luz:');
  OutTextXY(55, 270, 'Indique el numero de fila y luego el de columna');
  OutTextXY(40, 280, '- Cada luz seleccinada:');
  OutTextXY(55, 290, 'Cambiara el estado de la misma y de las 4 luces adyacentes');
  OutTextXY(40, 300, '- Para saltar al siguiente nivel, presione la tecla s');

  OutTextXY(20, 330, 'Modo editor:');
  OutTextXY(40, 350, '- Seleccione las luces que desea prender indicando:');
  OutTextXY(55, 360, 'el numero de fila seguido por el numero de columna');
  OutTextXY(40, 370, '- Una vez finalizado su nivel, presione enter');

  while TRUE do
    begin
      repeat until keypressed;
      key1:= readkey;
      if key1=#0 then menuFn;
    end;
end;

procedure actualiza(coord1, coord2: Integer);
begin
  if ((coord1>0) and (coord1<6)) and ((coord2>0) and (coord2<6)) then
  begin
    if matrizJuego[coord1, coord2] = 1 then
      begin
        SetFillStyle(1, 15);
        matrizJuego[coord1, coord2]:=0;
      end
      else
        begin
          SetFillStyle(1, 14);
          matrizJuego[coord1, coord2]:=1;
        end;
        coord1 := coord1 * 70;
        coord2 := coord2 * 70;
        FillEllipse(coord2, coord1, 25, 25);
  end;
end;

function loadLvl: string; external;
{$L loader.obj}

procedure modoJuego;
label comienzoJuego;
begin
  initScreen;
  SetColor(15);
  pintaMatriz;


    while TRUE do
    begin
      comienzoJuego:
      repeat until keypressed;
      key1 := readkey;
      if key1 =#0 then menuFn;
      if key1 = 's' then
        begin
          {carga nuevo nivel}
          OutTextXY(150, 390, 'Cambiando nivel');
          sleep;
          initScreen;
          SetColor(15);
          loadMat;
          pintaMatriz;
          goto comienzoJuego;
        end;
      repeat until keypressed;
      key2 := readkey;

      keyNum1 := ord(key1) - $30;
      keyNum2 := ord(key2) - $30;

      actualiza(keyNum1, keyNum2);
      actualiza(keyNum1+1, keyNum2);
      actualiza(keyNum1-1, keyNum2);
      actualiza(keyNum1, keyNum2+1);
      actualiza(keyNum1, keyNum2-1);

      k:=0;
      for i:=1 to 5 do
        begin
          for j:=1 to 5 do
          begin
            k:= k + matrizJuego[i,j];
          end;
        end;

      if k=0 then
        begin
          OutTextXY(150, 390, 'Nivel completado!');
          sleep;
          initScreen;
          SetColor(15);
          loadMat;
          pintaMatriz;
        end;

    end;
end;

procedure iniciaEditor;
begin
  SetColor(15);
  SetFillStyle(1, 15);
  for i:=1 to 5 do
    begin
      j:= i*70;
      k:= 70;
      while k < 420 do
        begin
          FillEllipse(j, k, 25, 25);
          k:= k+70;
        end;
    end;

  for i := 1 to 5 do
    begin
      for j := 1 to 5 do
      begin
        matrizEditor[i,j]:=0;
      end;
    end;
end;

procedure creando(var mat: matriz); external;
{$L LVLCRE~1.obj}

procedure modoEditor;
label comienzoEditor;
begin
  initScreen;
  iniciaEditor;

  while TRUE do
  begin
    comienzoEditor:
    repeat until keypressed;
    key1 := readkey;
    if key1 =#0 then menuFn;
    if key1 =#13 then
      begin
        creando(matrizEditor);
        OutTextXY(150, 390, 'Nivel guardado!');
        sleep;
        initScreen;
        iniciaEditor;
        goto comienzoEditor;
      end;
    repeat until keypressed;
    key2 := readkey;

    keyNum1 := ord(key1) - $30;
    keyNum2 := ord(key2) - $30;

    actualiza(keyNum1, keyNum2);
  end;
end;

begin
  initScreen;
  nivel := 'levels\LVL001.txt';
  loadMat;

  while TRUE do
    begin
      repeat until keypressed;
      key1 := readkey;
      if key1=#0 then menuFn;
    end;
End.
