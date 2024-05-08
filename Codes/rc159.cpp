#include <bits/stdc++.h>
using namespace std;


void solve()
{
    int a, b, c, k;
    a = 1;
    b = 1;
    k = 3;
    while (1) {
        c = (a + b) % 1000000000;
        if (c == 999999999) {
            cout << k << endl;
            break;
        }
        a = b;
        b = c;
        k++;
    }
}


int main()
{
    solve();
    return 0;
}
