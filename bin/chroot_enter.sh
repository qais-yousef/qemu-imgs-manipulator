#!/bin/bash

# Allow the user to customise the command
if [ -n "$3" ]; then
	CMD=$3
else
	CMD="bash -i"
fi

set -eu

IMG=$1
MNT=$2

# Autocleanup on exit
trap "$(dirname $0)/chroot_exit.sh $MNT" EXIT

sudo mount -o loop $IMG $MNT
sudo mount --bind /dev $MNT/dev
sudo mount --bind /sys $MNT/sys
sudo mount --bind /proc $MNT/proc

sudo chroot $MNT /usr/bin/env PATH=/usr/sbin:/usr/bin:/bin:/sbin $CMD
