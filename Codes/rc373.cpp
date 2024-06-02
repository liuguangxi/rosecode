#include <bits/stdc++.h>
using namespace std;


using u8 = unsigned char;
using ll = long long;


ll calc(int t)
{
    constexpr u8 Write[2][6] = {{1, 1, 0, 1, 0, 1}, {1, 1, 1, 0, 1, 1}};
    constexpr int Move[2][6] = {{-1, 1, 1, -1, -1, -1}, {-1, 1, 1, 1, 1, -1}};
    constexpr int Next[2][6] = {{1, 2, 5, 0, 0, 4}, {0, 1, 3, 4, 2, -1}};

    vector<u8> tape(t * 3);
    u8 symbol = 0;
    int state = 0;
    int pos = t * 3 / 2;
    ll step = 0;
    int numwr1 = 0;

    while (1) {
        step++;
        if (step % 10000000 == 0)
            printf("Step = %lld    # '1' = %d\n", step, numwr1);

        u8 wr = Write[symbol][state];
        numwr1 -= symbol;
        numwr1 += wr;
        if (numwr1 == t)    break;

        tape[pos] = wr;
        pos += Move[symbol][state];
        state = Next[symbol][state];
        if (state == -1)    break;
        symbol = tape[pos];
    }

    return step;
}


void solve()
{
    constexpr int Target = 100000;
    ll s = calc(Target);
    cout << s << endl;
}


int main()
{
    solve();
    return 0;
}
