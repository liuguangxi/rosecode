calc_area(p) = {
    my(s);
    s = sum(i = 1, N, p[i][1]*p[i+1][2] - p[i+1][1]*p[i][2]);
    s = abs(s) / 2;
    return(s);
}


/*
(x1, y1), (x2, y2) =>
line: (y2 - y1)*x + (x1 - x2)*y = x1*y2 - x2*y1 =>
a*x + b*y = c

two lines: a1*x + b1*y = c1, a2*x + b2*y = c2
M = [a1, b1; a2, b2], c = [c1; c2] =>
M * [x; y] = c => det(M) = a1*b2 - a2*b1
if det(M) == 0, no solution or infinity solutions
else only one solution
*/
segcross(s1, s2) = {
    my(a1, b1, c1, a2, b2, c2, detm, cc1, cc2, xc, yc, d1, d2, d3, d4);
    a1 = s1[4] - s1[2]; b1 = s1[1] - s1[3]; c1 = s1[1]*s1[4] - s1[3]*s1[2];
    a2 = s2[4] - s2[2]; b2 = s2[1] - s2[3]; c2 = s2[1]*s2[4] - s2[3]*s2[2];
    detm = a1*b2 - a2*b1;
    if (detm == 0,
        \\ two lines are parallel
        if (a1 != 0, cc1 = c1 / a1, cc1 = c1 / b1);
        if (a2 != 0, cc2 = c2 / a2, cc2 = c2 / b2);
        if (cc1 != cc2, return(0));
        d1 = [s2[1]-s1[1], s2[2]-s1[2]];
        d2 = [s2[3]-s1[1], s2[4]-s1[2]];
        if (d1 != [0, 0] && d2 != [0, 0] && d1[1]*d2[1]+d1[2]*d2[2] < 0, return(1));
        d1 = [s2[1]-s1[3], s2[2]-s1[4]];
        d2 = [s2[3]-s1[3], s2[4]-s1[4]];
        if (d1 != [0, 0] && d2 != [0, 0] && d1[1]*d2[1]+d1[2]*d2[2] < 0, return(1));
        return(0);
        ,
        \\ two lines cross
        xc = (-c2*b1 + c1*b2) / detm;
        yc = (c2*a1 - c1*a2) / detm;
        d1 = [s1[1]-xc, s1[2]-yc]; d2 = [s1[3]-xc, s1[4]-yc];
        d3 = [s2[1]-xc, s2[2]-yc]; d4 = [s2[3]-xc, s2[4]-yc];
        if (d1[1]*d2[1]+d1[2]*d2[2] <= 0 && d3[1]*d4[1]+d3[2]*d4[2] <= 0,
            if (d1[1]*d2[1]+d1[2]*d2[2] == 0 && d3[1]*d4[1]+d3[2]*d4[2] == 0, return(0), return(1)),
            return(0);
        );
    );
}


chk(v) = {
    my(dx, dy, pt, seg, ok, area);

    pt = vector(N + 1, i, [0, 0]);
    for (n = 1, N,
        if (n % 2 == 1,
            dx = 0; dy = n * (1 - 2*v[n]),
            dx = n * (1 - 2*v[n]); dy = 0;
        );
        pt[n + 1] = pt[n] + [dx, dy];
    );
    seg = vector(N, i, [pt[i][1], pt[i][2], pt[i+1][1], pt[i+1][2]]);

    ok = 1;
    for (i = 1, N - 1, for (j = i + 1, N,
        if (segcross(seg[i], seg[j]), ok = 0; break(2));
    ));
    if (ok,
        area = calc_area(pt);
        print("Area = ", area);
        if (area < area_min, area_min = area);
        if (area > area_max, area_max = area);
    );
}


dfs(k, acc_ns, acc_ew) = {
    my(acc_ns_new, acc_ew_new);
    for (d = 0, 1,
        vdir[k] = d;
        acc_ns_new = acc_ns; acc_ew_new = acc_ew;
        if (k % 2 == 1,
            acc_ns_new += k * (1 - 2 * d),
            acc_ew_new += k * (1 - 2 * d);
        );
        if (k == N,
            if (acc_ns_new == 0 && acc_ew_new == 0, chk(vdir)),
            dfs(k + 1, acc_ns_new, acc_ew_new);
        );
    );
}


{
N = 24;
vdir = vector(N);    \\ odd: N/S, even: E/W; 0: N/E, 1:S/W
area_min = 10^9; area_max = 0;
dfs(3, 1, 2);
printf("%d,%d\n", area_min, area_max);
}
