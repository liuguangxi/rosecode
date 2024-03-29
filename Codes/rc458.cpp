#include <cstdio>
#include <cmath>
#include <cstring>
#include <ctime>
#include <algorithm>

using namespace std;


typedef signed char s8;
typedef long long ll;


const int M = 1000000007;
const int N = 50000000;
const int Npi = 3001134;    // PrimePi(N)

bool isprime[N + 1];
int prime[Npi];
int phi[N + 1];
s8 mu[N + 1];
ll f[N + 1];


void init()
{
    int tot = 0;
    memset(isprime, false, sizeof(isprime));
    phi[1] = 1;
    mu[1] = 1;
    for (int i = 2; i <= N; ++i) {
        if (!isprime[i]) {
            prime[tot++] = i;
            phi[i] = i - 1;
            mu[i] = -1;
        }
        for (int j = 0; j < tot; ++j) {
            if (i * prime[j] > N)    break;
            isprime[i * prime[j]] = true;
            if (i % prime[j] == 0) {
                phi[i * prime[j]] = phi[i] * prime[j];
                mu[i * prime[j]] = 0;
            } else {
                phi[i * prime[j]] = phi[i] * (prime[j] - 1);
                mu[i * prime[j]] = -mu[i];
            }
        }
    }

    // f[m] = sum(i = 1, N\m, phi(m*i))
    for (int m = 1; m <= N; ++m) {
        ll s = 0;
        for (int k = m; k <= N; k += m)
            s += phi[k];
        f[m] = s;
    }
}


void calc()
{
    int s = 0;
    for (int k = 1; k <= N; ++k) {
        s8 muk = mu[k];
        if (muk == 0)    continue;
        int dmax = N / k;
        int s1 = 0;
        for (int d = 1; d <= dmax; ++d) {
            ll fkd = f[k * d];
            ll s2 = (fkd / phi[d]) % M;
            s2 = ((fkd % M) * s2) % M;
            s2 = (s2 * d) % M;
            s1 = (s1 + s2) % M;
        }
        if (muk == 1)
            s = (s + s1) % M;
        else
            s = (s - s1 + M) % M;
    }
    printf("S(%d) mod %d = %d\n", N, M, s);
}


int main()
{
    clock_t t0 = clock();

    init();
    calc();

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
