var mas,prior:array[1..6,1..6] of byte;
s,i,j,p,f,prior1,ansver:integer;

function maxz(p,h:byte):byte;
var i1,max,maxi:byte;
begin
max:=0;
if p=1 then
begin
for i1:=1 to 6 do if mas[i1,h]>max then
 begin
 max:=mas[i1,h];
 maxi:=i1;
 end;
end else
for i1:=1 to 6 do if mas[h,i1]>max then
 begin
 max:=mas[h,i1];
 maxi:=i1;
 end;
maxz:=maxi;
end;

function oc(p,h:byte):byte;
var sum,i1:byte;
begin
sum:=0;
if p=1 then
begin
for i1:=1 to 6 do sum:=sum+mas[h,i1];
end else
for i1:=1 to 6 do sum:=sum+mas[i1,h];
if ((p=1) and (sum=mas[h,s])) or ((p=2) and (sum=mas[s,h])) then oc:=sum else oc:=0;
end;  


begin{
for i:=1 to 6 do
 for j:=1 to 6 do prior[j,i]:=0;
}
prior1:=-10000;

for i:=1 to 6 do 
 for j:=1 to 6 do read(mas[j,i]);
read(p);

if p=1 then f:=2;
if p=2 then f:=1;

read(s);
{
if p=1 then
begin
 for i:=1 to 6 do if (mas[i,s]>mas[maxz(f,i),i]) or (oc(f,i,s)>0) then prior[i,s]:=prior[i,s]+mas[i,s]-mas[maxz(f,i),i]+oc(f,i,s);
end else
 for i:=1 to 6 do if (mas[s,i]>mas[i,maxz(f,i)]) or (oc(f,i,s)>0) then prior[s,i]:=prior[s,i]+mas[s,i]-mas[i,maxz(f,i)]+oc(f,i,s);

if p=1 then
begin
for i:=1 to 6 do if prior[i,s]>prior1 then
 begin
 prior1:=prior[i,s];
 ansver:=i;
 end; 
end else
for i:=1 to 6 do if prior[s,i]>prior1 then
 begin 
 prior1:=prior[s,i];
 ansver:=i;
 end;
}

if p=1 then
 begin
 for i:=1 to 6 do
  if (mas[i,s] > 0) and (mas[i,s]-mas[i,maxz(f,i)]>prior1) then
  begin
  prior1:=mas[i,s]-mas[i,maxz(f,i)];
  ansver:=i;
  end;
 for i:=1 to 6 do if oc(p,i)<>0 then ansver:=i;
 end;
  
if p=2 then
 begin
 for i:=1 to 6 do
  if (mas[s,i] > 0) and (mas[s,i]-mas[maxz(f,i),i]>prior1) then
  begin
  prior1:=mas[s,i]-mas[maxz(f,i),i];
  ansver:=i;
  end;
 for i:=1 to 6 do if oc(p,i)<>0 then ansver:=i;
 end;
IF ansver=0 then write(maxz(p,s)) else write(ansver);
end.

