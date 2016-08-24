var n,s,ch,i,j,a,b:longint;
begin
read(n,s);
ch:=0;

for i:=1 to n do ch:=ch+i;

if (ch=s) or (ch-s<=2) then write('no') else
begin
 writeln('yes');
 for i:=1 to n do
  for j:=1 to n do if (i<>j) and (i+j=ch-s) then
   begin
   a:=i;
   b:=j;
   end;
 write(a,' ',b);
end;
end.