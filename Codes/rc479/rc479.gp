/*
a*10^d + b = b^2 - a^2 =>
(2*a+10^d)^2 - (2*b-1)^2 = 10^(2*d)-1
where d > 0, 10^(d-1) <= a < b < 10^d
*/


{
vn = List();
for (d = 1, 25,
    T = 10^(2*d)-1;
    fordiv (T, v,
        if (v^2 > T, break);
        u = T / v;
        if ((u + v) % 2 != 0, next);
        a = (u + v) / 2 - 10^d; if (a % 2 != 0, next, a /= 2);
        b = (u - v) / 2 + 1; if (b % 2 != 0, next, b /= 2);
        if (10^(d-1) <= a && a < b && b < 10^d,
            n = a*10^d + b;
            print(n); listput(vn, n);
        );
    );
);
vn = Vec(vn);
cnt = #vn; sumn = vecsum(vn);
printf("%d,%d\n", cnt, sumn);
}
