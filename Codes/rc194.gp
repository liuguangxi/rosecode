{
L = 641;
Pos1 = [0, 10]; Pos2 = [100, 112]; Pos3 = [200, 216];

p1 = Pos1; p2 = Pos2; p3 = Pos3;
dir1 = 1; dir2 = -1; dir3 = 1;    \\ 1:clockwise, -1:counter-clockwise
T = 0;
while (1,
    collide = 0;
    T++;
    p1 = (p1 + [dir1, dir1]) % L;
    p2 = (p2 + [dir2, dir2]) % L;
    p3 = (p3 + [dir3, dir3]) % L;

    \\ Meeting at integer time T
    if (p1[2] == (p2[1] - 1) % L,
        collide = 1; dir1 = -dir1; dir2 = -dir2,
        if (p2[2] == (p3[1] - 1) % L,
            collide = 1; dir2 = -dir2; dir3 = -dir3,
            if (p3[2] == (p1[1] - 1) % L,
                collide = 1; dir3 = -dir3; dir1 = -dir1;
            );
        );
    );

    \\ Meeting at integer+1/2 time T
    if (p1[2] == p2[1],
        collide = 1; dir1 = -dir1; dir2 = -dir2;
        p1 = (p1 + [dir1, dir1]) % L; p2 = (p2 + [dir2, dir2]) % L,
        if (p2[2] == p3[1],
            collide = 1; dir2 = -dir2; dir3 = -dir3;
            p2 = (p2 + [dir2, dir2]) % L; p3 = (p3 + [dir3, dir3]) % L,
            if (p3[2] == p1[1],
                collide = 1; dir3 = -dir3; dir1 = -dir1;
                p3 = (p3 + [dir3, dir3]) % L; p1 = (p1 + [dir1, dir1]) % L;
            );
        );
    );

    if (p1 == Pos1 && p2 == Pos2 && p3 == Pos3,
        print(T); break;
    );
);
}
