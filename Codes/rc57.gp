chk(n) = {
    my(vn);
    vn = digits(n);
    return(#vn == #Set(vn));
}


{
x1 = 0; x2 = 0;
total = 0; jump = 0;
for (i = 1, 1000000,
    if (chk(i),
        total++;
        x2 = i; if (x2 - x1 > jump, jump = x2 - x1);
        x1 = i;
    );
);
printf("%d.%d\n", total, jump);
}
