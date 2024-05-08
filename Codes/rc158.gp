/*
Three sides: {a, a, b}
8*a^2 * sin(acos(b/(2*a))/3)^2 * sin(acos(1 - b^2/(2*a^2))/3) / sqrt(4*a^2 - b^2)

Three sides: {a, b, b}
8*b^2 * sin(acos(1 - a^2/(2*b^2))/3) * sin(acos(a/(2*b))/3)^2 / sqrt(-a^2 + 4*b^2)

Answer: 29791,35282,137423/24
*/


f1(a, b) = 8*a^2 * sin(acos(b/(2*a))/3)^2 * sin(acos(1 - b^2/(2*a^2))/3) / sqrt(4*a^2 - b^2);

f2(a, b) = 8*b^2 * sin(acos(1 - a^2/(2*b^2))/3) * sin(acos(a/(2*b))/3)^2 / sqrt(-a^2 + 4*b^2);


{
P1 = 94000; P2 = 95000;

/*
{a, a, b}: P = 2*a+b and P1 <= P <= P2 and b/2 < a < b =>
P1/3 < b < P2/2 and (P1-b)/2 <= a <= (P2-b)/2 and b/2 < a < b
*/
bestden = 10^100;
print("{a, a, b}");
for (b = floor(P1/3)+1, ceil(P2/2)-1,
    amin = max(ceil((P1-b)/2), floor(b/2)+1);
    amax = min(floor((P2-b)/2), b-1);
    for (a = amin, amax,
        if (gcd(a, b) > 1, next);
        x = f1(a, b); xappr = bestappr(x);
        xapprden = denominator(xappr);
        if (xapprden < bestden,
            bestden = xapprden;
            printf("(%d, %d) -> ", a, b); print(xappr);
        );
    );
);

/*
{a, b, b}: P = 2*b+a and P1 <= P <= P2 and 0 < a < b =>
P1/3 < b < P2/2 and (P1-2*b)/2 <= a <= (P2-2*b)/2 and 0 < a < b
*/
bestden = 10^100;
print("{a, b, b}");
for (b = floor(P1/3)+1, ceil(P2/2)-1,
    amin = max(ceil((P1-2*b)/2), 1);
    amax = min(floor((P2-2*b)/2), b-1);
    for (a = amin, amax,
        if (gcd(a, b) > 1, next);
        x = f2(a, b); xappr = bestappr(x);
        xapprden = denominator(xappr);
        if (xapprden < bestden,
            bestden = xapprden;
            printf("(%d, %d) -> ", a, b); print(xappr);
        );
    );
);
}
