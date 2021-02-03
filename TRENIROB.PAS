program trenirob;
USES TrenOb;
type

  PObj = ^nobec;
  kspbj = object(spbj)
          end;
  nobec = object(bj)
         procedure pr;
         end;

procedure nobec.pr;
  begin
  nom:=nom*3;
  end;

var
  ob:nobec;
  d,c:kspbj;
begin
  ob.nom:=4;
  ob.pr;
  writeln(ob.nom);
  D.obj^.nom:=3;
  D.obj^.pr;
  Writeln(D.obj^.nom);
end.