/*
S(B, L) = sum(k = 0, B-1, (-1)^k * (
              (B-k)^L*binomial(B-1,k-1)/(B-1)*(B-1)*B/2*(B^L-1)/(B-1) +
              (B-k-1)*(B-k)^(L-1)*binomial(B-1,k)*(1/(B-1)*(B-1)*B/2*B^(L-1) + (B-k-1)/(B-k)/(B-1)*(B-1)*B/2*(B^(L-1)-1)/(B-1))
          ))
H(B, N) = sum(L = 1, N, S(B, L))
        = sum(k = 0, B-1, (-1)^k * sum(L - 1, N,
              binomial(B-1,k-1)*B/2/(B-1) * (B-k)^L*(B^L-1) +
              binomial(B-1,k)*(B-k-1)*B/2 * (B-k)^(L-1)*B^(L-1) +
              binomial(B-1,k)*(B-k-1)^2/(B-k)*B/2/(B-1) * (B-k)^(L-1)*(B^(L-1)-1)
          ))
        = sum(k = 0, B-1, (-1)^k * (
              binomial(B-1,k-1)*B/2/(B-1) * ( (((B--k)*B)^(N+1) - (B-k)*B) / ((B-k)*B - 1) - ((B-k)^(N+1)-(B-k))/(B-k-1) ) +
              binomial(B-1,k)*(B-k-1)*B/2 * (((B-k)*B)^N - 1) / ((B-k)*B - 1) +
              binomial(B-1,k)*(B-k-1)^2/(B-k)*B/2/(B-1) * ( (((B-k)*B)^N - 1) / ((B-k)*B - 1) - ((B-k)^N-1)/(B-k-1) )
          ))
*/


{
B = 12345678; N = 87654321;
M = 1000000007;

s = 0;
bino1 = Mod(0, M); bino2 = Mod(1, M);
for (k = 0, B - 1,
    if (k % 100000 == 0, print("k = ", k));
    r1 = Mod(B - k, M); r2 = r1 * B;

    s11 = (r2^(N+1) - r2)/(r2 - 1);
    if (r1 == Mod(1, M), s12 = Mod(N, M), s12 = (r1^(N+1) - r1)/(r1 - 1));
    s1 = bino1 * Mod(B/2/(B-1), M) * (s11 - s12);

    s21 = (r2^N - 1)/(r2 - 1);
    s2 = bino2 * Mod((B-k-1)*B/2, M) * s21;

    s31 = (r2^N - 1)/(r2 - 1);
    if (r1 == Mod(1, M), s32 = Mod(N, M), s32 = (r1^N - 1)/(r1 - 1));
    s3 = bino2 * Mod((B-k-1)^2/(B-k)*B/2/(B-1), M) * (s31 - s32);

    s += (-1)^k * (s1 + s2 + s3);

    bino1 = bino2; bino2 *= Mod(B - 1 - k, M) / Mod(k + 1, M);
);
print(lift(s));    \\ 928213457
}
