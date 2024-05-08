chk(n) = {
    my(vn, lvn);
    for (b = 2, 20,
        vn = digits(n, b); lvn = #vn;
        if (lvn < b, break);
        if (lvn != b, next);
        if (Set(vn) == [0..b-1], return(1));
    );
    return(0);
}


{
forprime (p = 1, 10^6,
    if (chk(p), print(p));
);
}
