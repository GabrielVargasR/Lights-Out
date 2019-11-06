program lights;

uses graph, crt;

var gDriver, gMode, error : Integer; num: char;

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
      OutTextXY(80, 450, 'Opciones: F1 - Modo Juego   F2 - Modo Editor   F3 - Ayuda');
    end;
end;

procedure acercaDe;
begin
  OutTextXY(200,20,'Lights Out - Sem II 2019');
  OutTextXY(150,30,'Arquitectura de computadores - Grupo 2');
  OutTextXY(20,70,'Autores:');
  OutTextXY(40,90,'David Solano - 2018167435');
  OutTextXY(40,100,'Gabriel Vargas - 2018103129');
  OutTextXY(20, 140, 'Ayuda:');
  OutTextXY(40, 160, '//Meter opciones');
end;

procedure modoJuego;
begin
  OutTextXY(200, 250, 'Modalidad no implementada');
end;

procedure modoEditor;
begin
  OutTextXY(200, 250, 'Modalidad no implementada');
end;


begin
    {repeat until keypressed;
    num:= readkey;
    Writeln('Tecla: ', num);}
    initScreen;
    modoJuego;
    initScreen;
    acercaDe;
    Readln;
    CloseGraph;
End.
