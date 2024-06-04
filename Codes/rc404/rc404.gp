/*
b1^3*x^2 - b2^3*y^2 = 1
if has solution, (x1, y1), (x2, y2), ...
K = y2 / y1 - 1
x(n+2) = K * x(n+1) - x(n)
y(n+2) = K * y(n+1) - y(n)
*/


calcm(b1, b2) = {
    my(a, pq, x, y, m, sol);
    sol = List();
    a = contfrac(sqrt(b2^3/b1^3));
    pq = contfracpnqn(a, #a);
    for (i = 1, #a,
        x = pq[1,i]; y = pq[2,i];
        m = b2^3*y^2; if (m > Mmax, break);
        if (b1^3*x^2 - b2^3*y^2 == 1,
            listput(sol, m);
            printf("[%d, %d] => [%d, %d] : %d\n", b1, b2, x, y, m);
        );
    );
    return(Vec(sol));
}


{
default(realprecision, 200);
Mmax = 10^50;
Vsqf = select(x->issquarefree(x), [2..100]);
Lsqf = #Vsqf;
Vm = [];
for (i1 = 1, Lsqf, for (i2 = 1, Lsqf,
    B1 = Vsqf[i1]; B2 = Vsqf[i2];
    Vm = concat(Vm, calcm(B1, B2));
));
Vm = Set(Vm);
print("m = ", Vm);
print(Vm[11]);
}
