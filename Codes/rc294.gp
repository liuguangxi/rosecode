{
a = 203; b = 265; c = 372;
tot = 0;
Rmin = 10^10; pmin = 0; qmin = 0; rmin = 0;
for (p = 1, a - 1, for (q = 1, b - 1, for (r = 1, c - 1,
    R1 = (a*b - a*q + p*q) * (a*c - c*p + p*r) * (b*c - b*r + q*r);
    R2 = (a*b*c - a*b*r - a*c*q - b*c*p + a*q*r + b*p*r + c*p*q - 2*p*q*r)^2;
    if (R2 > 0 && R1 % R2 == 0,
        tot++;
        ratio = R1/R2;
        if (ratio < Rmin, Rmin = ratio; pmin = p; qmin = q; rmin = r);
        printf("Ratio = %d    (p = %d, q = %d, r = %d)\n", ratio, p, q, r);
    );
)));
printf("%d/%d,%d,%d\n", tot, pmin, qmin, rmin);
}
