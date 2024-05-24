{
E = exp(1);
[Ae, Be, Ce] = -lindep([E^2, E, 1], 30)~;
[Api, Bpi, Cpi] = -lindep([Pi^2, Pi, 1], 30)~;
printf("%d,%d,%d,%d,%d,%d\n", Ae, Be, Ce, Api, Bpi, Cpi);
}
