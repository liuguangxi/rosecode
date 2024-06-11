/* k = m - r - 1 = n - s - 1 */


{
[m, n, r, s] = [777, 555, 333, 111];
k = m - r - 1;
ans = 2 * binomial(m - 1, k) * binomial(n - 1, k);
while (ans % 10 == 0, ans /= 10);
printf("%010d\n", ans % 10^10;);
}
