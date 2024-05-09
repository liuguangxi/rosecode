/* https://oeis.org/A000186 */
a(n) = {
    my(t0 = 0);
    for (j = 0, n, for (k = 0, n - j,
        t0 += (2^j/j!)*k!*binomial(-3*(k+1), n-k-j);
    ));
    return(n!*t0);
}


{
N = 208;
s = a(N);
printf("S(%d) = %d\n", N, s);
vs = digits(s); lenvs = #vs;
if (lenvs > 20,
    for (i = 1, 10, printf(vs[i]));
    printf("[%d]", lenvs - 20);
    forstep (i = 9, 0, -1, printf(vs[lenvs - i]));
    print;
);
}
