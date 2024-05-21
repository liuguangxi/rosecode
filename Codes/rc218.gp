{
P = primes([1, 75]); L = #P;
cnt = 0;
forsubset ([L, 11], v,
    vp = vector(11, i, P[v[i]]);
    sp = vecsum(vp);
    if (sp % 11 == 0 && isprime(sp / 11),
        cnt++;
        vlast = vp;
    );
);
printf("%d;%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
    cnt, vlast[1], vlast[2], vlast[3], vlast[4], vlast[5], vlast[6], vlast[7], vlast[8], vlast[9], vlast[10], vlast[11]);
}
