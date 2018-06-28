#!/bin/bash

function print_usage {
	echo "Usage: $(basename $0) <src/directory> <dst/directory> [options]"
	echo "	Options:"
	echo "		--arch [arch]: x86_64(default)|i386|aarch64|arm"
	echo "		-h|--help: print this help message"
}

if [ $# -lt 2 ]; then
	print_usage
	exit -1
fi

if [ ! -d $1 ]; then
	echo "ERROR: $1 is not a directory!"
	exit -1
fi

set -eu

SRC=$(realpath $1)
DST=$(echo $2 | sed s#^/*##)
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

# Make sure to cleanup on exit
trap "$(dirname $(realpath $0))/bin/umount_img.sh $MNT" EXIT

sudo mount -o loop $IMG $MNT

pushd $MNT &> /dev/null

set -x
cp -r $SRC $DST
set +x
popd &> /dev/null