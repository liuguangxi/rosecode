dfs(k) = {
    my(pt, pt_new, used);
    pt = Vpt[k];
    for (d = 1, 6,
        pt_new = pt + Dir[d];
        used = 0;
        for (i = 1, k - 1, if (Vpt[i] == pt_new, used = 1; break));
        if (!used,
            Vpt[k + 1] = pt_new;
            Vpath[k] = d;
            if (k == N - 1,
                CountPaths++;
                if (Vecrev(Vpath) == Vpath, CountPalindromic++),
                dfs(k + 1);
            );
        );
    );
}


{
N = 12;
Dir = [2, 1+I, -1+I, -2, -1-I, 1-I];    \\ dx = re(Dir)*(1/2), dy = im(Dir)*(sqrt(3)/2)
Vpt = vector(N);
Vpath = vector(N - 1);
Vpt[2] = Dir[1];
Vpath[1] = 1;
CountPaths = 0; CountPalindromic = 0;
dfs(2);
printf("%d,%d\n", CountPaths*6, CountPalindromic*6);
}
