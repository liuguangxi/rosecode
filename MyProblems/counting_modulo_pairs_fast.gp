Sref(n) = sum(x = 1, n, x / factorback(factor(x)[,1]));


S(n, coef = 1, ipmin = 1) = {
    my(s, p, q, nnew, coefnew);
    s = coef * n;
    for (i = ipmin, Lvp,
        p = Vp[i]; q = p*p;
        nnew = n \ q;
        if (nnew == 0, break);
        coefnew = coef * (p - 1);
        while (nnew > 0,
            s += S(nnew, coefnew, i + 1);
            nnew \= p;
            coefnew *= p;
        );
    );
    return(s);
}


default(parisize, 10^8);

{
N = 10^14;
Nsqrt = sqrtint(N);
Vp = primes(primepi(Nsqrt));
Lvp = #Vp;
sn = S(N);
printf("S(%d) = %d\n", N, sn);

/*srefn = Sref(N);
printf("Sref(%d) = %d\n", N, srefn);
if (sn == srefn, print("OK"), print("ERROR"));*/
}
