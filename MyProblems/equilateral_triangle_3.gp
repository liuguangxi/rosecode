/*
Point D inside equilateral triangle ABC with side length equal to t
DA = x, DB = y, DC = z =>
x^4 + y^4 + z^4 + t^4 = x^2*y^2 + x^2*z^2 + x^2*t^2 + y^2*z^2 + y^2*t^2 + z^2*t^2
0 < x <= y <= z < t, x + y > t
x^2 + x*y + y^2 >= t
(x, y, t) + A(y, z, t) + A(z, x, t) = A(t, t, t)
*/


area(a, b, c) = {
    my(area2);
    area2 = (b + c - a) * (a + c - b) * (a + b - c) * (a + b + c);
    return(sqrt(area2)/4);
}


{
T = 5000;
cnt = 0; s = 0;
xmax = floor(T/sqrt(3));
for (x = 1, xmax,
    ymax = floor((sqrt(4*T^2-3*x^2)-x)/2);
    for (y = x, ymax,
        u1 = (x + y)^2; u2 = (y - x)^2;
        zmax = min(T-1, x+y-2);
        for (z = y, zmax,
            z2 = z^2; p1 = u1 - z2; p2 = z2 - u2;
            if (p1 % 3 != 0 && p2 % 3 != 0, next);
            k2 = 3 * p1 * p2;
            if (!issquare(k2, &k), next);
            t2 = k + x^2 + y^2 + z2;
            if (t2 % 2 == 1, next, t2 /= 2);
            if (!issquare(t2, &t), next);
            if (t > T || t <= z || t >= x + y, next);
            if (gcd([x, y, z, t]) > 1, next);
            if (abs(area(x, y, t) + area(y, z, t) + area(z, x, t) - area(t, t, t)) > 1e-8, next);
            cnt++; s += x + y + z + t;
            printf("(%d)    %d  %d  %d  %d\n", cnt, x, y, z, t);
        );
    );
);
printf("%d,%d\n", cnt, s);
}
