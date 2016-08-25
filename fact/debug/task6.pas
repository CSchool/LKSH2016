{
Составьте программу удаления второго элемента массива C(N), 
если N лежит в диапазоне 1..100
}
var
 c:array[1..10] of integer;
 n, i, t:integer;

begin
 readln(n);
 for i:=1 to n do begin
   read(c[n]);
 end;

 for i:=2 to n do begin
  c[i]:=c[i+1];
 end;

 for i:=1 to n do begin
   writeln(c[n], ' ');
 end;
end.