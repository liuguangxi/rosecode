cross(x, y) = x[1]*y[2] - x[2]*y[1];


cmpfpol(x, y) = {
    my(c = cross(y, x));
    if (c != 0, return(c), return((x[1]^2+x[2]^2)-(y[1]^2+y[2]^2)));
}


graham(v) = {
    my(v1, v2, vc, pnew, p1, p2);
    v1 = vecsort(v, [2,1]);
    v2 = vector(#v1-1, i, v1[i+1]-v1[1]);
    v2 = vecsort(v2, cmpfpol);
    vc = List([[0,0], v2[1]]);
    for (i = 2, #v2,
        pnew = v2[i];
        while (#vc > 1,
            p1 = vc[#vc-1]; p2 = vc[#vc];
            if (cross(pnew-p2, p2-p1) >= 0, listpop(vc), break);
        );
        listput(vc, pnew);
    );
    return(vc);
}


{
N = 1000;
default(realprecision, N*6+10);
pidig = digits(floor((Pi-3)*10^(6*N)));
vpt = vector(N, i, [pidig[6*(i-1)+1..6*(i-1)+3]*[100,10,1]~, pidig[6*(i-1)+4..6*(i-1)+6]*[100,10,1]~]);
vch = graham(vpt);
s = sum(i = 2, #vch-1, abs(cross(vch[i]-vch[1], vch[i+1]-vch[1]))/2);
if (s == floor(s), print(s), printf("%.1f\n", s));
}
