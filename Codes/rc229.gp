f1(n) = {
    my(k, r, x, y);
    k = sqrtint(n); r = n - k^2;
    if (r == 0,
        if (k % 2 == 0, x = 0, y = k - 1, x = k - 1; y = 0),
        if (k % 2 == 0,
            if (r <= k, x = r - 1; y = k, x = k, y = 2 * k - r + 1),
            if (r <= k, x = k; y = r - 1, x = 2 * k - r + 1; y = k);
        );
    );
    return([x, y]);
}


f2(x, y) = {
    my(k, s);
    k = max(x, y) + 1;
    s = (k - 1)^2;
    if (k % 2 == 0,
        if (x == k - 1, s += y + 1, s += 2 * k - 1 - x),
        if (y == k - 1, s += x + 1, s += 2 * k - 1 - y);
    );
    return(s);
}


{
N = 10^17;
[X, Y] = [718281828,141592653];
p = f1(N);
index = f2(X, Y);
printf("%d,%d/%d\n", p[1], p[2], index);
}
