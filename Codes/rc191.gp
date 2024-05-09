{
N = 6;
s = 0;
for (w1 = 1, N*N-4,
    for (w2 = w1+1, N*N-3,
        for (w3 = w2+1, N*N-2,
            for (w4 = w3+1, N*N-1,
                for (w5 = w4+1, N*N,
                    used = vector(N*N);

                    i = (w1-1)\N+1; j = (w1-1)%N+1;
                    for (k = 1, N, used[(i-1)*N+k] = 1);    \\ -
                    for (k = 1, N, used[(k-1)*N+j] = 1);    \\ |
                    t = i+j; for (k = 1, t-1, if (k <= N && t-k <= N, used[(k-1)*N+(t-k)] = 1));    \\ /
                    t = j-i; for (k = 1, N, if (k+t >= 1 && k+t <= N, used[(k-1)*N+(k+t)] = 1));    \\ \

                    i = (w2-1)\N+1; j = (w2-1)%N+1;
                    for (k = 1, N, used[(i-1)*N+k] = 1);    \\ -
                    for (k = 1, N, used[(k-1)*N+j] = 1);    \\ |
                    t = i+j; for (k = 1, t-1, if (k <= N && t-k <= N, used[(k-1)*N+(t-k)] = 1));    \\ /
                    t = j-i; for (k = 1, N, if (k+t >= 1 && k+t <= N, used[(k-1)*N+(k+t)] = 1));    \\ \

                    i = (w3-1)\N+1; j = (w3-1)%N+1;
                    for (k = 1, N, used[(i-1)*N+k] = 1);    \\ -
                    for (k = 1, N, used[(k-1)*N+j] = 1);    \\ |
                    t = i+j; for (k = 1, t-1, if (k <= N && t-k <= N, used[(k-1)*N+(t-k)] = 1));    \\ /
                    t = j-i; for (k = 1, N, if (k+t >= 1 && k+t <= N, used[(k-1)*N+(k+t)] = 1));    \\ \

                    i = (w4-1)\N+1; j = (w4-1)%N+1;
                    for (k = 1, N, used[(i-1)*N+k] = 1);    \\ -
                    for (k = 1, N, used[(k-1)*N+j] = 1);    \\ |
                    t = i+j; for (k = 1, t-1, if (k <= N && t-k <= N, used[(k-1)*N+(t-k)] = 1));    \\ /
                    t = j-i; for (k = 1, N, if (k+t >= 1 && k+t <= N, used[(k-1)*N+(k+t)] = 1));    \\ \

                    i = (w5-1)\N+1; j = (w5-1)%N+1;
                    for (k = 1, N, used[(i-1)*N+k] = 1);    \\ -
                    for (k = 1, N, used[(k-1)*N+j] = 1);    \\ |
                    t = i+j; for (k = 1, t-1, if (k <= N && t-k <= N, used[(k-1)*N+(t-k)] = 1));    \\ /
                    t = j-i; for (k = 1, N, if (k+t >= 1 && k+t <= N, used[(k-1)*N+(k+t)] = 1));    \\ \

                    nfree = N*N - vecsum(used);
                    if (nfree >= 6,
                        if (s == 0, w = [w1, w2, w3, w4, w5]; b = select(x -> x == 0, used, 1)[1..6]);
                        print([w1, w2, w3, w4, w5], "  ", nfree, "    ", Strchr(used+vector(N*N, i, 48)));
                        s += binomial(nfree, 6);
                    );
                );
            );
        );
    );
);
printf("%d/(%d,%d)(%d,%d)(%d,%d)(%d,%d)(%d,%d)/(%d,%d)(%d,%d)(%d,%d)(%d,%d)(%d,%d)(%d,%d)\n",
    s, (w[1]-1)\N+1, (w[1]-1)%N+1, (w[2]-1)\N+1, (w[2]-1)%N+1, (w[3]-1)\N+1, (w[3]-1)%N+1, (w[4]-1)\N+1, (w[4]-1)%N+1, (w[5]-1)\N+1, (w[5]-1)%N+1,
    (b[1]-1)\N+1, (b[1]-1)%N+1, (b[2]-1)\N+1, (b[2]-1)%N+1, (b[3]-1)\N+1, (b[3]-1)%N+1, (b[4]-1)\N+1, (b[4]-1)%N+1, (b[5]-1)\N+1, (b[5]-1)%N+1, (b[6]-1)\N+1, (b[6]-1)%N+1);
}
