/*
Fermat point
P is a point outside triangle ABC such that triangle PAB is an equilateral
Q is a point outside triangle ABC such that triangle QBC is an equilateral
R is a point outside triangle ABC such that triangle RCA is an equilateral
*/
fermat(a, b, c) = {
    my(x, y, z, A, B, C, PC, PCB, QA, QAC, RB, RBA);
    A = acos((b^2+c^2-a^2)/(2*b*c));
    B = acos((c^2+a^2-b^2)/(2*c*a));
    C = acos((a^2+b^2-c^2)/(2*a*b));
    PC = sqrt(c^2 + a^2 - 2*c*a*cos(B+Pi/3));
    PCB = acos((a^2+PC^2-c^2)/(2*a*PC));
    x = a*sin(PCB)/sin(2/3*Pi);
    QA = sqrt(a^2 + b^2 - 2*a*b*cos(C+Pi/3));
    QAC = acos((b^2+QA^2-a^2)/(2*b*QA));
    y = b*sin(QAC)/sin(2/3*Pi);
    RB = sqrt(b^2 + c^2 - 2*b*c*cos(A+Pi/3));
    RBA = acos((c^2+RB^2-b^2)/(2*c*RB));
    z = c*sin(RBA)/sin(2/3*Pi);
    return([x, y, z]);
}


{
N = 1923;
sx = sy = sz = 0;
for (i = 1, N,
    a = sqrt(i + 1); b = sqrt(i + 2); c = sqrt(i + 3);
    [x, y, z] = fermat(sqrt(a), sqrt(b), sqrt(c));
    sx += x; sy += y; sz += z;
);
printf("%.10f,%.10f,%.10f\n", sx, sy, sz);
}
