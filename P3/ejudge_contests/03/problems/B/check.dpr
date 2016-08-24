program checker;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  unJudge17; 

var
  n: Integer;
  e, f: Integer;
  p: array[1..500] of Longint;
  w: array[1..500] of Longint;
  i: Integer;
  Min, Max, m: Longint;
  sum: array[0..10000] of Longint;
  weight, coin: Integer;
  umin, umax: Longint;
  answer: string;
begin
  WF := InputTxt;
  WF.Reset;
  WF.ReadLongInt(e, f);
  WF.NextLine;
  WF.ReadLongInt(n);
  WF.NextLine;
  for i := 1 to n do begin
    WF.ReadLongInt(p[i], w[i]);
    WF.NextLine;
  end;

  sum[0] := 0;
  for weight := 1 to f - e do begin
    m := -1;{impossible}
    for coin := 1 to n do begin
      if weight - w[coin] >= 0 then begin {index Ok}
        if sum[weight - w[coin]] >= 0 then begin {possible}
          if (m = -1) or (sum[weight - w[coin]] + p[coin] < m) then begin
            m := sum[weight - w[coin]] + p[coin];
          end;
        end;
      end;
    end;
    sum[weight] := m;
  end;
  Min := sum[f - e];

  sum[0] := 0;{impossible}
  for weight := 1 to f - e do begin
    m := -1;
    for coin := 1 to n do begin
      if weight - w[coin] >= 0 then begin {index Ok}
        if sum[weight - w[coin]] >= 0 then begin {possible}
          if sum[weight - w[coin]] + p[coin] > m then begin
            m := sum[weight - w[coin]] + p[coin];
          end;
        end;
      end;
    end;
    sum[weight] := m;
  end;
  Max := sum[f - e];

  WF := OutputTxt;
  WF.Reset;
  WF.ReadLine(answer);
  if answer = 'This is impossible.' then begin
    if Min <> -1 then
      VRejectWA;
    VAccept;
  end;
  WF.Reset;
  WF.ReadLongInt(umin);
  WF.ReadLongInt(umax);
  if (umin < 0) or (umax < 0) then
    VRejectPE;
  if (umin <> Min) or (umax <> Max) then
    VRejectWA;
  VAccept;
end.
