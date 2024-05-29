{
N = 20000;

M = vector(N, i, List());
for (u = 1, floor(sqrt(N/2)),
    forstep (v = u + 1, N \ 2 \ u, 2,
        if (v^2 - u^2 <= N && gcd(u, v) == 1,
            a = v^2 - u^2; b = 2*u*v; maxab = max(a, b);
            for (k = 1, N \ maxab,
                ak = a*k; bk = b*k;
                listput(M[ak], bk); listput(M[bk], ak);
            );
        );
    );
);

count = 0;
sumc1 = sumc2 = sumc3 = 0;
for (i = 1, N,
    L = M[i];
    if (#L >= 2,
        for (k1 = 1, #L - 1, for (k2 = k1 + 1, #L,
            x = i - L[k1]; y = i - L[k2];
            if (x > 0 && y > 0,
                isvld = 0;
                for (k = 1, #M[x], if (M[x][k] == y, isvld = 1; break));
                if (isvld,
                    count++; sumc1 += i;
                    if (i - x < i - y,
                        sumc2 += i - x; sumc3 += y;
                        printf("%d  %d  %d\n", i, i - x, y),
                        sumc2 += i - y; sumc3 += x;
                        printf("%d  %d  %d\n", i, i - y, x);
                    );
                );
            );
        ));
    );
);
printf("%d,%d,%d,%d\n", count, sumc1, sumc2, sumc3);
}
