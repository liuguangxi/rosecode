Sref(n) = sum(x = 1, n, sumdiv(x, d, moebius(d) * (floor(x*Euler) \ d)));


/*
F(N) = #{k/n: k/n < Euler, 1 <= n <= N} = sum(x = 1, N, floor(x*Euler))
S(N) = #{k/n: k/n < Euler, 1 <= n <= N, gcd(k, n) = 1} =>
F(N) = sum(m = 1, N, S(N \ m))
*/

/* sum(i = 1, n, floor(a*i)), where a is rational number */
T(x, num, den) = {
    my(q, r, ret);
    if (x == 0 || num == 0, return(0));
    if (x >= den,
        q = x \ den; r = x % den;
        ret = (q * (q * num * den - den + num + 1)) \ 2 + r * q * num;
        ret += T(r, num, den),
        if (num >= den,
            q = num \ den; r = num % den;
            ret = ((x * (x + 1) * q) \ 2) + T(x, r, den),
            q = num * x \ den;
            ret = x * q - T(q, den, num);
        );
    );
    return(ret);
}


rat(a, n) = {
    my(bnd, a1);
    bnd = 2 * n;
    while (1,
        a1 = bestappr(a, bnd);
        if (denominator(a1) > n, break, bnd *= 2);
    );
    return(a1);
}


S(n) = {
    my(rat_euler, num_euler, denom_euler);
    my(nsqrt, vs_s, vs_l, s, x, xsqrt, tmax);

    rat_euler = rat(Euler, n);
    num_euler = numerator(rat_euler);
    denom_euler = denominator(rat_euler);
    nsqrt = sqrtint(n);
    vs_s = vector(nsqrt);    \\ S(i)
    vs_l = vector(nsqrt);    \\ S(n\i)

    for (i = 1, nsqrt,
        x = i;
        s = T(x, num_euler, denom_euler);
        xsqrt = sqrtint(x);
        if (xsqrt < 2,
            for (m = 2, x, s -= vs_s[x \ m]),
            for (m = 2, xsqrt, s -= vs_s[x \ m]);
            tmax = x \ (xsqrt + 1);
            for (t = 1, tmax, s -= (x\t - x\(t+1)) * vs_s[t]);
        );
        vs_s[i] = s;
    );
    forstep (i = nsqrt, 1, -1,
        x = n \ i;
        s = T(x, num_euler, denom_euler);
        xsqrt = sqrtint(x);
        if (xsqrt < 2,
            for (m = 2, x, s -= vs_s[x \ m]),
            for (m = 2, xsqrt,
                if (x \ m <= nsqrt, s -= vs_s[x \ m], s -= vs_l[n \ (x \ m)]);
            );
            tmax = x \ (xsqrt + 1);
            for (t = 1, tmax, s -= (x\t - x\(t+1)) * vs_s[t]);
        );
        vs_l[i] = s;
    );

    return(vs_l[1]);
}


{
N = 10^9;

sn = S(N);
printf("S(%d) = %d\n", N, sn);

/*srefn = Sref(N);
printf("Sref(%d) = %d\n", N, srefn);
if (sn == srefn, print("OK"), print("ERROR"));*/
}
