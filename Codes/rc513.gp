f(n, m) = {
    my(x, k, A0, A1, C, coef, x0, xn);
    k = 1; while (k! % m > 0, k++);
    x = B[1..2*k] % m;
    A0 = matrix(k, k, i, j, x[i+j-1]);
    A1 = matrix(k, k, i, j, x[i+j]);
    C = lift(Mod(A1 / A0, m));
    coef = C[k,];
    printf("order = %d  c(%d) = %d\n", k, m, coef);
    x0 = Mod(x[1..k], m);
    xn = Mod(C, m)^n * x0~;
    return(xn[1]);
}


{
NB = 70;
B = vector(NB + 1, i, 1);    \\ B_n = B[n + 1]
for (n = 1, NB, B[n+1] = sum(k = 0, n - 1, binomial(n - 1, k) * B[k + 1]));

N = 10^7;
M = 30!;
fa = factor(M); lenfa = #fa[,1];
fv = List();
for (i = 1, lenfa,
    listput(fv, f(N, fa[i,1]^fa[i,2]));
);
s = lift(chinese(fv));
ans = s % (10^9+7);
print(ans);
}
