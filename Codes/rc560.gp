/*
for (s1 = 0, Smax, for (s2 = 0, Smax,
    if (s1 + s2 > Smax, break);
    vf[s1+s2+1] += vf1[s1+1] * vf2[s2+1];
    vg[s1+s2+1] += vg1[s1+1] * Mod(10, M)^len2 * vf2[s2+1] + vg2[s2+1] * vf1[s1+1];
));
*/
conv(vf1, vf2, vg1, vg2, len2) = {
    my(pol1, pol2, pol, vff, vgg);

    pol1 = Polrev(vf1) + O(x^(Smax+1));
    pol2 = Polrev(vf2) + O(x^(Smax+1));
    pol = pol1 * pol2;
    if (polcoeff(pol, 0) == 0,
        vf = Vec(pol + Mod(1, M)); vf[1] = 0,
        vf = Vec(pol);
    );

    pol1 = Polrev(vg1) + O(x^(Smax+1));
    pol2 = Polrev(vf2) + O(x^(Smax+1));
    pol = pol1 * pol2 * Mod(10, M)^len2;
    pol1 = Polrev(vg2) + O(x^(Smax+1));
    pol2 = Polrev(vf1) + O(x^(Smax+1));
    pol += pol1 * pol2;
    if (polcoeff(pol, 0) == 0,
        vg = Vec(pol + Mod(1, M)); vg[1] = 0,
        vg = Vec(pol);
    );

    return([vf, vg]);
}


{
N = 11^1111;
M = 1000000007;


/* Initialization */
vN = digits(N);
L = #vN;
K = max((L-1)\2, 1);
Smax = 9*(K+1);
f = matrix(K + 1, Smax + 1, i, j, Mod(0, M));
g = matrix(K + 1, Smax + 1, i, j, Mod(0, M));
f0 = matrix(K + 1, Smax + 1, i, j, Mod(0, M));
g0 = matrix(K + 1, Smax + 1, i, j, Mod(0, M));
for (i = 1, 9, f[1,i+1] = Mod(1, M); g[1,i+1] = Mod(i, M));
for (i = 0, 9, f0[1,i+1] = Mod(1, M); g0[1,i+1] = Mod(i, M));
for (k = 1, K,
    for (s = 0, 9*K, for (d = 0, 9,
        if (s + d > Smax, break);
        f[k+1,s+d+1] += f[k,s+1];
        g[k+1,s+d+1] += 10 * g[k,s+1] + d * f[k,s+1];
        f0[k+1,s+d+1] += f0[k,s+1];
        g0[k+1,s+d+1] += 10 * g0[k,s+1] + d * f0[k,s+1];
    ));
);
print("Initialization done");


/* Part 1: [1, 10^(L-1)-1] */
Count1 = 9; Sum1 = vecsum(g[1,]);
for (n = 2, L-1,
    n2 = n \ 2;
    if (n % 2 == 0,
        for (s = 1, 9*n2,
            Count1 += f[n2,s+1] * f0[n2,s+1];
            Sum1 += g[n2,s+1] * Mod(10, M)^n2 * f0[n2,s+1] + g0[n2,s+1] * f[n2,s+1];
        ),
        for (s = 1, 9*n2,
            Count1 += f[n2,s+1] * f0[n2,s+1] * 10;
            Sum1 += (g[n2,s+1] * Mod(10, M)^(n2+1) * f0[n2,s+1] + g0[n2,s+1] * f[n2,s+1]) * 10 + 45 * Mod(10, M)^n2 * f[n2,s+1] * f0[n2,s+1];
        );
    );
);
print("Part 1 done");


/* Part 2: [10^(L-1), N\10^(L\2)*10^(L\2)-1] */
Count2 = 0; Sum2 = 0;
dspre = 0; sumpre = Mod(0, M);
if (L % 2 == 0,
    for (k = 1, L/2,
        if (k == 1, dmin = 1, dmin = 0);
        if (vN[k] > dmin,
            vfk = vector(Smax + 1, i, Mod(0, M)); vgk = vector(Smax + 1, i, Mod(0, M));
            for (d = dmin, vN[k]-1,
                vfk[dspre+d+1] = Mod(1, M);
                vgk[dspre+d+1] = sumpre * 10 + d;
            );
            if (k < L/2, [vfk, vgk] = conv(vfk, f0[L/2-k,], vgk, g0[L/2-k,], L/2-k));
            for (s = 1, Smax,
                Count2 += vfk[s+1] * f0[L/2,s+1];
                Sum2 += vgk[s+1] * Mod(10, M)^(L/2) * f0[L/2,s+1] + g0[L/2,s+1] * vfk[s+1];
            );
        );
        dspre += vN[k]; sumpre = sumpre * 10 + vN[k];
    );
    ,
    for (k = 1, L\2,
        if (k == 1, dmin = 1, dmin = 0);
        if (vN[k] > dmin,
            vfk = vector(Smax + 1, i, Mod(0, M)); vgk = vector(Smax + 1, i, Mod(0, M));
            for (d = dmin, vN[k]-1,
                vfk[dspre+d+1] = Mod(1, M);
                vgk[dspre+d+1] = sumpre * 10 + d;
            );
            if (k < L\2, [vfk, vgk] = conv(vfk, f0[L\2-k,], vgk, g0[L\2-k,], L\2-k));
            for (s = 1, Smax,
                Count2 += vfk[s+1] * f0[L\2,s+1] * 10;
                Sum2 += (vgk[s+1] * Mod(10, M)^(L\2+1) * f0[L\2,s+1] + g0[L\2,s+1] * vfk[s+1]) * 10 + 45 * Mod(10, M)^(L\2) * vfk[s+1] * f0[L\2,s+1];
            );
        );
        dspre += vN[k]; sumpre = sumpre * 10 + vN[k];
    );
    vNmid = vN[L\2+1];
    if (vNmid > 0,
        Count2 += f0[L\2,dspre+1] * vNmid;
        Sum2 += (sumpre * Mod(10, M)^(L\2+1) * f0[L\2,dspre+1] + g0[L\2,dspre+1]) * vNmid + binomial(vNmid, 2) * Mod(10, M)^(L\2) * f0[L\2,dspre+1];
    );
);
print("Part 2 done");


/* Part 3: [N\10^(L\2)*10^(L\2), N] */
Count3 = 0; Sum3 = 0;
ds = vecsum(vN[1..L\2]);
dspre = 0; sumpre = Mod(0, M);
for (k = ceil(L/2)+1, L,
    if (vN[k] > 0,
        vfk = vector(Smax + 1, i, Mod(0, M)); vgk = vector(Smax + 1, i, Mod(0, M));
        for (d = 0, vN[k]-1,
            vfk[dspre+d+1] = Mod(1, M);
            vgk[dspre+d+1] = sumpre * 10 + d;
        );
        if (k < L, [vfk, vgk] = conv(vfk, f0[L-k,], vgk, g0[L-k,], L-k));
        Count3 += vfk[ds+1];
        Sum3 += vgk[ds+1];
    );
    dspre += vN[k]; sumpre = sumpre * 10 + vN[k];
);
npre = Mod(fromdigits(vN[1..ceil(L/2)]), M) * Mod(10, M)^(L-ceil(L/2));
Sum3 += Count3 * npre;
print("Part 3 done");


/* Final results */
Count = Count1 + Count2 + Count3;
Sum = Sum1 + Sum2 + Sum3;
print(lift(Count), ",", lift(Sum));
}
