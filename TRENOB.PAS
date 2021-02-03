Unit TrenOb;

interface
type
  PObj = ^bj;
  spbj = object
         Obj:PObj;
         end;
  bj = object
        nom:byte;
        next:PObj;
        procedure pr;
        end;

implementation

procedure bj.pr;
  begin
  nom:=nom*2;
  end;



end.