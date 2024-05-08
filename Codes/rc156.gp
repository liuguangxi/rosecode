dfs1(k, t) = {
    my(tnew, z, d);
    for (x = 1, 3,
        if (x == 1, tnew = t + 101, if (x == 2, tnew = t - 211, tnew = (-2) * t));
        v1[k] = x;
        d = fromdigits(v1[1..k]);
        if (mapisdefined(m1, tnew, &z),
            if (d < z, mapput(m1, tnew, d)),
            mapput(m1, tnew, d);
        );
        if (k < L1, dfs1(k + 1, tnew));
    );
}


dfs2(k, t) = {
    my(tnew, z, d);
    for (x = 1, 3,
        if (x == 1, tnew = t - 101,
            if (x == 2, tnew = t + 211,
                if (t % 2 == 0, tnew = t \ (-2), next);
            );
        );
        v2[k] = x;
        d = fromdigits(Vecrev(v2[1..k]));
        if (mapisdefined(m2, tnew, &z),
            if (d < z, mapput(m2, tnew, d)),
            mapput(m2, tnew, d);
        );
        if (k < L2, dfs2(k + 1, tnew));
    );
}


{
T = 100000001;
L1 = 13; L2 = 16;

v1 = vector(L1); v2 = vector(L2);
m1 = Map(); mapput(m1, 0, 0);
dfs1(1, 0);
print("dfs1 done");
m2 = Map(); mapput(m2, T, 0);
dfs2(1, T);
print("dfs2 done");

nmin = 10^(L1+L2);
s = setintersect(Set(m1), Set(m2));
if (#s > 0,
    for (i = 1, #s,
        n = fromdigits(concat(digits(mapget(m1, s[i])), digits(mapget(m2, s[i]))));
        if (n < nmin, nmin = n);
        print(n);
    );
    print("N = ", nmin),
    print("No solution!");
);
}
