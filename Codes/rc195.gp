{
N = 17;
vc = vector(N); vs = vector(N);
vc[1] = 4; vc[2] = 6;
vs[1] = 16; vs[2] = 341;
for (n = 3, N,
    vc[n] = 6*(sum(i = 1, (n-1)\2, vc[n-2*i]) + 1);
    vs[n] = vc[n]/6 * 31*(1+10^(n-1)) + 6*sum(i = 1, (n-1)\2, vs[n-2*i]*10^i);
);
Count = vecsum(vc); Sum = vecsum(vs);
printf("%d,%d\n", Count, Sum);
}
