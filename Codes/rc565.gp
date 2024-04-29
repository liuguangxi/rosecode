/*
The Enumeration of Trees by Height and Diameter

s_{h+1}(x) = x / prod(p = 1, inf, (1 - x^p)^s_{p,h})

u_{2*d}(x) = s_d(x) - ((s_{d-1}(x))^2 - s_{d-1}(x^2))/2
u_{2*d+1}(x) = s_d(x) - (2*s_d(x)*s_{d-1}(x) - (s_d(x))^2 - s_{d}(x^2))/2
*/


get_sh_x(a) = {
    my(n = #a, ox = O(x^(n+1)), fx, c, b);
    c = vector(n, i, sumdiv(i, d, d * a[d]));
    b = vector(n);
    for (i = 1, n,
        b[i] = (c[i] + sum(k = 1, i - 1, c[k]*b[i-k])) / i;
    );
    fx = x * Polrev(concat([1, b])) + ox;
    return(fx);
}


{
N = 1000; D = 15;
M = 1000000007;

d = D \ 2;
shx = vector(d);
vsh = vector(N, i, Mod(i == 1, M));
for (h = 1, d,
    print("h = ", h);
    shx[h] = get_sh_x(vsh);
    vsh = vector(N, i, polcoeff(shx[h], i));
);

ox = O(x^(N+1));
shxd = shx[d];
if (d == 1, shxd1 = x, shxd1 = shx[d-1]);
if (D % 2 == 1,
    if (d == 1,
        uhx = shxd - (2*shxd*shxd1 - shxd^2 - subst(shxd, x, x^2) + ox) / 2,
        uhx = shxd - (2*shxd*shxd1 - shxd^2 - subst(shxd, x, x^2) + ox) / 2;
    ),
    uhx = shxd - (shxd1^2 - subst(shxd1, x, x^2) + ox) / 2;
);
T = lift(polcoeff(uhx, N));
printf("T(%d, %d) = %d\n", N, D, T);
}
