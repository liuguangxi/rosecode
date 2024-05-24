/*
n = 2, 3, 4, ...
C(n) = 2, 4, 6, 10, 12, 18, 22, 28, 32, 42, ...
C(n) = sum(k = 1, n, eulerphi(k))
*/


check(p) = {
    my(lenp = #p);
    for (i1 = 1, lenp - 3, for (i2 = i1 + 2, lenp - 1,
        for (j1 = i1 + 1, i2 - 1, for (j2 = i2 + 1, lenp,
            if (p[i1] + p[i2] == p[j1] + p[j2], return(0));
        ));
    ));
    return(1);
}


calc(n) = {
    my(s = 0);
    for (i = 0, n! - 1,
        p = concat(0, Vec(numtoperm(N, i)));
        if (check(p), s++);
    );
    return(s);
}


{
N = 1000;
\\ C = calc(N);
C = sum(k = 1, N, eulerphi(k));
printf("C(%d) = %d\n", N, C);
}
