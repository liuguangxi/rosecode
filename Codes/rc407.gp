dfs(k, pmin, s) = {
    my(m, x, pk, snew);
    if (k <= 2,
        forprime (p = pmin, Pmax,
            vp[k] = p;
            dfs(k + 1, p + 1, s * p);
            if (tot == 2, return);
        ),
        m = lcm(vp[1..k-1] - vector(k - 1, i, 1));
        if (k == 3,
            fordiv (s - 1, d,
                pk = d + 1;
                if (pk >= pmin && pk <= Pmax && (s*pk-1) % m == 0 && isprime(pk),
                    vp[k] = pk; snew = s * pk;
                    dfs(k + 1, pk + 1, snew);
                    if (tot == 2, return);
                );
            ),
            x = (s - 1) \ m;
            fordiv (x, d,
                pk = d * m + 1;
                if (pk >= pmin && pk <= Pmax && isprime(pk),
                    vp[k] = pk; snew = s * pk;
                    if (k == 10,
                        tot++; print(snew, "    ", vp),
                        dfs(k + 1, pk + 1, snew);
                        if (tot == 2, return);
                    );
                );
            );
        );
    );
}


{
Pmax = 10^7;
vp = vector(10);
tot = 0;
dfs(1, 3, 1);
}
