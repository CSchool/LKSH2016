#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n, x = rnd(1, 10), rnd(2, 1000)

    mtx = [[str(rnd(1, x - 1)) for i in range(n)] for j in range(n)]

    xi = rnd(0, n - 1)
    xj = rnd(0, n - 1)
    mtx[xi][xj] = str(x);

    dat.write('%d %d\n' % (n, x))
    dat.write('\n'.join(list(map(' '.join, mtx))))

    t = mtx[0][0]
    mtx[0][0] = mtx[xi][xj]
    mtx[xi][xj] = t

    ans.write('\n'.join(list(map(' '.join, mtx))))

    dat.close()
    ans.close()
