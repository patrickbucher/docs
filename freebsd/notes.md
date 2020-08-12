# Copy Files to USB Stick

USB storage appears as `/dev/da*`, starting with 0. List your disks:

	# camcontrol devlist

List GEOM disks:

	$ geom disk list

Show partitions (of `/dev/da0`):

	$ gpart show da0

Remove partitioning scheme:

	# gpart destroy da0

If the disk still has partitions, this error appears:

	gpart: Device busy

Either delete all partitions:

	$ gpart show da0
	# gpart delete -i 1 da0
	# gpart delete -i 2 da0

Or force delete the partition scheme:

	# gpart destroy -F da0

Create a new GPT partition scheme:

	# gpart create -s gpt da0

Create a new partition (UFS, 10G):

	# gpart add -t freebsd-ufs -l data -s 10G da0

Omit the size parameter to use the full (remaining) size.

Create the partition:

	# newfs /dev/da0p1

Mount it:

	# mount /dev/da0p1 /mnt

## Fat 32

	# sudo gpart create -s mbr da0
	# sudo gpart add -t fat32 da0
	# newfs_msdos -F32 /dev/da0s1
	# mount -t msdosfs /dev/da0s1 /mnt

# Miscellaneous

set the font of the video terminal:

	vidcontrol -f terminus-b32.fnt

to make it permanent, add this to `/etc/rc.conf`:

	allscreens_flags="-f terminus-b32"

change the efault shell (from `/etc/shells`):

	chsh -s /usr/local/bin/bash

boot after 3 instead of 10 seconds (`/boot/loader.conf`):

	autoboot_delay="3"
