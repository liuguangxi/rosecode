/* https://oeis.org/A045621 */
{
N = 365;
a = 2^N - binomial(N, floor(N/2));
p = a / 2^N;
print(p);
}
