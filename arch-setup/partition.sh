#!/usr/bin/bash

set -e

# TODO: define a disk and set partition sizes
disk='mmcblk0'
init_mibs='1'
boot_mibs='250'
swap_mibs='2000'
root_mibs='4000'
var_mibs='4000'
tmp_mibs='1000'

# calculate partition sizes
boot_from="${init_mibs}"
swap_from="$(expr ${boot_from} + ${boot_mibs})"
root_from="$(expr ${swap_from} + ${swap_mibs})"
var_from="$(expr ${root_from} + ${root_mibs})"
tmp_from="$(expr ${var_from} + ${var_mibs})"
home_from="$(expr ${tmp_from} + ${tmp_mibs})"

# delete all partitions (find out device using lsblk)
disk_dev="/dev/${disk}"
parted -s "$disk_dev" mklabel gpt

# create the partitions
parted -s "$disk_dev" mkpart boot fat32 "${boot_from}MiB" "${swap_from}MiB"
parted -s "$disk_dev" set 1 esp on
parted -s "$disk_dev" mkpart swap linux-swap "${swap_from}Mib" "${root_from}MiB"
parted -s "$disk_dev" mkpart root ext4 "${root_from}MiB" "${var_from}MiB"
parted -s "$disk_dev" mkpart var ext4 "${var_from}MiB" "${tmp_from}MiB"
parted -s "$disk_dev" mkpart tmp ext4 "${tmp_from}MiB" "${home_from}MiB"
parted -s "$disk_dev" mkpart home ext4 "${home_from}MiB" '100%'

# format the partitions
mkfs.fat -F32 "/dev/${disk}p1"
mkswap "/dev/${disk}p2"
mkfs.ext4 -F "/dev/${disk}p3"
mkfs.ext4 -F "/dev/${disk}p4"
mkfs.ext4 -F "/dev/${disk}p5"
mkfs.ext4 -F "/dev/${disk}p6"

# mount the partitions
mount "/dev/${disk}p3" /mnt
mkdir /mnt/boot
mount "/dev/${disk}p1" /mnt/boot
swapon "/dev/${disk}p2"
mkdir /mnt/var
mount "/dev/${disk}p4" /mnt/var
mkdir /mnt/tmp
mount "/dev/${disk}p5" /mnt/tmp
mkdir /mnt/home
mount "/dev/${disk}p6" /mnt/home

# generate file system table
mkdir -p /mnt/etc
genfstab -U /mnt >> /mnt/etc/fstab

echo "Perform the following tasks manually"
echo "- install the base system:\t pacstrap /mnt base linux linux-firmware"
echo "- chroot into the system: \t arch-chroot /mnt"
echo "- set an admin password:  \t passwd"
