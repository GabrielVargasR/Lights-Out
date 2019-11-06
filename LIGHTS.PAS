program lights;

uses graph;

var gDriver, gMode, error : Integer;

procedure initScreen;
begin
  gDriver := Detect;
  InitGraph(gDriver, gMode, 'g:\TP\BGI\Lights~1');
  error := GraphResult;

  if error <> grOK then
    begin
      Writeln('Error: ', GraphErrorMsg(error));
      halt;
    end
end;

procedure acercaDe;
begin
  SetColor(4);
  OutTextXY(200,20,'Lights Out - Sem II 2019');
  OutTextXY(150,30,'Arquitectura de computadores - Grupo 2');
  OutTextXY(20,70,'Autores:');
  OutTextXY(40,90,'David Solano - 2018167435');
  OutTextXY(40,100,'Gabriel Vargas - 2018103129');
  OutTextXY(20, 140, 'Ayuda:');
  OutTextXY(40, 160, '//Meter opciones');
end;

begin
    initScreen;
    acercaDe;
    Readln;
    CloseGraph;
End.
