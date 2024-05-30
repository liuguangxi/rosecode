{
N = 2*10^7;
Nsqrt = sqrtint(N);
Nsqrtsqrt = sqrtint(Nsqrt);

visp = vectorsmall(Nsqrt, i, i > 1);
for (i = 2, Nsqrtsqrt,
    if (visp[i],
        forstep (j = i * i, Nsqrt, i, visp[j] = 0);
    );
);
print("visp done");


/*
Calculate number of squarefree numbers <= n
Init: S(v, 1) = v
For p > 1:
    S(v, p) = S(v, p - 1)    for p is NOT prime or p^2 > v
    S(v, p) = S(v, p - 1) - S(v\p^2)    otherwise
*/
smalls = vector(Nsqrt, i, i);    \\ S(i)
larges = vector(Nsqrt, i, N\i);    \\ S(N\i)
for (p = 2, Nsqrt,
    if (visp[p] == 0, next);
    q = p * p;
    end = min(Nsqrt, N\q);
    for (i = 1, end,
        d = i * q;
        if (d <= Nsqrt, larges[i] -= larges[d], larges[i] -= smalls[N\d]);
    );
    forstep (i = Nsqrt, q, -1,
        smalls[i] -= smalls[i\q];
    );
);
print("smalls / larges done");


s = smalls[1] * larges[1];
for (i = 2, Nsqrt, s += (smalls[i] - smalls[i - 1]) * (larges[i] - smalls[i - 1]));
print(s);
}
