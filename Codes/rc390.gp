{
N = 100000;
s = N/4 * (3*N + 4)/4 * (3*N + 8)/8;
for (a = 1, N\4,
    if (a % 100 == 0, print("a = ", a));
    for (b = a, N,
        ab = a * b;
        if (issquare(ab),
            bmax = a + b + 2*sqrtint(ab) - 1,
            bmax = a + b + floor(2*sqrt(ab));
        );
        s += min(N, bmax) - b + 1;
    );
);
print(s);    \\ 138895335312108
}
