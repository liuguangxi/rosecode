/*
C(B, L) = sum(k = 0, B-1, (-1)^k * ((B-k)*(B-k)^(L-1)*binomial(B-1,k-1)+(B-k-1)*(B-k)^(L-1)*binomial(B-1,k)))
D(B, N) = sum(L = 1, N, C(B, L))
        = sum(k = 0, B-1, (-1)^k * sum(L = 1, N, (B-k)*(B-k)^(L-1)*binomial(B-1,k-1)+(B-k-1)*(B-k)^(L-1)*binomial(B-1,k)))
        = sum(k = 0, B-1, (-1)^k * sum(L = 1, N, (B-k)^(L-1)) * ((B-k)*binomial(B-1,k-1)+(B-k-1)*binomial(B-1,k)))
*/


{
B = 12345678; N = 87654321;
M = 1000000007;
s = 0;
bino1 = Mod(0, M); bino2 = Mod(1, M);
for (k = 0, B - 1,
    r = Mod(B - k, M);
    if (r == Mod(1, M), t = Mod(N, M), t = (r^N - 1)/(r - 1));
    s += t * (-1)^k * (r*bino1 + (r - 1)*bino2);
    bino1 = bino2; bino2 *= Mod(B - 1 - k, M) / Mod(k + 1, M);
);
print(lift(s));    \\ 441797524
}
