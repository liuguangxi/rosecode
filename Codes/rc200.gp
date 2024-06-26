/* https://oeis.org/A000186 */
a(n) = {
    my(t0 = 0);
    for (j = 0, n, for (k = 0, n - j,
        t0 += (2^j/j!)*k!*binomial(-3*(k+1), n-k-j);
    ));
    return(n!*t0);
}


repr(x) = {
    my(vx = digits(x), lenvx = #vx, strx);
    if (lenvx <= 20, return(Str(x)));
    if (lenvx > 20,
        strx = "";
        for (i = 1, 10, strx = concat(strx, Str(vx[i])));
        strx = concat([strx, "[", Str(lenvx - 20), "]"]);
        forstep (i = 9, 0, -1, strx = concat(strx, Str(vx[lenvx - i])));
    );
    return(strx);
}


{
N = 208;
s = a(N);
printf("S(%d) = %d\n", N, s);
print(repr(s));
}
