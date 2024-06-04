dfs(d, k) = {
    my(dnew, d1, d2, diff);
    for (i = 0, 1,
        if (i == 0, dnew = d, dnew = d * e[k]);
        if (dnew > dmax, next);
        if (k == L,
            d1 = dnew; d2 = m / dnew; diff = d2 - d1;
            if (diff < best_diff,
                best_d1 = d1; best_d2 = d2; best_diff = diff;
                printf("d1 = %d, d2 = %d, diff = %d\n", best_d1, best_d2, best_diff);
            ),
            dfs(dnew, k + 1);
        );
    );
}


{
N = 100;
ve = factor(N!)[,2];
L = #ve;
e = vector(L, i, ve[i] + 1);
m = prod(i = 1, L, e[i]);
dmax = sqrtint(m);
best_d1 = best_d2 = 0; best_diff = m;
dfs(1, 1);
printf("%d,%d\n", best_d1, best_d2);
}
