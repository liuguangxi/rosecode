{
N = 30!;
fa = factor(N);
s = 1;
for (i = 1, #fa[,1],
    p = fa[i,1]; e = fa[i,2];
    s *= e + 1 - e/p;
);
printf("A(%d) = %s\n", N, Str(s));
}
