chk(p) = {
    my(c);
    c = Mod(2, p);
    for (n = 2, p,
        c = c * (c + n + 140);
        if (n == p, break, c /= Mod(n, p));
    );
    return(c != 0);
}


{
default(realprecision, 1000);

forprime (p = 3,,
    if (chk(p), idx = p; break);
);

n0 = 10; c = 2;
for (n = 2, 10, c = c * (c + n + 140) / n);
clg = log(c)/log(10);
for (n = n0 + 1, idx,
    clg = 2*clg - log(n)/log(10);
);
ndig = floor(clg) + 1;

printf("%d,%d\n", idx, ndig);
}
