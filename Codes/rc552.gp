dfs(i, slcm, sgn) = {
    my(slcm2, sgn2);
    slcm2 = slcm; sgn2 = sgn;
    if (i == Lvab,
        if (slcm2 <= N, listput(Vlcm, [slcm2, sgn2])),
        dfs(i + 1, slcm2, sgn2);
    );
    slcm2 = lcm(slcm, Vab[i]); sgn2 = -sgn;
    if (i == Lvab,
        if (slcm2 <= N, listput(Vlcm, [slcm2, sgn2])),
        dfs(i + 1, slcm2, sgn2);
    );
}


{
A = 11; B = 20; N = 11^20; Kmax = 150;
P = 10^18+3;

Vpk = vector(Kmax, k, sumformal(Mod(n, P)^k));
Vab = [A..B]; Lvab = #Vab;
Vlcm = List();
dfs(1, 1, 1);
Vlcm = vecsort(Vec(Vlcm)); Lvlcm = #Vlcm;

vp = ve = vector(Kmax);
for (k = 1, Kmax,
    for (i = 1, Lvlcm,
        vp[k] += Vlcm[i][2] * Mod(Vlcm[i][1], P)^k * subst(Vpk[k], n, N \ Vlcm[i][1]);
    );
);
ve[1] = vp[1];
for (k = 2, Kmax,
    t = Mod(0, P);
    for (i = 1, k - 1,
        t += (-1)^(i+1) * ve[i] * vp[k - i];
    );
    ve[k] = (vp[k] - t) / (-1)^(k+1) / Mod(k, P);
);
S = lift(vecsum(ve));
print(S);
}
