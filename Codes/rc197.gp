/*
https://oeis.org/A003602 => n = (2k-1)*2^m then a(n) = k
*/


S(n) = {
    while (n % 2 == 0, n / = 2);
    return((n + 1) / 2);
}


{
N = 12345678910111213;
ans = S(N);
print(ans);
}
