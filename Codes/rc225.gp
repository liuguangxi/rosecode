fusetostr(x) = {
    my(s, p, q);
    p = numerator(x);
    q = logint(denominator(x), 2);
    s = Strprintf("%d.%d", p, q);
}


{
R = 111/64;
Qmax = denominator(R)*2;

s = [0];
t = 0;
while (1,
    lens = #s; s2 = List();
    for (i = 1, lens,
        a = s[i];
        for (j = i, lens,
            b = s[j];
            if (b - a >= 1, break);
            c = (a + b + 1) / 2;
            if (c < R && denominator(c) <= Qmax, listput(s2, c));
        );
    );
    s2 = vecsort(setunion(Set(s), Set(s2)));
    if (#s2 == #s, break, s = s2);
);

vsol = List();
for (i = 1, lens,
    a = s[i];
    if (a > R - 1/2, break);
    b = 2*R - 1 - a;
    if (b - a >= 1, next);
    for (k = 1, lens,
        if (s[k] == b,
            listput(vsol, Strprintf("%s~%s", fusetostr(a), fusetostr(b)));
            break;
        );
    );
);
print1(vsol[1]);
for (i = 2, #vsol, print1(",", vsol[i]));
}
