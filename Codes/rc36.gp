/* https://oeis.org/A000088 */


permcount(v) = {
    my(m = 1, s = 0, k = 0, t);
    for(i = 1, #v,
        t = v[i];
        k = if (i > 1 && t == v[i-1], k+1, 1);
        m *= t * k; s += t;
    );
    return(s!/m);
}


edges(v) = {
    sum(i = 2, #v, sum(j = 1, i-1, gcd(v[i], v[j]))) + sum(i = 1, #v, v[i]\2)
}


a(n) = {
    my(s = 0);
    forpart (p = n, s += permcount(p) * 2^edges(p));
    return(s/n!);
}


{
N = 28;
s = a(N);
print(s);
}
