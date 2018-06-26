#!/bin/bash
set -eux

IMG=$1
MNT=$(realpath $2)

sudo mount $IMG $MNT
sudo mount --bind /dev $MNT/dev
sudo mount --bind /sys $MNT/sys
sudo mount --bind /proc $MNT/proc

sudo chroot $MNT /usr/bin/env PATH=/usr/sbin:/usr/bin:/bin:/sbin bash -i
