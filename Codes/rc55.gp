numconv(n) = {
    my(vn);
    vn = digits(n);
    if (vn == Vecrev(vn), return(0))
    for (i = 1, 100,
        n = sum(i = 1, #vn, vn[i]^3);
        vn = digits(n);
        if (vn == Vecrev(vn), return(i));
    );
    return(-1);
}


{
L = 9^3*6; V = vector(L);
for (x = 1, L, V[x] = numconv(x));

number = 0; steps = 0;
for (x = 1, 1000000,
    vx = digits(x);
    s = V[sum(i = 1, #vx, vx[i]^3)] + 1;
    if (s > steps,
        number = x; steps = s;
        print(number, " -> ", steps);
    );
);
printf("%d.%d\n", number, steps);
}
