/*
n = a*10^K + b
(10^K-2*a)^2 + (2*b-1)^2 = 10^(2*K)+1
10^(K-1) <= a < 10^K, 0 <= b < 10^K
*/


gen(x1, x2) = [x1[1]*x2[2]+x1[2]*x2[1], abs(x1[1]*x2[1]-x1[2]*x2[2])];


{
K = 18;

n = 10^(2*K)+1;
fa = factor(n)[,1]~;
q = Qfb(1, 0, 1);
vf = List();
for (i = 1, #fa, listput(vf, qfbsolve(q, fa[i])));

v = List();
for (i = 1, #fa,
    x0 = vf[i][1]; y0 = vf[i][2];
    if (i == 1,
        listput(v, [x0, y0]),
        for (j = 1, #v,
            listput(v, gen(v[j], [x0, y0]));
            listput(v, gen(v[j], [y0, x0]));
        );
        for (j = 1, 2^(i-2), listpop(v, 1));
    );
);

vn = List();
for (i = 1, #v,
    x = v[i][1]; y = v[i][2];
    if (x % 2 == 1, t = x; x = y; y = t);
    a1 = (10^K + x) / 2; a2 = (10^K - x) / 2;
    b = (y + 1) / 2;
    if (a1 >= 10^(K-1) && a1 < 10^K && b < 10^K, listput(vn, a1*10^K+b));
    if (a2 >= 10^(K-1) && a2 < 10^K && b < 10^K, listput(vn, a2*10^K+b));
);
listsort(vn);
\\for (i = 1, #vn, print(vn[i]));
print(vn[1]);
}
