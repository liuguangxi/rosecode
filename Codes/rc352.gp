isperiod(x, n) = {
    my(x0, m);
    fordiv (n, d,
        if (d > 1,
            x0 = x % 10^(n/d);
            m = sum(i = 0, d - 1, 10^(n/d*i));
            if (x0 * m == x, return(1));
        );
    );
    return(0);
}


{
n = 68;

vx = List();
N = 10^n;
fordiv (N - 1, d,
    d2 = (N - 1) / d;
    if (gcd(d, d2) == 1,
        X = d * lift(1 / Mod(d, d2));
        if (X >= N/10, listput(vx, X));
    );
);
listput(vx, N - 1);
listsort(vx);

count = 0; sumx = 0;
for (i = 1, #vx,
    if (isperiod(vx[i], n),
        count++; sumx += vx[i];
        print(vx[i]);
    );
);
printf("%d,%d\n", count, sumx);
}
