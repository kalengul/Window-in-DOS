program test;
 uses UGraph,UOkno,UMouse,UButton;
var
   okno,BOkno,COkno,DOkno,ActOkno:POkno;
   button,pbutton:byte;
   x,y,x1,y1:word;
   next:boolean;
   kon:byte;
   meny1,ElMeny1,Pysk:PMeny;
   but:Newbutton;
begin
writeln('go');
CreatMeny(Meny1,'Meny.txt');
CreatMeny(Pysk,'Pysk.txt');

Okno^.Next:=nil;

writeln('Creat');
CreatOkno(OKno,10,10,200,200,'okno1');
CreatOkno(OKno,100,100,250,250,'okno2');
CreatOkno(OKno,150,50,150,100,'okno3');

BOkno:=Okno^.next;
ResetMouse;

writeln('OpenGr');
OpenGr;
BOkno:=Okno^.next;
while BOkno<>nil do
  begin
  PaintOkno(BOkno);
  BOkno:=BOkno^.next;
  end;
PaintPanel(Okno);
ShowCursor;
repeat
next:=false;
COkno:=nil;
DOkno:=nil;
while not next do
  begin
  GetCursor(button,x,y);
  if button=2 then
    begin
    ClrGr;
    HideCursor;
    BOkno:=Okno^.next;
    while BOkno<>nil do
      begin
      PaintOkno(BOkno);
      BOkno:=BOkno^.next;
      end;
    PaintPanel(Okno);
    ShowCursor;
    end;
  if button=1 then
    begin
    HideCursor;
    if PopadPysk(x,y) then
      PaintMeny(Pysk,0,GrMaxY-HPan-2,true);
    COkno:=PopadOkno(Okno^.next,x,y);
    DOkno:=PopadPanel(Okno^.next,x,y);
    ElMeny1:=ViborMeny(Pysk,x,y);
    if But.PopadButton(x,y) then
      exit;
    If ElMeny1^.par='New' then
       begin
       CreatOkno(OKno,125,150,150,200,'NewOkno');
{       But.NewButton(130,175,10,10,'exit');}
{       readln;}
       end;
    If ElMeny1^.par='exit' then
       exit;
    If ElMeny1^.par='Close' then
      begin
      ActOkno:=okno;
      while ActOkno^.next<>nil do
        ActOkno:=ActOkno^.next;
      If actOkno<>okno then
        DestroyOkno(Okno,ActOkno);
      end;
    If ElMeny1^.par='MinMaze' then
      begin
      ActOkno:=okno;
      while ActOkno^.next<>nil do
        ActOkno:=ActOkno^.next;
      ClrGr;
      SvernytOkno(ActOkno);
      end;
    If ElMeny1^.par='MaxMaze' then
      BEGIN
      ActOkno:=okno;
      while ActOkno^.next<>nil do
        ActOkno:=ActOkno^.next;
      YvelitOkno(ActOkno);
      end;

    BOkno:=Okno^.next;
    while BOkno<>nil do
      begin
      PaintOkno(BOkno);
      BOkno:=BOkno^.next;
      end;
    PaintPanel(Okno);

    If PopadUpPanel(okno,x,y) and (button=1) and(not PopadKlav(okno,SmeshKn,x,y))
    and(not PopadKlav(okno,SmeshKn*2,x,y)) and(not PopadKlav(okno,SmeshKn*3,x,y))then
      begin
      HideCursor;
      PaintRamka(COkno^.x0,COkno^.y0,COkno^.x0+COkno^.xh,COkno^.y0+COkno^.yh);
      While Button=1 do
        begin
        GetCursor(button,x,y);
        ClearRamka(COkno^.x0,COkno^.y0,COkno^.x0+COkno^.xh,COkno^.y0+COkno^.yh);
        COkno^.x0:=x;
        COkno^.y0:=y;
        PaintRamka(COkno^.x0,COkno^.y0,COkno^.x0+COkno^.xh,COkno^.y0+COkno^.yh);
        end;
      ClrGr;
      COkno:=Okno^.next;
      while COkno<>nil do
       begin
       PaintOkno(COkno);
       COkno:=COkno^.next;
       end;
      PaintPanel(Okno);
      ShowCursor;
      end;

   ShowCursor;
   while button=1 do
      GetCursor(button,x,y);

    end;
  if COkno<>nil then
    begin
    ActivateOkno(Okno,COkno);
    HideCursor;
    PaintOkno(COkno);
    PaintPanel(Okno);
    ShowCursor;
    next:=true;
    end;

  if DOkno<>nil then
    begin
    ActivateOkno(Okno,DOkno);
    HideCursor;
    RazvernytOkno(DOkno);
    PaintOkno(DOkno);
    PaintPanel(Okno);
    ShowCursor;
    next:=true;
    end;
  end;

if PopadKlav(okno,SmeshKn,x,y) then
  begin
  DestroyOkno(Okno,COkno);
  ClrGr;
  HideCursor;
  BOkno:=Okno^.next;
  while BOkno<>nil do
    begin
    PaintOkno(BOkno);
    BOkno:=BOkno^.next;
    end;
  PaintPanel(Okno);
  ShowCursor;
  end;

if PopadKlav(okno,SmeshKn*2,x,y) then
  begin
  YvelitOkno(COkno);
  HideCursor;
  if COkno^.kvad = 2 then
    PaintOkno(COkno);
  If COkno^.kvad = 1 then
    begin
    ClrGr;
    BOkno:=Okno^.next;
    while BOkno<>nil do
      begin
      PaintOkno(BOkno);
      BOkno:=BOkno^.next;
      end;
    PaintPanel(Okno);
    end;
  ShowCursor;
  end;

if PopadKlav(okno,SmeshKn*3,x,y) then
  begin
  SvernytOkno(COkno);
  HideCursor;
  ClrGr;
  BOkno:=Okno^.next;
  while BOkno<>nil do
    begin
    PaintOkno(BOkno);
    BOkno:=BOkno^.next;
    end;
  PaintPanel(Okno);
  ShowCursor;
  end;

until empty(Okno);
HideCursor;
CloseGr;

end.