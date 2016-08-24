program checker;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  unJudge17;

type
  tdirect = array[1..250, 1..250] of (from_up, from_left, stop);
  tdigit  = array[1..250, 1..250] of Byte;
  tway    = array[1..250, 1..250] of Char;

var
  direct: ^tdirect;
  digits: ^tdigit;
  n, i, j: Integer;
  c: Char;
  sum1, sum2: array[1..250] of Integer;
  checksum, newsum, sharp: Integer;
begin
  New(direct);
  New(digits);
  WF := InputTxt;
  WF.ReadLongInt(n);
  WF.NextLine;
  for i := 1 to n do begin
    for j := 1 to n do begin
      WF.ReadChar(c);
      digits^[i, j] := Ord(c) - Ord('0');
    end;
    WF.NextLine;
  end;
  direct^[1, 1] := stop;
  sum1[1] := digits^[1, 1];
  for j := 2 to n do begin
    sum1[j]       := sum1[j - 1] + digits^[1, j];
    direct^[1, j] := from_left;
  end;
  for i := 2 to n do begin
    direct^[i, 1] := from_up;
    sum2[1]       := sum1[1] + digits^[i, 1];
    for j := 2 to n do begin
      if sum1[j] < sum2[j - 1] then begin
        sum2[j] := sum1[j] + digits^[i, j];
        direct^[i, j] := from_up;
      end
      else begin
        sum2[j] := sum2[j - 1] + digits^[i, j];
        direct^[i, j] := from_left;
      end;
    end;
    sum1 := sum2;
  end;
  checksum := sum1[n];
  WF := OutputTxt;
  newsum := 0;
  sharp := 0;
  for i := 1 to n do begin
    for j := 1 to n do begin
      if WF.Eof then
        VRejectPE;
      if WF.Eoln then
        VRejectPE;
      WF.ReadChar(c);
      if not (c in ['-', '#']) then
        VRejectPE;
      if c = '#' then begin
        Inc(newsum, digits^[i, j]);
        Inc(sharp);
      end;
    end;
    if not WF.Eoln then
      VRejectPE;
    WF.NextLine;
  end;
  if not WF.Eof then
    VRejectPE;
  if sharp <> n * 2 - 1 then
    VRejectPE;
  if newsum <> checksum then
    VRejectWA;
  VAccept;
end.
