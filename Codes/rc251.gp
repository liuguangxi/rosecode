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


checkpoly(m) = {
    my(nr, nc, vm, m2, mcov, vptfree, vshape, vpt, depth, isvalid, mnr, mnc, ptcmin, ptcmax, overlap);

    [nr, nc] = matsize(m);
    if (!(nr <= Rcover && nc <= Ccover), return(0));

    vm = List(m);
    m2 = matrix(nr, nc);
    for (i = 1, nr, for (j = 1, nc, m2[i,j] = m[nr+1-i,nc+1-j]));
    listput(vm, m2);
    m2 = matrix(nc, nr);
    for (i = 1, nc, for (j = 1, nr, m2[i,j] = m[j,nc+1-i]));
    listput(vm, m2);
    for (i = 1, nc, for (j = 1, nr, m2[i,j] = m[nr+1-j,i]));
    listput(vm, m2);
    vm = Set(vm);

    mcov = matrix(Rcover, Ccover);
    vptfree = vshape = vpt = vector(4);
    vptfree[1] = [1,1]; vshape[1] = 1; vpt[1] = [1,1];
    depth = 1;
    while (depth > 0,
        isvalid = 0;
        while (isvalid == 0 && vshape[depth] <= #vm,
            [mnr, mnc] = matsize(vm[vshape[depth]]);
            if (vptfree[depth][1] + mnr - 1 <= Rcover,
                ptcmin = max(max(vptfree[depth][2] - mnc + 1, 1), vpt[depth][2]);
                ptcmax = min(vptfree[depth][2] + mnc - 1, Ccover) - mnc + 1;
                for (c = ptcmin, ptcmax,
                    if (vm[vshape[depth]][1,vptfree[depth][2]-c+1] != 1, next);
                    overlap = 0;
                    for (i = 1, mnr, for (j = 1, mnc,
                        if (mcov[vptfree[depth][1]+i-1,c+j-1] > 0 && vm[vshape[depth]][i,j] == 1,
                            overlap = 1; break(2);
                        );
                    ));
                    if (overlap == 0,
                        isvalid = 1; vpt[depth] = [vptfree[depth][1],c]; break;
                    );
                );
                if (isvalid == 0, vshape[depth]++; vpt[depth] = [vptfree[depth][1],1]),
                vshape[depth]++; vpt[depth] = [vptfree[depth][1],1];
            );
        );

        if (isvalid,
            for (i = 1, mnr, for (j = 1, mnc,
                if (vm[vshape[depth]][i,j] == 1,
                    mcov[vpt[depth][1]+i-1, vpt[depth][2]+j-1] = depth;
                );
            ));
            if (depth == 4,
                for (i = 1, Rcover, for (j = 1, Ccover, printf(" %d", mcov[i,j])); print);
                return(1),
                depth++;
                for (i = 1, Rcover, for (j = 1, Ccover,
                    if (mcov[i,j] == 0, vptfree[depth] = [i,j]; break(2));
                ));
                vshape[depth] = 1; vpt[depth] = [vptfree[depth][1],1];
            ),
            depth--;
            if (depth > 0,
                [mnr, mnc] = matsize(vm[vshape[depth]]);
                for (i = 1, mnr, for (j = 1, mnc,
                    if (vm[vshape[depth]][i,j] == 1,
                        mcov[vpt[depth][1]+i-1, vpt[depth][2]+j-1] = 0;
                    );
                ));
                vpt[depth][2]++;
            );
        );
    );

    return(0);
}


{
Nsquare = 8;
Rcover = 4; Ccover = 8;

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

vvalue = List();
print;
for (k = 1, #vpoly,
    mpoly = numtomat(vpoly[k][1], vpoly[k][2], vpoly[k][3]);
    if (checkpoly(mpoly),
        listput(vvalue, vpoly[k][1]);
        printf("Canonical Value = %d, Row = %d, Col = %d\n",
            vpoly[k][1], vpoly[k][2], vpoly[k][3]);
        printpoly(numtomat(vpoly[k][1], vpoly[k][2], vpoly[k][3]));
        print;
    );
);

for (k = 1, #vvalue - 1, printf("%d,", vvalue[k]));
printf("%d\n", vvalue[#vvalue]);
}
