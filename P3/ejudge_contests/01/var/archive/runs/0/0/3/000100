var a,b,i,sum,s, k,n,d,r, j: integer;
begin
read (n,s);
sum:=0;
  for i:=1 to n do sum:=sum+i;
  if  (s=sum) or (sum-s<=2) then write ('no');
  if s<sum then
    begin
    r:=sum-s;
     for i:=1 to n do
      begin
      d:=r-i;
      if (d<=n) and (d<>i) then
       begin
       a:=d;
       b:=i;
       end;
      end;
    end;
if s<sum then
begin
 writeln('yes');
 write(a,' ', b);
end;
end.