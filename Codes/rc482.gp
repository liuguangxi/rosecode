/*
parent[i] is parent node number of node number i
s.t. p[1] = 0, p[i] < i (i > 1)
*/


parenttostr() = {
    my(str, k);
    str = "1";
    for (i = 2, N,
        if (Parent[i] > Parent[i - 1],
            str = concat([str, "(", Str(i)]),
            k = i - 1;
            while (Parent[k] != Parent[i],
                k--; str = concat(str, ")");
            );
            str = concat([str, ",", Str(i)]),
        );
    );
    k = N;
    while (Parent[k] != 1,
        k--; str = concat(str, ")");
    );
    str = concat(str, ")");
    return(str);
}


calc() = {
    my(mat, p, v, k1, k2, x, str);

    mat = matrix(N, N);
    for (n = 2, N,
        p = Parent[n]; mat[n,p] = mat[p,n] = 1;
    );

    v = vector(N - 2);
    for (i = 1, N - 2,
        for (n = 1, N,
            if (vecsum(mat[n,]) == 1, k1 = n; break);
        );
        for (j = 1, N,
            if (mat[k1,j] == 1, k2 = j; break);
        );
        mat[k1,k2] = mat[k2,k1] = 0;
        v[i] = k2;
    );

    x = fromdigits(v);
    if (isprime(x),
        S += x;
        if (#Set(v) == N - 2,
            str = parenttostr();
            print("Parent = ", Parent);
            print("Code = ", v);
            print("String = ", str, "\n");
            listput(Sol, str);
        );
    );
}


rec(k) = {
    my(node);
    node = k - 1;
    while (node > 0,
        Parent[k] = node;
        if (k == N, calc(), rec(k + 1));
        node = Parent[node];
    );
}


{
N = 10;

S = 0;
Parent = vector(N);
Sol = List();
rec(2);
Sol = vecsort(Vec(Sol));

printf("%d,", S);
for (i = 1, #Sol - 1, printf("%s/", Sol[i]));
printf("%s\n", Sol[#Sol]);
}
