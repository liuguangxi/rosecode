f(n) = {
    my(nd, lend, s, t, m);
    if (n <= 1, return(0));
    nd = binary(n); lend = #nd;
    s = sum(i  =1, lend-1, 2^(i-2)*(i-1));
    t = 0;
    for (i = 2, lend,
        if (i == lend,
            if (nd[i] == 0, s += t + 1, s += 2 * t + 1),
            if (nd[i] == 0,
                t++,
                m = lend - i; s += (t+1)*2^m + 2^(m-1)*m;
            );
        );
    );
    return(s);
}


{
N1 = 12345678910111213; N2 = 31211101987654321;
ans = f(N2) - f(N1 - 1);
print(ans);
}
