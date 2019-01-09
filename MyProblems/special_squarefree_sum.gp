/*
S(n) = sum({x | 1 <= x <= n, x is squarefree and also sum of two positive squares})
*/


Sref(n) = {
    my(check(n) = 
        for (x = 1, sqrtint(n \ 2), if (issquare(n - x^2), return(1)));
        return(0);
    );
    my(s = 0);
    for (x = 1, n, if (issquarefree(x) && check(x), s += x));
    return(s);
}


init_primes(n) = {
    my(v = List(2));
    forprime (p = 3, n, if (p % 4 == 1, listput(v, p)));
    listput(v, n + 1);    \\ dummy number
    return(Vec(v));
}


init_primesum(n) = {
    my(sum1(n) = 2*n^2 + 3*n);
    my(sum3(n) = 2*n^2 + 5*n + 3);
    my(nsqrt, vs1_s, vs1_l, vs3_s, vs3_l, q, imax, d);
    
    nsqrt = sqrtint(n);
    vs1_s = vector(nsqrt, i, sum1((i-1)\4));      \\ primesum1(i)
    vs1_l = vector(nsqrt, i, sum1((n\i-1)\4));    \\ primesum1(n\i)
    vs3_s = vector(nsqrt, i, sum3((i-3)\4));      \\ primesum3(i)
    vs3_l = vector(nsqrt, i, sum3((n\i-3)\4));    \\ primesum3(n\i)
    
    forprime (p = 3, nsqrt,
        q = p^2; imax = min(nsqrt, n\q);
        for (i = 1, imax,
            d = i * p;
            if (p % 4 == 1,
                if (d <= nsqrt,
                    vs1_l[i] -= p * (vs1_l[d] - vs1_s[p-1]); vs3_l[i] -= p * (vs3_l[d] - vs3_s[p-1]),
                    vs1_l[i] -= p * (vs1_s[n\d] - vs1_s[p-1]); vs3_l[i] -= p * (vs3_s[n\d] - vs3_s[p-1]);
                ),
                if (d <= nsqrt,
                    vs1_l[i] -= p * (vs3_l[d] - vs3_s[p-1]); vs3_l[i] -= p * (vs1_l[d] - vs1_s[p-1]),
                    vs1_l[i] -= p * (vs3_s[n\d] - vs3_s[p-1]); vs3_l[i] -= p * (vs1_s[n\d] - vs1_s[p-1]);
                );
            );
        );
        forstep (i = nsqrt, q, -1,
            if (p % 4 == 1,
                vs1_s[i] -= p * (vs1_s[i\p] - vs1_s[p-1]); vs3_s[i] -= p * (vs3_s[i\p] - vs3_s[p-1]),
                vs1_s[i] -= p * (vs3_s[i\p] - vs3_s[p-1]); vs3_s[i] -= p * (vs1_s[i\p] - vs1_s[p-1]);
            );
        );
    );
    
    return([vs1_s, vs1_l]);
}


S(n, ipmin = 1) = {
    my(s, p);
    if (n <= Nsqrt, s = Vs1_s[n], s = Vs1_l[N\n]);
    if (ipmin == 1, s += 2, s -= Vs1_s[Vp[ipmin-1]]);
    for (i = ipmin, Lvp,
        p = Vp[i];
        if (p^2 > n, break);
        s += p * S(n\p, i+1);
    );
    return(s);
}


default(parisize, 2*10^8);

{
N = 10^12;

Nsqrt = sqrtint(N);
Vp = init_primes(Nsqrt);
Lvp = #Vp - 1;    \\ valid length
[Vs1_s, Vs1_l] = init_primesum(N);

sn = S(N);
printf("S(%d) = %d\n", N, sn);    \\ S(1000000000000) = 43762566450798536018224

/*srefn = Sref(N);
printf("Sref(%d) = %d\n", N, srefn);
if (sn == srefn, print("OK"), print("ERROR"));*/
}
