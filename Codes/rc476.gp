/* A000399      Unsigned Stirling numbers of first kind s(n,3). */


check(v) = {
    setv = Set(v); maxv = vecmax(v);
    if (setv != [1..maxv], return(0));
    rec = 1; currmax = v[1];
    for (i = 2, N, if (v[i] > currmax, rec++; currmax = v[i]));
    if (rec != 3, return(0));
    for (k = 2, maxv,
        for (i = 1, N, if (v[i] == k - 1, i1 = i; break));
        forstep (i = N, 1, -1, if (v[i] == k, i2 = i; break));
        if (i1 >= i2, return(0));
    );
    return(1);
}


{
N = 100;
/*s = 0;
for(a1=1,N,for(a2=1,N,for(a3=1,N,for(a4=1,N,for(a5=1,N,for(a6=1,N,for(a7=1,N,for(a8=1,N,
    v = [a1, a2, a3, a4, a5, a6, a7, a8];
    if (check(v), print(v); s++);
))))))));
print(s);*/
print(abs(stirling(N, 3)));
}
