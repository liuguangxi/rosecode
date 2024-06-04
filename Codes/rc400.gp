dfs1(k, s) = {
    my(x, p);
    x = s; p = p1[k];
    while (x < T,
        if (k == lenp1, listput(d1, x), dfs1(k + 1,x));
        x *= p;
    );
}


dfs2(k, s) = {
    my(x, p);
    x = s; p = p2[k];
    while (x < T,
        if (k == lenp2, listput(d2, x), dfs2(k + 1,x));
        x *= p;
    );
}


{
T = 10^15-1;
p1 = [2, 3, 5, 7, 11];
p2 = [13, 17, 19, 23, 29, 31, 37, 41, 43, 47];
lenp1 = #p1; lenp2 = #p2;
d1 = List(); d2 = List();
dfs1(1, 1); d1 = vecsort(d1);
dfs2(1, 1); d2 = vecsort(d2);
len1 = #d1; len2 = #d2;

best = 0;
k2 = len2;
for (k1 = 1, len1,
    while (k2 > 0,
        s = d1[k1] * d2[k2];
        if (s >= T, k2--, break);
    );
    if (k2 <= 0, break);
    if (s > best, best = s; print("s = ", s));
);
print(best);
}
