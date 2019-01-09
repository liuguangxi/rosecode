// g++ -Wall -O3 -march=native -I/usr/local/include/flint -L/usr/local/lib sum_of_factorials.cpp -o sum_of_factorials -lflint

/*
S(100000000) mod 1000000000039 = 178361127949
Elapsed time is 0.203 s

S(1000000000) mod 1000000000039 = 772256701511
Elapsed time is 0.967 s

S(10000000000) mod 1000000000039 = 294122634560
Elapsed time is 4.524 s

S(100000000000) mod 1000000000039 = 639625878786
Elapsed time is 20.248 s

S(1000000000000) mod 1000000000039 = 298315653978
Elapsed time is 80.933 s

S(314159265358) mod 1000000000039 = 57745704476
Elapsed time is 43.587 s
*/

/*
Time complex: O(n^(1/2)*log(n)^2)
Let v = sqrtint(n) =>
S(n) = sum(i = 1, n, i!)
     = sum(i = 1, v^2, i!) + (v^2)! * sum(i = v^2+1, n, prod(j = v^2+1, i, j))
     = s1(v) + (v^2)! * s2(v, n)
Let p(x) = sum(i = 1, v, prod(j = 0, i-1, x+j))
    q(x) = prod(i = 0, v-1, x+i)
=>
Values pp(i) = p(v*i+1), i = 0 .. v-1
       qq(0) = 1,
       qq(1) = qq(0)*q(1) = v!,
       ...
       qq(v-1) = qq(v-2)*q((v-2)*v+1) = ((v-1)*v)!,
       qq(v) = qq(v-1)*q((v-1)*v+1) = (v^2)!.
=>
s1(v) = sum(i = 0, v-1, pp(i) * qq(i))
(v^2)! = qq(v)
*/


#include <cstdio>
#include <cmath>
#include <ctime>
#include "nmod_poly.h"
#include "ulong_extras.h"


// poly1 = (x+xs[0])*(x+xs[1])*...*(x+xs[n-1])
// poly2 = (x+xs[0]) + (x+xs[0])*(x+xs[1]) + ... + (x+xs[0])*(x+xs[1])*...*(x+xs[n-1])
void product_roots(mp_ptr poly1, mp_ptr poly2, mp_srcptr xs, slong n, nmod_t mod)
{
    if (n == 0) {
        poly1[0] = UWORD(1);
        poly2[0] = UWORD(1);
    } else if (n < 30) {
        slong i, j;
        poly1[n] = UWORD(1);
        poly1[n-1] = xs[0];
        _nmod_vec_zero(poly2, n+1);
        poly2[0] = xs[0];
        poly2[1] = UWORD(1);
        for (i = 1; i < n; ++i) {
            poly1[n-i-1] = n_mulmod2_preinv(poly1[n-i], xs[i], mod.n, mod.ninv);
            for (j = 0; j < i-1; ++j) {
                poly1[n-i+j] = nmod_add(poly1[n-i+j], n_mulmod2_preinv(poly1[n-i+j+1], xs[i], mod.n, mod.ninv), mod);
            }
            poly1[n-1] = nmod_add(poly1[n-1], xs[i], mod);
            _nmod_vec_add(poly2, poly2, poly1+n-i-1, i+2, mod);
        }
    } else {
        const slong m = (n + 1) / 2;
        mp_ptr tmp1, tmp2;
        tmp1 = _nmod_vec_init(n + 2);
        tmp2 = _nmod_vec_init(n + 2);
        product_roots(tmp1, tmp2, xs, m, mod);
        product_roots(tmp1+m+1, tmp2+m+1, xs+m, n-m, mod);
        _nmod_poly_mul(poly1, tmp1, m+1, tmp1+m+1, n-m+1, mod);
        _nmod_poly_mul(poly2, tmp1, m+1, tmp2+m+1, n-m+1, mod);
        _nmod_vec_add(poly2, poly2, tmp2, m+1, mod);
        _nmod_vec_clear(tmp1);
        _nmod_vec_clear(tmp2);
    }
}


ulong calc(ulong n, ulong p)
{
    nmod_t mod;
    ulong v, t;
    mp_ptr pol_p_xs, pol_p_ys, pol_p;
    mp_ptr pol_q_xs, pol_q_ys, pol_q;
    ulong s1, s2, s;


    nmod_init(&mod, p);
    v = n_sqrt(n);
    pol_p_xs = _nmod_vec_init(v + 1);
    pol_p_ys = _nmod_vec_init(v + 1);
    pol_p = _nmod_vec_init(v + 1);
    pol_q_xs = _nmod_vec_init(v + 1);
    pol_q_ys = _nmod_vec_init(v + 1);
    pol_q = _nmod_vec_init(v + 1);


    for (ulong i = 0; i <= v; ++i)    pol_p_xs[i] = n_mod2_preinv(i, mod.n, mod.ninv);
    product_roots(pol_q, pol_p, pol_p_xs, v, mod);

    for (ulong i = 0; i < v; ++i)
        pol_p_xs[i] = n_mod2_preinv(i * v + 1, mod.n, mod.ninv);
    _nmod_poly_evaluate_nmod_vec(pol_p_ys, pol_p, v+1, pol_p_xs, v, mod);

    for (ulong i = 0; i <= v; ++i)
        pol_q_xs[i] = n_mod2_preinv((i - 1) * v + 1, mod.n, mod.ninv);
    _nmod_poly_evaluate_nmod_vec(pol_q_ys, pol_q, v+1, pol_q_xs, v+1, mod);

    pol_q_ys[0] = UWORD(1);
    for (ulong i = 1; i <= v; ++i)
        pol_q_ys[i] = n_mulmod2_preinv(pol_q_ys[i], pol_q_ys[i-1], mod.n, mod.ninv);


    s1 = UWORD(0);
    for (ulong i = 0; i < v; ++i) {
        t = n_mulmod2_preinv(pol_p_ys[i], pol_q_ys[i], mod.n, mod.ninv);
        s1 = n_addmod(s1, t, p);
    }
    s2 = UWORD(0);
    t = UWORD(1);
    for (ulong i = v * v + 1; i <= n; ++i) {
        t = n_mulmod2_preinv(t, i, mod.n, mod.ninv);
        s2 = n_addmod(s2, t, p);
    }
    s2 = n_mulmod2_preinv(s2, pol_q_ys[v], mod.n, mod.ninv);
    s = n_addmod(s1, s2, p);
    
    
    _nmod_vec_clear(pol_p_xs);
    _nmod_vec_clear(pol_p_ys);
    _nmod_vec_clear(pol_p);
    _nmod_vec_clear(pol_q_xs);
    _nmod_vec_clear(pol_q_ys);
    _nmod_vec_clear(pol_q);

    return s;
}


int main()
{
    clock_t t0 = clock();

    ulong n = UWORD(314159265358);
    ulong p = UWORD(1000000000039);
    ulong s = calc(n, p);
    flint_printf("S(%wd) mod %wd = %wd\n", n, p, s);

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
