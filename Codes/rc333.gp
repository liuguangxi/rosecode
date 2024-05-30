/*
Special pair (6th): (75, 1215)
Other pairs: (2^n-2, 2^n*(2^n-2))
*/


buddy(k) = {
    my(n);
    if (k == 6, return([75, 1215]));
    if (k < 6, n = k + 1, n = k);
    return([2^n-2, 2^n*(2^n-2)]);
}


{
N = 30;
[m, n] = buddy(N);
printf("%d,%d\n", m, n)
}
