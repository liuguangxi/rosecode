{
N = 25!;
fa = factor(N);
s = 1;
for (i = 1, #fa[,1],
    p = fa[i,1]; e = fa[i,2];
    s *= 1 + (p^(2*e) - 1)/(p^(2*e+1) + 1);
);
printf("A(%d) = %s\n", N, Str(s));
}
