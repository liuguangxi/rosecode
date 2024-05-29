/*
a(n+1) = 1*a(n) - 1*b(n) +  2*c(n) -  3*d(n) + 5*e(n) -  8
b(n+1) = 1*b(n) - 2*c(n) +  3*d(n) -  5*e(n) + 8*a(n) - 13
c(n+1) = 2*c(n) - 3*d(n) +  5*e(n) -  8*a(n) +13*b(n) - 21
d(n+1) = 3*d(n) - 5*e(n) +  8*a(n) - 13*b(n) +21*c(n) - 34
e(n+1) = 5*e(n) - 8*a(n) + 13*b(n) - 21*c(n) +34*d(n) - 55
a(0) = b(0) = c(0) = d(0) = e(0) = 1
*/

{
A = [1, -1, 2, -3, 5; 8, 1, -2, 3, -5; -8, 13, 2, -3, 5; 8, -13, 21, 3, -5; -8, 13, -21, 34, 5];
C = -[8; 13; 21; 34; 55];
x0 = [1; 1; 1; 1; 1];
M = 10000019;

Am = Mod(A, M);
Cm = Mod(C, M);
x0m = Mod(x0, M);
Im = Mod(matid(5), M);

N = 3^4^5;
xn = Am^N * x0m + (Am^N - Im) / (Am - Im) * Cm;
an = lift(xn[1,1]);
bn = lift(xn[2,1]);
cn = lift(xn[3,1]);
dn = lift(xn[4,1]);
en = lift(xn[5,1]);
printf("%d,%d,%d,%d,%d\n", an, bn, cn, dn, en);
}
