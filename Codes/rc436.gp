/*
a^4 + 4*b^4 = (a^2 - 2*a*b + 2*b^2) * (a^2 + 2*a*b + 2*b^2)
b = 2^250
a^4 + 2^1002 is semiprime if and only if
(a^2 - 2*a*b + 2*b^2) and (a^2 + 2*a*b + 2*b^2) are both primes
*/


{
b = 2^250;
a = 1;
while (1,
    if (ispseudoprime(a^2 - 2*a*b + 2*b^2) && ispseudoprime(a^2 + 2*a*b + 2*b^2),
        print(a); break;
    );
    a += 2;
);
}
