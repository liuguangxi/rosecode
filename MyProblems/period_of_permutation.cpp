// g++ -Wall -O3 -I/usr/local/include/flint -L/usr/local/lib period_of_permutation.cpp -o period_of_permutation -lflint

#include <cstdio>
#include <cmath>
#include <ctime>
#include <nmod_poly.h>

using namespace std;


typedef long long ll;

const int M = 1000000007;
const int L = 10000;
const int P = 1000;

int Facmod[L + 1];


int modinv(int a, int m)
{
    int j = 1, i = 0, b = m, c = a, x, y;
    while (c) {
        x = b / c;    y = b - x * c;    b = c;    c = y;
        y = j;    j = i - j * x;    i = y;
    }
    if (i < 0)    i += m;
    return i;
}


void init()
{
    Facmod[0] = 1;
    for (int i = 1; i <= L; ++i) {
        ll t = (ll)Facmod[i - 1] * (ll)i % M;
        Facmod[i] = (int)t;
    }
}


int Sf(int p)
{
    ll s = 0;
    nmod_poly_t x, y;

    nmod_poly_init2(x, M, L+1);
    nmod_poly_init2(y, M, L+1);

    for (int k = 1; k <= p; ++k) {
        if (p % k == 0)    nmod_poly_set_coeff_ui(x, k, modinv(k, M));
    }
    nmod_poly_exp_series(y, x, L+1);
    for (int i = 1; i <= L; ++i) {
        ll t = (ll)nmod_poly_get_coeff_ui(y, i) * (ll)Facmod[i] % M;
        s = (s + t) % M;
    }
    printf("Sf(%d) = %d\n", p, (int)s);
    fflush(stdout);

    nmod_poly_clear(x);
    nmod_poly_clear(y);

    return s;
}


int calc()
{
    ll s = 0;
    for (int p = 1; p <= P; ++p)    s = (s + Sf(p)) % M;
    return (int)s;
}


int main()
{
    clock_t t0 = clock();

    init();
    int s = calc();
    printf("S(%d, %d) = %d\n", L, P, s);    // S(10000, 1000) = 33981364

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
