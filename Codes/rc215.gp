H(p) = {
    my(c = 1, cnt = 0);
    for (n = 2, 2*p-1,
        if (!isprime(n), c = c * n % p);
        if (c == p - 1, cnt++; print("n = ", n));
    );
    printf("H(%d) = %d\n", p, cnt);
    return(cnt);
}


{
printf("%d,%d,%d,%d,%d\n", H(6031001), H(6873371), H(9103859), H(6133003), H(7834447));
}
