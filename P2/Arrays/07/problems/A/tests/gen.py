#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n  = rnd(1, 40)

    dat.write('%d\n' % n)
   
    f = [1,1]
    for i in range (2, n+1):
        f.append(f[i-1] + f[i-2])
    ans.write('%d\n' % f[n])

    dat.close()
    ans.close()
