/*
Phi(n) = sum(i = 1, n, eulerphi(i))
s(n) = sum(i = 1, n, sum(j = 1, n+1-i, gcd(i,j)==1))
     = sum(i = 1, n, sum(j = 1, n+1, gcd(i,j)==1)) - sum(i = 1, n, sum(j = 1, i, gcd(i,j)==1))
     = sum(i = 1, n, sum(j = 1, i, gcd(i,j)==1)) + sum(j = 2, n+1, sum(i = 1, j-1, gcd(i,j)==1)) - Phi(n)
     = Phi(n) + (Phi(n+1) - 1) - Phi(n)
     = Phi(n+1) - 1
*/


/*
Phi(n) = n*(n+1)/2 - sum(i = 2, n, Phi(n\i))
       = n*(n+1)/2 - sum(i = 2, sqrtint(n), Phi(n\i)) - sum(i = 1, n\(sqrtint(n)+1), (n\i-n\(i+1))*Phi(i))
*/
getP(n) = {
    my(s, t);
    if (mapisdefined(Phi, n, &t), return(t));
    s = n*(n+1)/2;
    for (i = 2, sqrtint(n),
        if (mapisdefined(Phi, n\i, &t), s -= t, s -= getP(n\i));
    );
    for (i = 1, n\(sqrtint(n)+1),
        if (mapisdefined(Phi, i, &t), s -= (n\i-n\(i+1))*t, s -= (n\i-n\(i+1))*getP(i));
    );
    mapput(Phi, n, s);
    return(s);
}


genP(n) = {
    my(L0);
    L0 = sqrtint(n);
    vecP = vector(L0, i, eulerphi(i));
    for (i = 2, L0, vecP[i] += vecP[i - 1]);
    for (x = 1, L0, mapput(Phi, x, vecP[x]));
}


{
N = 10^9;
Phi = Map();    \\ Phi(n\x), x = 1, 2, ..., sqrtint(n)
genP(N + 1);
s = getP(N + 1) - 1;
print(s);
}
