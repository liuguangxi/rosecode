/*
T(n, k) = prod(a1 = 1,k, a2 = 1,k, ..., an = 1,k, prod(phi(i = 1,n, ai)))

fp(x) = (fp0(x))^n
      = sum(i = 0, d, ci*x^i) =>
s = prod(i = 0, d, (phi(p^i))^ci)
  = ((p-1)/p) ^ (fp(1)-fp(0)) * p ^ (fp'(1))
*/


Sp(n, p) = {
    my(s = 0);
    n \= p;
    while (n > 0, s += n; n \= p);
    return(s);
}


{
N = 10^7; K = 10^7; M = 10^9+7;
fp1 = Mod(K, M-1)^N;
fpp1_c = Mod(N, M-1) * Mod(K, M-1)^(N-1);
s = Mod(1, M);
forprime (p = 2, K,
    fp0 = Mod(K-K\p, M-1)^N;
    fpp1 = fpp1_c * Mod(Sp(K, p), M-1);
    s *= (1-1/Mod(p,M))^lift(fp1-fp0) * Mod(p, M)^lift(fpp1);
);
printf("T(%d, %d) = %d mod %d\n", N, K, lift(s), M);
}
