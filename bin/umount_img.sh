#!/bin/bash
set -eux

MNT=$(realpath x86_fs)

sudo umount $MNT
