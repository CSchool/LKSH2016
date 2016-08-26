#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n, m, x = rnd(1, 10), rnd(1, 10), rnd(1, 100)

    mtx = [[str(rnd(1, x)) for i in range(m)] for j in range(n)]

    dat.write('%d %d %d\n' % (n, m, x))
    dat.write('\n'.join(list(map(' '.join, mtx))))

    flag = False
    for line in mtx:
       ans.write('1\n' if (len(list(filter(lambda a: int(a) < x, line))) != 0) else '0\n')

    dat.close()
    ans.close()
