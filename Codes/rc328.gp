valid(v) = {
    my(s, lenv, b, mask);
    s = vecsum(v)\2; lenv = #v; b = 2^lenv;
    for (x = b+1, 2*(b-1),
        mask = digits(x, 2)[2..-1]~;
        if (v * mask == s, return(1));
    );
    return(0);
}


check(v) = {
    for (i = 1, #v, if (!valid(setminus(v, [v[i]])), return(0)));
    return(1);
}


{
P = vector(15, i, prime(i+1));
lenp = #P;

for (i1 = 1, lenp, for (i2 = i1 + 1, lenp, for (i3 = i2 + 1, lenp, for (i4 = i3 + 1, lenp, for (i5 = i4 + 1, lenp,
    a = [P[i1], P[i2], P[i3], P[i4], P[i5]];
    if (check(a), print(a));
    for (i6 = i5 + 1, lenp, for (i7 = i6 + 1, lenp,
        a = [P[i1], P[i2], P[i3], P[i4], P[i5], P[i6], P[i7]];
        if (check(a), print(a));
    ));
)))));
/* 3,5,7,13,19,37,41 */
}
