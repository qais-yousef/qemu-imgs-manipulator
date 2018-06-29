# qemu-imgs-manipulator

Create and handle qemu-imgs that are suitable to perform kernel testing/development on.

## Requirements

`apt install qemu qemu-user-static debootstrap`

## Usage

```
./create_img --arch aarch64     # Required once

./run_qemu --arch aarch64 path/to/kernel/arm64/boot/Image

# Login using $(whoami) or root.
# There's no password set on your user nor root and you have sudo access.

# run your experiment

sudo shutodwn -h now     # When done
```

## TODO

- Maybe must ensure uid of $(whoami) in the guest matches the host's.
- Fix network support in the guest

## Commands

NOTE:
- A lot of these commands require sudo access.
- Default arch is x86_64. All commands accept --arch option to select a different arch.
- Use -h to print usage.

### `create_img`
create_img will create x86_64 image by default. To select a different arch use --arch option.
The created image is based on Ubuntu 18.04 Bionic for x86 and Debian Stable for ARM. It is setup at creation time to:

- Add a user with the same name as $(whoami)
- Give sudo access to this user
- Allow passwordless access for root and this user
- Add new universe repo to get access to a wider range of software

Creating a user with the same name is very useful if you want to move files in and out of the image.

See bin/setup_img.sh for nitty gritty details.

### `./chroot_img`
Will mount and chroot into the image. Very useful to easily install new software from easier environment.
Type `exit` when finished.

### `./mount_img`
Very helpful to access the image to analyse data without copying them out. This is none-chroot access, keep this in mind.
Type `exit` when finished.

### `./copy_{to,from}_img <src> <dst>`
Copy files into and out of the image. Be careful with this command. Use -n option to see a dry run of the command that will be executed.

### `./run_qemu`
Run qemu using a created image as the rootfs. You can login as 'root' or '$(whoami)', the latter preferred so you can access created files from host/guest without permission problems.

Make sure to shutdown gracefully when done.

`sudo shutdown -h now`
