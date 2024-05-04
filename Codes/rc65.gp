{
f = sum(i = 1, 6, x^i)^2;
fa = factor(f);
f1 = fa[1,1]; f2 = fa[2,1]; f3 = fa[3,1]; f4 = fa[4,1];
for (k1 = 0, 2, for (k2 = 0, 3, for (k3 = 0, 2, for (k4 = 0, 2,
    D1 = f1^k1 * f2^k2 * f3^k3 * f4^k4;
    if (D1 == sum(i = 1, 6, x^i), next);
    if (polcoef(D1, 0) != 0, next);
    if (f % D1 != 0, next);
    D2 = f / D1;
    if (polcoef(D2, 0) != 0, next);
    if (vecsum(Vec(D1)) == 6 && vecsum(Vec(D2)),
        print(D1, ", ", D2);
    );
))));

ans = "122334,134568";
print(ans);
}
