unit UOkno;

interface

type
     str40 = string[40];
     POkno = ^ZOkno;
     ZOkno = record
             x0,y0:word;
             xh,yh:word;
             next:POkno;
             kvad:byte;
             zag:str40;
             end;

{procedure constr(var root:POkno);    }
procedure CreatOkno(root:POkno; x0,y0,xh,yh:word; zag:str40);
procedure DestroyOkno(Root,DesOkno:POkno);
procedure ActivateOkno(Root,ActOkno:POkno);
procedure YvelitOkno(COkno:POkno);
procedure RazvernytOkno(COkno:POkno);
procedure SvernytOkno(COkno:POkno);
function PopadOkno(root:POkno; x,y:word):POkno;
function PopadPanel(root:POkno; x,y:word):POkno;
function PopadKlav(Root:POkno; smesh:byte; x,y:word):boolean;
function empty(Root:POkno):boolean;

var
  x0,y0,xh,yh:word;

implementation

uses UGraph;

var
  LastOkno:POkno;

{procedure constr(var root:POkno);
  begin
  New(Root);
  Root^.next:=nil;
  LastOkno:=Root;
  writeln(LastOkno^.x0,' ',LastOkno^.y0,' ',LastOkno^.xh,' ',LastOkno^.yh);
  writeln(LastOkno^.x0,' ',LastOkno^.y0,' ',LastOkno^.x0+LastOkno^.xh,' ',LastOkno^.y0+LastOkno^.yh,' ',x,' ',y);

  end;  }

procedure CreatOkno(root:POkno; x0,y0,xh,yh:word; zag:str40);
  Var
    NewOkno:POkno;
  begin
  LastOkno:=Root;
  While LastOkno^.next<>nil do
    LastOkno:=LastOkno^.next;
  New(NewOkno);
  LastOkno^.Next:=NewOkno;
  NewOkno^.kvad:=1;
  NewOkno^.x0:=x0;
  NewOkno^.y0:=y0;
  NewOkno^.xh:=xh;
  NewOkno^.yh:=xh;
  NewOkno^.zag:=zag;
  NewOkno^.next:=nil;
  end;

procedure DestroyOkno(Root,DesOkno:POkno);
  begin
  LastOkno:=Root;
  While LastOkno^.next<>DesOkno do
    LastOkno:=LastOkno^.next;
  LastOkno^.Next:=DesOkno^.Next;
  Dispose(DesOkno);
  end;

procedure ActivateOkno(Root,ActOkno:POkno);
  begin
  LastOkno:=Root;
  While LastOkno^.next<>ActOkno do
    LastOkno:=LastOkno^.next;
  LastOkno^.Next:=ActOkno^.Next;

  While LastOkno^.next<>nil do
    LastOkno:=LastOkno^.next;
  LastOkno^.next:=ActOkno;
  ActOkno^.next:=nil;
{  writeln(actOkno^.x0,' ',actOkno^.y0,' ',actOkno^.x0+actOkno^.xh,' ',actOkno^.y0+actOkno^.yh);}
  end;

procedure YvelitOkno(COkno:POkno);
  begin
  if COkno^.kvad = 1 then
    begin
    COkno^.Kvad:=2;
    x0:=COkno^.x0;
    xh:=COkno^.xh;
    y0:=COkno^.y0;
    yh:=COkno^.yh;
    COkno^.x0:=0;
    COkno^.xh:=GrMaxX;
    COkno^.y0:=0;
    COkno^.yh:=GrMaxY-HPan;
    end
  else
    begin
    COkno^.Kvad:=1;
    COkno^.x0:=x0;
    COkno^.xh:=xh;
    COkno^.y0:=y0;
    COkno^.yh:=yh;
    end;
  end;

procedure RazvernytOkno(COkno:POkno);
  begin
  COkno^.Kvad:=1;
  end;

procedure SvernytOkno(COkno:POkno);
  begin
  COkno^.Kvad:=3;
  end;

function PopadOkno(root:POkno; x,y:word):POkno;
  begin
  PopadOkno:=nil;
  LastOkno:=Root;
  While LastOkno<>nil do
    begin
    if (LastOkno^.x0<=x) and (LastOkno^.x0+LastOkno^.xh>=x) and
       (LastOkno^.y0<=y) and (LastOkno^.y0+LastOkno^.yh>=y) and
       (LastOkno^.Kvad<>3) then
       PopadOkno:= LastOkno;
    LastOkno:=LastOkno^.next;
    end;
  end;

function PopadPanel(root:POkno; x,y:word):POkno;
  var
    i,n:word;
    ShagX:Real;
  begin
  PopadPanel:=nil;
  n:=0;
  LastOkno:=Root;
  While LastOkno<>nil do
    begin
    LastOkno:=LastOkno^.next;
    inc(n);
    end;
  if n=0 then
    ShagX:=0
  else
    ShagX:=(GrMaxX-ConTime-ConStart)/n;
  If ShagX>ShagMax then ShagX:=ShagMax;

  LastOkno:=Root;
  for i:=1 to n do
    begin
{    Writeln(x,' ',y,' ',ConStart+Trunc(ShagX*i),' ',ConStart+Trunc(ShagX*(i-1)),' ',GrMaxY,' ',GrMaxY-HPan);}
    if (ConStart+Trunc(ShagX*i)>=x) and (ConStart+Trunc(ShagX*(i-1))<=x) and
       (GrMaxY>=y) and (GrMaxY-HPan<=y) then
       begin
       PopadPanel:= LastOkno;
{       Writeln('1');}
       end;
    LastOkno:=LastOkno^.next;
    end;
  end;

function PopadKlav(Root:POkno; smesh:byte; x,y:word):boolean;
  begin
  LastOkno:=Root;
  While LastOkno^.next<>nil do
    LastOkno:=LastOkno^.next;
  if (LastOkno^.x0+LastOkno^.xh-Smesh<=x) and (LastOkno^.x0+LastOkno^.xh>=x) and
     (LastOkno^.y0<=y) and (LastOkno^.y0+HPanel>=y) then
     PopadKlav:=true
  else
     PopadKlav:=false;
  end;

function empty(Root:POkno):boolean;
  begin
  empty:=Root^.next=nil;
  end;

end.