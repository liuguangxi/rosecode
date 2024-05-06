#include <bits/stdc++.h>
using namespace std;


void solve()
{
    constexpr int Tgt = 5000;
    constexpr int L = 50000000;
    vector<int> a(L + 1);

    a[0] = 1;
    int f1 = 1, f2 = 1;
    while (f2 <= L) {
        for (int i = L; i >= f2; i--)
            a[i] += a[i - f2];
        int f3 = f1 + f2;
        f1 = f2;
        f2 = f3;
    }

    //int amax = 0;
    for (int i = 0; i <= L; i++) {
        //amax = max(amax, a[i]);
        if (a[i] == Tgt) {
            cout << i << endl;
            break;
        }
    }
    //cout << "max(a) = " << amax << endl;
}


int main()
{
    solve();
    return 0;
}
