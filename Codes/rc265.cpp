#include <bits/stdc++.h>
using namespace std;


using i64 = long long;
using i128 = __int128;
constexpr i64 N = 1000000000000000000LL;


string i128_to_str(i128 x)
{
    string str;
    while (x > 0) {
        str += '0' + x % 10;
        x /= 10;
    }
    if (str.empty())    str = "0";
    reverse(str.begin(), str.end());
    return str;
}


void solve()
{
    i64 count = 0;
    i128 sumz = 0;
    int mmax = (int)pow((long double)N, 1./3);

    for (int m = 2; m <= mmax; m++) {
        if (m % 100000 == 0)    printf("m = %d\n", m);
        int cutoff = (int)(m * (sqrt(2.0) - 1.0));

        for (int n = 1; n <= cutoff; n++) {
            // 2*m*n < m^2-n^2
            if ((m + n) % 2 == 1 && __gcd(m, n) == 1) {
                i64 a = (i64)m * (i64)m - (i64)n * (i64)n;
                i64 b = 2 * (i64)m * (i64)n;
                i64 q = (i64)m * (i64)m + (i64)n * (i64)n;
                if (q > N / b)    break;
                count++;
                sumz += (i128)a * (i128)b;
            }
        }

        for (int n = m - 1; n >= cutoff + 1; n--) {
            // 2*m*n > m^2-n^2
            if ((m + n) % 2 == 1 && __gcd(m, n) == 1) {
                i64 a = (i64)m * (i64)m - (i64)n * (i64)n;
                i64 b = 2 * (i64)m * (i64)n;
                i64 q = (i64)m * (i64)m + (i64)n * (i64)n;
                if (q > N / a)    break;
                count++;
                sumz += (i128)a * (i128)b;
            }
        }
    }

    cout << count << "," << i128_to_str(sumz) << endl;    // 362728981,113541715309178510820003084
}


int main()
{
    solve();
    return 0;
}
