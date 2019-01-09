/*
Define f(l,p) is number of permutations of length l
such that its period divides p

f(x) = prod(k|p, sum(i = 0, inf, 1/i!/k^i * x^(k*i)))
     = exp(sum(k|p, x^k/k))
     = sum(i = 0, inf, c_i * x^i/i!)
=> c_i = f(i,p)
*/


Sf(p) = {
    my(f, vcoef, s);
    f = exp(Mod(sumdiv(p, k, x^k/k), M) + O(x^(L+1)));
    vcoef = Vec(f);
    s = sum(i = 1, L, vcoef[i+1] * Facmod[i]);
    printf("Sf(%d) = %d\n", p, lift(s));
    return(s);
}


{
M = 1000000007;
L = 10000;
P = 1000;

Facmod = vector(L);
Facmod[1] = Mod(1, M);
for (i = 2, L, Facmod[i] = Facmod[i-1] * i);

s = sum(p = 1, P, Sf(p));
printf("S(%d, %d) = %d\n", L, P, lift(s));
}
