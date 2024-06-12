/*
F(10^13, 998244353) = 642466383
F(10^14, 998244353) = 25892163
*/


#include <bits/stdc++.h>
#include <atcoder/modint>
using namespace std;
using namespace atcoder;


using ll = long long;
constexpr int P = 998244353;
constexpr ll N = 10000000000000LL;
constexpr int Nsqrt = (int)sqrt((long double)N + 0.5);
using mint = static_modint<P>;
vector<mint> FactMod(P);
vector<bool> isprime(Nsqrt + 1);


void init()
{
    FactMod[0] = 1;
    for (int i = 1; i < P; i++)
        FactMod[i] = FactMod[i - 1] * i;

    for (int i = 2; i <= Nsqrt; i++)    isprime[i] = true;
    for (int i = 2; i <= Nsqrt; i++) {
        if (isprime[i]) {
            for (int j = i * 2; j <= Nsqrt; j += i)    isprime[j] = false;
        }
    }

    cout << "init done" << endl;
}


mint f(ll n)
{
    int q = n / P;
    int r = n % P;
    mint ret = mint(P - 1).pow(q) * FactMod[r];
    if (q < P)
        ret *= FactMod[q];
    else
        ret *= f(q);
    return ret;
}


void solve()
{
    init();
    cout << "Nsqrt = " << Nsqrt << endl;

    vector<int> smalls0(Nsqrt + 1);
    vector<ll> larges0(Nsqrt + 1);
    vector<mint> smalls(Nsqrt + 1);
    vector<mint> larges(Nsqrt + 1);

    for (int i = 1; i <= Nsqrt; i++) {
        smalls0[i] = i - 1;
        larges0[i] = N / i - 1;
        smalls[i] = f(i);
        larges[i] = f(N / i);
    }
    cout << "smalls/larges done" << endl;

    for (int p = 2; p <= Nsqrt; p++) {
        if (!isprime[p])    continue;
        if ((p < 5000) || (p >= 5000 && p % 100 == 1))    cout << "p = " << p << endl;
        ll q = (ll)p * (ll)p;
        int imax = min((ll)Nsqrt, N / q);
        for (int i = 1; i <= imax; i++) {
            ll d = (ll)i * (ll)p;
            if (d <= (ll)Nsqrt) {
                ll c = larges0[d] - smalls0[p - 1];
                larges0[i] -= c;
                if (p != P)    larges[i] /= mint(p).pow(c);
                larges[i] *= smalls[p - 1] / larges[d];
            } else {
                ll c = smalls0[N / d] - smalls0[p - 1];
                larges0[i] -= c;
                if (p != P)    larges[i] /= mint(p).pow(c);
                larges[i] *= smalls[p - 1] / smalls[N / d];
            }
        }
        for (int i = Nsqrt; i >= q; i--) {
            int c = smalls0[i / p] - smalls0[p - 1];
            smalls0[i] -= c;
            if (p != P)    smalls[i] /= mint(p).pow(c);
            smalls[i] *= smalls[p - 1] / smalls[i / p];
        }
    }

    cout << "F(" << N << ", " << P << ") = " << larges[1].val() << endl;
}


int main()
{
    solve();
    return 0;
}
