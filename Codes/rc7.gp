ispalindromic(x) = {
    my(x4, x6);
    x4 = digits(x, 4);
    if (x4 != Vecrev(x4), return(0));
    x6 = digits(x, 6);
    if (x6 != Vecrev(x6), return(0), return(1));
}


{
N = 10^7;
s = 0;
for (n = 1, N,
    if (n % 1000000 == 0, print("n = ", n));
    if (ispalindromic(n), s += n);
);
print(s);
}
