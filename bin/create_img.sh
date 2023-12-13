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

DEBOOTSTRAP=$(which qemu-debootstrap || which debootstrap)

# Create the contents
if [ "$ARCH" == "x86_64" ]; then
	sudo ${DEBOOTSTRAP} --arch amd64 stable $TMP_DIR
elif [ "$ARCH" == "i386" ]; then
	sudo ${DEBOOTSTRAP} --arch i386 stable $TMP_DIR
elif [ "$ARCH" == "aarch64" ]; then
	sudo ${DEBOOTSTRAP} --arch arm64 stable $TMP_DIR
elif [ "$ARCH" == "arm" ]; then
	sudo ${DEBOOTSTRAP} --arch armel stable $TMP_DIR
else
	echo "ERROR: unknown arch $ARCH"
	exit -1
fi

# Setup the image for our purposes
$(dirname $0)/setup_img.sh $ARCH $IMG $MNT
