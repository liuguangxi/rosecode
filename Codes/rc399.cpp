#include <bits/stdc++.h>
#include <gmpxx.h>
using namespace std;


using ll = long long;

//const mpz_class T = mpz_class("24807450000000");    // N = 10^6
const mpz_class T = mpz_class("245396386000000000000000000");    // N = 10^8
constexpr int Pr[8] = {2, 3, 5, 7, 11, 13, 17, 19};
int Ve[8];
ll Cnt;
ll S;


int getsn()
{
    int maxs = 0, p, x, xx, c;
    for (int i = 0; i < 8; i++) {
        if (Ve[i] == 0)    continue;
        p = Pr[i];
        x = 0;
        c = 0;
        while (c < Ve[i]) {
            x += p;
            xx = x;
            while (xx % p == 0) {
                c++;
                xx /= p;
            }
        }
        if (x > maxs)    maxs = x;
    }
    return maxs;
}


void dfs(int k, mpz_class s)
{
    Ve[k] = 0;
    while (true) {
        if (k == 7)    S += getsn();
        else    dfs(k + 1, s);
        if (Pr[k] <= T / s) {
            s *= Pr[k];
            Ve[k]++;
        } else {
            break;
        }
    }
}


void dfscnt(int k, mpz_class s)
{
    while (true) {
        if (k == 7)    Cnt++;
        else    dfscnt(k + 1, s);
        if (Pr[k] <= T / s)    s *= Pr[k];
        else    break;
    }
}


void solve()
{
    Cnt = 0;
    dfscnt(0, 1);
    cout << "Cnt = " << Cnt << endl;

    S = 0;
    dfs(0, 1);
    cout << "Sum = " << S << endl;
}


int main()
{
    solve();
    return 0;
}
