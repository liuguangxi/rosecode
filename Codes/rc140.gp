\\ Digit sum of [10^(k-1), 10^k-1] (k digits of 10^k-10^(k-1))
sumdigk(k) = {
    my(s);
    s = 10^(k-1) * 45;    \\ highest digit sum
    s += (10^k-10^(k-1))/10 * 45 * (k-1);    \\ lower digits sum
    return(s);
}


\\ Digit sum of [0, d-1] (d <= 10^(k-1))
sumdigkd(k, d) = {
    my(s, m, r);
    if (k == 1, return(d*(d-1)/2));
    m = d \ 10^(k-1); r = d % 10^(k-1);
    s = 10^(k-1) * (m*(m-1)/2);    \\ highest digit sum
    s += m*10^(k-2) * 45 * (k-1);    \\ lower digits sum
    if (r != 0,
        s += m * r;    \\ highest digit sum for remain r numbers
        s += sumdigkd(k - 1, r);
    );
    return(s);
}


\\ Digit sum of 123456789 101112 ... (n digits)
sumd(n) = {
    my(s = 0, k, x, d, r, v);

    \\ integral [10^(k-1), 10^k-1]
    k = 1; x = 9;
    while (n >= x,
        s += sumdigk(k); n -= x;
        k++; x = k * (10^k - 10^(k-1));
    );
    if (n == 0, return(s));

    \\ [10^(k-1), 10^(k-1)+d]
    if (n < k, return(s + 1));
    d = n \ k;
    s += sumdigkd(k, 10^(k-1) + d) - 10^(k-2) * 45 * (k-1);

    \\ remain part of 10^(k-1)+d
    r = n % k;
    if (r != 0,
        v = digits(10^(k-1) + d); s += vecsum(v[1..r]);
    );
    return(s);
}


K(n) = sumd(10^n);


{
N = 100;
ans = sumdigits(K(N));
print(ans);
}
