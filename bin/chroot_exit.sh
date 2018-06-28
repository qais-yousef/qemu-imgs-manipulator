#!/bin/bash
set -eu

MNT=$1

sudo umount $MNT/dev
sudo umount $MNT/sys
sudo umount $MNT/proc
sudo umount $MNT
