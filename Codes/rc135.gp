{
Nmin = 10^19; Nmax = 10^19+10^6;
c = 0; s = 0;
forprime (p = Nmin, Nmax,
    if (p % 4 == 1,
        x = factor(p*I)[1,1];
        u = real(x); v = imag(x);
        a = abs(u^2 - v^2); b = 2*u*v;
        c++; s += min(a, b);
    );
);
printf("%d,%d\n", c, s);
}
