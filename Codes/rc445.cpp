#include <cstdio>
#include <cmath>
#include <ctime>
#include <vector>
#include <algorithm>

using namespace std;


typedef long long ll;


int f(int n, int p)
{
    int s = 0;
    int x = 1;
    while (x <= n / p) {
        x *= p;
        s += n / x;
    }
    return s;
}


void calc(int n)
{
    const int M = 1000000007;
    int n2 = (int)(sqrt(2.0 * n) + 0.5);
    vector<bool> isprime(n2 + 1, true);
    vector<int> prime;
    int cnt_prime;
    ll s = 0;

    for (int i = 2; i <= n2; ++i) {
        if (isprime[i]) {
            prime.push_back(i);
            for (int j = i * 2; j <= n2; j += i)    isprime[j] = false;
        }
    }
    cnt_prime = prime.size();

    for (int x = 1; x <= n; ++x) {
        ll t = 1;
        for (int i = 0; i < cnt_prime; ++i) {
            int p = prime[i];
            if (p * p > 2 * x)    break;
            int e = f(2*x, p) - 2*f(x, p);
            if (e > 1) {
                for (int k = 1; k < e; ++k) {
                    t *= (ll)p;
                    t %= M;
                }
            }
        }
        s = (s + t) % M;
    }

    printf("S(%d) = %lld\n", n, s);
}


int main()
{
    clock_t t0 = clock();

    calc(1000000);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
