/*
Calculate a \uparrow\uparrow b modulo m, where a, b, m, are positive integers
*/
g(a, b, m) = {
    my(phim);
    if (m == 1, return(0));
    if (a == 1, return(1));
    if (b == 1, return(a));
    if (b == 2, return(lift(Mod(a, m)^a)));
    phim = eulerphi(m);
    return(lift(Mod(a, m) ^ (phim + g(a, b - 1, phim))));
}


{
K = 10^6;
s = 0; p = K;
for (i = 1, K,
    if (i % 10000 == 0, print("i = ", i));
    p = nextprime(p + 1);
    t = g(i, i, p);
    s += t;
);
print(s);
}
