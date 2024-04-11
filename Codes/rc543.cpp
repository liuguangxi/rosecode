/*
P(100000000000000000, 61, 120) = 39764514016224346
*/


#include <bits/stdc++.h>
using namespace std;


using ll = long long;
using ull = unsigned long long;

constexpr ll N = 100000000000000000LL;
constexpr int A = 61;
constexpr int B = 120;

vector<int> Vx;
vector<int> Vp;
vector<pair<ull, int>> Vd;


ll gcd(ll a, ll b)
{
    ll r;
    while (b > 0) {
        r = a % b;
        a = b;
        b = r;
    }
    return a;
}


bool isprime(int n)
{
    for (int x = 2; x * x <= n; x++) {
        if (n % x == 0)    return false;
    }
    return true;
}


void dfs(int k, ull n, int sgn)
{
    int lvp = Vp.size();
    if (k < lvp - 1)    dfs(k + 1, n, sgn);
    int sgn2 = -sgn;
    ull n2 = n * (ull)Vp[k];
    if (n2 <= (ull)N) {
        Vd.emplace_back(n2, sgn2);
        if (k < lvp - 1)    dfs(k + 1, n2, sgn2);
    }
}


void init()
{
    for (int x = A; x <= B; x++) {
        if (isprime(x))
            Vp.push_back(x);
        else
            Vx.push_back(x);
    }
    Vd.emplace_back(1, 1);
    dfs(0, 1, 1);
    sort(Vd.begin(), Vd.end());
}


void solve()
{
    map<ll, int> mx;
    mx[1] = -1;
    int lvx = Vx.size();
    for (int i = 0; i < lvx; i++) {
        int x = Vx[i];
        map<ll, int> mx2(mx);
        for (const auto &kv : mx) {
            ll xi = kv.first;
            int c = kv.second;
            ll g = gcd(xi, x);
            ull xnew = (ull)xi * (ull)x / (ull)g;
            if (xnew > (ull)N)    continue;
            mx2[(ll)xnew] -= c;
        }
        swap(mx, mx2);
        cout << "x = " << x << "    #mx = " << mx.size() << endl;
    }

    ll s = 0;
    int lvd = Vd.size();
    for (const auto &kv : mx) {
        ll xi = kv.first;
        int c = kv.second;
        ll vdmax = N / xi;
        for (int i = 0; i < lvd; i++) {
            ll vdx = (ll)Vd[i].first;
            if (vdx > vdmax)    break;
            int vdc = Vd[i].second;
            ll xi2 = xi * vdx;
            if (xi2 == 1)    continue;
            s += (N / xi2) * (c * vdc);
        }
    }
    cout << "P(" << N << ", " << A << ", " << B << ") = " << s << endl;
}


int main()
{
    init();
    solve();
    return 0;
}
