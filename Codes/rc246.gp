dfs(k, xmin, xset) = {
    my(lenx = #xset, xm, x, xset_new);
    if (k == N,
        if (xset[lenx] == M,
            cnt++; print("[", cnt, "]    ", S);
            if (cnt == Ord, Sord = S);
        ),
        xm = max(xmin, Smin[k]);
        for (i = 1, lenx,
            x = xset[i];
            if (x < xm, next);
            if (x > M - (15 - k), break);
            S[k] = x;
            xset_new = List();
            for (j = 1, k,
                if (S[j] + x <= M, listput(xset_new, S[j] + x), break);
            );
            xset_new = setunion(Set(xset_new), xset);
            dfs(k + 1, x + 1, xset_new);
        );
    );
}


{
M = 1881; N = 15; Ord = 1001;

Smin = vector(N, i, M);
forstep (i = N - 1, 1, -1, Smin[i] = ceil(Smin[i + 1] / 2));

S = vector(N); S[1] = 1; S[2] = 2; S[N] = M;
cnt = 0; Sord = vector(N);
dfs(3, 3, [1..4]);

printf("%d,%d\n", cnt, Sord);    \\ 2964,{1,2,4,5,9,14,19,38,57,114,228,456,912,1824,1881}
}
