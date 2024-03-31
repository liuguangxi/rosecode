function rc422

proc(13813);
proc(13822);
proc(13823);
proc(13824);
proc(13825);
proc(13826);
proc(13832);
proc(13842);

end


function proc(n)

d = num2str(n) - '0';
cnt = 0;
sol = [];

fprintf('[n = %d]\n', n);

% X,X,X,X,X
[c, s] = find_11111(d, n);
cnt = cnt + c;
disp(s);

% X,X,X,XX
[c, s] = find_1112(d, n);
cnt = cnt + c;
disp(s);

% X,X,XXX
[c, s] = find_113(d, n);
cnt = cnt + c;
disp(s);

% X,XX,XX
[c, s] = find_122(d, n);
cnt = cnt + c;
disp(s);

% X,XXXX
[c, s] = find_14(d, n);
cnt = cnt + c;
disp(s);

% XX,XXX
[c, s] = find_23(d, n);
cnt = cnt + c;
disp(s);

% Display summary
fprintf('# primitive factors = %d\n\n', cnt);

end


function [c, s] = find_11111(d, n)

v = unique(d(perms(1:5)), 'rows');
vd = v;

vop0 = zeros(625, 4);
for i = 1:5
    for j = 1:5
        for k = 1:5
            for m = 1:5
                vop0((i-1)*125+(j-1)*25+(k-1)*5+m, :) = [i, j, k, m];
            end
        end
    end
end
vop = [zeros(625, 2), vop0(:, 1), zeros(625, 1), vop0(:, 2), zeros(625, 1), vop0(:, 3), zeros(625, 1), vop0(:, 4);...
    zeros(625, 3), vop0(:, 1:2), zeros(625, 1), vop0(:, 3), zeros(625, 1), vop0(:, 4);...
    zeros(625, 2), vop0(:, 1), zeros(625, 2), vop0(:, 2:3), zeros(625, 1), vop0(:, 4);...
    zeros(625, 3), vop0(:, 1), zeros(625, 1), vop0(:, 2:3), zeros(625, 1), vop0(:, 4);...
    zeros(625, 4), vop0(:, 1:3), zeros(625, 1), vop0(:, 4);...
    zeros(625, 2), vop0(:, 1), zeros(625, 1), vop0(:, 2), zeros(625, 2), vop0(:, 3:4);...
    zeros(625, 3), vop0(:, 1:2), zeros(625, 2), vop0(:, 3:4);...
    zeros(625, 2), vop0(:, 1), zeros(625, 2), vop0(:, 2), zeros(625, 1), vop0(:, 3:4);...
    zeros(625, 2), vop0(:, 1), zeros(625, 3), vop0(:, 2:4);...
    zeros(625, 3), vop0(:, 1), zeros(625, 1), vop0(:, 2), zeros(625, 1), vop0(:, 3:4);...
    zeros(625, 4), vop0(:, 1:2), zeros(625, 1), vop0(:, 3:4);...
    zeros(625, 3), vop0(:, 1), zeros(625, 2), vop0(:, 2:4);...
    zeros(625, 4), vop0(:, 1), zeros(625, 1), vop0(:, 2:4);...
    zeros(625, 5), vop0];

s = [];
for i = 1:size(vd, 1)
    d = vd(i, :);
    ok = 0;
    for j = 1:size(vop, 1)
        op = vop(j, :);
        x = calc_postfix(d, op);
        if (abs(x - n) < 1e-3)
            ok = 1;
            fprintf('%s\n', print_postfix(d, op));
        end
    end
    if (ok)
        s = [s; sort(d)];
    end
    s = unique(s, 'rows');
    c = size(s, 1);
end

end


function [c, s] = find_1112(d, n)

v = unique(d(perms(1:5)), 'rows');
v = [v(:,1), v(:,2), v(:,3), v(:,4:5)*[10, 1]'];
v = unique(sort(v, 2), 'rows');
lenv = size(v, 1);
vd = zeros(lenv*24, 4);
vd(1:24:end, :) = v;
vd(2:24:end, :) = [v(:,1), v(:,2), v(:,4), v(:,3)];
vd(3:24:end, :) = [v(:,1), v(:,3), v(:,2), v(:,4)];
vd(4:24:end, :) = [v(:,1), v(:,3), v(:,4), v(:,2)];
vd(5:24:end, :) = [v(:,1), v(:,4), v(:,2), v(:,3)];
vd(6:24:end, :) = [v(:,1), v(:,4), v(:,3), v(:,2)];
vd(7:24:end, :) = [v(:,2), v(:,1), v(:,3), v(:,4)];
vd(8:24:end, :) = [v(:,2), v(:,1), v(:,4), v(:,3)];
vd(9:24:end, :) = [v(:,2), v(:,3), v(:,1), v(:,4)];
vd(10:24:end, :) = [v(:,2), v(:,3), v(:,4), v(:,1)];
vd(11:24:end, :) = [v(:,2), v(:,4), v(:,1), v(:,3)];
vd(12:24:end, :) = [v(:,2), v(:,4), v(:,3), v(:,1)];
vd(13:24:end, :) = [v(:,3), v(:,1), v(:,2), v(:,4)];
vd(14:24:end, :) = [v(:,3), v(:,1), v(:,4), v(:,2)];
vd(15:24:end, :) = [v(:,3), v(:,2), v(:,1), v(:,4)];
vd(16:24:end, :) = [v(:,3), v(:,2), v(:,4), v(:,1)];
vd(17:24:end, :) = [v(:,3), v(:,4), v(:,1), v(:,2)];
vd(18:24:end, :) = [v(:,3), v(:,4), v(:,2), v(:,1)];
vd(19:24:end, :) = [v(:,4), v(:,1), v(:,2), v(:,3)];
vd(20:24:end, :) = [v(:,4), v(:,1), v(:,3), v(:,2)];
vd(21:24:end, :) = [v(:,4), v(:,2), v(:,1), v(:,3)];
vd(22:24:end, :) = [v(:,4), v(:,2), v(:,3), v(:,1)];
vd(23:24:end, :) = [v(:,4), v(:,3), v(:,1), v(:,2)];
vd(24:24:end, :) = [v(:,4), v(:,3), v(:,2), v(:,1)];

vop0 = zeros(125, 3);
for i = 1:5
    for j = 1:5
        for k = 1:5
            vop0((i-1)*25+(j-1)*5+k, :) = [i, j, k];
        end
    end
end
vop = [zeros(125, 2), vop0(:, 1), zeros(125, 1), vop0(:, 2), zeros(125, 1), vop0(:, 3);...
    zeros(125, 2), vop0(:, 1), zeros(125, 2), vop0(:, 2:3);...
    zeros(125, 3), vop0(:, 1:2), zeros(125, 1), vop0(:, 3);...
    zeros(125, 3), vop0(:, 1), zeros(125, 1), vop0(:, 2:3);...
    zeros(125, 4), vop0];

s = [];
for i = 1:size(vd, 1)
    d = vd(i, :);
    ok = 0;
    for j = 1:size(vop, 1)
        op = vop(j, :);
        x = calc_postfix(d, op);
        if (abs(x - n) < 1e-3)
            ok = 1;
            fprintf('%s\n', print_postfix(d, op));
        end
    end
    if (ok)
        s = [s; sort(d)];
    end
    s = unique(s, 'rows');
    c = size(s, 1);
end

end


function [c, s] = find_113(d, n)

v = unique(d(perms(1:5)), 'rows');
v = [v(:,1), v(:,2), v(:,3:5)*[100, 10, 1]'];
v = unique(sort(v, 2), 'rows');
lenv = size(v, 1);
vd = zeros(lenv*6, 3);
vd(1:6:end, :) = v;
vd(2:6:end, :) = [v(:,1), v(:,3), v(:,2)];
vd(3:6:end, :) = [v(:,2), v(:,1), v(:,3)];
vd(4:6:end, :) = [v(:,2), v(:,3), v(:,1)];
vd(5:6:end, :) = [v(:,3), v(:,1), v(:,2)];
vd(6:6:end, :) = [v(:,3), v(:,2), v(:,1)];

vop0 = zeros(25, 2);
for i = 1:5
    for j = 1:5
        vop0((i-1)*5+j, :) = [i, j];
    end
end
vop = [zeros(25, 2), vop0(:, 1), zeros(25, 1), vop0(:, 2);...
    zeros(25, 3), vop0];

s = [];
for i = 1:size(vd, 1)
    d = vd(i, :);
    ok = 0;
    for j = 1:size(vop, 1)
        op = vop(j, :);
        x = calc_postfix(d, op);
        if (abs(x - n) < 1e-3)
            ok = 1;
            fprintf('%s\n', print_postfix(d, op));
        end
    end
    if (ok)
        s = [s; sort(d)];
    end
    s = unique(s, 'rows');
    c = size(s, 1);
end

end


function [c, s] = find_122(d, n)

v = unique(d(perms(1:5)), 'rows');
v = [v(:,1), v(:,2:3)*[10, 1]', v(:,4:5)*[10, 1]'];
v = unique(sort(v, 2), 'rows');
lenv = size(v, 1);
vd = zeros(lenv*6, 3);
vd(1:6:end, :) = v;
vd(2:6:end, :) = [v(:,1), v(:,3), v(:,2)];
vd(3:6:end, :) = [v(:,2), v(:,1), v(:,3)];
vd(4:6:end, :) = [v(:,2), v(:,3), v(:,1)];
vd(5:6:end, :) = [v(:,3), v(:,1), v(:,2)];
vd(6:6:end, :) = [v(:,3), v(:,2), v(:,1)];

vop0 = zeros(25, 2);
for i = 1:5
    for j = 1:5
        vop0((i-1)*5+j, :) = [i, j];
    end
end
vop = [zeros(25, 2), vop0(:, 1), zeros(25, 1), vop0(:, 2);...
    zeros(25, 3), vop0];

s = [];
for i = 1:size(vd, 1)
    d = vd(i, :);
    ok = 0;
    for j = 1:size(vop, 1)
        op = vop(j, :);
        x = calc_postfix(d, op);
        if (abs(x - n) < 1e-3)
            ok = 1;
            fprintf('%s\n', print_postfix(d, op));
        end
    end
    if (ok)
        s = [s; sort(d)];
    end
    s = unique(s, 'rows');
    c = size(s, 1);
end

end


function [c, s] = find_14(d, n)

v = unique(d(perms(1:5)), 'rows');
v = [v(:,1), v(:,2:5)*[1000, 100, 10, 1]'];
lenv = size(v, 1);
vd = zeros(lenv*2, 2);
vd(1:2:end, :) = v;
vd(2:2:end, :) = [v(:,2), v(:,1)];
vop = [zeros(5, 2), (1:5)'];

s = [];
for i = 1:size(vd, 1)
    d = vd(i, :);
    ok = 0;
    for j = 1:size(vop, 1)
        op = vop(j, :);
        x = calc_postfix(d, op);
        if (abs(x - n) < 1e-3)
            ok = 1;
            fprintf('%s\n', print_postfix(d, op));
        end
    end
    if (ok)
        s = [s; sort(d)];
    end
    s = unique(s, 'rows');
    c = size(s, 1);
end

end


function [c, s] = find_23(d, n)

v = unique(d(perms(1:5)), 'rows');
v = [v(:,1:2)*[10, 1]', v(:,3:5)*[100, 10, 1]'];
lenv = size(v, 1);
vd = zeros(lenv*2, 2);
vd(1:2:end, :) = v;
vd(2:2:end, :) = [v(:,2), v(:,1)];
vop = [zeros(5, 2), (1:5)'];

s = [];
for i = 1:size(vd, 1)
    d = vd(i, :);
    ok = 0;
    for j = 1:size(vop, 1)
        op = vop(j, :);
        x = calc_postfix(d, op);
        if (abs(x - n) < 1e-3)
            ok = 1;
            fprintf('%s\n', print_postfix(d, op));
        end
    end
    if (ok)
        s = [s; sort(d)];
    end
    s = unique(s, 'rows');
    c = size(s, 1);
end

end


function res = calc_postfix(d, op)

lend = length(d);
stk = zeros(1, lend);
pd = 0;
pstk = 0;
for k = 1:length(op)
    if (op(k) == 0)
        pd = pd + 1;
        pstk = pstk + 1;
        stk(pstk) = d(pd);
    else
        d2 = stk(pstk);
        pstk = pstk - 1;
        d1 = stk(pstk);
        switch op(k)
            case 1
                x = d1 + d2;
            case 2
                x = d1 - d2;
            case 3
                x = d1 * d2;
            case 4
                x = d1 / d2;
            case 5
                x = d1 ^ d2;
        end
        stk(pstk) = x;
    end
end
res = stk(pstk);

end


function str = print_postfix(d, op)

StrOp = '+-*/^';
str = '';
p = 0;
for k = 1:length(op)
    if (op(k) == 0)
        p = p + 1;
        str = [str, num2str(d(p)), ' '];
    else
        str = [str, StrOp(op(k)), ' '];
    end
end

end
