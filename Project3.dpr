program Project3;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Windows,
  Math;

// local var abreviations:
{
  varAbr+type+name
}

type
  calcFunction = function(abcd: Single): Single;

function timeProcedure(tpx: calcFunction): Single;
var

  tPi, tPj: Integer;
  tPxt: Extended80;
  startTime64, endTime64, frequency64: Int64;
  // elapsedSeconds: Single;

begin
  tPxt := 0;
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  for tPj := 1 to 1000 do
  begin
    for tPi := 1 to 1000000 do
      tPxt := tPxt + tpx(tPi);
  end;

  QueryPerformanceCounter(endTime64);
  Result := (endTime64 - startTime64) / frequency64;

end;

function FastInvSqrt(fix: Single): Single;
var
  xhalf: Single;
  fii: Integer;
begin
  xhalf := 0.5 * fix;
  fii := $5F3759DF - (PInteger(@fix)^ shr 1);
  fix := PSingle(@fii)^;
  Result := 1 / (fix * (1.5 - (xhalf * fix * fix))); // calc sqrt
end;

function regInvSqrt(rgX: Single): Single;
begin
  Result := Sqrt(rgX); // calc sqrt
end;

var
  Ix: Int64;

begin
  Writeln('Reg - ', char(9), timeProcedure(regInvSqrt));
  Writeln('fast - ', char(9), timeProcedure(FastInvSqrt));
  // comparing fast inverse sqrt to windows sqrt fx;
  Readln;

end.
