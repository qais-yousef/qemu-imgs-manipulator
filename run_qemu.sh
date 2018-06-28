#!/bin/bash

#
# REFERENCES:
# - https://www.collabora.com/news-and-blog/blog/2017/01/16/setting-up-qemu-kvm-for-kernel-development/
# - https://www.collabora.com/news-and-blog/blog/2017/03/13/kernel-debugging-with-qemu-overview-tools-available/
#

function print_usage {
	echo "Usage: $(basename $0) <path/to/kernel/image> [options]"
	echo "	Options:"
	echo "		--arch [arch]: x86_64(default)|i386|aarch64|arm"
	echo "		-h|--help: print this help message"
}

if [ $# -lt 1 ]; then
	print_usage
	exit -1
fi

set -eu

KERNEL=$1
ARCH=x86_64

SHORTOPTS="h"
LONGOPTS="arch:,help"

ARGS==`getopt -n "$(basename $0)" --options $SHORTOPTS --longoptions $LONGOPTS -- "$@"`

eval set -- "$ARGS"

while true;
do
	case "$1" in
		-h|--help)
			print_usage
			exit 0
			;;

		--arch)
			shift
			ARCH="$1"
			;;

		--)
			shift
			break
			;;
	esac
	shift
done

# Information required by plumbing layer
IMG=$(dirname $(realpath $0))/images/qemu-image-$ARCH.img

sudo qemu-system-$ARCH				\
	-kernel $KERNEL				\
	-hda $IMG				\
	-append "root=/dev/sda console=ttyS0"	\
	-smp cores=4,threads=2			\
	--enable-kvm				\
	--nographic				\
	-m 512					\
	-net nic -net user
