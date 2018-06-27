#!/bin/bash
set -eux

#
# REFERENCES:
# - https://www.collabora.com/news-and-blog/blog/2017/01/16/setting-up-qemu-kvm-for-kernel-development/
# - https://www.collabora.com/news-and-blog/blog/2017/03/13/kernel-debugging-with-qemu-overview-tools-available/
#

KERNEL=$1
IMG=$2
ARCH=x86_64

qemu-system-$ARCH				\
	-kernel $KERNEL				\
	-hda $IMG				\
	-append "root=/dev/sda console=ttyS0"	\
	-smp cores=4,threads=2			\
	--enable-kvm				\
	--nographic				\
	-m 512					\
	-net nic -net user
