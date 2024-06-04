/* https://oeis.org/A001422 */


{
T = vector(5000);
for (a = 1, sqrtint(5000), T[a^2] = 1);
for (a = 1, sqrtint(5000\2),
    for (b = a + 1, sqrtint(5000 - a^2),
        t = a^2 + b^2;
        if (t > 5000, break, T[t] = 1);
    );
);
for (a = 1, sqrtint(5000\3),
    for (b = a + 1, sqrtint((5000 - a^2)\2),
        for (c = b + 1, sqrtint(5000 - a^2 - b^2),
            t = a^2 + b^2 + c^2;
            if (t > 5000, break, T[t] = 1);
        );
    );
);
for (a = 1, sqrtint(5000\4),
    for (b = a + 1, sqrtint((5000 - a^2)\3),
        for (c = b + 1, sqrtint((5000 - a^2 - b^2)\2),
            for (d = c + 1, sqrtint(5000 - a^2 - b^2 - c^2),
                t = a^2 + b^2 + c^2 + d^2;
                if (t > 5000, break, T[t] = 1);
            );
        );
    );
);
for (a = 1, sqrtint(5000\5),
    for (b = a + 1, sqrtint((5000 - a^2)\4),
        for (c = b + 1, sqrtint((5000 - a^2 - b^2)\3),
            for (d = c + 1, sqrtint((5000 - a^2 - b^2 - c^2)\2),
                for (e = d + 1, sqrtint(5000 - a^2 - b^2 - c^2 - d^2),
                    t = a^2 + b^2 + c^2 + d^2 + e^2;
                    if (t > 5000, break, T[t] = 1);
                );
            );
        );
    );
);
for (a = 1, sqrtint(5000\6),
    for (b = a + 1, sqrtint((5000 - a^2)\5),
        for (c = b + 1, sqrtint((5000 - a^2 - b^2)\4),
            for (d = c + 1, sqrtint((5000 - a^2 - b^2 - c^2)\3),
                for (e = d + 1, sqrtint((5000 - a^2 - b^2 - c^2 - d^2)\2),
                    for (f = e + 1, sqrtint(5000 - a^2 - b^2 - c^2 - d^2 - e^2),
                        t = a^2 + b^2 + c^2 + d^2 + e^2 + f^2;
                        if (t > 5000, break, T[t] = 1);
                    );
                );
            );
        );
    );
);

Count = 0; Sum = 0;
for (i = 1, 5000,
    if (T[i] == 0, Count++; Sum += i);
);
printf("%d,%d\n", Count, Sum);
}
