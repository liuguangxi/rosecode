/*
Point D inside equilateral triangle ABC with side length equal to t
DA = x, DB = y, DC = z =>
x^4 + y^4 + z^4 + t^4 = x^2*y^2 + x^2*z^2 + x^2*t^2 + y^2*z^2 + y^2*t^2 + z^2*t^2
0 < x <= y <= z < t, x + y > t
x^2 + x*y + y^2 >= t
A(x, y, t) + A(y, z, t) + A(z, x, t) = A(t, t, t)
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include <algorithm>

using namespace std;


typedef long long ll;


int gcd(int a, int b)
{
    int r;
    while (b > 0) {
        r = a % b;    a = b;    b = r;
    }
    return a;
}


double area(int a, int b, int c)
{
    ll area2 = (ll)(b + c - a) * (ll)(a + c - b) * (ll)(a + b - c) * (ll)(a + b + c);
    return sqrt((double)area2)/4;
}


void calc(int lim)
{
    int cnt = 0, s = 0;
    int xmax = (int)(lim / sqrt(3.0));
    for (int x = 1; x <= xmax; ++x) {
        int ymax = (int)((sqrt(4.0 * lim * lim - 3.0 * x * x) - x) / 2.0);
        for (int y = x; y <= ymax; ++y) {
            int u1 = (x + y) * (x + y);
            int u2 = (y - x) * (y - x);
            int zmax = min(lim - 1, x + y - 2);
            for (int z = y; z <= zmax; ++z) {
                int z2 = z * z;
                int p1 = u1 - z2;
                int p2 = z2 - u2;
                if (p1 % 3 != 0 && p2 % 3 != 0)    continue;
                ll k2 = 3LL * (ll)p1 * (ll)p2;
                int k = (int)(sqrt((double)k2) + 0.5);
                if ((ll)k * (ll)k != k2)    continue;
                int t2 = k + x*x + y*y + z2;
                if (t2 % 2 == 1)    continue;
                else    t2 /= 2;
                int t = (int)(sqrt((double)t2) + 0.5);
                if (t * t != t2)    continue;
                if (t > lim || t <= z || t >= x + y)    continue;
                if (gcd(gcd(x, y), gcd(z, t)) > 1)    continue;
                if (fabs(area(x, y, t) + area(y, z, t) + area(z, x, t) - area(t, t, t)) > 1e-8)    continue;
                ++cnt;
                s += x + y + z + t;
                printf("(%d)    %d  %d  %d  %d\n", cnt, x, y, z, t);
            }
        }
    }
    printf("%d,%d\n", cnt, s);
}


int main()
{
    clock_t t0 = clock();

    const int T = 5000;
    calc(T);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
