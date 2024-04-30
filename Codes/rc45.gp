/* https://oeis.org/A028859 */


a(n)=([1, 1]*[2, 2; 1, 0]^n)[1];


{
N = 150;
s = a(N);
print(s);
}
