/*
a1^2 + b1^2 = c1^2, a2^2 + b2^2 = c2^2
0 < a1 < b1 < c1, 0 < a2 < b2 < c2
d1 = b1 - a2 > 0, d2 = b2 - a1 > 0
a1, c1, a2, c2, d1, d2 are twin primes
A = a1*b1 + a2*b2 + d1*d2 = a1*a2 + b1*b2

for valid (a, b, c) => parallelogram area A > a*b => a*b < Amax
a = v^2 - u^2, b = 2*u*v, c = u^2+v^2, a < b
where (u + v) mod 2 = 1, 0 < u < v
=> a*b = 2*u*v*(v-u)*(u+v) > 4*u^3 => 4*u^3 < Amax
a = (v+u)*(v-u) is prime => v = u + 1
*/


istwinprime(n) = {
    if (!isprime(n), return(0));
    if (isprime(n - 2) || isprime(n + 2), return(1), return(0));
}


{
Amax = 10^19;
vabc = List();
for (u = 1, floor((Amax/4)^(1/3)),
    a = 2*u+1; b = 2*u*(u+1); c = b+1;
    if (istwinprime(a) && istwinprime(c),
        listput(vabc, [a, b, c]);
    );
);
vabc = Vec(vabc);

count = 0; sumofareas = 0;
for (i = 1, #vabc, for (j = i, #vabc,
    [a1, b1, c1] = vabc[i]; [a2, b2, c2] = vabc[j];
    d1 = b1 - a2; d2 = b2 - a1;
    if (istwinprime(d1) && istwinprime(d2),
        area = a1*a2 + b1*b2;
        if (area < Amax,
            printf("(%d, %d, %d)  (%d, %d, %d) => Area = %d\n", a1, b1, c1, a2, b2, c2, area);
            count++; sumofareas += area;
        );
    );
));
printf("%d,%d\n", count, sumofareas % 2^64);
}
