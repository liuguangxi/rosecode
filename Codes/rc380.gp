/*
  dir = 0    dir = 1    dir = 2    dir = 3
    <--        ---        ---       |   ^
       |      |   |      |          |   |
    ---       v   |       -->        ---

  dir = 4    dir = 5    dir = 6    dir = 7
    ---        ---        -->       ^   |
       |      |   |      |          |   |
    <--       |   v       ---        ---
*/


getxy(z) = {
    my(DirNxt, Rot, Kmax, d, x, y, xyoffset, q, dxy);

    DirNxt = [
        5, 0, 0, 7; 6, 1, 1, 4; 7, 2, 2, 5; 4, 3, 3, 6;
        3, 4, 4, 1; 0, 5, 5, 2; 1, 6, 6, 3; 2, 7, 7, 0
    ];
    Rot = [0, -1; 1, 0];
    Kmax = 60;

    d = 5;
    x = 1/2.;
    y = 1/2.;
    xyoffset = 1/4.;
    for (k = 1, Kmax,
        q = floor(z * 4);
        if (d < 4,
            dxy = xyoffset * [-1; -1]; dxy = Rot ^ ((d + q) % 4) * dxy,
            dxy = xyoffset * [-1; 1]; dxy = Rot ^ ((d - 4 - q) % 4) * dxy;
        );
        x += dxy[1,1]; y += dxy[2,1];

        z = z * 4 - q;
        xyoffset /= 2;
        d = DirNxt[d + 1, q + 1];
    );
    return([x, y]);
}


getz(x, y) = {
    my(DirNxt, Zunit, Kmax, d, pc, z, xyoffset, zoffset, q, dx, dy);

    DirNxt = [
        5, 0, 0, 7; 4, 6, 1, 1; 2, 5, 7, 2; 3, 3, 6, 4;
        1, 4, 4, 3; 0, 2, 5, 5; 6, 1, 3, 6; 7, 7, 2, 0
    ];
    Zunit = [
        -3, -1, 1, 3; 3, -3, -1, 1; 1, 3, -3, -1; -1, 1, 3, -3;
        3, 1, -1, -3; -3, 3, 1, -1; -1, -3, 3, 1; 1, -1, -3, 3
    ];
    Kmax = 30;

    d = 5;
    pc = [1/2.; 1/2.];
    z = 1/2.;
    xyoffset = 1/4.;
    zoffset = 1/8.;
    for (k = 1, Kmax,
        dx = x - pc[1,1]; dy = y - pc[2,1];
        if (dx < 0,
            if (dy < 0,
                q = 0; pc += [-xyoffset; -xyoffset],
                q = 3; pc += [-xyoffset; xyoffset];
            ),
            if (dy < 0,
                q = 1; pc += [xyoffset; -xyoffset],
                q = 2; pc += [xyoffset; xyoffset];
            );
        );
        z += zoffset * Zunit[d + 1, q + 1];

        xyoffset /= 2;
        zoffset /= 4;
        d = DirNxt[d + 1, q + 1];
    );
    return(z);
}



{
default(realprecision, 50);

z = Pi - 3;
xy = getxy(z);
printf("%.12f -> (%.12f, %.12f)\n", z, xy[1], xy[2]);

xu = exp(1) - 2; yu = Euler;
zu = getz(xu, yu);
printf("%.12f <- (%.12f, %.12f)\n", zu, xu, yu);

printf("%.10f,%.10f,%.10f\n", xy[1], xy[2], zu);
}
