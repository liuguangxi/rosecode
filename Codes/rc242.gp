{
K = 10; M = 10^9;

A = Mod(matrix(K, K, x, y, (x==1)*1+(x>1)*(x-y==1)), M);
F0 = Mod(vector(K, x, 1)~, M);

p = 0;
while (1,
    p += M;
    F = A^p * F0;
    if (F == F0, break);
);
print("Period = ", p);

fordiv (p, d,
    F = A^d * F0;
    if (F == F0, period = d; break);
);
printf("P(%d, %d0) = %d\n", K, M, period);    \\ -257,7881197,224,4870846
}
