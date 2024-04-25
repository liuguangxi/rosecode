prob(v1, v2) = {
    my(s = 0);
    for (i = 1, 6, for (j = 1, 6, if (v1[i] > v2[j], s++)));
    return(s);
}


distinct(n) = {return(#Set(digits(n)) == 6);}


findabc(A) = {
    my(digitsa, vecb, vecc, B, C, p, lenvecb, lenvecc, ibmin, ibmax, icmin, icmax, sol, solmin);
    digitsa = fromdigits(A);
    vecb = List();
    vecc = List();
    for(x1 = 1, Max, for(x2 = x1, Max, for(x3 = x2, Max, for(x4 = x3, Max, for(x5 = x4, Max, for(x6 = x5, Max,
        B = [x1, x2, x3, x4, x5, x6];
        p = prob(A, B);
        if (p > 18, listput(vecb, [p, fromdigits(B)]));
        C = B;
        p = prob(C, A);
        if (p > 18, listput(vecc, [p, fromdigits(C)]));
    ))))));
    vecb = vecsort(Vec(vecb));
    vecc = vecsort(Vec(vecc));
    lenvecb = #vecb;
    lenvecc = #vecc;

    ibmin = 1; icmin = 1;
    while (ibmin <= lenvecb,
        ibmax = ibmin;
        p = vecb[ibmin][1];
        while (ibmax <= lenvecb && vecb[ibmax][1] == p, ibmax++);
        ibmax--;
        icmin = 1;
        while (icmin <= lenvecc && vecc[icmin][1] != p, icmin++);
        if (icmin <= lenvecc,
            icmax = icmin;
            while (icmax <= lenvecc && vecc[icmax][1] == p, icmax++);
            icmax--;

            \\print(p, "  ", [ibmin, ibmax], [icmin, icmax]);
            for (ib = ibmin, ibmax, for (ic = icmin, icmax,
                if (prob(digits(vecb[ib][2]), digits(vecc[ic][2])) == p,
                    Cnt++;
                    sol = [digitsa,vecb[ib][2],vecc[ic][2]];
                    print("[",Cnt,"]    ",sol);
                    solmin = vecmin(sol);
                    if (sol[1] == solmin, listput(ListSol, sol),
                        if (sol[2] == solmin,
                            listput(ListSol, [sol[2], sol[3], sol[1]]),
                            listput(ListSol, [sol[3], sol[1], sol[2]])
                        );
                    );
                );
            ));
        );

        ibmin = ibmax + 1;
    );
}


{
Max = 8;
Cnt = 0;
ListSol = List();
for(x1 = 1, Max, for(x2 = x1, Max, for(x3 = x2, Max, for(x4 = x3, Max, for(x5 = x4, Max, for(x6 = x5, Max,
    findabc([x1, x2, x3, x4, x5, x6]);
))))));
ListSol = Set(ListSol);
Count = #ListSol;
for (i = 1, Count,
    if (distinct(ListSol[i][1]), dies = ListSol[i]; print(dies));
);
print(Count, "/", digits(dies[1]), digits(dies[2]), digits(dies[3]));    \\ 13868/(1,3,4,5,6,7)(3,3,3,3,4,8)(2,2,2,6,8,8)
}
