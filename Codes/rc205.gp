f(n) = {
    my(x = digits(n));
    return(sum(i = 1, #x, x[i]^2));
}


ishappy(n) = {
    while (n != 1,
        if (n == 4, return(0), n = f(n));
    );
    return(1);
}


{
N = 2^300;
Ndig = digits(N);
D = #Ndig;
L = D*9^2+1;

vd = vector(D - 1, i, vector(L));
for (i = 1, D - 1,
    for (d = 0, 9,
        if (i == 1,
            vd[i][d^2+1] = 1,
            for (k = 1, L, if (vd[i - 1][k] > 0, vd[i][d^2 + k] += vd[i - 1][k]));
        );
    );
);

v = vector(L);
sl = 0;
for (i = 1, D,
    if (i == D,
        for (d = 0, Ndig[i], v[sl + d^2 + 1]++),
        for (d = 0, Ndig[i] - 1,
            for (k = 1, L, if (vd[D - i][k] > 0, v[sl + d^2 + k] += vd[D - i][k]));
        );
    );
    sl += Ndig[i]^2;
);

h = 0;
for (i = 2, L, if (ishappy(i - 1), h += v[i]));
print(h);
}
