factp(n, p) = {
    my(ret = 0);
    while (n >= p, n \= p; ret += n);
    return(ret);
}


{
N = 10000;
s = 1;
forprime (p = 2, N,
    np = factp(N, p);
    s *= numbpart(np);
);
ans = sumdigits(s);
print(ans);
}
