/*
https://oeis.org/A016064
=>
a(1) = 3, a(2) = 13
a(n) = 4*a(n-1) - a(n-2) + 2, n >= 3
*/


{
N = 100;
a = vector(N);
a[1] = 3; a[2] = 13;
for (n = 3, N, a[n] = 4*a[n-1] - a[n-2] + 2);
print(a[N]);
}
