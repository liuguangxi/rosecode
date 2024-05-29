vp(n, p) = {
    my(ret = 0);
    while (n >= p, n \= p; ret += n);
    return(ret);
}


{
N = 100000;
s = 1;
forprime (p = 2, N,
    e = vp(N, p);
    s *= (p^(e+1) - 1) / (p - 1);
);
ans = sumdigits(s);
print(ans);
}
