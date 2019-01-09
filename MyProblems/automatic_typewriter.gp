/*
10 digits (d = 0,..,9) with probability (d+1)/55

Input
A digit sequence contains digits from 0 to 9.

Output
Output the expected time the typewriter will need to type a word,
rounded to the nearest integer.
*/


gauss_bf(nword, st) = {
    my(m, b, x);
    m = matrix(nword, nword);
    for (k = 1, nword,
        m[k,k] = -55;
        for (i = 1, 10,
            if (st[k,i] <= nword, m[k,st[k,i]] += i);
        );
    );
    \\print("Matrix:\n", m);
    b = vector(nword, i, -55)~;
    x = matsolve(m, b);
    print("Ref E = ", x[1]);
}


calc(word) = {
    my(nword, vword, st, fail, vlast, clast, r, r2, e);

    /* Preprocess intput string */
    nword = #word;
    vword = vector(nword, i, word[i] + 1);    \\ 0->1,...,9->10

    /* Build AC automata */
    st = matrix(nword, 10);
    for (k = 1, nword, st[k, vword[k]] = k + 1);
    fail = vector(nword + 1);
    fail[2] = 1;
    for (i = 1, 10, if (st[1,i] == 0, st[1,i] = 1));
    for (k = 2, nword,
        for (i = 1, 10,
            if (i == vword[k], st[k,i] = k + 1, st[k,i] = st[fail[k],i]);
        );
        fail[k + 1] = st[fail[k],vword[k]];
    );
    \\print(fail);
    \\print("After build:\n", st);

    /* Gaussian elimination */
    \\gauss_bf(nword, st);
    vlast = vector(nword); clast = -1;
    vlast[nword] = -55;
    for (i = 1, 10,
        if (st[nword,i] <= nword, vlast[st[nword,i]] += i);
    );
    \\print(vlast, "  ", clast);
    forstep (k = nword - 1, 1, -1,
        r = vlast[k + 1]; r2 = vword[k];
        if (r == 0, next);
        if (r2 > 1,
            for (j = 1, k + 1, vlast[j] *= r2);
            clast *= r2;
        );
        vlast[k] += 55 * r;
        for (i = 1, 10, vlast[st[k,i]] -= i * r);
        clast += r;
        \\print(vlast, "  ", clast);
    );
    e = 55 * clast / vlast[1];

    /* Output result */
    return(e);
}


{
default(realprecision, 12000);

N = 10000;
x = floor(Pi*10^(N-1));
E = calc(digits(x));
\\print("E = ", E);

Ernd = round(E);
ve = digits(Ernd); lene = #ve;
if (lene > 20,
    first10 = Strchr(ve[1..10] + vector(10, i, 48));
    last10 = Strchr(ve[lene-9..lene] + vector(10, i, 48));
    lenrest = lene - 20;
    printf("%s[%d]%s\n", first10, lenrest, last10);
);
}
