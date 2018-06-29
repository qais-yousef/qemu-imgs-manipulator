# qemu-imgs-manipulator
Create and handle qemu-imgs that are suitable to perform kernel testing/development on.

## Commands
NOTE: A lot of these commands require sudo access

### create_img
create_img will create x86_64 image by default. To select a different arch use --arch option.
The created image is based on Ubuntu 18.04 Bionic. It is setup at creation time to:

- Add a user with the same name as $(whoami)
- Give sudo access to this user
- Allow passwordless access for root and this user
- Add new ubuntu repo to get access to a wider range of software

Creating a user with the same name is very useful if you want to move files in and out of the image.

TODO: Maybe must ensure uid is the same too.

See bin/setup_img.sh for nitty gritty details.

### chroot_img
Will mount and chroot into the image. Very useful to easily install new software from easier environment.
Type `exit` when finished.

### mount_img
Very helpful to access the image to analyse data without copying them out. This is none-chroot access, keep this in mind.
Type `exit` when finished.

### copy_{to,from}_img
Copy files into and out of the image. Be careful with this command. Use -n option to see a dry run of the command that will be executed.

### run_qemu
Run qemu using a created image as the rootfs.
