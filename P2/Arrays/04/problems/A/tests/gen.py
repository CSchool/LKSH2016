#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n, m = rnd(1, 10), rnd(1, 10)

    mtx = [[str(rnd(1, 1000)) for i in range(m)] for j in range(n)]

    xi = rnd(0, n - 1)
    xj = rnd(0, m - 1)
    mtx[xi][xj] = str(0);

    dat.write('%d %d\n' % (n, m))
    dat.write('\n'.join(list(map(' '.join, mtx))))

    mx = mtx[0][0]
    mxi = 0
    mxj = 0

    for i, line in enumerate(mtx):
        for j, a in enumerate(line):
            if (a > mx):
                mx = a
                mxi = i
                mxj = j
    

    ans.write('%d %d' % (mxi, mxj))

    dat.close()
    ans.close()
