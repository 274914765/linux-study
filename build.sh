#!/bin/sh

OBJS="study/helper.o"
OBJS="$OBJS study/stub_memory.o"
OBJS="$OBJS study/stub_arch.o"
OBJS="$OBJS study/stub_kernel.o"
OBJS="$OBJS study/stub_fs.o"
OBJS="$OBJS study/stub_net.o"
OBJS="$OBJS arch/x86/lib/atomic64_cx8_32.o"
OBJS="$OBJS lib/checksum.o"
OBJS="$OBJS lib/find_bit.o"
OBJS="$OBJS lib/kasprintf.o"
OBJS="$OBJS lib/md5.o"
# OBJS="$OBJS lib/once.o"
OBJS="$OBJS kernel/user.o"  # init_user_ns
OBJS="$OBJS kernel/locking/mutex.o"  # __mutex_init
OBJS="$OBJS kernel/sched/wait.o"  # __init_waitqueue_head
OBJS="$OBJS kernel/time/time.o"  # jiffies
OBJS="$OBJS kernel/time/timer.o"
OBJS="$OBJS mm/page_alloc.o"  # alloc_large_system_hash
OBJS="$OBJS fs/inode.o"  # new_inode_pseudo
OBJS="$OBJS net/socket.o"
OBJS="$OBJS net/core/datagram.o"
OBJS="$OBJS net/core/request_sock.o"
OBJS="$OBJS net/core/skbuff.o"
OBJS="$OBJS net/core/sock.o"
OBJS="$OBJS net/core/secure_seq.o"
OBJS="$OBJS net/ipv4/af_inet.o"
OBJS="$OBJS net/ipv4/inet_connection_sock.o"
OBJS="$OBJS net/ipv4/inet_hashtables.o"
OBJS="$OBJS net/ipv4/ip_options.o"
OBJS="$OBJS net/ipv4/ip_output.o"
OBJS="$OBJS net/ipv4/route.o"
OBJS="$OBJS net/ipv4/tcp.o"
OBJS="$OBJS net/ipv4/tcp_input.o"
OBJS="$OBJS net/ipv4/tcp_ipv4.o"
# OBJS="$OBJS net/ipv4/tcp_metrics.o"
OBJS="$OBJS net/ipv4/tcp_minisocks.o"
OBJS="$OBJS net/ipv4/tcp_output.o"
# OBJS="$OBJS net/ipv4/tcp_timer.o"

set -x

if [ -z ${LINK+x} ];
then
make ARCH=um $OBJS || { exit 1; }
g++ -std=c++11 -Wall -g -O0 -c study/build.cc -o study/build.o
g++ -std=c++11 -Wall -g -O0 -c study/lib.cc -o study/lib.o
fi

g++ -std=c++11 -Wall -g -O0 study/main.cc study/lib.o study/build.o $OBJS -lnet -o tcp
