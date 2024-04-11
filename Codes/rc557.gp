/*
T1 = s1/u + s2/f + s3/d
T2 = s1/d + s2/f + s3/u
exist x, y >= 0, s.t.
x*T1 + y*T2 = s1 + s2 + s3 =>
x/u + y/d == 1 && x/f + y/f == 1 && x/d + y/u == 1 =>
0 < u < f < d, 1/f = (1/u + 1/d)/2
Let gcd(u, d) = g => u = g*uu, d = g*dd, gcd(uu, dd) = 1
f = 2*g*uu*dd/(uu+dd)
*/


{
T = 10^8;
s = 0;
uumax = sqrtint(T);
for (uu = 1, uumax,
    for (dd = uu + 1, T,
        if ((uu+dd)\2*dd > T, break);
        if (gcd(uu, dd) > 1, next);
        if ((uu+dd)%2 == 0, g = (uu+dd)/2, g = uu+dd);
        d = g * dd; if (d >= T, next);
        \\u = g * uu; f = 2*g/(uu+dd)*uu*dd; print([u, f, d]);
        s++;
    );
);
print(s);
}
