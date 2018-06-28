#!/bin/bash
set -eu

ARCH=$1
IMG=$2
MNT=$3

# chroot into the image
cat << EOF | $(dirname $0)/chroot_enter.sh $IMG $MNT bash

set -eux

# First make sure root has no password
passwd -d root

# Now add a user that matches the current user ID
adduser --disabled-password --gecos "" $(whoami)
# No password login
passwd -d $(whoami)
# Make admin and sudoer
usermod -G sudo,adm $(whoami)

# Add more ubuntu repo to allow more software to be installed
echo "deb http://archive.ubuntu.com/ubuntu bionic universe" >> /etc/apt/sources.list

# Make sure apt is up-to-date after adding the repo
apt update

# Make sure our rootfs is mounted correctly, or it'd be readonly
echo "/dev/sda	/	auto	defaults	0	1" > /etc/fstab

# Install some software we usually need
apt install trace-cmd likwid

# exit chroot
exit

EOF
