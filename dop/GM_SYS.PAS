{*******************************************************************
модуль System - содержит объекты для работы системных ресурсов
объект mouse - работа с мышью
работа начата - 09.05.07
последнее изменение - 09.05.07
*******************************************************************}
unit Gm_sys;

interface

uses dos;

type

TTimer = object
  enabled:boolean;
  interval:word;
  function chech:boolean;
  end;

Tmouse = object
  x,y:word;
  procedure visible;
  procedure create;
  procedure destroy;
  function chesk:boolean;
  end;
var
  regs: registers;

implementation

function TTimer.chech:boolean;
  var
  time1,time2,time:word;
  begin
  interval:=trunc(interval*100/55);
  chech:=false;
  regs.ah:=$00;
  intr($1a,regs);
  time1:=regs.dx;
  while time<>interval do
    begin
    regs.ah:=$00;
    intr($1a,regs);
    time2:=regs.dx;
    time:=time2-time1
    end;
  chech:=true;
  end;

procedure Tmouse.create;
  begin
  regs.Ax:=$00;
  intr($33,regs);
  end;

procedure Tmouse.visible;
  begin
  regs.ax:=$01;
  intr($33,regs);
  end;

procedure Tmouse.destroy;
  begin
  regs.ax:=$02;
  intr($33,regs);
  end;

function Tmouse.chesk:boolean;
  var
  bytton:byte;
  begin
  chesk:=false;
  regs.ax:=$03;
  intr($33,regs);
  bytton:=regs.bl;
  x:=regs.cx;
  y:=regs.dx;
  if bytton<>0 then
   chesk:=true;
  end;

end.