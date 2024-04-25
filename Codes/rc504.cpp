#include <iostream>

using namespace std;


const int N = 17;
const int Mmax = 9;
int Vd[N] = {0};
int Rest[Mmax + 1] = {0};
int Cnt = 0;


void dfs(int k)
{
    for (int x = 1; x <= Mmax; x++) {
        if (Rest[x] == 0)
            continue;

        bool ok = true;
        switch (k) {
        case 1:
            if (x <= Vd[0])
                ok = false;
            break;
        case 2:
            if (x <= Vd[1])
                ok = false;
            break;
        case 3:
            if (x <= Vd[2])
                ok = false;
            break;
        case 4:
            if (x < Vd[0])
                ok = false;
            break;
        case 5:
            if (x < Vd[1] || x <= Vd[4])
                ok = false;
            break;
        case 6:
            if (x < Vd[2] || x <= Vd[5])
                ok = false;
            break;
        case 7:
            if (x < Vd[3] || x <= Vd[6])
                ok = false;
            break;
        case 8:
            if (x < Vd[4])
                ok = false;
            break;
        case 9:
            if (x < Vd[5] || x <= Vd[8])
                ok = false;
            break;
        case 10:
            if (x < Vd[6] || x <= Vd[9])
                ok = false;
            break;
        case 11:
            if (x < Vd[7] || x <= Vd[10])
                ok = false;
            break;
        case 12:
            if (x < Vd[8])
                ok = false;
            break;
        case 13:
            if (x < Vd[9] || x <= Vd[12])
                ok = false;
            break;
        case 14:
            if (x < Vd[10] || x <= Vd[13])
                ok = false;
            break;
        case 15:
            if (x < Vd[12])
                ok = false;
            break;
        case 16:
            if (x < Vd[15])
                ok = false;
            break;
        default:
            break;
        }
        if (ok) {
            Vd[k] = x;
            if (k == N - 1) {
                Cnt++;
            } else {
                Rest[x]--;
                dfs(k + 1);
                Rest[x]++;
            }
        }
    }
}


void calc()
{
    Rest[1] = Rest[2] = Rest[3] = Rest[4] = Rest[5] = Rest[6] = Rest[7] = Rest[8] = 2;
    Rest[9] = 1;
    dfs(0);
    cout << Cnt << endl;
}


int main()
{
    calc();
    return 0;
}
