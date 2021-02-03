unit UOkno;

interface

type
     str12 = string[12];
     str20 = string[20];
     POkno = ^ZOkno;
     ZOkno = record
             x0,y0:word;
             xh,yh:word;
             next:POkno;
             kvad:byte;
             zag:str20;
             end;
     PMeny = ^ZMeny;
     ZMeny = record
             pokaz:boolean;
             i:byte;
             x0,y0:word;
             par:str20;
             Next:PMeny;
             Prev:PMeny;
             Dop:PMeny;
             Naz:PMeny;
             end;


{procedure constr(var root:POkno);    }
procedure CreatOkno(root:POkno; x0,y0,xh,yh:word; zag:str20);
procedure DestroyOkno(Root,DesOkno:POkno);
procedure ActivateOkno(Root,ActOkno:POkno);
procedure YvelitOkno(COkno:POkno);
procedure RazvernytOkno(COkno:POkno);
procedure SvernytOkno(COkno:POkno);
Procedure CreatMeny(Root:PMeny; NameFile:str12);
function PopadOkno(root:POkno; x,y:word):POkno;
function PopadPanel(root:POkno; x,y:word):POkno;
function PopadPysk(x,y:word):boolean;
function PopadKlav(Root:POkno; smesh:byte; x,y:word):boolean;
function PopadMeny(Root:PMeny; x,y:word):boolean;
function PopadUpPanel(Root:POkno; x,y:word):boolean;
function empty(Root:POkno):boolean;
procedure perevod (var st:string);

var
  x0,y0,xh,yh:word;

implementation

uses UGraph;

var
  LastOkno:POkno;
  LastMeny:PMeny;

{procedure constr(var root:POkno);
  begin
  New(Root);
  Root^.next:=nil;
  LastOkno:=Root;
  writeln(LastOkno^.x0,' ',LastOkno^.y0,' ',LastOkno^.xh,' ',LastOkno^.yh);
  writeln(LastOkno^.x0,' ',LastOkno^.y0,' ',LastOkno^.x0+LastOkno^.xh,' ',LastOkno^.y0+LastOkno^.yh,' ',x,' ',y);

  end;  }

procedure CreatOkno(root:POkno; x0,y0,xh,yh:word; zag:str20);
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
  While LastOkno^.next<>DesOkno  do
    LastOkno:=LastOkno^.next;
  LastOkno^.Next:=DesOkno^.next;
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

Procedure CreatMeny(Root:PMeny; NameFile:str12);
  var
    par1:str12;
    i:byte;
    f:text;
    par:str20;
    NewMeny,PrevMeny:PMeny;
    k:boolean;
  begin
  Assign(f,NameFile);
  {$I-}
  Reset(f);
  {$I+}
  If (IoResult<>0) or (NameFile='') then
    begin
    writeln('Невозможно открыть фаил с именем - ',NameFile);
    readln;
    halt;
    end;
  Root^.next:=nil;
  LastMeny:=Root;

  while not eof(f) do
    begin
    Readln(F,par);
    New(NewMeny);
    NewMeny^.pokaz:=false;
    par1:=par;
    if par='/nmeny' then
      begin
      LastMeny^.dop:=NewMeny;
      NewMeny^.naz:=LastMeny;
      If Not Eof(f) then
        readln(f,par);
      NewMeny^.dop:=nil;
      NewMeny^.Prev:=nil;
      NewMeny^.Next:=nil;
      NewMeny^.par:=par;
      end;

    k:=false;
    If Par='/kmeny' then
      begin
      While LastMeny^.prev<>nil do
        LastMeny:=LastMeny^.prev;
      LastMeny:=LastMeny^.naz;
      If Not Eof(f) then
        readln(f,par)
      else
        k:=true
      end;
    if (par1<>'/nmeny') and (not k) then
      begin
      LastMeny^.Next:=NewMeny;
      NewMeny^.prev:=LastMeny;
      NewMeny^.Dop:=nil;
      NewMeny^.naz:=nil;
      NewMeny^.Next:=nil;
      NewMeny^.par:=par;
      end;
    LastMeny:=NewMeny;
    end;

{  LastMeny:=Root;
  While LastMeny^.Next<>nil do
    begin
    LastMeny:=LastMeny^.Next;
    Writeln(LastMeny^.par);
    If LastMeny^.dop<>nil then
      begin
      Writeln('     ',LastMeny^.Dop^.par);
      Writeln('     ',LastMeny^.Dop^.Next^.par);
      Writeln('     ',LastMeny^.Dop^.Next^.Next^.par);
      end;
    end;
  readln;}
  Close(f);
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
    if (ConStart+Trunc(ShagX*i)>=x) and (ConStart+Trunc(ShagX*(i-1))<=x) and
       (GrMaxY>=y) and (GrMaxY-HPan<=y) then
       PopadPanel:= LastOkno;
    LastOkno:=LastOkno^.next;
    end;
  end;

function PopadKlav(Root:POkno; smesh:byte; x,y:word):boolean;
  begin
  LastOkno:=Root;
  While LastOkno^.next<>nil do
    LastOkno:=LastOkno^.next;
  PopadKlav:=(LastOkno^.x0+LastOkno^.xh-Smesh<=x) and (LastOkno^.x0+LastOkno^.xh>=x) and
             (LastOkno^.y0<=y) and (LastOkno^.y0+HPanel>=y);
  end;

function PopadUpPanel(Root:POkno; x,y:word):boolean;
  begin
  LastOkno:=Root;
  While LastOkno^.next<>nil do
    LastOkno:=LastOkno^.next;
  PopadUpPanel:=(LastOkno^.x0<=x) and (LastOkno^.x0+LastOkno^.xh>=x) and
                (LastOkno^.y0<=y) and (LastOkno^.y0+HPanel>=y);
  end;


function PopadMeny(Root:PMeny; x,y:word):boolean;
  var
    n:byte;
  begin
  LastMeny:=root;
  n:=0;
  While LastMeny^.next<>nil do
    begin
    Inc(n);
    LastMeny:=LastMeny^.next;
    end;
  PopadMeny:=(x>=Root^.x0) and (y>=Root^.y0) and
             (x<=Root^.x0+ShMeny) and (y<=Root^.y0+n*VsMeny);
  end;

function PopadPysk(x,y:word):boolean;
  begin
  PopadPysk:=(GrMaxY>=y) and (GrMaxY-HPan<=y) and (x>=0) and (x<=ConStart);
  end;

function empty(Root:POkno):boolean;
  begin
  empty:=Root^.next=nil;
  end;

procedure perevod (var st:string);
var
i:integer;
begin
for i:=1 to length(st) do
 begin
 if (ord(st[i])>=192) and (ord(st[i])<=239) then
 st[i]:=chr(ord(st[i])-64);            {128}
 if (ord(st[i])>=240) and (ord(st[i])<=255) then
 st[i]:=chr(ord(st[i])-16);            {224}
 if ord(st[i])=184 then
 st[i]:=Chr(165);
  END;
  end;


end.