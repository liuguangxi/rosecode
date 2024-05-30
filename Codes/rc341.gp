check(n) = {
    my(v = digits(n));
    for (i = 1, #v,
        if (v[i] != 2 && v[i] != 3 && v[i] != 5 && v[i] != 7, return(0));
    );
    return(1);
}


dfs(k, s) = {
    my(m, s2, d, x);
    m = 10^k;
    for (i = 1, 4,
        s2 = s + m / 10 * Pri[i];
        if (check(Dmul[1] * s2 % m) == 0, next);
        if (check(Dmul[2] * s2 % m) == 0, next);
        if (check(Dmul[3] * s2 % m) == 0, next);
        d = Dmul[1] + 10*Dmul[2] + 100*Dmul[3];
        if (k == N, x = d * s2, x = d * s2 % m);
        if (check(x),
            if (k == N, printf("%d*%d=%d\n", s2, d, s2*d), dfs(k + 1, s2));
        );
    );
}


{
N = 12;
Pri = [2, 3, 5, 7];
for (x1 = 2, 4, for (x2 = 2, 4, for (x3 = 2, 4,
    Dmul = [Pri[x1], Pri[x2], Pri[x3]];
    dfs(1, 0);
)));
}
