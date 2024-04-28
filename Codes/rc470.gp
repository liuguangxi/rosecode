/*
Number of permuatations in Sn with a given cycle structure is
n! / prod(d = 1, n, (c_d)!*d^c_d)
where c_d denotes number of cycles of length d
*/


{
n = 1000;
p = 641;    \\ p is prime and p > n/2
vd = [1, p]; vcd = [n - p, 1];
u = n! / prod(i = 1, #vd, vcd[i]!*vd[i]^vcd[i]);

s = u; while (s % 10 == 0, s /= 10);
ans = s % 10^10;
print(ans);
}
