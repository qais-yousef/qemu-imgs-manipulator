#!/bin/bash
set -eux

MNT=$(realpath x86_fs)

sudo umount $MNT/dev
sudo umount $MNT/sys
sudo umount $MNT/proc
sudo umount $MNT
