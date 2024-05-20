sumdig2(n) = {
    my(vn = digits(n));
    return(sum(i = 1, #vn, vn[i]^2));
}


{
N = 12345678;

M = 9^2*8;
Happy = vector(M);    \\ 0:not process, 10:process, 1:ok, -1:bad
Happy[1] = 1;
for (n = 2, M,
    if (Happy[n] == 1 || Happy[n] == -1, next);
    x = n; ok = 1;
    while (1,
        if (Happy[x] == 0,
            Happy[x] = 10; x = sumdig2(x),
            if (Happy[x] == 10 || Happy[x] == -1,
                ok = 0; break,
                break;
            );
        );
    );
    for (i = 1, M,
        if (Happy[i] == 10,
            Happy[i] = if (ok, 1, -1);
        );
    );
);

s = 0;
for (n = 1, N,
    if (n % 100000 == 0, print("n = ", n));
    if (Happy[sumdig2(n)] == 1, s++);
);
printf("H(%d) = %d\n", N, s);
}
