var i,a,b,sum,s, k,n,d,r, j: integer;
begin
randomize;
read (n);
read (s);
sum:=0;
for i:=1 to n do sum:=sum+i;
  if (s=sum) or (sum-s<=2) or (sum-s>=20) then write ('no');
  if (s<sum) and (sum-s>2) and (sum-s<20) then
    begin
    r:=sum-s;
    repeat
     i:=random(r-1)+1;
     d:=r-i;
    until (d<=n) and (d<>i);
    {for i:=1 to n do
     for j:=1 to n do if (i<>j) and (i+j=sum-s) then
     begin
     a:=i;
     b:=j;
     end;}
    writeln('yes');
    write(a,' ',b);
    end;
end.