{
R = 10^9;
B = floor(R*sqrt(3)/2);
sqrt3appr = bestappr(sqrt(3), B);
x = denominator(sqrt3appr);
y = round(x*sqrt(3));
s = [(2*x)^2, x^2 + y^2, x^2 + y^2];
s = vecsort(s);
printf("%d,%d,%d\n", s[1], s[2], s[3]);
}
