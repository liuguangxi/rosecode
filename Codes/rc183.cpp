#include <cstdio>
#include <cmath>
#include <ctime>

typedef long long ll;

const int M = 1000000000;
const int N = M - 1;
const int Nsqrt = 31622;


void calc()
{
    bool *isprime = new bool[Nsqrt+1];
    int *fac = new int[N+1];

    for (int i = 2; i <= Nsqrt; ++i)
        isprime[i] = true;

    for (int i = 2; i <= Nsqrt; ++i) {
        if (isprime[i]) {
            for (int j = i*2; j <= Nsqrt; j += i)
                isprime[j] = false;
        }
    }

    for (int i = 1; i <= N; ++i)
        fac[i] = i;

    for (int p = 2; p <= Nsqrt; ++p) {
        if (isprime[p]) {
            int p2 = p * p;
            ll x = p2;
            while (x <= (ll)N) {
                for (ll k = x; k <= (ll)N; k += x)
                    fac[k] /= p;
                x *= (ll)p2;
            }
        }
    }

    ll s = 0;
    for (int i = 1; i <= N; ++i)
        s += (i/2) / fac[i];
    printf("func(%d) = %lld\n", M, s);

    delete [] isprime;
    delete [] fac;
}


int main()
{
    clock_t t0 = clock();

    calc();

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
