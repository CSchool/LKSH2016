{
Written by Fyodor Menshikov 22.05.2002
9:47-10:04
}
{$N+,E-}
label
   01;
var
   i,j,n,k,ibuf:integer;
   Fi,Fj,Fn,cbuf,min,max,mid,cur,prev,next:comp;
begin
   readln(i,Fi,j,Fj,n);
   if i>j then begin
      ibuf:=i;
      i:=j;
      j:=ibuf;
      cbuf:=Fi;
      Fi:=Fj;
      Fj:=cbuf;
   end;
   min:=-2000000001;
   max:=2000000001;
   while true do begin
   01:
      mid:=(min+max)/2;
      prev:=Fi;
      cur:=mid;
      for k:=i+2 to j do begin
         next:=prev+cur;
         if next<-2000000000 then begin
            min:=mid;
            goto 01;
         end;
         if next>2000000000 then begin
            max:=mid;
            goto 01;
         end;
         prev:=cur;
         cur:=next;
      end;
      if cur<Fj then
         min:=mid
      else if cur>Fj then
         max:=mid
      else begin
         j:=i+1;
         Fj:=mid;
         break;
      end;
   end;
   if n=i then
      Fn:=Fi;
   if n=j then
      Fn:=Fj;
   if n>j then begin
      prev:=Fi;
      cur:=Fj;
      for k:=j+1 to n do begin
         next:=prev+cur;
         prev:=cur;
         cur:=next;
      end;
      Fn:=cur;
   end;
   if n<i then begin
      next:=Fj;
      cur:=Fi;
      for k:=i-1 downto n do begin
         prev:=next-cur;
         next:=cur;
         cur:=prev;
      end;
      Fn:=cur;
   end;
   writeln(Fn:0:0);
end.