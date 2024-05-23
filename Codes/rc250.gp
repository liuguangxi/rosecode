mattonum(m) = {
    my(nr, nc, v = []);
    [nr, nc] = matsize(m);
    for (i = 1, nr, v = concat(v, m[i,]); v = concat(v, 0));
    return(fromdigits(v, 2));
}


numtomat(n, nr, nc) = {
    my(v, lenv, m, k);
    nc++;
    v = Vecrev(binary(n)); lenv = #v;
    m = matrix(nr, nc - 1); k = 0;
    forstep (i = nr, 1, -1, forstep (j = nc - 1, 1, -1,
        k++; if (k % nc == 1, k++);
        if (k > lenv, break(2), m[i,j] = v[k]);
    ));
    return(m);
}


getcv(m) = {
    my(nr, nc, cvmin, nrmin, ncmin, m2, cv);
    [nr, nc] = matsize(m);

    \\ Original
    cvmin = mattonum(m);
    if (nr <= nc,
        cvmin = mattonum(m); nrmin = nr; ncmin = nc,
        cvmin = 2^(nc*(nr+1));
    );

    \\ Rotate Pi
    if (nr <= nc,
        m2 = matrix(nr, nc);
        for (i = 1, nr, for (j = 1, nc, m2[i,j] = m[nr+1-i,nc+1-j]));
        cv = mattonum(m2);
        if (cv  < cvmin, cvmin = cv; nrmin = nr; ncmin = nc);
    );

    if (nr >= nc,
        m2 = matrix(nc, nr);
        \\ Rotate Pi/2 anti-clockwise
        for (i = 1, nc, for (j = 1, nr, m2[i,j] = m[j,nc+1-i]));
        cv = mattonum(m2);
        if (cv  < cvmin, cvmin = cv; nrmin = nc; ncmin = nr);

        \\ Rotate Pi/2 clockwise
        for (i = 1, nc, for (j = 1, nr, m2[i,j] = m[nr+1-j,i]));
        cv = mattonum(m2);
        if (cv  < cvmin, cvmin = cv; nrmin = nc; ncmin = nr);
    );

    return([cvmin, nrmin, ncmin]);
}


printpoly(m) = {
    my(nr, nc);
    [nr, nc] = matsize(m);
    for (i = 1, nr,
        for (j = 1, nc,
            if (m[i,j] == 0, printf("  "), printf(" #"));
        );
        print;
    );
}


{
Nsquare = 8;

vpoly = [[6,1,2]];    \\ 2 squares
for (num = 3, Nsquare,
    vpolynew = List();
    for (k = 1, #vpoly,
        [n, nr, nc] = vpoly[k];
        mp = numtomat(n, nr, nc);
        for (i = 1, nr, for (j = 1, nc,
            if (mp[i,j] == 0, next);

            \\ Left
            if (j == 1,
                mpnew = matconcat([matrix(nr,1,x,y,x==i), mp]);
                listput(vpolynew, getcv(mpnew)),
                if (mp[i,j-1] == 0,
                    mpnew = mp; mpnew[i,j-1] = 1;
                    listput(vpolynew, getcv(mpnew));
                );
            );

            \\ Right
            if (j == nc,
                mpnew = matconcat([mp, matrix(nr,1,x,y,x==i)]);
                listput(vpolynew, getcv(mpnew)),
                if (mp[i,j+1] == 0,
                    mpnew = mp; mpnew[i,j+1] = 1;
                    listput(vpolynew, getcv(mpnew));
                );
            );

            \\ Up
            if (i == 1,
                mpnew = matconcat([matrix(1,nc,x,y,y==j); mp]);
                listput(vpolynew, getcv(mpnew)),
                if (mp[i-1,j] == 0,
                    mpnew = mp; mpnew[i-1,j] = 1;
                    listput(vpolynew, getcv(mpnew));
                );
            );

            \\ Down
            if (i == nr,
                mpnew = matconcat([mp; matrix(1,nc,x,y,y==j)]);
                listput(vpolynew, getcv(mpnew)),
                if (mp[i+1,j] == 0,
                    mpnew = mp; mpnew[i+1,j] = 1;
                    listput(vpolynew, getcv(mpnew));
                );
            );
        ));
    );
    vpoly = Set(vpolynew);
);

print;
for (k = 1, #vpoly,
    printf("[%d] Canonical Value = %d, Row = %d, Col = %d\n",
        k, vpoly[k][1], vpoly[k][2], vpoly[k][3]);
    printpoly(numtomat(vpoly[k][1], vpoly[k][2], vpoly[k][3]));
    print;
);

Count = #vpoly; Value = vpoly[666][1];
printf("%d,%d\n", Count, Value);
}
