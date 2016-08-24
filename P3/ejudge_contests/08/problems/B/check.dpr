var
   n:integer;
   br:array[1..101]of char;
   minlen:array[1..100,1..100]of integer;

   procedure load;
   begin
      assign(input,paramstr(1));
      reset(input);
      n:=0;
      while not eoln do begin
         inc(n);
         read(br[n]);
      end;
      close(input);
   end;

   function len(_from,_to:integer):integer;
   var
      min,i:integer;
   begin
      if _from>_to then begin
         len:=0;
         exit;
      end;
      if _from=_to then begin
         len:=2;
         exit;
      end;
      if minlen[_from,_to]<>-1 then
         {nothing}
      else if br[_from] in [')',']'] then
         minlen[_from,_to]:=len(_from+1,_to)+2
      else if br[_to] in ['(','['] then
         minlen[_from,_to]:=len(_from,_to-1)+2
      else begin
         min:=300;
         for i:=_from to _to-1 do
            if len(_from,i)+len(i+1,_to)<min then
               min:=len(_from,i)+len(i+1,_to);
         if(br[_from]='(')and(br[_to]=')')or(br[_from]='[')and(br[_to]=']')then begin
            if len(_from+1,_to-1)+2<min then
               min:=len(_from+1,_to-1)+2;
         end;
         minlen[_from,_to]:=min;
      end;
      len:=minlen[_from,_to];
   end;

   function minstr(_from,_to:integer):string;
   var
      i:integer;
   begin
      if _from>_to then begin
         minstr:='';
         exit;
      end;
      if _from=_to then begin
         case br[_from] of
         '[',']':minstr:='[]';
         '(',')':minstr:='()';
         else
            writeln('Q');
            halt(1);
         end;
         exit;
      end;
      if br[_from]=']' then begin
         minstr:='[]'+minstr(_from+1,_to);
         exit;
      end;
      if br[_from]=')' then begin
         minstr:='()'+minstr(_from+1,_to);
         exit;
      end;
      if br[_to]='[' then begin
         minstr:=minstr(_from,_to-1)+'[]';
         exit;
      end;
      if br[_to]='(' then begin
         minstr:=minstr(_from,_to-1)+'()';
         exit;
      end;
      if (br[_from]='(') and (br[_to]=')') then begin
         if len(_from,_to)=len(_from+1,_to-1)+2 then begin
            minstr:='('+minstr(_from+1,_to-1)+')';
            exit;
         end;
      end;
      if (br[_from]='[') and (br[_to]=']') then begin
         if len(_from,_to)=len(_from+1,_to-1)+2 then begin
            minstr:='['+minstr(_from+1,_to-1)+']';
            exit;
         end;
      end;
      for i:=_from to _to-1 do begin
         if len(_from,_to)=len(_from,i)+len(i+1,_to) then begin
            minstr:=minstr(_from,i)+minstr(i+1,_to);
            exit;
         end;
      end;
      writeln('q');
      halt(2);
   end;

   procedure findminlen;
   var
      i,j:integer;
   begin
      for i:=1 to 100 do
         for j:=1 to 100 do
            minlen[i,j]:=-1;
      i:=len(1,n);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(4);
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(5);
   end;

   procedure ok;
   begin
      writeln('ok');
      halt(0);
   end;

   procedure ie;
   begin
      halt(6);
   end;

var
   answer:array[1..200]of char;
   alen:integer;
   stack:array[1..200]of char;
   sp:integer;

   procedure check;
   var
      minlen:integer;
      c:char;
      i,j:integer;
   begin
      minlen:=length(minstr(1,n));
      assign(input,paramstr(2));
      reset(input);
      alen:=0;
      while not eoln do begin
         inc(alen);
         if alen>200 then
            pe;
         read(c);
         if not (c in ['(','[',')',']']) then
            pe;
         answer[alen]:=c;
      end;
      readln;
      if not eof then
         pe;
      close(input);
      br[n+1]:='|';
      j:=1;
      for i:=1 to alen do
         if answer[i]=br[j] then
            inc(j);
      if j<=n then
         pe;
      sp:=0;
      for i:=1 to alen do
         case answer[i] of
         '(':begin
            inc(sp);
            stack[sp]:=')';
         end;
         '[':begin
            inc(sp);
            stack[sp]:=']';
         end;
         ')',']':begin
            if sp=0 then
               pe;
            if stack[sp]<>answer[i] then
               pe;
            dec(sp);
         end;
         else
            ie;
         end;
      if sp>0 then
         pe;
      if alen>minlen then
         wa;
      if alen<minlen then
         ie;
      ok;
   end;

begin
   load;
   findminlen;
   check;
end.
