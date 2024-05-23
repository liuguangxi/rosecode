calcprob(k) = {
    my(p, vm, la, vpa, vpb, x, y);

    vm = List();
    la = (M + N) / (k + 1);
    if (la == floor(la),
        for (x = 0, la, if (x <= N && la - x <= M, listput(vm, [x, la - x]))),
        for (x = 0, floor(la), if (x <= N && la - x <= M, listput(vm, [x, la - x])));
        for (y = 0, floor(la), if (y <= M && la - y <= N, listput(vm, [la - y, y])));
    );

    vpa = vpb = vector(#vm);
    for (i = 1, #vm,
        x = vm[i][1]; y = vm[i][2];
        if (x == floor(x) && y == floor(y),
            vpa[i] = Npath[y+1, x+1]; vpb[i] = Npath[M-y+1, N-x+1],
            if (y != floor(y),
                vpa[i] = Npath[floor(y)+1, x+1]; vpb[i] = Npath[floor(M-y)+1, N-x+1],
                vpa[i] = Npath[y+1, floor(x)+1]; vpb[i] = Npath[M-y+1, floor(N-x)+1];
            );
        );
    );

    p = sum(i = 1, #vm, vpa[i]*vpb[i]) / (vecsum(vpa) * vecsum(vpb));
    print("p(", k, ") = ", p);
    return(p);
}


{
M = 19; N = 23;
Npath = matrix(M+1, N+1, i, j, binomial(i+j-2, i-1));
p1 = calcprob(4/3);
p2 = calcprob(6/5);
print(p1, ",", p2);
}
