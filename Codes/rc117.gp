P(n) = {
    my(s = 0, z);
    if (mapisdefined(Mp, n, &z), return(z));
    fordiv (n, x,
        if (n == 1, s = 1, if (x < n, s += P(x)));
    );
    mapput(Mp, n, s);
    return(s);
}


{
N = 46079 + 1;
Mp = Map();
ans = P(N);
print(ans);
}
