{
[N, D] = [2^19-1, 2^19];
forprime (p = 2, 10^10,
    t = (p + 1) * D;
    if (t % N != 0, next);
    q = t / N - 1;
    if (isprime(q),
        printf("%d,%d\n", p, q);
        break;
    );
);
}
