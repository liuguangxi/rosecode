/*
      a b c
    x   d e
-----------
    * * * *
  * * * *
-----------
  * * * * *
*/


{
SD = [2, 3, 5, 7]; L = #SD;

s = 0;
for (a = 1, L, for (b = 1, L, for (c = 1, L, for (d = 1, L, for (e = 1, L,
    abc = SD[a] * 100 + SD[b] * 10 + SD[c];
    de = SD[d] * 10 + SD[e];
    m1 = abc * SD[e];
    m2 = abc * SD[d];
    m = abc * de;
    v = concat(concat(digits(m1), digits(m2)), digits(m));
    v = Set(v);
    if (setminus(v, SD) != [], next);
    s++;
    printf("%d * %d, %d, %d, = %d\n", abc, de, m1, m2, m);
)))));
print(s);
}
