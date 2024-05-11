/*
Answer: CD97BA4368251DBAC491287563
*/


dfs(k) = {
    my(r, c);
    r = Ruse[k]; c = Cuse[k];
    for (x = 1, N,
        if (bittest(User[r], x) == 0 && bittest(Usec[c], x) == 0,
            M[r+1, c+1] = x;
            User[r] = bitor(User[r], 1 << x);
            Usec[c] = bitor(Usec[c], 1 << x);
            if (k == NN,
                Found = 1; return,
                dfs(k + 1);
            );
            if (Found, return);
            User[r] = bitxor(User[r], 1 << x);
            Usec[c] = bitxor(Usec[c], 1 << x);
        );
    );
}


{
N = 13;

StrD = Vec("123456789ABCDEF");
NN = (N - 1)^2;
M = matrix(N, N, i, j, if (i == 1, j, if (j == 1, i, 0)));
Ruse = vector(NN, i, (i-1)\(N-1)+1);
Cuse = vector(NN, i, (i-1)%(N-1)+1);
User = vector(N - 1, i, 1 << (i + 1));
Usec = User;

Found = 0;
dfs(1);
for (i = 1, N,
    for (j = 1, N,
        printf(" %s", StrD[M[i,j]]);
    );
    print;
);
}
