{
N = 1000;
s = 0;
forprime (p1 = 1, N, forprime (p2 = p1 + 1, N,
    p12 = fromdigits(concat(digits(p1), digits(p2)));
    if (!isprime(p12), next);
    p21 = fromdigits(concat(digits(p2), digits(p1)));
    if (!isprime(p21), next);
    s++;
));
print(s);
}
