check(n) = {
    my(ok, d, len, x);
    print("n = ", n);
    ok = 1;
    d = Vecrev(digits(n));
    len = #d;
    for (i = 1, len,
        if (i == len, kmin = 1, kmin = 0);
        for (k = kmin, 9,
            x = n - 10^(i-1)*d[i] + 10^(i-1)*k;
            if (isprime(x), ok = 0; printf("%d is prime\n", x));
        );
    );
    return(ok);
}


{
n = 10012233445566778899;
if (check(n), print("Answer: ", n));

n = 10012233445566778989;
if (check(n), print("Answer: ", n));

n = 10012233445566778998;
if (check(n), print("Answer: ", n));
}
