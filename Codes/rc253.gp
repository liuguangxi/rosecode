dfs(k) = {
    for (x = 1, 4,
        if (Neigh1[k] > 0 && v[Neigh1[k]] == x, next);
        if (Neigh2[k] > 0 && v[Neigh2[k]] == x, next);
        if (Neigh3[k] > 0 && v[Neigh3[k]] == x, next);
        v[k] = x;
        if (k == T,
            tot++;
            if (tot == M, conf = v; found = 1),
            dfs(k + 1);
            if (found, return);
        );
    );
}


{
N = 10;
M = 10^7;
T = N*(N+1)/2;

Neigh1 = vector(T);    \\ left-up
Neigh2 = vector(T);    \\ right-up
Neigh3 = vector(T);    \\ left
n = 0;
for (i = 1, N, for (j = 1, i,
    n++;
    if (j == 1,
        Neigh1[n] = 0;
        if (i == 1, Neigh2[n] = 0, Neigh2[n] = n - i + 1);
        Neigh3[n] = 0,
        Neigh1[n] = n - i;
        if (j == i, Neigh2[n] = 0, Neigh2[n] = n - i + 1);
        Neigh3[n] = n - 1;
    );
));

v = vector(T);
tot = 0; conf = 0; found = 0;
dfs(1);

Cnt = 6468240187392;    \\ OEIS A182798
printf("%d/", Cnt);
n = 0;
for (i = 1, N,
    for (j = 1, i, n++; printf("%d", conf[n]));
    if (i < N, printf(","));
);
}
