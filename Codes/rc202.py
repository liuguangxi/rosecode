"""
Counts paths exactly as in the given pseudocode, but efficiently (DP instead of recursion).

Key interpretation of the pseudocode:
- Moves allowed: Right, Down, Up (no Left), and you cannot revisit a cell.
- row_max starts at 1 and is incremented by 1 on EVERY Down move (even if you've been down before).
  So row_max == ROWS  <=>  total_down_moves == ROWS - 1.
- COUNT increments whenever you are in the last column AND row_max == ROWS.

This DP computes the same COUNT for large M,N (e.g., 100x200) quickly.
"""

from __future__ import annotations
import sys
from typing import Tuple


def condensed_repr(x: int) -> str:
    s = str(x)
    if len(s) <= 20:
        return s
    return f"{s[:10]}[{len(s)-20}]{s[-10:]}"


def count_paths(M: int, N: int) -> int:
    if M <= 0 or N <= 0:
        return 0

    D = M - 1  # required number of Down moves to have row_max == M

    # dp[row][d] = number of ways to be at (row, current_col) with exactly d Down moves so far
    # row is 1..M, d is 0..D (we prune >D because it can never be counted)
    dp = [[0] * (D + 1) for _ in range(M + 1)]
    dp[1][0] = 1  # start at (1,1) with 0 Down moves

    # Transition across columns 1..N-1
    # From row r in this column, you may move vertically (monotone) to any row s, then move right.
    # Down-cost is max(0, s-r). Up-cost doesn't affect d.
    #
    # Efficient formula for dp_next[s][d]:
    #   contributions from r >= s (moving up or staying): sum_{r=s..M} dp[r][d]
    #   contributions from r < s (moving down k=s-r):    sum_{k=1..min(s-1,d)} dp[s-k][d-k]
    for _col in range(1, N):
        # suffix sums over rows for each d: suf[r][d] = sum_{x=r..M} dp[x][d]
        suf = [[0] * (D + 1) for _ in range(M + 2)]
        for d in range(D + 1):
            running = 0
            for r in range(M, 0, -1):
                running += dp[r][d]
                suf[r][d] = running

        # diagonal prefix sums: diagpref[r][d] = dp[r][d] + dp[r-1][d-1] + dp[r-2][d-2] + ...
        diagpref = [[0] * (D + 1) for _ in range(M + 1)]
        # row 1
        diagpref[1][:] = dp[1][:]
        # rows 2..M
        for r in range(2, M + 1):
            diagpref[r][0] = dp[r][0]
            prev = diagpref[r - 1]
            dprow = dp[r]
            cur = diagpref[r]
            for d in range(1, D + 1):
                cur[d] = dprow[d] + prev[d - 1]

        # build next dp
        dp_next = [[0] * (D + 1) for _ in range(M + 1)]
        # s = 1
        dp_next[1][:] = suf[1][:]
        # s = 2..M
        for s in range(2, M + 1):
            dp_next[s][0] = suf[s][0]
            diag = diagpref[s - 1]
            sufs = suf[s]
            nxt = dp_next[s]
            for d in range(1, D + 1):
                nxt[d] = sufs[d] + diag[d - 1]

        dp = dp_next

    # We're now in the last column (col == N).
    # COUNT increments each time we *arrive at a cell* in last column with d == D.
    #
    # In the last column, if you arrive with:
    # - d == D: you may continue moving Up only (Down would make d>D and stop counting),
    #           and each visited cell in last column with d==D is counted once.
    #           Starting at row r, you can go up to 1 without revisiting: contributes r counts.
    # - d < D: the only way to ever reach d==D in last column without reversing is to move
    #          Down immediately by rem=D-d steps (if within bounds). That yields exactly 1 count.
    COUNT = 0
    for r in range(1, M + 1):
        ways_r = dp[r]
        # case d == D
        COUNT += ways_r[D] * r
        # cases d < D
        for d in range(D):
            rem = D - d
            if r + rem <= M:
                COUNT += ways_r[d]

    return COUNT


def main(argv: list[str]) -> None:
    if len(argv) == 3:
        M = int(argv[1])
        N = int(argv[2])
    else:
        M, N = 100, 200  # default requested values

    ans = count_paths(M, N)
    print(f"M = {M}, N = {N}")
    print(f"COUNT = {ans}")
    print(condensed_repr(ans))


if __name__ == "__main__":
    main(sys.argv)
