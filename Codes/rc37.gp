/* https://oeis.org/A000337 */


a(n) = (n-1)*2^n + 1;


{
N = 150;
s = a(N);
print(s);
}
