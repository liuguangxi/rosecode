default(parisize, 10^9);

{
K = 100;
N = 2000;
T = floor(N^1.05);

o = O(x^(T+1));
f0 = sum(i = 1, K, 1.0/K*x^i);
fk = 1 + o; f = 0;
for (i = 1, T,
    fk = fk * f0 + o;
    f += fk;
);
Vp0 = Vec(f);
Vp = vector(N^2, i, if (i <= T, Vp0[i], 2.0/(K+1)));

Vq = vector(N); Vq[1] = Vp[1];
E = 0;
for (k = 2, N,
    Vq[k] = Vp[k^2] - sum(i = 1, k-1, Vq[i] * Vp[k^2-i^2]);
    E += Vq[k] * (k-1);
    printf("(%d) E = %.14f\n", k, E);
);
printf("E(%d) = %.10f\n", K, E);
}
