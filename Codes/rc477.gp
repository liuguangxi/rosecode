/* https://oeis.org/A180056 */


{
N = 100;
M = 10^10;
n = N \ 2 + 1;
s = sum(j = 0, n, (-1)^j*(n-j)^(2*n-1)*binomial(2*n, j)) / (2*n);
ans = s % M;
print(ans);
}
