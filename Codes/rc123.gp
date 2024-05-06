f(x, n) = (x - 1) % n + 1;


creatures(n, d, m) = {
    my(num0, vmat, i1, i2, i3, i4, i5, i6, mn, ddivn, dmodn, md, s);
    num0 = vector(n + 1, i, Mod(1, m))~;
    vmat = vector(n, i, Mod(matrix(n + 1, n + 1), m));
    for (i = 1, n,
        vmat[i][n+1,n+1] = Mod(1, m);
        for (k = 1, n,
            i1 = f(i + 1, n); i2 = f(i + 2, n); i3 = f(i + 3, n);
            i4 = f(i + 4, n); i5 = f(i + 5, n); i6 = f(i + 6, n);
            if (k == i,
                vmat[i][k,i] = Mod(1, m);
                vmat[i][k,i1] = Mod(1, m);
                vmat[i][k,i2] = Mod(1, m);
                vmat[i][k,i3] = Mod(2, m);
                vmat[i][k,i5] = Mod(1, m);
                vmat[i][k,n+1] = Mod(999, m);
            );
            if (k == i4,
                vmat[i][k,i4] = Mod(2, m);
                vmat[i][k,n+1] = Mod(17, m);
            );
            if (k == i5,
                vmat[i][k,n+1] = Mod(1, m);
            );
            if (k == i6,
                vmat[i][k,i6] = Mod(4, m);
            );
            if (k != i && k != i4 && k != i5 && k != i6,
                vmat[i][k,k] = Mod(1, m);
            );
        );
    );
    mn = prod(i = 1, n, vmat[n+1-i]);
    ddivn = d \ n; dmodn = d % n;
    md = mn ^ ddivn;
    for (i = 1, dmodn, md = vmat[i] * md);
    s = md * num0;
    s = lift(vecsum(s[1..n]));
    return(s);
}


{
N = 11; D = 10^19; M = 10^9;
c = creatures(N, D, M);
print(c);
}
