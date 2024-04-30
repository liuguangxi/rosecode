chk(x) = {
    my(x8, x9);
    x8 = digits(x, 8);
    x9 = digits(fromdigits(Vecrev(digits(x))), 9);
    return(x8 == x9);
}


{
N = 10^7;
ans = 0;
for (n = 1, N,
    if (n % 1000000 == 0, print("n = ", n));
    if (chk(n), ans = max(ans, n));
);
print(fromdigits(digits(ans, 8)));
}
