unit UMouse;

interface

procedure ShowCursor;
procedure HideCursor;
procedure GetCursor(var button:byte; var x,y:word);
procedure resetmouse;


implementation

uses dos;

var
 regs:registers;


 procedure ShowCursor;
 begin
  regs.ax:=$01;
  intr($33,regs);
 end;

 procedure HideCursor;
 begin
  regs.ax:=$02;
  intr($33,regs);
 end;

 procedure GetCursor(var button:byte; var x,y:word);
 begin
  regs.ax:=$03;
  intr($33,regs);
  with regs do
  begin
   button:=bl;
   x:=cx;
   y:=dx;
  end;
 end;

procedure resetmouse;
  var
     mouse_ok:boolean;
     button:byte;
  begin
  regs.ax:=$00;
  intr($33,regs);
  mouse_ok:=odd(regs.ax);
  button:=regs.bx;
  end;

end.