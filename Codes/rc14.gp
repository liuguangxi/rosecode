getcycle(x) = {
    my(xx = x, ret = 1);
    while (xx != 1,
        xx = if (xx % 2 == 0, xx / 2, 3 * xx + 1);
        if (xx <= L && V[xx] > 0,
            ret += V[xx]; break,
            ret++;
        );
    );
    if (x <= L, V[x] = ret);
    return(ret);
}


{
L = 1000000; V = vectorsmall(L);
ans = 0;
for (n = 1, 1000000,
    if (n % 100000 == 0, print("n = ", n));
    ans = max(ans, getcycle(n));
);
print(ans);
}
