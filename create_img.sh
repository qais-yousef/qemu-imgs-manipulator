#!/bin/bash
set -eux

IMG=qemu-image.img
DIR=$(mktemp -d)
MOUNTED=0

function finish {
	if [ $MOUNTED -eq 1 ]; then
		sudo umount $DIR
	fi
	rm -rf "$DIR"
}

# Make sure to cleanup on error
trap finish EXIT

# Creat the image
if [ ! -e $IMG ]; then
	qemu-img create $IMG 1g
	mkfs.ext2 $IMG
fi

# Mount it
MOUNTED=1
sudo mount -o loop $IMG $DIR

# Create the contens
sudo debootstrap --arch amd64 --include trace-cmd,kernelshark stretch $DIR

# Setup root user
sudo chroot $DIR
