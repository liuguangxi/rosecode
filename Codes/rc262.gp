dfs(k, r, s) = {
    my(rnew, snew);
    for (x = 0, 9,
        if (k == 1 && x % 2 == 0, next);
        if (Num[x + 1] <= r,
            rnew = r - Num[x + 1];
            snew = s + x * 10^(k - 1);
            if (rnew == 0,
                if (x != 0 && isprime(snew), Count++),
                dfs(k + 1, rnew, snew);
            );
        );
    );
}


{
Num = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6];
Count = 0;
dfs(1, 20, 0);
print(Count);
}
