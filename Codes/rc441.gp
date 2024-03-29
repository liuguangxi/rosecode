/*
Let F(n, k) = sum(i = 1, n, i^k), which is a polynomial of degree k+1
Let f(n) = F(n, k), with f(0) = 0, f(1),...,f(k),f(k+1) precomputed
According to Lagrange interpolation formula,
F(n, k) = sum(i = 0, k+1, prod(0<=j<=k+1 && j!=i, n-j)/prod(0<=j<=k+1&&j!=i, i-j) * f(i))
        = sum(i = 1, k+1, prod(j = 0, k+1, n-j)/(n-i) * (-1)^(k+1-i)/i!/(k+1-i)! * f(i))
Let a(i) = i! * (k+1-i)! then
a(0) = (k+1)!, for i >= 1, a(i) = a(i-1) * i/(k+2-i)
*/


/* F(n, k, p) = sum(i = 1, n, i^k) mod p, p must be prime */
F(n, k, p = 1000000007) = {
    my(vf, c, s, sgn, a, c1);
    if (n <= 1000, return(sum(i = 1, n, Mod(i, p)^k)));
    vf = vector(k + 1); vf[1] = Mod(1, p);
    for (i = 2, k + 1, vf[i] = vf[i - 1] + Mod(i, p)^k);
    if (n <= k + 1, return(vf[n]));
    c = prod(j = 0, k + 1, Mod(n - j, p));
    sgn = (-1)^k;
    a = prod(j = 1, k + 1, Mod(j, p));
    s = 0;
    for (i = 1, k + 1,
        a *= Mod(i, p) / Mod(k + 2 - i, p);
        if (Mod(n - i, p) == 0,
            c1 = prod(j = 0, i - 1, Mod(n - j, p)) * prod(j = i + 1, k + 1, Mod(n - j, p));
            s += c1 * vf[i] * sgn / a,
            s += c * vf[i] / Mod(n - i, p) * sgn / a;
        );
        sgn = -sgn;
    );
    return(s);
}


Fref(n, k, p = 1000000007) = {
    if (k == 0, return(Mod(n, p)));
    if (k == 1, return(Mod(n*(n+1)/2, p)));
    if (k == 2, return(Mod(n*(n+1)*(2*n+1)/6, p)));
    if (k == 3, return(Mod((n^2*(1 + n)^2)/4, p)));
    if (k == 4, return(Mod((n*(1 + n)*(1 + 2*n)*(-1 + 3*n*(1 + n)))/30, p)));
    if (k == 5, return(Mod((n^2*(1 + n)^2*(-1 + 2*n*(1 + n)))/12, p)));
    if (k == 6, return(Mod((n*(1 + n)*(1 + 2*n)*(1 + 3*n*(1 + n)*(-1 + n + n^2)))/42, p)));
    if (k == 7, return(Mod((2*n^2 - 7*n^4 + 14*n^6 + 12*n^7 + 3*n^8)/24, p)));
    if (k == 8, return(Mod((n*(-3 + n^2*(20 + n^2*(-42 + 5*n^2*(12 + n*(9 + 2*n))))))/90, p)));
    if (k == 9, return(Mod((n^2*(-3 + n^2*(10 + n^2*(-14 + n^2*(15 + 2*n*(5 + n))))))/20, p)));
    if (k == 10, return(Mod((n*(5 - 33*n^2 + 66*n^4 - 66*n^6 + 55*n^8 + 33*n^9 + 6*n^10))/66, p)));
    if (k == 11, return(Mod((n^2*(10 + n^2*(-33 + n^2*(44 + n^2*(-33 + 2*n^2*(11 + n*(6 + n)))))))/24, p)));
    if (k == 12, return(Mod((n*(1 + n)*(1 + 2*n)*(-691 + 2073*n - 287*n^2 - 3285*n^3 + 1420*n^4 + 2310*n^5 - 1190*n^6 - 1050*n^7 + 525*n^8 + 525*n^9 + 105*n^10))/2730, p)));
    if (k == 13, return(Mod((n^2*(1 + n)^2*(-691 + 1382*n + 202*n^2 - 1786*n^3 + 367*n^4 + 1052*n^5 - 326*n^6 - 400*n^7 + 125*n^8 + 150*n^9 + 30*n^10))/420, p)));
    if (k == 14, return(Mod((n*(1 + n)*(1 + 2*n)*(105 - 315*n + 44*n^2 + 498*n^3 - 217*n^4 - 345*n^5 + 182*n^6 + 144*n^7 - 81*n^8 - 45*n^9 + 24*n^10 + 18*n^11 + 3*n^12))/90, p)));
    if (k == 15, return(Mod((n^2*(1 + n)^2*(420 - 840*n - 122*n^2 + 1084*n^3 - 226*n^4 - 632*n^5 + 203*n^6 + 226*n^7 - 83*n^8 - 60*n^9 + 21*n^10 + 18*n^11 + 3*n^12))/48, p)));
    if (k == 16, return(Mod((n*(1 + n)*(1 + 2*n)*(-3617 + 10851*n - 1519*n^2 - 17145*n^3 + 7485*n^4 + 11835*n^5 - 6275*n^6 - 4845*n^7 + 2775*n^8 + 1365*n^9 - 805*n^10 - 315*n^11 + 175*n^12 + 105*n^13 + 15*n^14))/510, p)));
    return(sum(i = 1, n, Mod(i, p)^k));
}


S(n, p) = {
    my(s, e);
    s = Mod(1, p);
    e = logint(n, 2);
    for (k = 2, e, s -= moebius(k) * (F(sqrtnint(n, k), k) - 1));
    for (k = 1, e \ 2, s -= moebius(k) * (F(sqrtnint(n, 2*k), 2*k) - 1));
    return(lift(s));
}


Sref1(n, p) = {
    my(s, e);
    s = Mod(1, p);
    e = logint(n, 2);
    for (k = 2, e, s -= moebius(k) * (Fref(sqrtnint(n, k), k) - 1));
    for (k = 1, e \ 2, s -= moebius(k) * (Fref(sqrtnint(n, 2*k), 2*k) - 1));
    return(lift(s));
}


Sref2(n, p = 1000000007) = {
    my(s = 1);
    for (x = 2, n, if(ispower(x) > 2, s += x));
    return(s % p);
}


{
n = 10^100;
m = 1000000007;

sn = S(n, m);
printf("S(n) = %d\n", sn);

sref1n = Sref1(n, m);
printf("Sref1(n) = %d\n", sref1n);

/*sref2n = Sref2(n, m);
printf("Sref2(n) = %d\n", sref2n);
if (sn == sref2n, print("OK"), print("ERROR"));*/
}
