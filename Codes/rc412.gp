/*
a^2  b^2  c^2
d^2  e^2  f^2
g^2  h^2  k^2
*/


{
N = 200;

vs = vector(2*N^2, i, List());
for (x = 1, N - 1, for (y = x + 1, N,
    xplusy = x^2 + y^2;
    listput(vs[xplusy], x); listput(vs[xplusy], y);
));

for (a = 1, N, for (b = 1, N,
    if (b == a, next);
    for (c = 1, N,
        if (c == a || c == b, next);
        s1 = b^2 + c^2;
        v = vs[s1]; lenv = #v / 2;
        if (lenv <= 2, next);
        s = a^2 + s1;
        v1 = List(); v2 = List();
        for (i = 1, lenv,
            x = v[2*i-1]; y = v[2*i];
            if (x == b || y == b, next);
            listput(v1, x); listput(v1, y);
            listput(v2, y); listput(v2, x);
        );
        lenv1 = #v1;
        for (i = 1, lenv1, for (j = 1, lenv1,
            if (i == j, next);
            d = v1[i]; g = v2[i]; e = v1[j]; k = v2[j];
            if (d == k, next);
            if (d^2 + e^2 != c^2 + k^2, next);
            if (b^2 + e^2 != g^2 + k^2, next);
            f2 = s - d^2 - e^2;
            if (issquare(f2), f = sqrtint(f2), next);
            h2 = s - b^2 - e^2;
            if (issquare(h2), h = sqrtint(h2), next);
            res = Set([a, b, c, d, e, f, g, h, k]);
            if (#res < 9, next);
            printf("%d,%d,%d,%d,%d,%d,%d,%d,%d\n", a, b, c, d, e, f, g, h, k);
            break(5);
        ));
    );
));
}
