t(n) = {
    my(ret = 0);
    fordiv (n, d,
        if (d % 4 != 0, ret += d);
    );
    return(ret * 8);
}


{
s = sum(k = 0, 100, t(10^17 + k));
print(s);
}
