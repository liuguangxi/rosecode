{
K = 5;
vp = List();
forprime (p = 10^(K-1), 10^K-1,
    pd = vecsort(digits(p));
    if (pd[1] != 0, listput(vp, p));
);
vp = Vec(vp); lvp = #vp;

vampire = List();
for (i = 1, lvp, for (j = i, lvp,
    f1 = vp[i]; f2 = vp[j]; f = f1 * f2;
    vf12 = vecsort(concat(digits(f1), digits(f2)));
    vf = vecsort(digits(f));
    if (vf12 == vf,
        listput(vampire, f);
        printf("%d = %d * %d\n", f, f1, f2);
    );
));
vampire = vecsort(Vec(vampire));
printf("%d,%d\n", vampire[1], vampire[#vampire]);
}
