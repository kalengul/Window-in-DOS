Unit UButton;

interface

uses UOkno,Graph;

Type
   NewButton = object
            name:str20;
            Procedure NewButton(x1,y1,xh1,yh1:word; name1:str20);
            Procedure paint;
            function PopadButton(xm,ym:word):boolean;
            private
              x,y,xh,yh:word;
            end;

implementation

Procedure NewButton.paint;
  begin
  SetFillStyle(1,Black);
  SetColor(7);
  bar(x,y,xh,yh);
  rectangle(x,y,xh,yh);
  rectangle(x+2,y+2,xh-2,yh-2);
  OutTextXY((x+xh-4) div 2 +1, (y+yh-4) div 2 - length(name) div 2,name);
  end;


Procedure NewButton.NewButton(x1,y1,xh1,yh1:word; name1:str20);
  begin
  x:=x1;
  y:=y1;
  xh:=xh1;
  yh:=yh1;
  Name:=Name1;
  {NewButton.}Paint;
  end;

function NewButton.PopadButton(xm,ym:word):boolean;
  begin
  PopadButton:=(xm>=x) and (xm<=x+xh) and (ym>=y) and (ym<=y+yh);
  end;

end.