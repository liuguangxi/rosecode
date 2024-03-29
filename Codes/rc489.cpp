/*
F(80, 47, 13, 10) = 299047832
Elapsed time is 179.941 s
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include <algorithm>
#include <utility>
#include <vector>
#include <map>

using namespace std;


typedef long long ll;
typedef pair<pair<int, int>, int> key;

const int P = 1000000007;


int F(int N, int M, int R, int D)
{
    vector< vector<int> > TabC(N + 1, vector<int>(N + 1));
    map<key, int> mapf, mapf1;
    map<key, int>::const_iterator piter;
    int c;
    ll t;
    key keyf;
    int s = 0;

    for (int a = 0; a <= N; ++a) {
        for (int b = 0; b <= a; ++b)
            TabC[a][b] = (b == 0 || b == a) ? 1 : ((TabC[a - 1][b - 1] + TabC[a - 1][b]) % P);
    }

    for (int l = 1; l <= min(D, N - M + 1); ++l)
        mapf[make_pair(make_pair(l, l-1), 1)] = 1;

    for (int m = M - 1; m >= 1; --m) {
        printf("m = %2d    #mapf = %d\n", m, (int)mapf.size());
        mapf1.clear();
        for (piter = mapf.begin(); piter != mapf.end(); ++piter) {
            int n = piter->first.first.first;
            int p = piter->first.first.second;
            int r = piter->first.second;
            int fnpr = piter->second;
            if (fnpr == 0)    continue;

            int lmax = min(D - 1, N - m - n);
            for (int k = 0; k <= p; ++k) {
                for (int l = 0; l <= lmax; ++l) {
                    c = (k == 0) ? 0 : TabC[l+k-1][l];
                    t = (ll)fnpr * (ll)c % P;
                    keyf = make_pair(make_pair(n+l+1, k+l), r);
                    if (mapf1.count(keyf))
                        mapf1[keyf] = (mapf1[keyf] + (int)t) % P;
                    else
                        mapf1[keyf] = (int)t;

                    if (r <= R) {
                        c = (k == 0) ? 1 : ((TabC[l+k][l] - TabC[l+k-1][l] + P) % P);
                        t = (ll)fnpr * (ll)c % P;
                        keyf = make_pair(make_pair(n+l+1, k+l), r+1);
                        if (mapf1.count(keyf))
                            mapf1[keyf] = (mapf1[keyf] + (int)t) % P;
                        else
                            mapf1[keyf] = (int)t;
                    }
                }
            }

            for (int k = p + 1; k <= n; ++k) {
                for (int l = 1; l <= lmax; ++l) {
                    c = (TabC[l+k-1][l] - TabC[l+k-p-1][l] + P) % P;
                    t = (ll)fnpr * (ll)c % P;
                    keyf = make_pair(make_pair(n+l+1, k+l), r);
                    if (mapf1.count(keyf))
                        mapf1[keyf] = (mapf1[keyf] + (int)t) % P;
                    else
                        mapf1[keyf] = (int)t;

                    if (r <= R) {
                        c = (TabC[l+k][l] - TabC[l+k-1][l] + P) % P;
                        t = (ll)fnpr * (ll)c % P;
                        keyf = make_pair(make_pair(n+l+1, k+l), r+1);
                        if (mapf1.count(keyf))
                            mapf1[keyf] = (mapf1[keyf] + (int)t) % P;
                        else
                            mapf1[keyf] = (int)t;
                    }
                }
            }
        }
        mapf = mapf1;
    }


    for (piter = mapf.begin(); piter != mapf.end(); ++piter) {
        int n = piter->first.first.first;
        int r = piter->first.second;
        int fnpr = piter->second;
        if (n == N && r == R)    s = (s + fnpr) % P;
    }

    return s;
}


int main()
{
    clock_t t0 = clock();

    int n = 80, m = 47, r = 13, d = 10;
    int s = F(n, m, r, d);
    printf("F(%d, %d, %d, %d) = %d\n", n, m, r, d, s);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
