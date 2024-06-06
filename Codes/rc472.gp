{
N = 10^9; M = 10^10;
q1 = q2 = 1; k = 1; idx = 1; i = 0;
while (1,
    i++;
    ii = 2*i; if (ii % 3 != 2, a = 1, a = (ii + 1) / 3 * 2);
    q = (a * q2 + q1) % M;
    [q1, q2] = [q2, q];
    if (i % 3 != 2, c = 1, c = (i + 1) / 3 * 4);
    if (k + c <= N,
        idx = (idx + c * q) % M; k += c,
        idx = (idx + (N - k) * q) % M; k = N;
    );
    if (k == N, ans = idx; break);
    ii++; if (ii % 3 != 2, a = 1, a = (ii + 1) / 3 * 2);
    q = (a * q2 + q1) % M;
    [q1, q2] = [q2, q];
);
print(ans);
}
