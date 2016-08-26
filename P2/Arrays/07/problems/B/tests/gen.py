#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n  = rnd(1, 20)

    dat.write('%d\n' % n)
   
    f = [1, 2, 4]
    for i in range (3, n):
        f.append(f[i-1] + f[i-2] + f[i-3])
    ans.write('%d\n' % f[n-1])

    dat.close()
    ans.close()
