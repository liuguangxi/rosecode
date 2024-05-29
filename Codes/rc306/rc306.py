m = [0]

with open("golden_rod.txt") as f:
    for line in f:
        nums = line.split()
        m.append(int(nums[1]))

L = len(m) - 1
for i in range(2, L + 1):
    for j in range(1, i // 2 + 1):
        if m[j] + m[i - j] > m[i]:
            m[i] = m[j] + m[i - j]

print(m[L])
