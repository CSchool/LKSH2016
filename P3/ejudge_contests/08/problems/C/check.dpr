{ VERIFICATION PROGRAM for "Folding" problem for NEERC'2002 }
{ (C) Roman Elizarov, 2002 }
{$APPTYPE CONSOLE}
program FOLDING_CHECK;

uses
  SysUtils,
  testlib in '/home/ejudge/inst-ejudge/share/ejudge/testlib/delphi/testlib.pas';
const
  MAX_LEN = 100;

var
  src: string;

type 
  TSolution = class
  public
    l: integer;

    constructor Create(var ins: InStream);
  end;

constructor TSolution.Create(var ins: InStream);
var
  s, u: string;
  pos: integer;

  function unfold: string;
  var
    pstart, pend: integer;
    cnt, i: integer;
    ss: string;
  begin
    result := '';
    while true do begin
      pstart := pos;
      while (pos <= length(s)) and (s[pos] >= 'A') and (s[pos] <= 'Z') do
        inc(pos);
      if (pos > length(s)) or (s[pos] = ')') then begin
        result := result + copy(s, pstart, pos - pstart);
        exit;
      end;
      if (s[pos] < '0') or (s[pos] > '9') then 
        ins.Quit(_WA, 'Wrong characted in folded string: ' + s[pos]);
      pend := pos;
      cnt := 0;
      while (pos <= length(s)) and (s[pos] >= '0') and (s[pos] <= '9') do begin
        cnt := 10*cnt + ord(s[pos]) - ord('0');
        inc(pos);
        if cnt > MAX_LEN then
          ins.Quit(_WA, 'Repeat counter is too big');
      end;
      if pos > length(s) then
        ins.Quit(_WA, 'End of string after repeat counter');
      if s[pos] <> '(' then
        ins.Quit(_WA, '"(" is not found after repeat counter');
      inc(pos);
      ss := unfold;
      if (pos > length(s)) or (s[pos] <> ')') then
        ins.Quit(_WA, '")" is not found after repeated group');
      inc(pos);
      result := result + copy(s, pstart, pend - pstart);
      for i := 1 to cnt do
        result := result + ss;
    end;
  end;

begin
  s := ins.ReadString;
  if not ins.SeekEof then
    ins.Quit(_PE, 'Extra data in file');
  { Try to unfold }
  if length(s) > MAX_LEN then
    ins.Quit(_WA, 'Folded string is too long');
  pos := 1;
  u := unfold;
  if pos < length(s) then
    ins.Quit(_WA, 'Count not unfold completely');
  if u <> src then
    ins.Quit(_WA, 'Does not unfold properly');
end;

var
  souf, sans: TSolution;

begin
  try
    { Read input }
    src := inf.ReadString;
    if not inf.SeekEof then
      Quit(_FAIL, 'Extra data in input file');
    { Read ans & ouf }
    sans := TSolution.Create(ans);
    souf := TSolution.Create(ouf);
    { Check answer }
    if souf.l <> sans.l then
      Quit(_WA, 'Wrong answer length: ' + IntToStr(souf.l) + ' <> ' + IntToStr(sans.l));
    Quit(_OK, 'Ok');
  except on e: Exception do
    Quit(_FAIL, e.Message);
  end;
end.
