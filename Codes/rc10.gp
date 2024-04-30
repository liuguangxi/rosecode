chk(k, x) = {
    if (k == 1, return(1));
    for (i = 1, k - 1, if (C[i] == x, return(0)));
    for (i = 1, k - 1, if (i - C[i] == k - x, return(0)));
    for (i = 1, k - 1, if (i + C[i] == k + x, return(0)));
    return(1);
}


rec(k) = {
    for (x = 1, N,
        if (chk(k, x),
            C[k] = x;
            if (k == N, s++; print(C), rec(k + 1));
        );
    );
}


{
N = 6;
C = vector(N);
s = 0;
rec(1);
print(s);
}
