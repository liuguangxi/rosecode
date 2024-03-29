#include <cstdio>
#include <cmath>
#include <ctime>
#include <vector>
#include <iostream>
#include <algorithm>
#include <gmpxx.h>

using namespace std;


typedef long long ll;

const unsigned K = 9;
const int N = 1000000000;

vector<bool> check(N + 1);
vector<int> prime;
int lenvp;
vector<int> vc;


mpz_class mpzpow(mpz_class base, unsigned exp)
{
    mpz_class res;
    mpz_pow_ui(res.get_mpz_t(), base.get_mpz_t(), exp);
    return res;
}


int modpow(ll a, int b, int m)
{
    ll res = 1;
    while (b > 0) {
        if (b & 1)
            res = (res * a) % m;
        b >>= 1;
        a = (a * a) % m;
    }
    return (int)res;
}


void dfs(ll n, int ipmin)
{
    for (int i = ipmin; i < lenvp; i++) {
        int p = prime[i];
        ll q = (ll)p * (ll)p;
        if (n < q)
            break;
        ll nnew = n / p;
        for (int ip = i + 1; prime[ip] <= nnew; ip++)
            vc[ip]++;
        if (nnew > q)
            dfs(nnew, i + 1);
        while (1) {
            vc[i]++;
            if (nnew >= q) {
                nnew /= p;
                for (int ip = i + 1; prime[ip] <= nnew; ip++)
                    vc[ip]++;
                if (nnew > q)
                    dfs(nnew, i + 1);
            } else {
                break;
            }
        }
    }
}


void init()
{
    lenvp = 0;
    for (int i = 2; i <= N; i++) {
        if (!check[i]) {
            prime.push_back(i);
            lenvp++;
        }
        for (int j = 0; j < lenvp; j++) {
            if (i * prime[j] > N)
                break;
            check[i * prime[j]] = true;
        }
    }

    vc.resize(lenvp, 1);
    dfs(N, 0);
    cout << "init done" << endl;
}


void calc_gmp()
{
    mpz_class s = 0;
    mpz_class t = 1;
    mpz_class t2 = 0;
    for (int i = 0; i < lenvp; i++) {
        t2 = t + vc[i];
        s += prime[i] * (mpzpow(t2, K) - mpzpow(t, K));
        t = t2;
    }
    cout << "S(" << K << ", " << N << ") = " << s << endl;
}


void calc_mod()
{
    const int M = 1000000000;
    ll s = 0;
    ll t = 1;
    ll t2 = 0;
    for (int i = 0; i < lenvp; i++) {
        t2 = t + vc[i];
        ll z = (modpow(t2, K, M) - modpow(t, K, M) + M) % M;
        s = (s + prime[i] * z % M) % M;
        t = t2;
    }
    cout << "S(" << K << ", " << N << ") mod " << M << " = " << s << endl;
}


int main()
{
    clock_t t0 = clock();

    init();
    //calc_gmp();
    calc_mod();

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
