/* E(10, 8) = 0.221703702539 */


chk(v) = {
    for (i = 1, #v,
        if (v[i] > 0 && !isprime(v[i]), return(0));
    );
    return(1);
}


{
M = 10; N = 8;

fr = Map();
v0 = vectorsmall(N + 1); mapput(fr, v0, 1);
v0[N + 1] = 1; mapput(fr, v0, 1);
for (r = 1, M,
    lenr = #fr; matr = Mat(fr); print("r = ", r, "    #fr = ", lenr);
    fr1 = Map();
    for (c = 1, lenr,
        v = matr[c,1]; b = v[N + 1]; x = matr[c,2];
        for (k = 1, N,
            for (i = 1, min(k, b),
                for (j = 0, 2 * i,
                    k2 = N - k; b2 = b + k - 2*i + j;
                    x2 = x * binomial(N - 1, k - 1) * binomial(k - 1, i - 1) * binomial(b, i) * binomial(2 * i, j);
                    v2 = v; v2[k2 + 1]++; v2[N + 1] = b2;
                    if (mapisdefined(fr1, v2, &x0),
                        mapput(fr1, v2, x0 + x2),
                        mapput(fr1, v2, x2);
                    );
                );
            );
        );
    );
    fr = fr1;
);

lenr = #fr; matr = Mat(fr);
ps1 = 0; ps = 0;
for (c = 1, lenr,
    v = matr[c,1]; b = v[N + 1]; x = matr[c,2];
    if (b == 0,
        ps += x;
        if (chk(v[1..N]), ps1 += x);
    );
);
E = ps1 / ps;
printf("E(%d, %d) = %.12f\n", M, N, E);
}
