/*
(-18, -1, 19)
(-15, -8, 17)
(-74, -25, 75)
(-1233, -652, 1291)
(-3341, -1654, 3471)
(-32820, -23949, 36615)
(-81610, -50199, 87505)
(-1, 3, 10)
(-9, 3, 12)
(-81, 48, 75)
(-1857, 1412, 1531)
(-10697, 7691, 9162)
12,-81610,-50199,87505
*/


#include <bits/stdc++.h>
using namespace std;


using i8 = signed char;
using ll = long long;

constexpr int N = 1026;
constexpr int T = 100000;
constexpr ll T3 = (ll)T * (ll)T * (ll)T;


// floor(x^(1/3)), x >= 0
int sqrt3int(ll x)
{
    if (x == 0)    return 0;
    ll r = (int)pow((double)x - 0.1, 0.333333);
    while (r * r * r <= x)    r++;
    return (int)(r - 1);
}


void solve()
{
    int Count = 0;
    int X = 0, Y = 0, Z = 0;
    int vmax = 0;
    int x, y, z;
    int xmax, ymax, zmax;

    // 0 <= x <= y <= z
    xmax = sqrt3int(N / 3);
    for (x = 0; x <= xmax; x++) {
        ymax = sqrt3int((N - x*x*x) / 2);
        for (y = x; y <= ymax; y++) {
            int z3 = N - x*x*x - y*y*y;
            z = sqrt3int(z3);
            if (z * z * z == z3) {
                Count++;
                printf("(%d, %d, %d)\n", x, y, z);
                if (z > vmax) {
                    vmax = z;
                    X = x; Y = y; Z = z;
                }
            }
        }
    }

    // -T < x < y < 0 < z < T
    ymax = sqrt3int((T3 - (ll)N) / 2);
    for (y = 1; y <= ymax; y++) {
        xmax = sqrt3int(T3 - (ll)N - (ll)y*(ll)y*(ll)y);
        for (x = y + 1; x <= xmax; x++) {
            ll z3 = (ll)N + (ll)x*(ll)x*(ll)x + (ll)y*(ll)y*(ll)y;
            z = sqrt3int(z3);
            if ((ll)z * (ll)z * (ll)z == z3) {
                Count++;
                printf("(%d, %d, %d)\n", -x, -y, z);
                if (max(x, z) > vmax) {
                    vmax = max(x, z);
                    X = -x; Y = -y; Z = z;
                }
            }
        }
    }

    // -T < x < 0 < y < z < T
    ymax = sqrt3int(((ll)N + T3) / 2);
    for (y = 1; y <= ymax; y++) {
        zmax = sqrt3int((ll)N + T3 - (ll)y*(ll)y*(ll)y);
        for (z = y + 1; z <= zmax; z++) {
            ll x3 = (ll)y*(ll)y*(ll)y + (ll)z*(ll)z*(ll)z - (ll)N;
            if (x3 < 0)    continue;
            x = sqrt3int(x3);
            if ((ll)x * (ll)x * (ll)x == x3) {
                Count++;
                printf("(%d, %d, %d)\n", -x, y, z);
                if (max(x, z) > vmax) {
                    vmax = max(x, z);
                    X = -x; Y = y; Z = z;
                }
            }
        }
    }

    // Result
    printf("%d,%d,%d,%d\n", Count, X, Y, Z);
}


int main()
{
    solve();
    return 0;
}
