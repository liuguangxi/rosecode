dfs(k, fmin, rest) = {
    my(fmax);
    fmax = min(sqrtnint(rest, N - k), fn);
    if (k == N - 1,
        if (rest >= fmin && rest <= fn,
            Found = 1; vf[k] = rest;
            printf("%d", vf);
        ),
        forstep (x = fmax, fmin, -1,
            if (Found, return);
            if (rest % x == 0,
                vf[k] = x; dfs(k + 1, x, rest / x);
            );
        );
    );
}


{
N = 28;
fn = precprime(N);
vf = vector(N); vf[N] = fn;
Found = 0;
dfs(1, 1, N!/fn);
}
