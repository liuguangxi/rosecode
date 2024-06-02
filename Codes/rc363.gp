{
N = 75; T = 10^30;
s1 = 2^71 * 3^35 * 5^18 * 7^11 * 11^6;
s2 = N!/s1;
d1 = divisors(s1); d2 = divisors(s2);
len1 = #d1; len2 = #d2;
best = 0;
k2 = len2;
for (k1 = 1, len1,
    while (k2 > 0,
        s = d1[k1] * d2[k2];
        if (s >= T, k2--, break);
    );
    if (k2 <= 0, break);
    if (s > best, best = s; print("s = ", s));
);
print(best);
}
