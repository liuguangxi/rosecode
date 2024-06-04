dfs(k, imin, r) = {
    my(rr);
    if (Found, return);
    if (r < 1/(Vp[Lp] + 1), return);
    for (i = imin, Lp,
        rr = r - 1/(Vp[i] + 1);
        if (rr < 0, next);
        Vi[k] = i;
        if (rr == 0,
            for (j = 1, k - 1, printf("%d,", Vp[Vi[j]])); printf("%d\n", Vp[Vi[k]]);
            Found = 1; return;
            ,
            dfs(k + 1, i + 1, rr);
        );
    );
}


{
R = 25/61;
Vp = primes([1, 100000]); Lp = #Vp;
Vi = vector(100);
Found = 0;
dfs(1, 1, R);
}
