import math
from collections import defaultdict

def prod(iterable):
    p = 1
    for x in iterable:
        p *= x
    return p

def hook_length_formula(partition):
    # partition is a list of parts, e.g., [21, 13, 8, 5, 3]
    # m = sum(partition)
    # Number of rows
    n_rows = len(partition)
    # Hook lengths
    # For a box at (i, j) (0-indexed), h_ij = (partition[i] - i) + (partition[j] - j) ?
    # No, h_ij = (number of cells in row i to right) + (number of cells in col j below) + 1
    # h_ij = (lambda_i - j) + (lambda_j' - i) + 1
    # where lambda' is the conjugate.

    # Compute conjugate
    conj = []
    if not partition:
        return 1
    for c in range(partition[0]):
        count = 0
        for r in range(n_rows):
            if partition[r] > c:
                count += 1
            else:
                break
        conj.append(count)

    hooks = []
    for r in range(n_rows):
        for c in range(partition[r]):
            # h_rc = (partition[r] - (c+1)) + (conj[c] - (r+1)) + 1
            # indices in formula usually 1-based?
            # using 0-based:
            # right boxes: partition[r] - 1 - c
            # down boxes: conj[c] - 1 - r
            h = (partition[r] - 1 - c) + (conj[c] - 1 - r) + 1
            hooks.append(h)

    m = sum(partition)
    # Factorial m
    fact_m = math.factorial(m)
    prod_h = prod(hooks)

    return fact_m // prod_h

def get_distributions(capacities, target):
    # Distribute 'target' items into buckets with 'capacities'
    # yield list of amounts added [x0, x1, ...]
    n = len(capacities)

    def backtrack(index, current_target):
        if index == n:
            if current_target == 0:
                yield []
            return

        # Optimization: check if possible
        # remaining capacity
        rem_cap = sum(capacities[index:])
        if rem_cap < current_target:
            return

        # Max we can put here
        limit = min(capacities[index], current_target)
        # Min we must put here?
        # remaining needed: current_target
        # remaining capacity after this: rem_cap - capacities[index]
        # if current_target > rem_cap_after, we must take at least current_target - rem_cap_after
        rem_after = sum(capacities[index+1:])
        min_val = max(0, current_target - rem_after)

        for val in range(min_val, limit + 1):
            for res in backtrack(index + 1, current_target - val):
                yield [val] + res

    return backtrack(0, target)

def solve_kostka(lambda_shape, content):
    # lambda_shape: tuple
    # content: list of ints

    # Current shapes: {shape_tuple: count}
    # Initial shape: (0, 0, 0, 0, 0) assuming len(lambda_shape) is 5
    n = len(lambda_shape)
    current_shapes = {tuple([0]*n): 1}

    for b in content:
        next_shapes = defaultdict(int)
        for nu, count in current_shapes.items():
            # Calculate capacities for horizontal strip
            # nu_i <= rho_i <= min(lambda_i, nu_{i-1})
            # Let x_i = rho_i - nu_i
            # 0 <= x_i <= min(lambda_i, nu_{i-1}) - nu_i
            # Note: nu_{-1} = infinity

            caps = []
            for i in range(n):
                upper = lambda_shape[i]
                if i > 0:
                    upper = min(upper, nu[i-1])

                cap = upper - nu[i]
                caps.append(cap)

            # Sum of caps must be >= b for solution to exist
            if sum(caps) < b:
                continue

            # Find distributions
            # Since n is small (5), we can do simple recursion
            # distributions of b into caps

            # Custom distribution generator
            # We need to yield x vector

            # To avoid creating a new list of caps every time, we could optimize, but Python is fast enough

            stack = [(0, b, ())] # index, rem_b, partial_x

            # Iterative DFS for distribution to avoid recursion depth issues if any (unlikely)
            # Or just use the generator

            # Using the generator defined above
            for x in get_distributions(caps, b):
                # Construct rho
                rho = tuple(nu[i] + x[i] for i in range(n))
                next_shapes[rho] += count

        current_shapes = next_shapes
        # print(f"Processed content {b}, num shapes: {len(current_shapes)}")

    return current_shapes.get(tuple(lambda_shape), 0)

# Define inputs
p = [21, 13, 8, 5, 3]
c1 = [1]*50
c2 = [2]*25
c3 = [3]*16 + [2]
c4 = [4]*12 + [2]
c5 = [5]*10

# Calculate K(p, c1) via hook length
k_c1 = hook_length_formula(p)

# Calculate others via iterative Pieri
k_c2 = solve_kostka(p, c2)
k_c3 = solve_kostka(p, c3)
k_c4 = solve_kostka(p, c4)
k_c5 = solve_kostka(p, c5)

print(f"{k_c1=}")
print(f"{k_c2=}")
print(f"{k_c3=}")
print(f"{k_c4=}")
print(f"{k_c5=}")
print(f"{k_c1},{k_c2},{k_c3},{k_c4},{k_c5}")
