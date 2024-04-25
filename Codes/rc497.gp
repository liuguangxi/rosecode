/* A000203: a(n) = sigma(n), the sum of the divisors of n. */


ismgood(m, a, b) = {
    my(v = Euler);
    return(a*ceil(v*b) - b*floor(v*a) == m);
}


{
M = 20;
s = 0;
for (a = 1, 1000, for (b = 1, 1000,
    if (ismgood(M, a, b) && !ismgood(M, a-b, b) && !ismgood(M, a, b-a),
        s++; print([a, b]);
    );
));
print(s);
}


{
M = 123456789101112;
s = sigma(M);
print(s);
}
