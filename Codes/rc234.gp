/*
Let C(0, 1)
t(A->C) = int(1 / (sqrt(1 - x^2) * (2 + x)), -1, 0) = 2*Pi*sqrt(3)/9
t(B->C) = int(1 / (sqrt(1 - x^2) * (2 + x)), 0, 1) + (-int(1 / (sqrt(1 - x^2) * (2 + x)), 1, 0))
        = 2*Pi*sqrt(3)/9
t(A->C) = t(B->C) =>
A, B meet at C
*/


{
X = 0; Y = 1;
ET = 2*Pi*sqrt(3)/9;
printf("%.3f,%.3f,%.12f\n", X, Y, ET);
}
