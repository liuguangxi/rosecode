\\ sum(n = 1, N, floor(a * n))    (a is rational, N is positive real)
sum_floor_rat(a, N) = {
    my(m, p, q, k, r, s);
    m = floor(N);
    if (a == 0 || m == 0, return(0));
    p = numerator(a); q = denominator(a);
    if (m >= q,
        k = m \ q; r = m % q;
        s = (k * (k * p * q - q + p + 1)) \ 2 + (r * k * p) + sum_floor_rat(a, r),
        if (p >= q,
            k = p \ q; r = p % q;
            s = ((m * (m + 1) * k) \ 2) + sum_floor_rat(r / q, m),
            k = p * m \ q; s = m * k - sum_floor_rat(q / p, k);
        );
    );
    return(s);
}


{
default(realprecision, 50);
a = sqrt(2); N = 10^20;
B = N;
while (1,
    x = bestappr(a, B);
    q = denominator(x);
    if (q > N, break, B *= 2);
);
S = sum_floor_rat(x, N);
print(S);
}
