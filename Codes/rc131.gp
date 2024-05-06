/* ...803 396454804 396... */


\\ Sum of number of digits in range [1, n]
S(n) = {
    my(ret = 0, k);
    k = logint(n, 10);
    for (i = 1, k, ret += i * (10^i - 10^(i-1)));
    ret += (k + 1) * (n - 10^k + 1);
    return(ret);
}


{
ans = S(396454803) - 2;
print(ans);
}
