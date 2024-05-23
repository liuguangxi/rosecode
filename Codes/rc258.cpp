/*
145581350723979994654655456542968750000000000000000000000000000
*/


#include <bits/stdc++.h>
using namespace std;


void solve()
{
    constexpr int N = 100000000;
    constexpr double Log2 = log(2.0);
    constexpr double Log3 = log(3.0);
    constexpr double Log5 = log(5.0);
    constexpr double Log7 = log(7.0);
    constexpr double Log11 = log(11.0);
    constexpr double T = 145.0;
    double p;

    vector<long double> vp;
    int i2max = (int)floor(T / Log2);
    int i3max = (int)floor(T / Log3);
    int i5max = (int)floor(T / Log5);
    int i7max = (int)floor(T / Log7);
    int i11max = (int)floor(T / Log11);
    double s2, s3, s5, s7, s11;
    int lenvp;

    for (int i2 = 0; i2 <= i2max; i2++) {
        s2 = i2 * Log2;
        if (s2 > T)    break;
        for (int i3 = 0; i3 <= i3max; i3++) {
            s3 = s2 + i3 * Log3;
            if (s3 > T)    break;
            for (int i5 = 0; i5 <= i5max; i5++) {
                s5 = s3 + i5 * Log5;
                if (s5 > T)    break;
                for (int i7 = 0; i7 <= i7max; i7++) {
                    s7 = s5 + i7 * Log7;
                    if (s7 > T)    break;
                    for (int i11 = 0; i11 <= i11max; i11++) {
                        s11 = s7 + i11 * Log11;
                        if (s11 > T)    break;
                        vp.push_back(s11);
                    }
                }
            }
        }
    }

    lenvp = (int)vp.size();
    printf("vp size = %d\n", lenvp);

    if (lenvp >= N) {
        sort(vp.begin(), vp.end());
        p = vp[N - 1];
        printf("log P(%d) = %.20f\n", N, p);

        for (int i2 = 0; i2 <= i2max; i2++) {
            s2 = i2 * Log2;
            if (s2 > T)    break;
            for (int i3 = 0; i3 <= i3max; i3++) {
                s3 = s2 + i3 * Log3;
                if (s3 > T)    break;
                for (int i5 = 0; i5 <= i5max; i5++) {
                    s5 = s3 + i5 * Log5;
                    if (s5 > T)    break;
                    for (int i7 = 0; i7 <= i7max; i7++) {
                        s7 = s5 + i7 * Log7;
                        if (s7 > T)    break;
                        for (int i11 = 0; i11 <= i11max; i11++) {
                            s11 = s7 + i11 * Log11;
                            if (s11 > T)    break;
                            if (s11 == p)
                                printf("2^%d * 3^%d * 5^%d * 7^%d * 11^%d\n", i2, i3, i5, i7, i11);
                        }
                    }
                }
            }
        }
    }
}


int main()
{
    solve();
    return 0;
}
