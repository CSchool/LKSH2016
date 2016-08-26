#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n= rnd(1, 100)

    mtx = [[str(rnd(1, 1000)) for i in range(n)] for j in range(n)] 

    dat.write('%d\n' % n)
    dat.write('\n'.join(list(map(' '.join, mtx))))
    k = 0
    for i, line in enumerate(mtx):
        for j, a in enumerate(line):
            if j < i and int(a) % 2 == 0:
             k += 1
    
    ans.write('%d' % k)

    dat.close()
    ans.close()
