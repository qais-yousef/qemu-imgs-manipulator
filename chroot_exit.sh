#!/bin/bash
set -eux

MNT=$(realpath $1)

sudo umount $MNT/dev
sudo umount $MNT/sys
sudo umount $MNT/proc
sudo umount $MNT
