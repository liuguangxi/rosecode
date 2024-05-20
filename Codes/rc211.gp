/*
https://oeis.org/A002487
a(0) = 0, a(1) = 1
for n > 0: a(2*n) = a(n), a(2*n+1) = a(n) + a(n+1)
=>
F(0)^k = a(k)/a(k + 1)
*/


a(n) = {
    my(z, ret);
    if (n <= 1, return(n));
    if (mapisdefined(Ma, n, &z), return(z));
    if (n % 2 == 0, ret = a(n \ 2), ret = a(n \ 2) + a(n \ 2 + 1));
    mapput(Ma, n, ret);
    return(ret);
}


idx(f) = {
    my(num, den);
    if (f == 1, return(1));
    if (f == 1/2, return(2));
    num = numerator(f); den = denominator(f);
    if (num < den,
        /* k is even, f = a(k/2) / (a(k/2) + a(k/2+1)) */
        return(2 * idx(num/(den-num)));
        ,
        /* k is odd, f = (a(k\2) + a(k\2+1)) / a(k\2+1) */
        return(2 * idx((num - den) / den) + 1);
    );
}


{
K = 1413121110987654321;
Ma = Map();
ND = a(K)/a(K+1);

F = 1415926535/5772156649;
Index = idx(F);

print(ND, ",", Index);
}
