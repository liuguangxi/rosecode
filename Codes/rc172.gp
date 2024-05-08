/*
N(n) = n =>
binary representation of n must be palindromic
*/


\\ Number of binary representation of x be palindromic with 1 <= x <= n
cntpal(n) = {
    my(nd, lend, vp, s, ndmir);
    nd = binary(n); lend = #nd;
    vp = vector(lend - 1, i, 1);
    for (i = 3, lend - 1,
        forstep (j = i - 2, 1, -2, vp[i] += vp[j]);
    );
    s = vecsum(vp);
    for (i = 2, lend \ 2,
        if (nd[i] == 1, s += vp[lend - 2 * (i - 1)]);
    );
    ndmir = nd;
    for (i = 1, lend \ 2, ndmir[lend + 1 - i] = ndmir[i]);
    if (lend % 2 == 0,
        if (fromdigits(ndmir, 2) <= n, s++),
        if (nd[lend \ 2 + 1] == 0,
            if (fromdigits(ndmir, 2) <= n, s++),
            if (fromdigits(ndmir, 2) <= n, s += 2, s++);
        );
    );
    return(s);
}


{
N = 10^100;
ans = cntpal(N);
print(ans);
}
