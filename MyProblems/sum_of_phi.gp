/*
S(n) = sum(i = 1, n, sum(j = 1, n, phi(i*j)))
     = sum(k = 1, n, mu(k) * sum(d = 1, n\k, d/phi(d) * (sum(i = 1, n\(k*d), phi(k*d*i)))^2))

Let f(n,m) = sum(i = 1, n\m, phi(m*i)), then phi(d) | f(n,k*d) =>
S(n) = sum(k = 1, n, mu(k) * sum(d = 1, n\k, f(n,k*d) / phi(d) * f(n,k*d) * d))
*/


Sref(n) = sum(i = 1, n, sum(j = 1, n, eulerphi(i*j)));

S(n) = sum(k = 1, n, moebius(k) * sum(d = 1, n\k, d/eulerphi(d) * (sum(i = 1, n\(k*d), eulerphi(k*d*i)))^2))


{
N = 1000;

sn = S(N);
printf("S(n) = %d\n", sn);

srefn = Sref(N);
printf("Sref(n) = %d\n", srefn);
if (sn == srefn, print("OK"), print("ERROR"));
}
