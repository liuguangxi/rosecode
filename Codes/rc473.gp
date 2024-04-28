{
P = 20000;
default(realprecision, P);

\\x = frac(exp(1));
x = 0; k = 0; lenx = 0;
while (lenx <= P,
    k++; lenk = #digits(k);
    lenx += lenk;
    if (lenx <= P, x = x * 10^lenk + k);
);
x = 1.0 * x / 10^(lenx - lenk);

N = 100;
for (i = 1, N,
    a = floor(1/x); x = 1 - a*x;
    \\print(i, "  ", a);
);

ans = a;
ve = digits(ans); lene = #ve;
if (lene > 20,
    first10 = Strchr(ve[1..10] + vector(10, i, 48));
    last10 = Strchr(ve[lene-9..lene] + vector(10, i, 48));
    lenrest = lene - 20;
    printf("%s[%d]%s\n", first10, lenrest, last10);
);
}
