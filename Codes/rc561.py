import sys

# Increase recursion depth just in case, though iterative BFS is used.
sys.setrecursionlimit(20000)

def solve():
    # Grid Dimensions
    NROWS = 9991
    NCOLS = 1001
    TOTAL_CELLS = NROWS * NCOLS

    # Generator Parameters
    GEN_RANGE = 10000000
    TARGET_PAINTED = 5000000

    # Use a bytearray for the grid (approx 10MB) to be memory efficient
    # 0 = Empty, 1 = Painted
    grid = bytearray(TOTAL_CELLS)

    # ---------------------------------------------------------
    # 1. Fill the Grid
    # ---------------------------------------------------------
    # Simulation of the C++ code:
    # uint32 seed = 10001;
    # while (painted < NCellsPainted) { ... }

    seed = 10001
    painted_count = 0
    MASK = 0xFFFFFFFF # Mask to simulate 32-bit unsigned integer behavior

    while painted_count < TARGET_PAINTED:
        seed = (seed * 10001 + 1001) & MASK
        idx = seed % GEN_RANGE

        # Check bounds (though GEN_RANGE < TOTAL_CELLS in this specific problem)
        if idx < TOTAL_CELLS:
            if grid[idx] == 0:
                grid[idx] = 1
                painted_count += 1

    # ---------------------------------------------------------
    # 2. Find Connected Components
    # ---------------------------------------------------------
    # We identify sets of contiguously painted cells (up, down, left, right).
    # We can modify 'grid' in place (setting to 0) to mark visited cells.

    sets = []

    for i in range(TOTAL_CELLS):
        if grid[i] == 1:
            # New component found
            # Since we iterate i from 0, this 'i' is guaranteed to be the
            # smallest index in the component.

            component_min = i
            component_size = 0
            component_sum = 0

            # BFS Queue
            q = [i]
            grid[i] = 0 # Mark as visited immediately

            head = 0
            while head < len(q):
                curr = q[head]
                head += 1

                # Update stats
                component_size += 1
                component_sum += curr

                # Check Neighbors (Up, Down, Left, Right)

                # Up
                if curr >= NCOLS:
                    nxt = curr - NCOLS
                    if grid[nxt] == 1:
                        grid[nxt] = 0
                        q.append(nxt)

                # Down
                if curr < TOTAL_CELLS - NCOLS:
                    nxt = curr + NCOLS
                    if grid[nxt] == 1:
                        grid[nxt] = 0
                        q.append(nxt)

                # Left (ensure not on first column)
                if (curr % NCOLS) > 0:
                    nxt = curr - 1
                    if grid[nxt] == 1:
                        grid[nxt] = 0
                        q.append(nxt)

                # Right (ensure not on last column)
                if (curr % NCOLS) < NCOLS - 1:
                    nxt = curr + 1
                    if grid[nxt] == 1:
                        grid[nxt] = 0
                        q.append(nxt)

            # Filter: only keep sets with more than 1 cell
            if component_size > 1:
                sets.append({
                    'min': component_min,
                    'size': component_size,
                    'sum': component_sum
                })

    # ---------------------------------------------------------
    # 3. Analyze Sets
    # ---------------------------------------------------------
    # The problem requires sets to be sorted by their smallest elements.
    # Our linear scan naturally produces this order, but we sort to be explicit.
    sets.sort(key=lambda x: x['min'])

    num_sets = len(sets)
    if num_sets == 0:
        print("0,0,0,0,0,0,0")
        return

    # Find set with maximal number of elements
    max_size = -1
    idx_max_size = -1

    # Find set with maximal sum of elements
    max_sum = -1
    idx_max_sum = -1

    for i, s in enumerate(sets):
        if s['size'] > max_size:
            max_size = s['size']
            idx_max_size = i

        if s['sum'] > max_sum:
            max_sum = s['sum']
            idx_max_sum = i

    # ---------------------------------------------------------
    # 4. Output
    # ---------------------------------------------------------
    # Format: a,b,c,d,e,f,g
    # a: number of sets
    # b: set number of set with max size (1-based)
    # c: size of that set
    # d: sum of that set
    # e: set number of set with max sum (1-based)
    # f: size of that set
    # g: sum of that set

    a = num_sets

    b = idx_max_size + 1
    c = sets[idx_max_size]['size']
    d = sets[idx_max_size]['sum']

    e = idx_max_sum + 1
    f = sets[idx_max_sum]['size']
    g = sets[idx_max_sum]['sum']

    print(f"{a},{b},{c},{d},{e},{f},{g}")

if __name__ == "__main__":
    solve()
