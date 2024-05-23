{
N = 3*10^10 - 1;

v = sqrtint(N);
smalls = vector(v, i, i-1);    \\ primepi(i)
larges = vector(v, i, N\i-1);    \\ primepi(N\i)
for (p = 2, v,
    if (smalls[p - 1] == smalls[p], next);
    pcnt = smalls[p - 1]; q = p * p; end = min(v, N \ q);
    for (i = 1, end,
        d = i * p;
        if (d <= v, larges[i] -= larges[d] - pcnt, larges[i] -= smalls[N\d] - pcnt);
    );
    forstep (i = v, q, -1,
        smalls[i] -= smalls[i\p] - pcnt;
    );
);

s = 0;
forprime (p = 2, v, s += larges[p] - smalls[p - 1]);
print(s);
}
