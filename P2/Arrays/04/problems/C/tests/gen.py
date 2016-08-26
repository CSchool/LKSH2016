#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n, x = rnd(1, 10), rnd(1, 100)

    mtx = [[str(rnd(1, x)) for i in range(n)] for j in range(n)]

    dat.write('%d %d\n' % (n, x))
    dat.write('\n'.join(list(map(' '.join, mtx))))

    diag1 = sum([int(mtx[i][i]) for i in range(n)])
    diag2 = sum([int(mtx[i][-i-1]) for i in range(n)])
    s = diag1 + diag2
    for i in range(n):
        if (n - i ==  i): 
            s = s - int(mtx[i][i])
    
    answer = 0
    if (s + 1 == x):
        answer = 1
    ans.write('%d' % answer)

    dat.close()
    ans.close()
