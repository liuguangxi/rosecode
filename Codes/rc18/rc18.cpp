#include <bits/stdc++.h>
using namespace std;


ifstream in("zebra.txt");
int k, z, t;
double a, b, c, ans[50][1024], x[10], y[10], d[10][10][2];


int main()
{
    in >> z >> t >> a >> b >> c;
    for (int j = 0; j < t; j++) {
        for (int p = 0; p < z; p++)    in >> x[p] >> y[p];
        for (int p = 0; p < z; p++) {
            for (int q = p + 1; q < z; q++) {
                double dis = sqrt((x[p] - x[q]) * (x[p] - x[q]) + (y[p] - y[q]) * (y[p] - y[q]));
                d[p][q][0] = a * dis;
                d[p][q][1] = -b * dis;
            }
        }
        for (int p = 0; p < (1 << z); p++) {
            ans[j][p] = 0;
            for (int q = 0; q < z; q++) {
                for (int r = q + 1; r < z; r++) {
                    if (((p & (1 << q)) == 0) == ((p & (1 << r)) == 0))
                        ans[j][p] += d[q][r][0];
                    else
                        ans[j][p] += d[q][r][1];
                }
            }
            if (j > 0) {
                double mins = 1e50;
                for (int q = 0; q < (1 << z); q++) {
                    int n_diff = 0;
                    for (int r = (q ^ p); r > 0; r >>= 1)    n_diff += (r & 1);
                    if (ans[j - 1][q] + c * n_diff < mins)    mins = ans[j - 1][q] + c * n_diff;
                }
                ans[j][p] += mins;
            }
        }
    }

    double mins = 1e50;
    for (int j = 0; j < (1 << z); j++) {
        if (ans[t - 1][j] < mins)    mins = ans[t - 1][j];
    }
    printf("%.2f\n", mins);

    return 0;
}
