powp(n, p) = {
    my(s = 0);
    while (n % p == 0, s++; n /= p);
    return(s);
}


{
N = 450;
M = precprime(N);

printf("param N := %d integer;\n", N);
printf("param M := %d integer;\n", M);
print("param Minf1 := 2 integer;\n");

print("var x{1..M} >= 0, integer;\n");
print("minimize res: x[Minf1];\n");

print("s.t. sumx: sum{i in 1..M} x[i] == N;");
forprime (p = 2, M,
    printf("s.t. p%d:", p);
    forstep (i = p, M, p,
        if (i == p, 
            printf(" x[%d]", i),
            c = powp(i, p); if (c == 1, printf(" + x[%d]", i), printf(" + %d*x[%d]", c, i));
        );
    );
    printf(" == %d;\n", powp(N!, p));
);
print("s.t. zero{i in 1..Minf1-1}: x[i] == 0;\n");

print("solve;\n");

print("printf(\"[\");");
print("for {i in 1..M-1}: printf \"\%d, \", x[i]; printf \"%d\", x[M];");
print("printf(\"]\\n\");");
print("printf \"\%f\\n\", sum{i in 1..M} x[i]*i^6;\n");

print("end;");
}

\q
