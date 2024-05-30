/*
O1O2 = abs(a^2-a*c) / sqrt(4*a^2-c^2)
*/


{
N = 10^8;
count = 0;
for (m = 2, floor(sqrt(N/4)),
    if (m % 10 == 0, print("m = ", m));
    for (n = 1, m - 1,
        if ((m + n) % 2 == 0 || gcd(m, n) != 1, next);
        a1 = 2*(m^2 + n^2); x1 = 8*m*n; y1 = 4*(m^2 - n^2);

        a = a1; c = x1; d = y1;
        while (2*a+c <= N,
            if ((a*(a-c)) % d == 0,
                count++;
            );
            a += a1; c += x1; d += y1;
        );

        a = a1; c = y1; d = x1;
        while (2*a+c <= N,
            if ((a*(a-c)) % d == 0,
                count++;
            );
            a += a1; c += y1; d += x1;
        );
    );
);
print(count);
}
