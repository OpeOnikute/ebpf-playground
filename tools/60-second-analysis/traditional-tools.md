## List
- uptime - load (moving sum) averages that help you know if there are processes blocked in I/O or just waiting to run. You can then use other tools to figure out what the processes are and why they are blocked. An example:
```
/ # uptime
 10:56:28 up 18:36,  load average: 0.00, 0.05, 0.01
```
This shows a slight decrease to 0.00 at the 1-minute mark from 0.05 at 5-minute and 0.01 at 15-minute.

- dmesg | tail - shows past ten system messages. Should reveal any errors. Example:
```
$ docker run -it --cap-add syslog alpine dmesg | tail
[183666.036468] docker0: port 2(vetha99c05a) entered blocking state
[183666.037245] docker0: port 2(vetha99c05a) entered disabled state
[183666.037914] device vetha99c05a entered promiscuous mode
[183666.038509] IPv6: ADDRCONF(NETDEV_UP): vetha99c05a: link is not ready
[183666.109933] IPVS: Creating netns size=2104 id=16
[183666.110343] IPVS: ftp: loaded support on port[0] = 21
[183666.257183] eth0: renamed from veth7938460
[183666.300140] IPv6: ADDRCONF(NETDEV_CHANGE): vetha99c05a: link becomes ready
[183666.301350] docker0: port 2(vetha99c05a) entered blocking state
[183666.302178] docker0: port 2(vetha99c05a) entered forwarding state
```
- vmstat 1 - use to diagnose virtual memory. e.g.
```
root@8f32cfdc6540:/# vmstat 1
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
6  0     76 106892  92252 1511532    0    0    20     9  116  278  0  1 99  0  0
0  0     76 106768  92252 1511536    0    0     0     0  313  755  0  1 99  0  0
0  0     76 106768  92252 1511540    0    0     0     0  319  663  1  1 99  0  0
0  0     76 106768  92252 1511540    0    0     0     0  420 1007  1  1 99  0  0
```
- mpstat -P ALL 1 - prints CPU time broken down into states.
```
root@8f32cfdc6540:/# mpstat -P ALL 1
Linux 4.9.125-linuxkit (8f32cfdc6540)   12/29/20        _x86_64_        (2 CPU)

11:35:03     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
11:35:04     all    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
11:35:04       0    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
11:35:04       1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
```
- pidstat 1 - shows CPU usage per process like `top` but provides running output.
```
root@1ee809bd6588:/# pidstat 1
Linux 4.9.125-linuxkit (1ee809bd6588)   12/29/20        _x86_64_        (2 CPU)
11:52:15      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
11:52:16        0        10    0.99    0.00    0.00    0.00    0.99     0  pidstat
```
- iostat -xz 1 - shows storage device I/O metrics such as number of reads/writes, utilisation, await time etc.
```
root@1ee809bd6588:/# iostat -xz 1
Linux 4.9.125-linuxkit (1ee809bd6588)   12/29/20        _x86_64_        (2 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.27    0.00    0.65    0.01    0.00   99.06

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sda              0.74    0.35     35.54     19.31     0.00     0.22   0.56  38.82    0.89    8.32   0.00    48.34    55.880.37   0.04
scd0             0.03    0.00      2.13      0.00     0.00     0.00   0.00   0.00    0.65    0.00   0.00    68.04     0.000.47   0.00
scd1             0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00    23.43     0.000.00   0.00
scd2             0.02    0.00      1.29      0.00     0.00     0.00   0.00   0.00    0.48    0.00   0.00    67.45     0.000.42   0.00

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.51    0.00    2.03    0.00    0.00   97.46
```
- free -m - shows the free memory in MB
```
root@1ee809bd6588:/# free -m
              total        used        free      shared  buff/cache   available
Mem:           1999         331         155           0        1512        1512
Swap:          1023           0        1023 
```
- sar -n DEV 1 - view network device metrics to see if any interface throughput limit has been reached on rxkB/s or txkB/s.
```
root@1ee809bd6588:/# sar -n DEV 1
Linux 4.9.125-linuxkit (1ee809bd6588)   12/29/20        _x86_64_        (2 CPU)

12:21:17        IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s   %ifutil
12:21:18         eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
12:21:18      ip6tnl0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
12:21:18        tunl0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
12:21:18           lo      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
```

- sar -n TCP,ETCP 1 -  see the active and passive TCP connection counts and the number of retransmits per second
```
root@1ee809bd6588:/# sar -n TCP,ETCP 1
Linux 4.9.125-linuxkit (1ee809bd6588)   12/29/20        _x86_64_        (2 CPU)

12:21:31     active/s passive/s    iseg/s    oseg/s
12:21:32         0.00      0.00      0.00      0.00

12:21:31     atmptf/s  estres/s retrans/s isegerr/s   orsts/s
12:21:32         0.00      0.00      0.00      0.00      0.00
```

- top - well-known tool for collecting CPU metrics
```
top - 12:34:41 up 20:05,  0 users,  load average: 0.09, 0.06, 0.01
Tasks:   2 total,   1 running,   1 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.7 us,  0.8 sy,  0.0 ni, 98.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  2047036 total,   156404 free,   340644 used,  1549988 buff/cache
KiB Swap:  1048572 total,  1047852 free,      720 used.  1547836 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
    1 root      20   0   18504   3376   2960 S   0.0  0.2   0:00.04 bash
   19 root      20   0   36584   3108   2684 R   0.0  0.2   0:00.01 top
```

## Others
The sar (1) command is of notable mention as you can get information about multiple layers from it. They are:
DEV, EDEV, NFS, NFSD, SOCK, IP, EIP, ICMP, EICMP, TCP, ETCP, UDP, SOCK6, IP6, EIP6, ICMP6, EICMP6 and UDP6.

- sar -n SOCK 1 - get information on the total number of sockets + TCP, UDP and RAW sockets in use.
```
root@1ee809bd6588:/# sar -n SOCK 1
Linux 4.9.125-linuxkit (1ee809bd6588)   12/29/20        _x86_64_        (2 CPU)

17:02:12       totsck    tcpsck    udpsck    rawsck   ip-frag    tcp-tw
17:02:13          246         0         0         0         0         0
17:02:14          246         0         0         0         0         0
```