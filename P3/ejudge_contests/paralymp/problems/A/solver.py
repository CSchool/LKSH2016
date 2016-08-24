n = int(input())
l = [list(map(int, input().split())) for i in range(n)]
for k in range(n):
    for i in range(n):
        for j in range(n):
            l[i][j] = min(l[i][j], l[i][k] + l[k][j])
ans = -1
for i in range(n):
    for j in range(n):
        ans = max(ans, l[i][j])
print(ans)
