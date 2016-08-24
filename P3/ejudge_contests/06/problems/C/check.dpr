{
Written by Fyodor Menshikov 19.01.2003
10:34-10:44
Modified into checker 30.12.2003
}
   procedure ac;
   begin
        writeln('ok');
      halt(0);
   end;

   procedure wa;
   begin
       writeln('wrong answer');
      halt(5);
   end;

   procedure pe;
   begin
       writeln('presentation error');
       halt(4);
   end;

var
   c:char;

   procedure nextchar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

   procedure check(judgeanswer:longint);
   var
      useranswer:longint;
      d:integer;
   begin
      assign(input,paramstr(2));
      reset(input);
      useranswer:=0;
      nextchar;
      if c='0' then begin
         nextchar;
      end
      else if c in ['1'..'9'] then begin
         while c in ['0'..'9'] do begin
            d:=ord(c)-ord('0');
            if useranswer<maxlongint div 10 then
               useranswer:=useranswer*10+d;{else it is already wrong}
            nextchar;
         end;
      end
      else
         pe;
      if c<>#13 then
         pe;
      readln;
      if not eof then
         pe;
      if useranswer<>judgeanswer then
         wa;
      ac;
   end;

var
   n,k,i,j:integer;
   a:array[1..100,1..100]of integer;
   sum:array[0..101,0..101]of longint;
   max:longint;
begin
   assign(input,paramstr(1));
   reset(input);
   readln(n,k);
   for i:=1 to n do begin
      for j:=1 to n do
         read(a[i,j]);
      readln;
   end;
   for i:=0 to n+1 do
      for j:=0 to n+1 do
         sum[i,j]:=0;
   sum[1,1]:=a[1,1];
   for k:=2 to k do begin
      for i:=1 to n do
         for j:=1 to n do
            if odd(i+j)<>odd(k) then begin
               max:=0;
               if sum[i+1,j]>max then
                  max:=sum[i+1,j];
               if sum[i-1,j]>max then
                  max:=sum[i-1,j];
               if sum[i,j-1]>max then
                  max:=sum[i,j-1];
               if sum[i,j+1]>max then
                  max:=sum[i,j+1];
               if max=0 then
                  sum[i,j]:=0
               else
                  sum[i,j]:=max+a[i,j];
            end;
   end;
   max:=0;
   for i:=1 to n do
      for j:=1 to n do
         if sum[i,j]>max then
            max:=sum[i,j];
   check(max);
end.
