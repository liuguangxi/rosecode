/*
sol(B, R) := sum(i = 1, Lbox, c_i * [nb_i, nr_i]) = [B, R]
W = sum(sol(B, R), B!*R! / prod(i = 1, Lbox, ((nb_i)!*(nr_i)!)^c_i*(c_i)!))
*/


#include <bits/stdc++.h>
using namespace std;


using ll = long long;
constexpr int Mod = 1000000007;
constexpr int B = 3141;
constexpr int R = 2718;
ll dp[2][B + 1][R + 1];


void exgcd(ll a, ll b, ll &x, ll &y)
{
    if (b == 0) {
        x = 1;
        y = 0;
        return;
    }
    exgcd(b, a % b, y, x);
    y -= a / b * x;
}


ll invmod(ll a, ll m)
{
    ll x, y;
    exgcd(a, m, x, y);
    return (x % m + m) % m;
}


void solve()
{
    vector<pair<int, int>> vbox;
    int lbox;
    for (int nb = 0; nb <= 6; nb++) {
        for (int nr = 0; nr <= 6; nr++) {
            if (nb + nr >= 2 && nb + nr <= 6 && nr >= 1 && nb <= 4)
                vbox.emplace_back(nb, nr);
        }
    }
    lbox = vbox.size();

    int lvf = max(B, R);
    vector<ll> vf(lvf + 1);
    int cur = 0, pre;
    dp[0][B][R] = 1;
    for (int i = 0; i < lbox; i++) {
        printf("i = %d\n", i);
        pre = cur;
        cur ^= 1;
        memset(dp[cur], 0, sizeof(dp[cur]));
        int box1 = vbox[i].first;
        int box2 = vbox[i].second;
        ll facbr = 1;
        for (int j = 1; j <= box1; j++) facbr *= j;
        for (int j = 1; j <= box2; j++) facbr *= j;
        vf[0] = 1;
        for (int j = 1; j <= lvf; j++) {
            vf[j] = vf[j - 1] * invmod(facbr, Mod) % Mod * invmod(j, Mod) % Mod;
        }
        for (int ib = 0; ib <= B; ib++) {
            for (int ir = 0; ir <= R; ir++) {
                if (dp[pre][ib][ir] == 0) continue;
                int cmax = min(ib / max(1, box1), ir / max(1, box2));
                for (int c = 0; c <= cmax; c++) {
                    dp[cur][ib - c * box1][ir - c * box2] = (dp[cur][ib - c * box1][ir - c * box2] + dp[pre][ib][ir] * vf[c] % Mod) % Mod;
                }
            }
        }
    }
    ll W = dp[cur][0][0];
    for (int j = 1; j <= B; j++) W = W * j % Mod;
    for (int j = 1; j <= R; j++) W = W * j % Mod;
    printf("W(%d, %d) = %lld\n", B, R, W);
}


int main()
{
    solve();
    return 0;
}
