{
R = 10^19;
count = 0;
umax = floor((R/4)^(1/4));
for (u = 1, umax,
    forstep (v = u + 1, R, 2,
        a = v^2 - u^2; b = 2*u*v; c = v^2 + u^2;
        if (a*b*c >= R, break);
        if (gcd(u, v) == 1,
            m = a*b*c;
            count += R \ m * 2;
        );
    );
);
printf("f(%d) = %d\n", R, count);
}
