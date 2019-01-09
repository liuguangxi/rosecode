// g++ -Wall -O3 -march=native -I/usr/local/include/flint -L/usr/local/lib q-factorial.cpp -o q-factorial -lflint

/*
S(100000000, 7) mod 1000000000039 = 907748641844
Elapsed time is 0.202 s

S(1000000000, 7) mod 1000000000039 = 312757219658
Elapsed time is 0.483 s

S(10000000000, 7) mod 1000000000039 = 127924804433
Elapsed time is 2.262 s

S(100000000000, 7) mod 1000000000039 = 574588443857
Elapsed time is 10.186 s

S(1000000000000, 7) mod 1000000000039 = 0
Elapsed time is 41.277 s

S(123456789876, 7) mod 1000000000039 = 562794167278
Elapsed time is 11.341 s
*/

/*
S(n, q) = prod(k = 1, n, [k]_q)
n, q are positive integers, n >= 1, q > 1

S(n, q) = 1/(q - 1)^n * prod(k = 1, n, q^k - 1) = 1/(q - 1)^n * s(n, q)
Let v = sqrtint(n), sv = v*v*(v+1)/2 =>
s(n, q) = prod(k = 1, v^2, q^k - 1) * prod(k = v^2+1, n, q^k - 1)
        = q^sv * prod(i = 0, v-1, f(q^(v*i))) * prod(k = v^2+1, n, q^k - 1)
where f(x) = prod(j = 1, v, x - q^(-j))
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include "nmod_poly.h"
#include "ulong_extras.h"


ulong calc(ulong n, ulong q, ulong p)
{
    nmod_t mod;
    nmod_t mod1;
    ulong v, t, t2;
    mp_ptr pol_f_xs, pol_f_ys, pol_f;
    ulong s;


    nmod_init(&mod, p);
    nmod_init(&mod1, p - 1);
    v = n_sqrt(n);
    pol_f_xs = _nmod_vec_init(v);
    pol_f_ys = _nmod_vec_init(v);
    pol_f = _nmod_vec_init(v + 1);


    pol_f_xs[0] = n_powmod2_preinv(q, -1, mod.n, mod.ninv);
    for (ulong i = 1; i < v; ++i)
        pol_f_xs[i] = n_mulmod2_preinv(pol_f_xs[0], pol_f_xs[i - 1], mod.n, mod.ninv);
    _nmod_poly_product_roots_nmod_vec(pol_f, pol_f_xs, v, mod);

    pol_f_xs[0] = UWORD(1);
    t = n_powmod2_preinv(q, v, mod.n, mod.ninv);
    for (ulong i = 1; i < v; ++i)
        pol_f_xs[i] = n_mulmod2_preinv(t, pol_f_xs[i - 1], mod.n, mod.ninv);
    _nmod_poly_evaluate_nmod_vec(pol_f_ys, pol_f, v + 1, pol_f_xs, v, mod);


    t2 = v * (v + 1) / 2;
    t2 = n_mulmod2_preinv(t2, v, mod.n, mod.ninv);
    t = n_powmod2_preinv(q, t2, mod.n, mod.ninv);
    s = t;
    for (ulong i = 0; i < v; ++i)
        s = n_mulmod2_preinv(s, pol_f_ys[i], mod.n, mod.ninv);
    t = n_powmod2_preinv(q, v * v, mod.n, mod.ninv);
    for (ulong i = v * v + 1; i <= n; ++i) {
        t = n_mulmod2_preinv(t, q, mod.n, mod.ninv);
        t2 = n_submod(t, UWORD(1), p);
        s = n_mulmod2_preinv(s, t2, mod.n, mod.ninv);
    }
    t = n_powmod2_preinv(q - 1, n, mod.n, mod.ninv);
    t = n_powmod2_preinv(t, -1, mod.n, mod.ninv);
    s = n_mulmod2_preinv(s, t, mod.n, mod.ninv);


    _nmod_vec_clear(pol_f_xs);
    _nmod_vec_clear(pol_f_ys);
    _nmod_vec_clear(pol_f);

    return s;
}


int main()
{
    clock_t t0 = clock();

    ulong n = UWORD(123456789876);
    ulong q = UWORD(7);
    ulong p = UWORD(1000000000039);
    ulong s = calc(n, q, p);
    flint_printf("S(%wd, %wd) mod %wd = %wd\n", n, q, p, s);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
