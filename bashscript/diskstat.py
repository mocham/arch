import sys, math

with open ('/proc/diskstats', 'r') as f:
    for l in f.readlines():
        sp = l.split('sd')
        if len(sp) != 2:
            continue
        s = sp[1]
        np = s.split(' ')
        if len(np) != 12:
            continue
        if len(np[0]) != 1:
            continue
        sys.stdout.write('sd' + np[0] + ' ' + str(math.floor(int(np[7])/1024/2)) + '; ')
