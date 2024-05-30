{
N = 9;
P = primes(N);
nmin = prod(i = 1, N, P[i]^2);
for (i = 0, N!-1,
    perm = numtoperm(N, i);
    v = vector(N, i, Mod(-perm[i], P[i]^2));
    n = lift(chinese(v));
    if (n < nmin, nmin = n; print("nmin = ", nmin));
);
print(nmin);
}
