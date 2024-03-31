default(parisize, 3*10^8);


{
N = 1000000;

a1 = log(66666)/log(2);
a2 = log(66667)/log(2);
m = log(10)/log(2);
d = a2 - a1;

qmin = floor(N/d*1.001); B = qmin;
while (1,
    rat = bestappr(m, B);
    p = numerator(rat);
    q = denominator(rat);
    if (q > qmin, break, B = floor(B*1.1));
);
pa2 = round(frac(a2)*q);
pd = round(d*q);

ve = List();
for (x = -2, pd+2,
    k = lift(Mod(x-pa2, q) / Mod(p, q));
    if (ceil(a1+k*m) == floor(a2+k*m),
        listput(ve, floor(a2+k*m));
    );
);
ve = vecsort(Vec(ve));
printf("e(%d) = %d\n", N, ve[N]);
}
