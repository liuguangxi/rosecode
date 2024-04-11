iszumkeller(n) = {
    my(vd, sumvd, f, c);
    vd = divisors(n);
    sumvd = vecsum(vd);
    if (sumvd % 2 == 1, return(0), sumvd /= 2);
    f = prod(i = 1, #vd, 1 + x^vd[i] + O(x^(sumvd+1)));
    return(polcoeff(f, sumvd) != 0);
}


{
N1 = 439050; N2 = 439100;
count = 0; sumn = 0;
for (n = N1, N2,
    if (iszumkeller(n),
        print(n);
        count++; sumn += n;
    );
);
printf("%d,%d\n", count, sumn);
}
