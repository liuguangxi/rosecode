{
N = 10^9;
s = 0;
for (m = 1, sqrtint(3*N),
    if (m % 1000 == 0, print("m = ", m));
    for (n = ceil(m/sqrt(3)), floor(sqrt((6*N-m^2)/3)),
        if (gcd(m, n) != 1, next);
        x = 3*n^2 - m^2; y = 2*m*n; z = 3*n^2 + m^2;
        g = gcd([x, y, z]);
        if (z <= g * N, s++);
    );
);
print(s);    \\ 275664503
}
