#include <cstdio>
#include <cmath>
#include <ctime>
#include <algorithm>

using namespace std;


const int N = 21;
bool isprime[2*N];
int Vd[N + 1];
bool Vuse[N + 1];
int Cnt = 0;


void init()
{
    for (int i = 0; i < 2*N; ++i)    isprime[i] = (i >= 2);
    for (int i = 2; i < 2*N; ++i) {
        if (isprime[i]) {
            for (int j = i*2; j < 2*N; j += i)    isprime[j] = false;
        }
    }

    for (int i = 1; i <= N; ++i)    Vd[i] = i;
    for (int i = 1; i <= N; ++i)    Vuse[i] = false;
}


void rec(int k)
{
    for (int x = 2; x <= N - 1; ++x) {
        if (Vuse[x])    continue;
        if (!isprime[Vd[k - 1] + x])    continue;
        Vd[k] = x;
        if (k == N - 1) {
            if (isprime[x + N]) {
                ++Cnt;
                /*printf("(%d)  ", Cnt);
                for (int i = 1; i <= N; ++i)    printf("%d ", Vd[i]);
                printf("\n");*/
            }
        } else {
            Vuse[x] = true;
            rec(k + 1);
            Vuse[x] = false;
        }
    }
}


int main()
{
    clock_t t0 = clock();

    init();
    rec(2);
    printf("%d\n", Cnt);    // 5626309

    printf("Elapsed time is %.3f s\n", 1.0 * (clock() - t0)/CLOCKS_PER_SEC);

    return 0;
}
