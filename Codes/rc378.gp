/*
f(x) = 2*x+4
f^n(x) = 2^n*x + (2^n-1)*4 = 2^n*(x+4) - 4
*/
fn(x, n) = Mod(2, M)^lift(n) * Mod(x + 4, M) - 4;


{
M = 10^20;
s1 = fn(5, 5);
s2 = fn(s1 + 2, s1 + 2);
s3 = fn(s2 + 2, s2 + 2);
s = lift(s3);
printf("%020d\n", s);
}
