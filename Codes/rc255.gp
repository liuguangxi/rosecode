Rdigits(n) = {
    my(a, b, r, aa, bb, s);
    a = n; b = 0; s = 0;
    while (!(a == 0 && b == 0),
        r = (a + b) % 2;
        aa = (-a + b + r) / 2; bb = (-a - b + r) / 2;
        a = aa; b = bb;
        s++;
    );
    return(s);
}


R(n) = {
    my(a, b, r, v, aa, bb);
    a = n; b = 0; v = List();
    while (!(a == 0 && b == 0),
        r = (a + b) % 2;
        aa = (-a + b + r) / 2; bb = (-a - b + r) / 2;
        a = aa; b = bb;
        listput(v, r);
    );
    return(fromdigits(Vecrev(v), 2));
}


{
\\ Question 1
an = 1; d = 1; n = 1;
while (Rdigits(an) < 60,
    an += d; n++;
    if (n % 2 == 0, d *= 2, d *= 8);
);
Ran = R(an);

\\ Question 2
bn = 1;
for (n = 2, 93,
    if (n % 6 == 1, bn += 16^((n-1)/6-1), bn += 16^(floor((n-1)/6)));
    Rbn = R(bn);
);

\\ Answers
printf("%d,%d,%d,%d\n", an, Ran, bn, Rbn);
}
