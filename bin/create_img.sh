#!/bin/bash
set -eu

IMAGES_TMP_DIR=images
mkdir -p $IMAGES_TMP_DIR

ARCH=$1
IMG=$2
MNT=$3
TMP_DIR=$(mktemp -d)
MOUNTED=0

function finish {
	if [ $MOUNTED -eq 1 ]; then
		sudo umount $TMP_DIR
	fi
	rm -rf "$TMP_DIR"
}

# Make sure to cleanup on error
trap finish EXIT

# Creat the image
if [ ! -e $IMG ]; then
	qemu-img create $IMG 10g
	mkfs.ext4 $IMG
fi

# Mount it
MOUNTED=1
sudo mount -o loop $IMG $TMP_DIR

# Fix the arch name for x86_64, it's called amd64!
if [ "$ARCH" == "x86_64" ]; then
	ARCH__=amd64
else
	ARCH__=$ARCH
fi

# Create the contens
sudo debootstrap --arch $ARCH__ bionic $TMP_DIR http://archive.ubuntu.com/ubuntu/

# Setup the image for our purposes
$(dirname $0)/setup_img.sh $ARCH $IMG $MNT
