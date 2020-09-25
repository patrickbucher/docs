#!/usr/bin/bash

# FIXME: this script hasn't been tested yet

set -e

# define a disk and set partition sizes
disk='nvme0n1'
init_mibs='1'
boot_mibs='256'
swap_mibs='16000'
root_mibs='64000'
var_mibs='8000'
tmp_mibs='4000'

# calculate partition sizes
boot_from="${init_mibs}"
boot_to="$(expr ${boot_from} + ${boot_mibs})"

# delete all partitions and overwrite disk with random data
disk_dev="/dev/${disk}"
shred --random-source=/dev/urandom --iterations=1 "/dev/${disk}"
parted -s "$disk_dev" mklabel gpt

# create and format boot partition
parted -s "$disk_dev" mkpart boot fat32 "${boot_from}MiB" "${boot_to}MiB"
parted -s "$disk_dev" set 1 esp on
mkfs.fat -F 32 "/dev/${disk}p1"

# prepare partition for disk encryption
parted -s "/dev/${disk}" mkpart cryptlvm "${swap_from}" '100%'
cryptsetup luksFormat "/dev/${disk}p2"
cryptsetup open "/dev/${disk}p2" cryptlvm
pvcreate /dev/mapper/cryptlvm
volume_group='VolumeGroup'
vgcreate "${volume_group}" /dev/mapper/cryptlvm

# create the partitions
lvcreate -L ${swap_mibs}M "${volume_group}" -n swap
lvcreate -L ${root_mibs}M "${volume_group}" -n root
lvcreate -L ${var_mibs}M "${volume_group}" -n var
lvcreate -L ${tmp_mibs}M "${volume_group}" -n tmp
lvcreate -L '100%' "${volume_group}" -n home

# format the partitions
mkswap "/dev/${volume_group}/swap"
mkfs.ext4 -F "/dev/${volume_group}/root"
mkfs.ext4 -F "/dev/${volume_group}/var"
mkfs.ext4 -F "/dev/${volume_group}/tmp"
mkfs.ext4 -F "/dev/${volume_group}/home"

# mount the partitions
mount "/dev/${volume_group}/root" /mnt
mkdir /mnt/boot
mount "/dev/${disk}p1" /mnt/boot
swapon "/dev/${volume_group}/swap"
mkdir /mnt/var
mount "/dev/${volume_group}/var" /mnt/var
mkdir /mnt/tmp
mount "/dev/${volume_group}/tmp" /mnt/tmp
mkdir /mnt/home
mount "/dev/${volume_group}/home" /mnt/home

# install the base system
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

echo "Perform the following tasks manually"
echo "- chroot into the system:  arch-chroot /mnt"
echo "- set an admin password:   passwd"
echo "- then continue with the setup.sh script"
