pownum(n, p) = {
    my(ret = 0, x = p);
    while (x <= n, ret += n \ x; x *= p);
    return(ret);
}


{
n = 1000000;
la = primepi(n);
pri = primes(la);
a = vector(la, i, pownum(n, pri[i]));
s = (prod(i = 1, la, 2*a[i]+1) + 1) / 2;
lens = #Str(s);
printf("%010d[%d]%010d\n", s\10^(lens-10), lens-20, s%(10^10));
}
