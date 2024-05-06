{
default(realprecision, 100);
T = 10^20;
r = bestappr(exp(1)/Pi, T);
x = numerator(r); y = denominator(r);
printf("%d,%d\n", x, y);
}
