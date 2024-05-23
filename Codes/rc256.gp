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
N = 10^5;
s = 0;
seed = 641;
for (i = 1, N,
    seed = (214013 * seed + 2531011) % 43097251273073;
    s += R(seed);
);
print(s);
}
