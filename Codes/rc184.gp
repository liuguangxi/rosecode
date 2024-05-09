{
K = 2^100;
vn = List(0);
for (i = 1, 100,
    vn2 = List();
    for (j = 1, #vn,
        x = vn[j];
        for (d = 0, 9,
            dx = d * 10^(i-1) + x;
            vm = digits(dx * K % 10^i);
            if (#vm < i, next);
            vm = Set(vm);
            if (vm == [1] || vm == [2] || vm == [1, 2],
                listput(vn2, dx);
            );
        );
    );
    vn = vn2;
    listsort(vn); if (#vn > 10, vn = vn[1..10]);
);
N = vn[1] * K % 10^100 / K;
print(N);
}
