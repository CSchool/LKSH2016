#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n  = rnd(1, 100)

    mtx = [rnd(1, 100) for i in range(n)]

    dat.write('%d\n' % n)
    dat.write(' '.join(list(map(str, mtx))))

    mtx.sort()
    ans.write(' '.join(list(map(str, mtx))))

    dat.close()
    ans.close()
