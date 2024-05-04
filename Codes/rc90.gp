chk(x, k) = {
    my(t = 0);
    if (k == 1, return(1));
    if (V[k - 1] == x, return(0));
    for (i = 1, k - 1, if (V[i] == x, t++));
    return(t < 2);
}


rec(k) = {
    for (x = 1, 3,
        if (chk(x, k),
            V[k] = x;
            if (k == 6,
                print(V); s++,
                rec(k + 1);
            );
        );
    );
}


{
V = vector(6);
s = 0;
rec(1);
print(s);
}
