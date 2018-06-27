#!/bin/bash
set -eux

IMG=qemu-image.img
MNT=$(realpath x86_fs)

sudo mount -o loop $IMG $MNT
