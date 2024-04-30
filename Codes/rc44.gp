{
f1 = sum(i = 1, 5, x^i)^8;
p1 = Vecrev(f1) / 5^8;
f2 = sum(i = 1, 6, x^i)^6;
p2 = Vecrev(f2) / 6^6;
s = 0;
for (i = 0, #p1 - 1, for (j = 0, #p2 - 1,
    if (i > j, s += p1[i+1] * p2[j+1]);
));
printf("%.9f\n", s);
}
