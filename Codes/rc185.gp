/*
1 < a < b < c
k * (a-1)*(b-1)*(c-1) = a*b*c-1 =>
c = (a*b-1) / (k*(a-1)*(b-1) - a*b) + 1

(2,4,8)(3,5,15)
*/


{
T = 1000;
for (a = 2, T, for (b = a + 1, T,
    t = (a-1)*(b-1);
    fordiv (a*b-1, d,
        if ((d + a*b) % t == 0,
            c = (a*b-1)/d + 1;
            if (c > b,
                print([a, b, c]);
            );
        );
    );
));
}
