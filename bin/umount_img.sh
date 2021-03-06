#!/bin/bash
set -eu

MNT=$1

sync
sudo umount $MNT
