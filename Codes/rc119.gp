sqf(n) = {
    my(fa);
    fa = factor(n);
    prod(k = 1, #fa[,1], if (fa[k,2] % 2 == 1, fa[k,1], 1));
}


getabcpq(k1, k2, k3, k4) = {
    my(A, B, C, P, Q, ABC, g, fa, gg);
    Q = sqrtint(k1 + k2);
    B = -sqrtint(k1^3 * X);
    C = sqrtint(k3^3 * Y);
    A = sqrtint(-8 * B * C);
    if (A^(1/3) - (-B)^(1/3) + C^(1/3) < 0, A = -A; B = -B; C = -C);
    ABC = vecsort([A, B, C]);
    g = gcd(ABC);
    fa = factor(g);
    P = prod(k = 1, #fa[,1], if (fa[k,2] % 3 == 0, fa[k,1]^(fa[k,2]/3), 1));
    ABC /= P^3;
    g = gcd(P, Q);
    P /= g; Q /= g;
    return([ABC[1], ABC[2], ABC[3], P, Q]);
}


{
X = 3645; Y = 2916;
SqfX = sqf(X); SqfY = sqf(Y);
for (n1 = 1, 3, for (n2 = 1, 3,
    k1 = SqfX * n1^2; k3 = SqfY * n2^2;
    m = 8 * k1 * k3;
    fordiv (m, k2,
        k4 = m / k2;
        if (k1 + k2 == k4 - k3 && k1*k2^2*X == k3*k4^2*Y && issquare(k1 + k2),
            printf("(n1, n2; k1, k2, k3, k4) = (%d, %d; %d, %d, %d, %d)\n", n1, n2, k1, k2, k3, k4);
            res = getabcpq(k1, k2, k3, k4);
            printf("(a, b, c, p, q) = (%d, %d, %d, %d, %d)\n", res[1], res[2], res[3], res[4], res[5]);
        );
    );
));

ans = "R3(2)+R3(20)-R3(25)";
print(ans);
}
