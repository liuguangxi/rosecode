/*
Let integers x1, x2, x3 s.t. f(x1) = f(x2) = f(x3) = 0 =>
x1 + x2 + x3 = -a
x1*x2 + x2*x3 + x1*x3 = b
x1*x2*x3 = -18811938
*/


{
Vab = List();
fordiv (18811938, X1,
    fordiv (18811938 / X1, X2,
        X3 = 18811938 / X1 / X2;
        if (X1 <= X2 <= X3,
            [x1, x2, x3] = [X1, X2, -X3]; listput(Vab, [-x1-x2-x3, x1*x2 + x2*x3 + x1*x3]);
            [x1, x2, x3] = [X1, -X2, X3]; listput(Vab, [-x1-x2-x3, x1*x2 + x2*x3 + x1*x3]);
            [x1, x2, x3] = [-X1, X2, X3]; listput(Vab, [-x1-x2-x3, x1*x2 + x2*x3 + x1*x3]);
            [x1, x2, x3] = [-X1, -X2, -X3]; listput(Vab, [-x1-x2-x3, x1*x2 + x2*x3 + x1*x3]);
        );
    );
);
Vab = Set(Vab);
s = 0;
for (i = 1, #Vab,
    [a, b] = Vab[i];
    s += -1 + a - b + 18811938;
);
print(s);
}
