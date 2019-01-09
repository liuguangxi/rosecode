/*
s = r where r is the smaller root of equation r + 1/r = b(0) = c =>
r = (c - sqrt(c^2-4))/2 =>
continued fraction coefficients = [0, c-1, {1, c-2}]
convergents p(n)/q(n) = 0/1, 1/(c-1), 1/c, (c-1)/(c*(c-1)-1)
p(n) = c*p(n-2) - p(n-4), q(n) = c*q(n-2) - q(n-4)
*/


P_Q(c, n) = {
    my(m, mn, pini, qini, p, q);
    m = Mod([0, c, 0, -1; 1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0], P);
    pini = Mod([c-1, 1, 1, 0]~, P);
    qini = Mod([c*(c-1)-1, c, c-1, 1]~, P);
    mn = m^(n-3);
    p = mn * pini; q = mn * qini;
    return([p[1], q[1]]);
}


SP_SQ(m, n) = {
    my(spq, fk, fk1, fk2);
    spq = [0, 0]; fk = Mod(1, P); fk1 = Mod(2, P);
    for (i = 4, m,
        fk2 = fk1 + fk;
        spq += P_Q(fk2, n);
        fk = fk1; fk1 = fk2;
    );
    return(lift(spq));
}


{
P = 1000000007;
M = 10^5;
N = 10^18;
s = SP_SQ(M, N);
printf("%d,%d\n", s[1], s[2]);
}
