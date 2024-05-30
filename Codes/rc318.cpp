/*
num = 3    size = 2
num = 4    size = 7
num = 5    size = 18
num = 6    size = 60
num = 7    size = 196
num = 8    size = 704
num = 9    size = 2499
num = 10    size = 9171
num = 11    size = 33622
num = 12    size = 123888
num = 13    size = 452600
num = 14    size = 1637640
num = 15    size = 5834709
num = 16    size = 20423954

r = 5, c = 6, v1 = 31861fc7, v2 = 3e318a5e, v3 = 38fe1863, v4 = 1e94631f
 3 3 3 2 2 2 2 2
 3 3 3 3 3 3 2 2
 3 4 4 4 4 3 2 2
 3 4 1 1 4 3 2 1
 3 4 1 2 3 3 2 1
 4 4 1 2 2 2 2 1
 4 4 1 1 1 1 1 1
 4 4 4 4 4 1 1 1

r = 6, c = 6, v1 = 71861fc3, v2 = fc308249e, v3 = c3f8618e0, v4 = 792410c3f
 3 3 2 2 2 2 2 2
 3 3 3 3 3 3 2 2
 3 4 4 4 4 3 2 1
 3 4 1 1 4 3 2 1
 3 4 1 2 3 3 2 1
 3 4 1 2 2 2 2 1
 4 4 1 1 1 1 1 1
 4 4 4 4 4 4 1 1

r = 5, c = 7, v1 = 314287e87, v2 = 7c2314bc2, v3 = 70bf0a146, v4 = 21e94621f
 3 3 3 2 2 2 2 2
 3 4 3 3 3 3 3 2
 3 4 4 4 4 3 2 2
 3 4 1 1 4 3 2 1
 3 4 1 2 3 3 2 1
 4 4 1 2 2 2 2 1
 4 1 1 1 1 1 2 1
 4 4 4 4 4 1 1 1

r = 6, c = 7, v1 = 1e24408107f, v2 = 1071861fc1, v3 = 3f82040891e, v4 = 20fe1863820
 4 3 3 3 3 3 3 3
 4 4 4 4 4 4 3 1
 4 2 2 2 2 4 3 1
 4 2 1 1 2 4 3 1
 4 2 1 3 4 4 3 1
 4 2 1 3 3 3 3 1
 4 2 1 1 1 1 1 1
 2 2 2 2 2 2 2 1

r = 6, c = 7, v1 = 3c48810207f, v2 = 1041c6187f, v3 = 3f81020448f, v4 = 3f8618e0820
 3 3 3 3 3 3 3 2
 4 4 4 4 4 4 3 2
 4 1 1 1 1 4 3 2
 4 1 2 2 1 4 3 2
 4 1 2 3 4 4 3 2
 4 1 2 3 3 3 3 2
 4 1 2 2 2 2 2 2
 4 1 1 1 1 1 1 1

3121213F07,3121217D07,13121213F03,78484040407F,7848404040FE
*/


#include <bits/stdc++.h>
using namespace std;


using u64 = unsigned long long;

struct Shape {
    u64 value;
    int row;
    int col;
};

struct ShapeLess {
    bool operator() (const Shape& lhs, const Shape& rhs) const {
        if (lhs.value != rhs.value)
            return lhs.value < rhs.value;
        else if (lhs.row != rhs.row)
            return lhs.row < rhs.row;
        else
            return lhs.col < rhs.col;
    }
};

set<Shape, ShapeLess> set_shape, set_shape_new;


void print_shape(const Shape& s)
{
    u64 v = s.value;
    int r = s.row;
    int c = s.col;
    static int m[8][8] = {{0}};
    int k = 0;

    for (int i = 7; i >= 8 - r; i--)
        for (int j = 7; j >= 8 - c; j--)
            m[i][j] = (v & (1ULL << (k++))) ? 1 : 0;

    printf("\n");
    for (int i = 8 - r; i < 8; i++) {
        for (int j = 8 - c; j < 8; j++)    printf(" %c", m[i][j] ? '#' : ' ');
        printf("\n");
    }
    printf("\n");
}


void print_cover(u64 x1, u64 x2, u64 x3, u64 x4)
{
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            u64 mask = (1ULL << ((7-i)*8+(7-j)));
            if (x1 & mask)    printf(" 1");
            else if (x2 & mask)    printf(" 2");
            else if (x3 & mask)    printf(" 3");
            else    printf(" 4");
        }
        printf("\n");
    }
    printf("\n");
}


Shape min_pre(const Shape& s)
{
    u64 v = s.value;
    int r = s.row;
    int c = s.col;
    Shape smin;
    u64 v2 = 0, v3 = 0, v4 = 0;

    // Anti-clock rotate 90 degrees
    for (int i = 0; i < r; i++)
        for (int j = 0; j < c; j++)
            if (v & (1ULL << (i*c+j)))    v2 |= (1ULL << ((c-1-j)*r+i));

    // Anti-clock rotate 180 degrees
    for (int i = 0; i < r; i++)
        for (int j = 0; j < c; j++)
            if (v & (1ULL << (i*c+j)))    v3 |= (1ULL << ((r-1-i)*c+(c-1-j)));

    // Anti-clock rotate 270 degrees
    for (int i = 0; i < r; i++)
        for (int j = 0; j < c; j++)
            if (v & (1ULL << (i*c+j)))    v4 |= (1ULL << (j*r+(r-1-i)));

    // Get minimal presentation
    if (r < c) {
        smin.value = min(v, v3);
        smin.row = r;    smin.col = c;
    } else if (r > c) {
        smin.value = min(v2, v4);
        smin.row = c;    smin.col = r;
    } else {
        smin.value = min(min(v, v3), min(v2, v4));
        smin.row = r;    smin.col = c;
    }
    return smin;
}


void gen_shape()
{
    Shape s, s_new;
    set<Shape, ShapeLess>::const_iterator iter;
    u64 v;
    int r, c;

    s.value = 0x3ULL;    s.row = 1;    s.col = 2;
    set_shape.insert(s);

    for (int num = 3; num <= 16; num++) {
        for (iter = set_shape.begin(); iter != set_shape.end(); iter++) {
            s = *iter;
            v = s.value;    r = s.row;    c = s.col;

            for (int i = 0; i < r; i++) {
                for (int j = 0; j < c; j++) {
                    if ((v & (1ULL << (i*c+j))) == 0)    continue;

                    // Left
                    if (j == c - 1) {
                        if (c < 8) {
                            s_new.value = 0;
                            u64 mask = (1ULL << c) - 1ULL;
                            for (int k = 0; k < r; k++)
                                s_new.value |= ((v >> (k*c)) & mask) << (k*(c+1));
                            s_new.value |= (1ULL << (i*(c+1)+(j+1)));
                            s_new.row = r; s_new.col = c + 1;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    } else {
                        if ((v & (1ULL << (i*c+j+1))) == 0) {
                            s_new.value = v | (1ULL << (i*c+j+1));
                            s_new.row = r;    s_new.col = c;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    }

                    // Right
                    if (j == 0) {
                        if (c < 8) {
                            s_new.value = 0;
                            u64 mask = (1ULL << c) - 1ULL;
                            for (int k = 0; k < r; k++)
                                s_new.value |= ((v >> (k*c)) & mask) << (k*(c+1)+1);
                            s_new.value |= (1ULL << (i*(c+1)));
                            s_new.row = r; s_new.col = c + 1;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    } else {
                        if ((v & (1ULL << (i*c+j-1))) == 0) {
                            s_new.value = v | (1ULL << (i*c+j-1));
                            s_new.row = r;    s_new.col = c;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    }

                    // Up
                    if (i == r - 1) {
                        if (r < 8) {
                            s_new.value = v;
                            s_new.value |= (1ULL << ((i+1)*c+j));
                            s_new.row = r + 1; s_new.col = c;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    } else {
                        if ((v & (1ULL << ((i+1)*c+j))) == 0) {
                            s_new.value = v | (1ULL << ((i+1)*c+j));
                            s_new.row = r;    s_new.col = c;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    }

                    // Down
                    if (i == 0) {
                        if (r < 8) {
                            s_new.value = v << c;
                            s_new.value |= (1ULL << j);
                            s_new.row = r + 1; s_new.col = c;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    } else {
                        if ((v & (1ULL << ((i-1)*c+j))) == 0) {
                            s_new.value = v | (1ULL << ((i-1)*c+j));
                            s_new.row = r;    s_new.col = c;
                            set_shape_new.insert(min_pre(s_new));
                        }
                    }
                }
            }
        }

        set_shape = set_shape_new;
        set_shape_new.clear();
        printf("num = %d    size = %d\n", num, (int)set_shape.size());
    }
    printf("\n");
}


u64 cut_num(const Shape& s)
{
    static const u64 MaskB = (1ULL << 32) | (1ULL << 33) | (1ULL << 34) | (1ULL << 35);

    u64 v1 = s.value, v2 = 0, v3 = 0, v4 = 0, v;
    int r = s.row;
    int c = s.col;
    vector<u64> vs;
    int len;
    u64 cov1, cov2, cov3;
    u64 min_num = 0xffffffffffffffffULL;

    // Generate all possible positions and shapes
    for (int i = 0; i < r; i++)    for (int j = 0; j < c; j++)    if (v1 & (1ULL << (i*c+j)))    v2 |= (1ULL << ((c-1-j)*r+i));
    for (int i = 0; i < r; i++)    for (int j = 0; j < c; j++)    if (v1 & (1ULL << (i*c+j)))    v3 |= (1ULL << ((r-1-i)*c+(c-1-j)));
    for (int i = 0; i < r; i++)    for (int j = 0; j < c; j++)    if (v1 & (1ULL << (i*c+j)))    v4 |= (1ULL << (j*r+(r-1-i)));

    // v1
    for (int j = 0; j <= 8 - c; j++) {    // column offset
        v = 0;
        u64 mask = (1ULL << c) - 1ULL;
        for (int k = 0; k < r; k++)    v |= (((v1 >> (k*c)) & mask) << (k*8+j));
        for (int i = 0; i <= 8 - r; i++)    // row offset
            vs.push_back(v << (i*8));
    }

    // v2
    if ((r != c) || (r == c && v2 != v1)) {
        for (int j = 0; j <= 8 - r; j++) {    // column offset
            v = 0;
            u64 mask = (1ULL << r) - 1ULL;
            for (int k = 0; k < c; k++)    v |= (((v2 >> (k*r)) & mask) << (k*8+j));
            for (int i = 0; i <= 8 - c; i++)    // row offset
                vs.push_back(v << (i*8));
        }
    }

    // v3
    if ((v3 != v1) && ((r != c) || (r == c && v3 != v2))) {
        for (int j = 0; j <= 8 - c; j++) {    // column offset
            v = 0;
            u64 mask = (1ULL << c) - 1ULL;
            for (int k = 0; k < r; k++)    v |= (((v3 >> (k*c)) & mask) << (k*8+j));
            for (int i = 0; i <= 8 - r; i++)    // row offset
                vs.push_back(v << (i*8));
        }
    }

    // v4
    if ((v4 != v2) && ((r != c) || (r == c && v4 != v1 && v4 != v3))) {
        for (int j = 0; j <= 8 - r; j++) {    // column offset
            v = 0;
            u64 mask = (1ULL << r) - 1ULL;
            for (int k = 0; k < c; k++)    v |= (((v4 >> (k*r)) & mask) << (k*8+j));
            for (int i = 0; i <= 8 - c; i++)    // row offset
                vs.push_back(v << (i*8));
        }
    }

    // Search
    len = (int)vs.size();
    for (int i1 = 0; i1 < len; i1++) {
        cov1 = vs[i1];
        if ((cov1 & 1ULL) == 0)    continue;
        for (int i2 = 0; i2 < len; i2++) {
            cov2 = vs[i2];
            if (cov1 & cov2)    continue;
            cov2 |= cov1;
            for (int i3 = i2 + 1; i3 < len; i3++) {
                cov3 = vs[i3];
                if (cov2 & cov3)    continue;
                cov3 |= cov2;
                for (int i4 = i3 + 1; i4 < len; i4++) {
                    if (cov3 & vs[i4])    continue;
                    if (((vs[i1] & MaskB) == 0) || ((vs[i2] & MaskB) == 0) || ((vs[i3] & MaskB) == 0) || ((vs[i4] & MaskB) == 0))
                        continue;
                    u64 num = min(min(vs[i1], vs[i2]), min(vs[i3], vs[i4]));
                    if (num < min_num)    min_num = num;
                    printf("r = %d, c = %d, v1 = %llx, v2 = %llx, v3 = %llx, v4 = %llx\n", r, c, v1, v2, v3, v4);
                    print_cover(vs[i1], vs[i2], vs[i3], vs[i4]);
                }
            }
        }

    }

    return (min_num < 0xffffffffffffffffULL) ? min_num : 0;
}


void cover_shape()
{
    Shape s;
    set<Shape, ShapeLess>::const_iterator iter;
    u64 num;
    vector<u64> vec_num;
    int len;

    for (iter = set_shape.begin(); iter != set_shape.end(); iter++) {
        s = *iter;
        num = cut_num(s);
        if (num)    vec_num.push_back(num);
    }

    if (!vec_num.empty()) {
        sort(vec_num.begin(), vec_num.end());
        len = (int)vec_num.size();
        for (int i = 0; i < len - 1; i++)    printf("%llX,", vec_num[i]);
        printf("%llX\n", vec_num[len-1]);
    }
}


void solve()
{
    gen_shape();
    cover_shape();
}


int main()
{
    solve();
    return 0;
}
