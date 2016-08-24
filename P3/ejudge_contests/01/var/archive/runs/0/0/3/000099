var a,b,i,sum,s, k,n,d,r, j: integer;
begin
read (n);
read (s);
sum:=0;
  for i:=1 to n do sum:=sum+i;
  if  s=sum then write ('no');
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
writeln ('yes');
write(a,' ', b);
end.