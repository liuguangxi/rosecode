/*
S(556678, 999, 12345701) mod 1000004321 = 822931683
*/


#include <bits/stdc++.h>
#include <flint/nmod.h>
#include <flint/nmod_poly.h>
#include <flint/ulong_extras.h>
using namespace std;


void solve(int B, int L, int N)
{
    const ulong M = 1000004321;
    nmod_t mod;
    ulong t1, t2;
    ulong kL1, kL;
    nmod_poly_t pol_c1, pol_s1;
    nmod_poly_t pol_cL2;
    nmod_poly_t pol_sL;
    vector<bool> isprime(N + 1);
    ulong s = 0;

    nmod_init(&mod, M);
    t1 = n_powmod2_preinv(B, L - 1, mod.n, mod.ninv);
    t1 = n_submod(t1, UWORD(1), M);
    t2 = n_submod(B, UWORD(1), M);
    t2 = n_powmod2_preinv(t2, -1, mod.n, mod.ninv);
    kL1 = n_mulmod2_preinv(t1, t2, mod.n, mod.ninv);
    t1 = n_powmod2_preinv(B, L - 1, mod.n, mod.ninv);
    kL = n_addmod(kL1, t1, M);

    nmod_poly_init2(pol_c1, M, N + 1);
    nmod_poly_init2(pol_s1, M, N + 1);
    nmod_poly_init2(pol_cL2, M, N + 1);
    nmod_poly_init2(pol_sL, M, N + 1);

    for (int i = 0; i < B; i++) {
        nmod_poly_set_coeff_ui(pol_c1, i, 1);
        nmod_poly_set_coeff_ui(pol_s1, i, i);
    }

    nmod_poly_pow_trunc(pol_cL2, pol_c1, L - 2, N + 1);
    cout << "pol_cL2 done" << endl;

    nmod_poly_scalar_mul_nmod(pol_c1, pol_c1, kL);
    t1 = n_submod(nmod_poly_get_coeff_ui(pol_c1, 0), kL1, M);
    nmod_poly_set_coeff_ui(pol_c1, 0, t1);
    nmod_poly_mullow(pol_sL, pol_c1, pol_cL2, N + 1);
    nmod_poly_mullow(pol_sL, pol_sL, pol_s1, N + 1);
    cout << "pol_sL done" << endl;

    for (int i = 2; i <= N; i++)    isprime[i] = true;
    for (int i = 2; i <= N; i++) {
        if (isprime[i]) {
            s = n_addmod(s, nmod_poly_get_coeff_ui(pol_sL, i), M);
            for (int j = i * 2; j <= N; j += i)    isprime[j] = false;
        }
    }
    flint_printf("S(%d, %d, %d) mod %wu = %wu\n", B, L, N, M, s);

    nmod_poly_clear(pol_c1);
    nmod_poly_clear(pol_s1);
    nmod_poly_clear(pol_cL2);
    nmod_poly_clear(pol_sL);
}


int main()
{
    //solve(5, 5, 11);
    //solve(56, 20, 101);
    solve(556678, 999, 12345701);

    return 0;
}
