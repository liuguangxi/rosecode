f(x) = log(113) - log(113 - x) - (100 - x)/61;


{
D = solve(x = 0, 100, f(x));
t_hour = (100 - D) / 61;
t_ms = round(t_hour * 3600 * 1000);
tms = t_ms % 1000;
ts = (t_ms \ 1000) % 60;
tmin = (t_ms \ 1000 \ 60) % 60;
thour =  t_ms \ 1000 \ 60 \ 60;
printf("%02d:%02d:%02d:%03d\n", thour, tmin, ts, tms);
}
