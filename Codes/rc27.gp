S(n) = {
    my(ret);
    if (n == 1, return(1));
    if (T[n] > 0, return(T[n]));
    ret = n^A - sum(k = 1, n - 1, binomial(n, k) * S(n - k));
    T[n] = ret;
    return(ret);
}


{
A = 1678; B = 1543;
T = vector(B);
s = S(B);
print(sumdigits(s));
}
