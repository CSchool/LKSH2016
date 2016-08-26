#!/usr/sbin/python3

from random import randint as rnd

for i in range(10):
    dat = open('%03d.dat' % i, 'w')
    ans = open('%03d.ans' % i, 'w')

    n = rnd(1, 100)
    m = 2
    mtx = [[str(rnd(1, 10)) for i in range(m)] for j in range(n)]


    print(n, file=dat)
    dat.write('\n'.join(list(map(' '.join, mtx))))

    s = 0
    for i, line in enumerate(mtx):
        e = 1
        for j, a in enumerate(line):
            e *= int(a) 
        s += e
    

    
    print(s, file=ans)

    dat.close()
    ans.close()
