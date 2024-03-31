/*
https://en.wikipedia.org/wiki/Pr%C3%BCfer_sequence
*/


prufertotree(a) = {
    my(n, degrees, u, v);
    n = #a + 2;
    degrees = vector(n, i, 1);
    for (i = 1, #a, degrees[a[i]]++);
    for (i = 1, #a, for (j = 1, n,
        if (degrees[j] == 1,
            Tree[a[i],j] = Tree[j,a[i]] = 1;
            degrees[a[i]]--; degrees[j]--;
            break;
        );
    ));
    u = v = 0;
    for (j = 1, n,
        if (degrees[j] == 1,
            if (u == 0, u = j, v = j; break);
        );
    );
    Tree[u,v] = Tree[v,u] = 1;
}


treetostr(d) = {
    my(s = Str(d), vsubd = List());
    Use[d] = 1;
    for (i = 1, N,
        if (Use[i] == 0 && Tree[d,i] == 1,
            Use[i] = 1; listput(vsubd, i);
        );
    );
    vsubd = Vec(vsubd);
    if (#vsubd == 0, return(s));
    s = concat([s, "(", treetostr(vsubd[1])]);
    for (i = 2, #vsubd,
        s = concat([s, ",", treetostr(vsubd[i])]);
    );
    s = concat(s, ")");
    return(s);
}


{
Sol = List();
xin = readstr("RC481_1.txt");
for (i = 1, #xin,
    c = eval(concat(["[", xin[i], "]"]));
    N = #c + 2;
    Tree = matrix(N, N);
    Use = vector(N);
    prufertotree(c);
    str = treetostr(1);
    listput(Sol, str);
);
Sol = vecsort(Vec(Sol));
print(Sol[#Sol]);
}
