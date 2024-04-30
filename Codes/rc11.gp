rec(k) = {
    my(d, r, ok);
    d = (k - 1) \ N + 1; r = (k - 1) % N + 1;
    if (r == 1,
        Latin[r,d] = d;
        rec(k + 1);
        ,
        for (c = 1, N,
            if (Latin[r,c] != 0, next);
            ok = 1;
            for (i = 1, r - 1, if (Latin[i,c] == d, ok = 0; break));
            if (ok,
                Latin[r,c] = d;
                if (k == N^2,
                    s++; \\print("[", s, "]  ", Latin);
                    ,
                    rec(k + 1);
                );
                Latin[r,c] = 0;
            );
        );
    );
}


{
N = 5;
Latin = matrix(N, N);
s = 0;
rec(1);
print(s);
}
