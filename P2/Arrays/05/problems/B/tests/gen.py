#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n  = rnd(1, 100)

    mtx = [rnd(1, 1000) for i in range(n)]

    dat.write('%d\n' % n)
    dat.write(' '.join(list(map(str, mtx))))

    i = 0
    while i < n / 2:
        mtx[i], mtx[-i - 1] = mtx[-i - 1], mtx[i]
        i += 1  
    ans.write(' '.join(list(map(str, mtx))))

    dat.close()
    ans.close()
