/*
pol(n) = k*pol(n - 1) - pol(n - 2), n >= 2
pol(0) = 1, pol(1) = k
*/


{
N = 100;

k = 'k;
vpol = vector(N);
vpol[1] = k; vpol[2] = k^2 - 1;
for (n = 3, N, vpol[n] = k*vpol[n - 1] - vpol[n - 2]);

v1 = Vec(vpol[N - 1]);
sum1 = sum(i = 1, #v1, v1[i]^3);
v2 = Vec(vpol[N]);
sum2 = sum(i = 1, #v2, v2[i]^3);
s = sum1 + sum2;
print(s);
}
