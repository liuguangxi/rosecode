#include <bits/stdc++.h>
using namespace std;


using ll = long long;
using bs = bitset<256>;

constexpr ll M = 98961651023LL;
constexpr int N = 30380400;
constexpr int LenD = 239;
int D[LenD] = {
    1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 29, 30, 36,
    40, 45, 48, 50, 54, 58, 60, 72, 75, 80, 87, 90, 97, 100, 108, 116, 120, 135, 144, 145,
    150, 174, 180, 194, 200, 216, 225, 232, 240, 261, 270, 290, 291, 300, 348, 360, 388, 400, 432, 435,
    450, 464, 485, 522, 540, 580, 582, 600, 675, 696, 720, 725, 776, 783, 870, 873, 900, 970, 1044, 1080,
    1160, 1164, 1200, 1305, 1350, 1392, 1450, 1455, 1552, 1566, 1740, 1746, 1800, 1940, 2088, 2160, 2175, 2320, 2328, 2425,
    2610, 2619, 2700, 2813, 2900, 2910, 3132, 3480, 3492, 3600, 3880, 3915, 4176, 4350, 4365, 4656, 4850, 5220, 5238, 5400,
    5626, 5800, 5820, 6264, 6525, 6960, 6984, 7275, 7760, 7830, 8439, 8700, 8730, 9700, 10440, 10476, 10800, 11252, 11600, 11640,
    12528, 13050, 13095, 13968, 14065, 14550, 15660, 16878, 17400, 17460, 19400, 19575, 20880, 20952, 21825, 22504, 23280, 25317, 26100, 26190,
    28130, 29100, 31320, 33756, 34800, 34920, 38800, 39150, 41904, 42195, 43650, 45008, 50634, 52200, 52380, 56260, 58200, 62640, 65475, 67512,
    69840, 70325, 75951, 78300, 84390, 87300, 101268, 104400, 104760, 112520, 116400, 126585, 130950, 135024, 140650, 151902, 156600, 168780, 174600, 202536,
    209520, 210975, 225040, 253170, 261900, 281300, 303804, 313200, 337560, 349200, 379755, 405072, 421950, 506340, 523800, 562600, 607608, 632925, 675120, 759510,
    843900, 1012680, 1047600, 1125200, 1215216, 1265850, 1519020, 1687800, 1898775, 2025360, 2531700, 3038040, 3375600, 3797550, 5063400, 6076080, 7595100, 10126800, 15190200
};
bs a[N + 1];


void solve()
{
    int kmax = 0;
    for (int i = LenD - 1; i >= 0; i--) {
        int x = D[i];
        int km = min(kmax, N - x);
        for (int k = km; k >= 0; k--) {
            if (k > 0 && a[k].none())    continue;
            int xk = x + k;
            a[xk] = a[k];
            a[xk][i] = 1;
        }
        kmax += x;
        if (kmax > N)    kmax = N;
        printf("x = %d\n", x);
    }

    bs sel = a[N];
    ll p = 1;
    for (int i = 0; i < LenD; i++) {
        if (sel[i]) {
            int d = D[i];
            printf("%d ", d);
            p = p * d % M;
        }
    }
    printf("\n\n");
    printf("%lld\n", p);
}


int main()
{
    solve();
    return 0;
}
