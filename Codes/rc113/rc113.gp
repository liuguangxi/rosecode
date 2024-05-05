/*
(1 + x + x^2)^n
= sum(0 <= i + j <= n, binomial(n, i) * binomial(n - i, j) * x^(2*i+j))
= sum(k = 0, 2*n, sum(max(k-n,0) <= i <= k/2 && j = k-2*i, binomial(n, i) * binomial(n - i, j)) * x^k)
*/


Sref(n) = vecsum(Vec((1 + x + x^2)^n) % 2);


{
N = 7;

nmsk = bitxor(2^(logint(N, 2) + 1) - 1, N);
v = List();
for (i = 0, N, if (bitand(nmsk, i) == 0, listput(v, i)));
v = Vec(v); lv = #v;

s = 0;
for (k = 0, 2 * N,
    if (k % 10000 == 0, print("k = ", k));
    sk = 0;
    imin = max(k - N, 0); imax = k \ 2;
    for (idx = 1, lv,
        vi = v[idx];
        if (vi < imin || vi > imax, next);
        msk = bitxor(2^30-1, N - vi);
        if (bitand(msk, k - 2*vi) == 0, sk++);
    );
    if (sk % 2 == 1, s++);
);
print(s);
}
