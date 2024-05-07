/*
1883328,20835702672,198851610672,219099923328
*/


{
M = 10^12;

B = M;
while (1,
    u = bestappr(sqrt(2), B);
    p = numerator(u); q = denominator(u);
    eint = abs((u - sqrt(2)) * M * q);
    if (q > M && eint < 1, break, B *= 2);
);

e = 0;
while (1,
    x = e / p % q;
    if (x < M && x % 4 == 1, break);
    if (e > 0,
        x = -e / p % q;
        if (x < M && x % 4 == 1, break);
    );
    e++;
);

c = round(x * sqrt(2));
print("c = ", c);
print("|c^2 / x^2 - 2| = ", c^2 / x^2 - 2);
va = List();
for (v = 1, floor(sqrt(x/2)),
    if (issquare(x - v^2),
        u = sqrtint(x - v^2);
        if (gcd(u, v) == 1,
            a = u^2 - v^2; b = 2*u*v;
            if (a > b, t = a; a = b; b = t);
            printf("a = %d, b = %d\n", a, b);
            listput(va, a);
        );
    );
);
listsort(va);
print("an = ", Vec(va));
}
