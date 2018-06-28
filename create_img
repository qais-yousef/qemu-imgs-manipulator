#!/bin/bash
set -eu

function print_usage {
	echo "Usage: $(basename $0) [options]"
	echo "	Options:"
	echo "		--arch [arch]: x86_64(default)|i386|aarch64|arm"
	echo "		-h|--help: print this help message"
}

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
MNT=$(dirname $(realpath $0))/mnt/$ARCH

# Make sure all required directories are created
mkdir -p $MNT
mkdir -p $(dirname $IMG)

# Do create the image
./bin/create_img.sh $ARCH $IMG $MNT
