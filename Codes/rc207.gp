/*
https://en.wikipedia.org/wiki/Laver_table
https://oeis.org/A098820
*/


{
N = 2^16;

T = vector(N - 1, i, List());
for (i = 1, N - 1, listput(T[i], i % N + 1));

forstep (i = N - 1, 1, -1,
    if (T[i][1] == N, next);
    for (j = 2, N,
        p = T[i][j-1];
        if (p == N,
            x = T[i][1],
            M = #T[p]; q = (T[i][1] - 1) % M + 1;
            x = T[p][q];
        );
        listput(T[i], x);
        if (x == N, break);
    );
);

T1 = Vec(T[1]);
printf("%d", T1);
}
