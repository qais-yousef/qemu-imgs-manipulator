#!/bin/bash

# Allow the user to customise the command
if [ -n "$1" ]; then
	CMD=$1
else
	CMD="bash -i"
fi

set -eux

IMG=qemu-image.img
MNT=$(realpath x86_fs)

sudo mount -o loop $IMG $MNT
sudo mount --bind /dev $MNT/dev
sudo mount --bind /sys $MNT/sys
sudo mount --bind /proc $MNT/proc

sudo chroot $MNT /usr/bin/env PATH=/usr/sbin:/usr/bin:/bin:/sbin $CMD
