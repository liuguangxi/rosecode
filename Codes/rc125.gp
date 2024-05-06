{
A = 101010101; B = 303030303;
Ae = A \ 2; Ao = A - Ae;
Be = B \ 2; Bo = B - Be;
s = (Ae * Bo + Ao * Be) / (A * B);
print(s);
}
