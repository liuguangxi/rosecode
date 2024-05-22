{
K = 50;

M = 2;
A = Mod(matrix(K, K, x, y, (x==1)*1+(x>1)*(x-y==1)), M);
fx = matdet(x * matid(K) - A);
vfx = factor(fx)[,1]~; lvfx = #vfx;
vp2 = vector(lvfx);
for (i = 1, lvfx,
    g = Mod(Mod(x, M), vfx[i]);
    p = M^poldegree(vfx[i]) - 1;
    fordiv (p, d,
        if (lift(lift(g^d)) == 1,
            vp2[i] = d;
            print("P(", lift(vfx[i]), ") = ", d);
            break;
        );
    );
);
p2_9 = lcm(vp2) * 2^8;
printf("P(%d, 2^9) = %d\n\n", K, p2_9);

M = 5;
A = Mod(matrix(K, K, x, y, (x==1)*1+(x>1)*(x-y==1)), M);
fx = matdet(x * matid(K) - A);
vfx = factor(fx)[,1]~; lvfx = #vfx;
vp5 = vector(lvfx);
for (i = 1, lvfx,
    g = Mod(Mod(x, M), vfx[i]);
    p = M^poldegree(vfx[i]) - 1;
    fordiv (p, d,
        if (lift(lift(g^d)) == 1,
            vp5[i] = d;
            print("P(", lift(vfx[i]), ") = ", d);
            break;
        );
    );
);
p5_9 = lcm(vp5) * 5^8;
printf("P(%d, 5^9) = %d\n\n", K, p5_9);

M = 10^9;
A = Mod(matrix(K, K, x, y, (x==1)*1+(x>1)*(x-y==1)), M);
fx = matdet(x * matid(K) - A);
g = Mod(Mod(x, M), fx);
p = lcm(p2_9, p5_9);
fordiv (p, d,
    if (lift(lift(g^d)) == 1,
        period = d;
        break;
    );
);
printf("P(%d, %d0) = %d\n", K, M, period);    \\ P(50, 10000000000) = 41562908435220464210100000000
}
