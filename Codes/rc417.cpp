#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr int N = 30000000;


void solve()
{
    ll s = 0;

    int dm = (int)floor(2 * sqrt((double)N));
    for (int d = 1; d <= dm; d++) {
        int xmax = min(d - 1, (N - 1) / 2);
        for (int x = 0; x <= xmax; x++) {
            ll r0 = (ll)x * (ll)x % d;
            int r = (d - (int)r0) % d;
            int Dmin = max(2 * x, x * (d - x));
            s += (N - r) / d - (Dmin - r) / d;
        }
    }

    for (int d = dm + 1; d <= N; d++) {
        if (d % 100000 == 0)    printf("d = %d\n", d);
        double t = sqrt((double)d * (double)d - 4 * N);
        int x1 = (int)floor((d - t) / 2);
        int x2 = (int)ceil((d + t) / 2);
        int xmax = min(d - 1, (N - 1) / 2);
        int x1max = min(x1, xmax);
        for (int x = 0; x <= x1max; x++) {
            ll r0 = (ll)x * (ll)x % d;
            int r = (d - (int)r0) % d;
            int Dmin = max(2 * x, x * (d - x));
            s += (N - r) / d - (Dmin - r) / d;
        }
        for (int x = x2; x <= xmax; x++) {
            ll r0 = (ll)x * (ll)x % d;
            int r = (d - (int)r0) % d;
            int Dmin = max(2 * x, x * (d - x));
            s += (N - r) / d - (Dmin - r) / d;
        }
    }

    printf("S(%d) = %lld\n", N, s);
}


int main()
{
    solve();
    return 0;
}
