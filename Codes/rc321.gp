f(x, y) = (y - 2*cos(x))^2 + (sin(x) - 4/y)^2;

fx(x, y) = 4*y*sin(x) - 6*cos(x)*sin(x) - 8*cos(x)/y;

fy(x, y) = 2*y - 4*cos(x) + 8*sin(x)/y^2 - 32/y^3;


{
fmin = 1e8;
x0 = Pi/4;
for (i = 1, 100,
    y0 = solve(y = 0.1, 10, fy(x0, y));
    x0 = solve(x = 0.1, 1.57, fx(x, y0));
    fxy = f(x0, y0);
    print([x0, y0, fxy]);
    if (abs(fxy - fmin) < 1e-24, break, fmin = fxy);
);
printf("%.20f\n", fmin);
}
