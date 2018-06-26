#!/bin/bash
set -eux

KERNEL=$1
IMG=$2

qemu-system-x86_64 -kernel $KERNEL -hda $IMG  -append "root=/dev/sda console=ttyS0" -smp cpus=4,cores=2,threads=2 --enable-kvm --nographic
