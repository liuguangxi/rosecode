dfs(b1, b2) = {
    my(depth, pos, backtrack, N, Nmax, test, x1, x2, v1, v2, cnt, res1, res2, M1, M2, c);
    depth = 1; pos = vector(L);
    while (depth > 0,
        pos[depth]++; backtrack = 0;

        if (pos[depth] >= b1,
            backtrack = 1,
            N = fromdigits(pos[1..depth], b1)*b1^(L-depth);
            Nmax = N+b1^(L-depth)-1;
            test = (N < best) && (Nmax >= b2^(L-1));
            if (test,
                x1 = N;    \\ (pos[1], ..., pos[depth], 0, ..., 0) (base b1)
                x2 = Nmax;    \\ (pos[1], ..., pos[depth], b1-1, ..., b1-1) (base b1)
                v1 = v2 = vector(L);
                for (i = 1, L,
                    v1[i] = x1 % b2; x1 \= b2; v2[i] = x2 % b2; x2 \= b2;
                );
                cnt = 0;
                forstep (i = L, 1, -1, if (v1[i] == v2[i], cnt++, break));
                res1 = fromdigits(v1[(L-cnt+1)..L], b1);
                res2 = fromdigits(Vecrev(pos[1..depth]), b2);
                M1 = b1^cnt; M2 = b2^depth;

                /*
                n = x*M1+res1 = y*M2+res2 => res1-res2 = (-x)*M1 + y*M2
                => n % M1 = res1 && n % M2 == res2 => n = n0 + lcm(M1, M2)*k
                N <= n <= Nmax
                */
                test = ((res1-res2) % gcd(M1,M2) == 0);
                if (test,
                    M = lcm(M1, M2);
                    if (M >= b1^(L-depth),    \\ ensure unique solution for N <= n <= Nmax
                        test = 0;
                        c = lift(chinese(Mod(res1,M1), Mod(res2,M2)));
                        N += (c - N) % M;    \\ c + k*M = N + e => e = (c+k*M-N) % M = (c-N) % M
                        if ((N < best) && (digits(N, b1) == Vecrev(digits(N, b2))),
                            best = N; base1 = b1;
                            printf("number = %d, base1 = %d\n", best, b1);
                        );
                    );
                );
            );
        );

        if (backtrack,
            depth--,
            if (test, depth++; pos[depth] = -1);
        );
    );
}


{
L = 9;
best = 100^L; base1 = 0;
for (b1 = 10, 99,
    b2 = fromdigits(Vecrev(digits(b1)));
    if (b1 < b2,
        print("base1 = ", b1);
        dfs(b1, b2);
    );
);
printf("%d,%d\n", best, base1);
}
