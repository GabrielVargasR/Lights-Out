program lights;

uses graph, crt;

var gDriver, gMode, error, i, j, k, l : Integer;
    key1, key2 : char;
    keyNum1, keyNum2: Integer;
    matrizJuego: array[1..5, 1..5] of integer;

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
{function validInp(num1,num2: word): Integer; Forward;}

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
      matrizJuego[i,j]:=1;
    end;
  end;
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

procedure modoJuego;
begin
  initScreen;
  SetColor(15);

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

    while TRUE do
    begin
      repeat until keypressed;
      key1 := readkey;
      if key1 =#0 then menuFn;
      repeat until keypressed;
      key2 := readkey;

      keyNum1 := ord(key1) - $30;
      keyNum2 := ord(key2) - $30;

      keyNum1 := keyNum1 * 70;
      keyNum2 := keyNum2 * 70;
      SetFillStyle(1, 14);
      FillEllipse(keyNum2, keyNum1, 25, 25);
    end;
end;

procedure modoEditor;
begin
  initScreen;

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

  while TRUE do
  begin
    menuFn;
  end;
end;

begin
  initScreen;
  loadMat;

  while TRUE do
    begin
      repeat until keypressed;
      key1 := readkey;
      if key1=#0 then menuFn;
    end;
End.
