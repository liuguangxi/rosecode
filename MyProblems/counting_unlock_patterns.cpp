#include <cmath>
#include <cstring>
#include <iostream>

using namespace std;


typedef __int128_t int128;

const int N = 5;
const int N2 = N*N;
const int NN = (1 << N2);

int must[N2][N2];
int dp[NN/2][N2];


int gcd(int a, int b)
{
    int r;
    while (b > 0) {
        r = a % b;
        a = b;
        b = r;
    }
    return a;
}


void print_int128(int128 x)
{
    int d[40];
    int i = 0;
    while (x > 0) {
        d[i++] = x % 10;
        x /= 10;
    }
    for (int k = i - 1; k >= 0; k--)
        cout << d[k];
}


void init()
{
    for (int i = 0; i < N2; i++) {
        for (int j = 0; j < N2; j++) {
            if (i == j)
                continue;
            int ix = i / N;
            int iy = i % N;
            int jx = j / N;
            int jy = j % N;
            int dx = jx - ix;
            int dy = jy - iy;
            int g = gcd(abs(dx), abs(dy));
            if (g < 2)
                continue;
            dx /= g;
            dy /= g;
            int x = ix + dx;
            int y = iy + dy;
            while (x != jx || y != jy) {
                must[i][j] |= (1 << (x*N+y));
                x += dx;
                y += dy;
            }
        }
    }
}


int calc(int mod)
{
    memset(dp, 0, sizeof(int) * (NN/2) * N2);
    for (int x = 0; x < N2; x++)
        dp[0][x] = 1;

    for (int mask = 1; mask < NN; mask++) {
        for (int i = 0; i < N2; i++) {
            if ((mask & (1 << i)) == 0)
                continue;
            int mli1 = ((1 << i) - 1);
            int mli2 = ((1 << (i + 1)) - 1);
            int maski = ((mask & (~mli2)) >> 1) | (mask & mli1);
            for (int j = 0; j < N2; j++) {
                if (mask & (1 << j))
                    continue;
                if ((must[i][j] & mask) == must[i][j]) {
                    int mlj1 = ((1 << j) - 1);
                    int mlj2 = ((1 << (j + 1)) - 1);
                    int maskj = ((mask & (~mlj2)) >> 1) | (mask & mlj1);
                    dp[maskj][j] += dp[maski][i];
                    if (dp[maskj][j] >= mod)
                        dp[maskj][j] -= mod;
                }
            }
        }
    }

    int s = 0;
    for (int mask = 0; mask < NN/2; mask++) {
        if (__builtin_popcount((unsigned)mask) < 3)
            continue;
        for (int i = 0; i < N2; i++) {
            s += dp[mask][i];
            if (s >= mod)
                s -= mod;
        }
    }
    return s;
}


void solve()
{
    init();

    int s1, s2, s3;
    s1 = calc(1000000007);
    cout << "S mod 1000000007 = " << s1 << endl;
    s2 = calc(1000000009);
    cout << "S mod 1000000009 = " << s2 << endl;
    s3 = calc(1000000021);
    cout << "S mod 1000000021 = " << s3 << endl;

    int128 m = (int128)1000000007 * (int128)1000000009 * (int128)1000000021;
    int128 s;
    s = (int128)s1 * (int128)35714286 * (int128)1000000030000000189;
    s += (int128)s2 * (int128)41666667 * (int128)1000000028000000147;
    s += (int128)s3 * (int128)922619067 * (int128)1000000016000000063;
    s %= m;
    cout << "S = ";
    print_int128(s);
    cout << endl;
}


int main()
{
    solve();

    return 0;
}
