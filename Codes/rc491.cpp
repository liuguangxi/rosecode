/*
x^2 + 13*x*y + y^2 = z^2 =>
(x, y, z) = (n*(2*m+13*n), (m-n)*(m+n), m^2+13*m*n+n^2)/g
where 0 < n < m, gcd(m, n) = 1, (m-n) % 15 != 0
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include <set>
#include <utility>
#include <algorithm>

using namespace std;


typedef long long ll;


ll gcd(ll a, ll b)
{
    ll r;
    while (b > 0) {
        r = a % b;    a = b;    b = r;
    }
    return a;
}


// floor(x^(1/2)), x > 0
int sqrtint(ll x)
{
    ll r = (int)sqrt((double)x - 0.1);
    while (r * r <= x)    ++r;
    return (int)(r - 1);
}


void calc(int lim)
{
    set<pair<int, int>> sol;
    int nmax = (int)sqrt(lim*11/3.);
    for (int n = 1; n <= nmax; ++n) {
        int mmax = sqrtint(55*lim + n*n);
        for (int m = n + 1; m <= mmax; ++m) {
            if ((m - n) % 15 == 0)    continue;
            if (gcd(m, n) != 1)    continue;
            ll x = (ll)n * (ll)(2*m+13*n);
            ll y = (ll)(m - n) * (ll)(m + n);
            ll g = gcd(x, y);
            x /= g;    y /= g;
            if (x > y)    swap(x, y);
            if (y < lim)    sol.insert(make_pair((int)x, (int)y));
        }
    }

    int cnt = 0;
    ll sx = 0, sy = 0, sz = 0;
    for (set<pair<int, int>>::const_iterator iter = sol.begin(); iter != sol.end(); ++iter) {
        ++cnt;
        ll x = iter->first;
        ll y = iter->second;
        ll z = sqrtint(x*x + 13*x*y + y*y);
        sx += x;    sy += y;    sz += z;
    }
    printf("%d,%lld,%lld,%lld\n", cnt, sx, sy, sz);
}


int main()
{
    clock_t t0 = clock();

    const int T = 10000000;
    calc(T);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
