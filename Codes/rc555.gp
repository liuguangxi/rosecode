/*
Let Q(n,m) be the number of distinct trees with n nodes where each node can have 
no more than m edges connected to it. 
Two trees are not considered distinct if they are isomorphic.

For example, Q(6,3) = 4. Four distinct trees are shown bellow.
You are given Q(15,4) = 4347 and Q(50,7) = 646618404 (mod 1000000007)

Find Q(1000,15) mod 1000000007


[Reference] https://www.cnblogs.com/flashhu/p/9457830.html
*/


{
N = 1000; M = 15;
P = 1000000007;

f = matrix(N+1, M+1, i, j, Mod(0, P));
f[1+1,0+1] = Mod(1, P);
for (mx = 1, (N+1)\2-1,
    a = 0; for (j = 0, M-1, a += f[mx+1,j+1]);
    forstep (i = N, mx+1, -1,
        for (j = 1, M,
            for (k = 1, min(j, i\mx),
                f[i+1,j+1] += f[i-mx*k+1,j-k+1] * binomial(a+k-1, k);
            );
        );
    );
);
ans = 0; for (j = 0, M, ans += f[N+1,j+1]);
if (N % 2 == 0,
    a = 0; for (j = 0, M-1, a += f[N\2+1,j+1]);
    ans += binomial(a + 1, 2);
);
printf("Q(%d, %d) = %d (mod %d)\n", N, M, lift(ans), P);
}
