var i,sum,s, k,n,d,r, j: integer;
begin
randomize;
read (n);
read (s);
sum:=0;
for i:=1 to n do sum:=sum+i;
  if (s=sum) or (sum-s<=2) or (sum-s>=19) then write ('no');
  if (s<sum) and (sum-s>2) and (sum-s<19) then
    begin
    r:=sum-s;
    repeat
     i:=random(r-1)+1;
     d:=r-i;
    until (d<=n) and (d<>i);
    writeln('yes');
    write(d,' ',i);
    end;
end.