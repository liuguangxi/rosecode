cntones(x) = {
    my(cnt = 0);
    while (x > 0, cnt += OneCnt[bitand(x, 4095)+1]; x >>= 12);
    return(cnt);
}


isbalance(x) = {
    my(msk, cnt);
    msk = 2^(N-1)-1; cnt = cntones(x);
    while (x > 0,
        x = bitand(bitxor(x, x >> 1), msk);
        cnt += cntones(x);
        msk >>= 1;
    );
    return(cnt == HalfNum);
}


dfs(tot, used, pos, num) = {
    my(used_new, num_new);
    for (x = 0, 1,
        used_new = used + x;
        if (used_new <= tot,
            num_new = num + (x << pos);
            if (used_new == tot,
                if (isbalance(num_new), listput(Vseq, num_new)),
                if ((pos < N - 1) && (used_new + N - pos > tot), dfs(tot, used_new, pos + 1, num_new));
            );
        );
    );
}


seqtosgn(s, n) = {
    my(str);
    str = vector(n);
    forstep (i = n, 1, -1,
        str[i] = if (s % 2 == 1, "-", "+");
        s >>= 1;
    );
    return(concat(str));
}


{
N = 23;
OneCnt = vectorsmall(4096, n, vecsum(digits(n - 1, 2)));
HalfNum = N*(N+1)/4;
Vseq = List();
for (k = 1, N,
    printf("#'-' = %d\n", k);
    dfs(k, 0, 0, 0);
    if (#Vseq > 0,
        printf("#'-' = %d, #'+' = %d\n", k, N - k);
        break;
    );
);
listsort(Vseq);
count = #Vseq; seq = Vseq[1];
printf("%d,%s\n", count, seqtosgn(seq, N));
}
