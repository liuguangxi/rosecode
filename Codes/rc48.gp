/*
"Giz": 0 or 1
"1900" ~ "1999": 1
"#+%&*!^;:-?/": 1 ~ 8
65535 words: 1
*/


{
s = 0;
for (giz = 0, 1,
    for (sc = 1, 8,
        s += (giz + 1 + sc + 1)! * 100 * binomial(12, sc) * 65535;
    );
);

d = s / 73 / 60 / 60 / 24;
printf("%.6f\n", d);
}
