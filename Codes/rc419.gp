R0(n) = {
    if(n == 1, return(6));
    if(n == 2, return(12));
    if(n == 3, return(8));
    if(n%8 == 7, return(0));
    if(n%8 == 3, return(24*qfbclassno(-n)),  return(12*qfbclassno(-4*n)));
}


R(n) = {
    my(f, s, p, nn);
    while(n%4 == 0, n/=4);
    if(n%8 == 7, return(0));
    if(issquarefree(n), return(R0(n)));
    f = factor(n)[,1]~;
    for(i = 1, #f,
        p = f[i]; if(n%p^2 != 0, next);
        nn = n/p^2;
        if(nn%p == 0, s = (p+1)*R(nn), s = (p+1- kronecker(-nn, p))*R(nn));
        if(nn%p^2 == 0, s-=p*R(nn/p^2));
        return(s);
    );
}


{
N = 10^17; M = 100;
s = sum(n = N, N+M-1, R(n));
printf("S(%d,%d) = %d\n", N, M, s);
}
