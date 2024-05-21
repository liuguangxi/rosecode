dfs(k, s) = {
    my(xmin, sk, M);
    xmin = if (k < D, 0, 1);
    M = 10^k;
    for (x = xmin, 9,
        sk = s + x*M/10;
        if (lift(Mod(sk, M)^P - Mod(sk, M)) == 0,
            if (k < D,
                dfs(k + 1, sk),
                Count++; Sum += sk;
                \\print(sk);
            );
        );
    );
}


{
D = 50; P = 73;
Count = 0; Sum = 0;
dfs(1, 0);
printf("%d,%d\n", Count, Sum);
}
