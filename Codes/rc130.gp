{
default(realprecision, 100);

Eps = 1e-40;
P = 1;
for (i = 1, 7,
    x = nextprime(floor(P^2^i));
    P = x^(1/2^i) + Eps;
);
print(vector(7,i,floor(P^2^i)));
printf("%.30f\n", P);
}
