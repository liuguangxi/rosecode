/*
1 <= a, b, c, d <= T
a < c < d < b
a * b - c * d = 0 => a / c = d / b
*/


#include <bits/stdc++.h>
using namespace std;


constexpr int T = 5000;


void solve()
{
    set<int> sr;
    for (int p = 1; p <= T / 2; p++) {
        for (int q = p + 1; q <= T / 2; q++) {
            if (__gcd(p, q) > 1)    continue;
            int k = T / q;
            int p2q2 = p * p + q * q;
            for (int k1 = 1; k1 <= k - 1; k1++) {
                for (int k2 = k1 + 1; k2 <= k; k2++) {
                    if (k1 * q != k2 * p)
                        sr.insert((k1 * k1 + k2 * k2) * p2q2);
                }
            }
        }
    }
    cout << "S(" << T << ") = " << sr.size() << endl;    // S(5000) = 5617244
}


int main()
{
    solve();
    return 0;
}
