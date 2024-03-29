check(n) = {
    my(v);
    v = Set(digits(n^2));
    return(v == [0..9]);
}


{
cnt = 0; s = 0;
i1 = 10!/10; i2 = 10!-1;
for (i = i1, i2,
    v = Vec(numtoperm(10, i)) - vector(10, i, 1);
    x1 = fromdigits(v[1..5]);
    x2 = fromdigits(v[6..10]);
    if (check(x1) && check(x2),
        x = fromdigits(v);
        cnt++; s += x;
        printf("(%d)  %d\n", cnt, x);
    );
);
printf("%d,%d\n", cnt, s);
}
